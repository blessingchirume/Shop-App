package com.example.shop_app

import android.content.Context
import android.graphics.*
import android.graphics.pdf.PdfDocument
import android.os.Build
import android.os.Bundle
import android.os.CancellationSignal
import android.os.ParcelFileDescriptor
import android.print.*
import android.print.pdf.PrintedPdfDocument
import android.view.View
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.FileOutputStream
import java.io.IOException


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.flutter.epic/test"

    private lateinit var channel: MethodChannel

    lateinit var _bitmap: Bitmap

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)

        channel.setMethodCallHandler { call, result ->
            if (call.method == "doPrint") {
                var arg = call.arguments

                print(arg)

                // Generate and print the receipt
                // Use the printing pipeline to print the receipt through the POS terminal

                var bitmap = call.arguments as ByteArray

                print(bitmap)
                
                _bitmap = BitmapFactory.decodeByteArray(bitmap, 0, bitmap.size)


                val message = doPrint("{}")


//                textView = findViewById(R.id.textView6)
//
//                var message = doPrint(textView)
//                result.success(message)
            }
        }

    }

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    private fun doPrint(json: String) {

//        _bitmap = loadBitmapFromView(bitmap, bitmap.getWidth(), bitmap.getHeight())!!
        // createPdf();

//        _bitmap = bitmap

        print("Hello from kotlin");

        this?.also { context ->

            val printManager = context.getSystemService(Context.PRINT_SERVICE) as PrintManager
            val jobName = "Test Print Document"
            printManager.print(jobName, MyPrintDocumentAdapter(context, json, _bitmap), null)
        }

    }

    @RequiresApi(Build.VERSION_CODES.KITKAT)
    inner class MyPrintDocumentAdapter(
        private var context: Context,
        private var json: String,
        private var bmp: Bitmap
    ) : PrintDocumentAdapter() {

        private var pageHeight = 0
        private var pageWidth = 0
        var myPdfDocument: PdfDocument? = null
        var totalpages: Int = 1

        override fun onLayout(
            oldAttributes: PrintAttributes?,
            newAttributes: PrintAttributes?,
            cancellationSignal: CancellationSignal?,
            callback: LayoutResultCallback?,
            extras: Bundle?
        ) {

            // Create a new PdfDocument with the requested page attributes
            myPdfDocument = PrintedPdfDocument(context, newAttributes!!)

            pageHeight = newAttributes.getMediaSize()!!.getHeightMils() / 1000 * 72
            pageWidth = newAttributes.getMediaSize()!!.getWidthMils() / 1000 * 72

            // Respond to cancellation request
            if (cancellationSignal?.isCanceled == true) {
                callback?.onLayoutCancelled()
                return
            }

            if (totalpages > 0) {
                // Return print information to print framework
                PrintDocumentInfo.Builder("print_output.pdf")
                    .setContentType(PrintDocumentInfo.CONTENT_TYPE_DOCUMENT)
                    .setPageCount(totalpages)
                    .build()
                    .also { info ->
                        // Content layout reflow is complete
                        callback?.onLayoutFinished(info, true)
                    }
            } else {
                // Otherwise report an error to the print framework
                callback?.onLayoutFailed("Page count calculation failed.")
            }

        }


        override fun onWrite(
            pages: Array<out PageRange>?,
            destination: ParcelFileDescriptor?,
            cancellationSignal: CancellationSignal?,
            callback: WriteResultCallback?
        ) {

            // Iterate over each page of the document,
            // check if it's in the output range.
            for (i in 0 until totalpages) {

                val newPage = PdfDocument.PageInfo.Builder(
                    pageWidth,
                    pageHeight, i
                ).create()

                val page = myPdfDocument!!.startPage(newPage)

                // check for cancellation
                if (cancellationSignal?.isCanceled == true) {
                    callback?.onWriteCancelled()
                    myPdfDocument?.close()
                    myPdfDocument = null
                    return
                }


                // Draw page content for printing
                drawPage(page, bmp)
//
//                // Rendering is complete, so page can be finalized.
                myPdfDocument?.finishPage(page)

            }
//
//            // Write PDF document to file
            try {
                myPdfDocument?.writeTo(FileOutputStream(destination?.fileDescriptor))
            } catch (e: IOException) {
                callback?.onWriteFailed(e.toString())
                return
            } finally {
                myPdfDocument?.close()
                myPdfDocument = null
            }

//            val json = ReadJsonFileFromAssets(context, "en.json")

//                val data = Gson().fromJson(json, Model::class.java)

//                Log.i("Json data", "data: $data")

//                SimpleTemplate(context).generatePdf(data, destination?.fileDescriptor);

            // Signal the print framework the document is complete
            callback?.onWriteFinished(pages)

        }

        private fun drawPage(page: PdfDocument.Page, image: Bitmap) {

            val canvas = page.canvas

            val paint = Paint()

            _bitmap = Bitmap.createScaledBitmap(image!!, pageWidth, pageHeight, true)

            paint.color = Color.BLUE

            canvas.drawBitmap(_bitmap, 0f, 0f, paint)

        }
    }


    private fun loadBitmapFromView(v: View, width: Int, height: Int): Bitmap? {
        val b = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)
        val c = Canvas(b)
        v.draw(c)
        return b
    }

}
