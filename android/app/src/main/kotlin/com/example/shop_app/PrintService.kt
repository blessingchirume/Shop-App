import android.content.Context
import android.graphics.*
import android.graphics.pdf.PdfDocument
import android.util.AttributeSet
import android.view.View
import androidx.core.content.ContextCompat
import com.example.shop_app.Model
import com.example.shop_app.R
import java.io.File
import java.io.FileDescriptor
import java.io.FileOutputStream

/**
 * Simple invoice template which is shown as preview.
 */
class SimpleTemplate @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyleAttr: Int = 0
) : View(context, attrs, defStyleAttr) {
    private val paint = Paint()
    private val textPaint = Paint()
    private val contentBgPaint = Paint()
    private val titleBgPaint = Paint()
    private var currencySymbol: String
    private var yMargin = 10f
    private var xMargin = 10f
    private var xPadding = 5f.dpToPx()
    private var yPadding = 5f.dpToPx()
    private var textSpacing = 5f
    private var yPointer = 0f
    private var data: Model? = null
    init {
        paint.color = ContextCompat.getColor(context, R.color.black)
        paint.isAntiAlias = true
        paint.style = Paint.Style.FILL_AND_STROKE
        textPaint.color = ContextCompat.getColor(context, R.color.black)
        textPaint.isAntiAlias = true
        textPaint.style = Paint.Style.FILL_AND_STROKE
        contentBgPaint.color = ContextCompat.getColor(context, R.color.black)
        contentBgPaint.isAntiAlias = true
        contentBgPaint.style = Paint.Style.FILL_AND_STROKE
        titleBgPaint.color = ContextCompat.getColor(context, R.color.black)
        titleBgPaint.isAntiAlias = true
        titleBgPaint.style = Paint.Style.FILL_AND_STROKE
        currencySymbol = "context.getString(R.string.)"
    }
    public override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        canvas?.apply {
            if (data != null) {
                drawHeader(canvas)
                drawCompanyInfo(canvas, data)
                drawDue(canvas, data)
                drawClientInfo(canvas, data)
                drawItemHeader(canvas)
                drawItems(canvas, data)
                drawTotal(canvas, data)
                drawFooter(canvas, data)
            }
            restore()
        }
    }
    private fun drawHeader(canvas: Canvas?, title: String = "INVOICE") {
        setTextSize(textPaint, 16f)
        setPaintColor(textPaint, getColor(R.color.white))
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.BOLD))
        textAlignCentre(textPaint)
        yPointer = 60f
        val rect =
            RectF(
                xMargin.dpToPx(),
                yMargin.dpToPx(),
                width.toFloat() - xMargin.dpToPx(),
                yPointer.dpToPx()
            )
        canvas?.drawRect(rect, titleBgPaint)
        canvas?.drawText(title, 0, title.length, rect.centerX(), rect.centerY() + 15, textPaint)
    }
    private fun drawCompanyInfo(
        canvas: Canvas?, data: Model?
    ) {
        setPaintColor(contentBgPaint, getColor(R.color.white))
        setTextSize(textPaint, 16f)
        setPaintColor(textPaint, getColor(R.color.black))
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.NORMAL))
        textAlignLeft(textPaint)
        val top = yPointer + yMargin
        val bottom = top + 65
        yPointer = bottom
        val rect = RectF(
            xMargin.dpToPx(),
            top.dpToPx(),
            width.toFloat() - xMargin.dpToPx(),
            bottom.dpToPx()
        )
        canvas?.drawRect(rect, contentBgPaint)
        val textBounds = Rect()
        textPaint.getTextBounds(data!!.userName, 0, data.userName.length, textBounds)
        val yBound = textBounds.height().toFloat() + (textSpacing + 2).dpToPx()
        val left = xMargin + xPadding
        val textY = rect.top + yPadding
        canvas?.drawText(
            data.userName,
            0,
            data.userName.length,
            left.dpToPx(),
            textY + (yBound),
            textPaint
        )
        canvas?.drawText(
            data.userLocation,
            0,
            data.userLocation.length,
            left.dpToPx(),
            textY + (yBound * 2),
            textPaint
        )
        canvas?.drawLine(
            left.dpToPx(),
            yPointer.dpToPx(),
            width.toFloat() - xMargin.dpToPx(),
            yPointer.dpToPx(),
            textPaint
        )
    }
    private fun drawDue(canvas: Canvas?, data: Model?) {
        setPaintColor(contentBgPaint, getColor(R.color.white))
        setTextSize(textPaint, 16f)
        setPaintColor(textPaint, getColor(R.color.black))
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.BOLD))
        val top = yPointer + yMargin
        val bottom = top + 35
        yPointer = bottom
        val rect = RectF(
            xMargin.dpToPx(),
            top.dpToPx(),
            width.toFloat() - xMargin.dpToPx(),
            bottom.dpToPx()
        )
        canvas?.drawRect(rect, contentBgPaint)
        val textBounds = Rect()
        val invoiceDate = data?.date
        textPaint.getTextBounds(invoiceDate!!, 0, invoiceDate.length, textBounds)
        val yBound = textBounds.height().toFloat() + textSpacing.dpToPx()
        val textY = rect.top + yPadding
        val invoiceNumber: String = "#INV" + data.number.toString()
        val left = xMargin + xPadding
        canvas?.drawText(
            invoiceNumber,
            0,
            invoiceNumber.length,
            left.dpToPx(),
            textY + yBound,
            textPaint
        )
        textAlignRight(textPaint)
        val date = "Date: $invoiceDate"
        canvas?.drawText(
            date,
            0,
            date.length,
            width.toFloat() - xMargin.dpToPx(),
            textY + yBound,
            textPaint
        )
        canvas?.drawLine(
            left.dpToPx(),
            yPointer.dpToPx(),
            width.toFloat() - xMargin.dpToPx(),
            yPointer.dpToPx(),
            textPaint
        )
    }
    private fun drawClientInfo(
        canvas: Canvas?, data: Model?
    ) {
        setPaintColor(contentBgPaint, getColor(R.color.white))
        setTextSize(textPaint, 16f)
        setPaintColor(textPaint, getColor(R.color.black))
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.BOLD_ITALIC))
        textAlignLeft(textPaint)
        val top = yPointer + yMargin
        val bottom = top + 110
        yPointer = bottom
        val rect = RectF(
            xMargin.dpToPx(),
            top.dpToPx(),
            width.toFloat() - xMargin.dpToPx(),
            bottom.dpToPx()
        )
        canvas?.drawRect(rect, contentBgPaint)
        val textBounds = Rect()
        textPaint.getTextBounds(data?.client!!.name, 0, data.client.name.length, textBounds)
        val yBound = textBounds.height().toFloat() + (textSpacing + 2).dpToPx()
        val left = xMargin + xPadding
        val textY = rect.top + yPadding
        canvas?.drawText(
            "Bill To",
            0,
            7,
            left.dpToPx(),
            textY + yBound,
            textPaint
        )
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.NORMAL))
        canvas?.drawText(
            data.client.name,
            0,
            data.client.name.length,
            left.dpToPx(),
            textY + (yBound * 2),
            textPaint
        )
        canvas?.drawText(
            data.client.address,
            0,
            data.client.address.length,
            left.dpToPx(),
            textY + (yBound * 3),
            textPaint
        )
        canvas?.drawText(
            data.client.email,
            0,
            data.client.email.length,
            left.dpToPx(),
            textY + (yBound * 4),
            textPaint
        )
    }
    private fun drawItemHeader(canvas: Canvas?) {
        setTextSize(textPaint, 16f)
        setPaintColor(textPaint, getColor(R.color.white))
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.BOLD))
        textAlignLeft(textPaint)
        val top = yPointer + yMargin
        val bottom = top + 40
        val right = width.toFloat()
        yPointer = bottom
        val rect = RectF(xMargin.dpToPx(), top.dpToPx(), right - xMargin.dpToPx(), bottom.dpToPx())
        canvas?.drawRect(rect, titleBgPaint)
        val description = "Item)"
        val hours = "Quantity"
        val price = "Price)"
        val headerTopMargin = 10f
        canvas?.drawText(
            description,
            0,
            description.length,
            xMargin * 2.dpToPx(),
            rect.centerY() + headerTopMargin,
            textPaint
        )
        canvas?.drawText(
            hours,
            0,
            hours.length,
            (width / 2).toFloat(),
            rect.centerY() + headerTopMargin,
            textPaint
        )
        textAlignRight(textPaint)
        canvas?.drawText(
            price,
            0,
            price.length,
            width.toFloat() - xMargin * 2.dpToPx(),
            rect.centerY() + headerTopMargin,
            textPaint
        )
    }
    private fun drawItems(canvas: Canvas?, data: Model?) {
        setPaintColor(contentBgPaint, getColor(R.color.black))
        setTextSize(textPaint, 16f)
        setPaintColor(textPaint, getColor(R.color.black))
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.NORMAL))
        textAlignLeft(textPaint)
        val hours = "resources.getString(R.string.hours)"
        val textBounds = Rect()
        textPaint.getTextBounds(hours, 0, hours.length, textBounds)
        val xBound = textBounds.width().toFloat()
        val yBound = textBounds.height().toFloat() + (textSpacing + 2).dpToPx()
        val top = yPointer + yMargin
        val bottom = top + calculateNormalizedTableHeight(data?.items!!.size, yBound.toInt())
        val right = width.toFloat()
        yPointer = bottom
        val rect = RectF(xMargin.dpToPx(), top.dpToPx(), right - xMargin.dpToPx(), bottom.dpToPx())
        canvas?.drawRect(rect, contentBgPaint)
        val textY = rect.top + yPadding
        var yBoundFactor = 1
        for (item in data?.items!!) {
            textAlignLeft(textPaint)
            canvas?.drawText(
                item.name,
                0,
                item.name.length,
                xMargin * 2.dpToPx(),
                textY + (yBound * yBoundFactor),
                textPaint
            )
            textAlignRight(textPaint)
            val hours = item.hours.toString()
            canvas?.drawText(
                hours,
                0,
                hours.length,
                (width / 2) + xBound,
                textY + (yBound * yBoundFactor),
                textPaint
            )
            val price: String = currencySymbol + item.rate
            canvas?.drawText(
                price,
                0,
                price.length,
                width.toFloat() - xMargin * 2.dpToPx(),
                textY + (yBound * yBoundFactor),
                textPaint
            )
            yBoundFactor++
        }
    }
    private fun drawTotal(canvas: Canvas?, data: Model?) {
        setTextSize(textPaint, 16f)
        setPaintColor(textPaint, getColor(R.color.black))
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.BOLD))
        textAlignRight(textPaint)
        val total = "Total  " + "700.00"
        val top = yPointer + yMargin * 3
        val bottom = top + 50
        yPointer = bottom
        canvas?.drawText(
            total,
            0,
            total.length,
            width.toFloat() - (xMargin * 2).dpToPx(),
            top.dpToPx(),
            textPaint
        )
    }
    private fun drawFooter(
        canvas: Canvas?,
        data: Model?
    ) {
        val top = height - 30.toFloat()
        val bottom = height - 10
        val rect = RectF(
            xMargin.dpToPx(),
            top,
            width.toFloat() - xMargin.dpToPx(), bottom - yMargin.dpToPx()
        )
        setPaintColor(textPaint, getColor(R.color.black))
        setTextSize(textPaint, 12f)
        setTypFace(textPaint, Typeface.create(Typeface.DEFAULT_BOLD, Typeface.NORMAL))
        textAlignLeft(textPaint)
        val mailTo = "Sent by: ${data!!.userEmail}"
        canvas?.drawText(
            mailTo,
            0,
            mailTo.length,
            xMargin * 2.dpToPx(),
            top,
            textPaint
        )
        textAlignRight(textPaint)
        val greeting = "Thank you"
        canvas?.drawText(
            greeting,
            0,
            greeting.length,
            width.toFloat() - xMargin * 2.dpToPx(),
            top,
            textPaint
        )
        canvas?.drawLine(
            xMargin * 2.dpToPx(),
            bottom.toFloat(),
            width.toFloat() - xMargin.dpToPx(),
            bottom.toFloat(),
            textPaint
        )
    }
    private fun calculateNormalizedTableHeight(size: Int, textBoundHeight: Int): Int {
        return size * textBoundHeight
    }
    private fun getColor(colorId: Int) = ContextCompat.getColor(context, colorId)
    private fun setTextSize(paint: Paint, size: Float) {
        paint.textSize = size.spToPx()
    }
    private fun setPaintColor(paint: Paint, color: Int) {
        paint.color = color
    }
    private fun setTypFace(paint: Paint, typeface: Typeface) {
        paint.typeface = typeface
    }
    private fun textAlignCentre(paint: Paint) {
        paint.textAlign = Paint.Align.CENTER
    }
    private fun textAlignLeft(paint: Paint) {
        paint.textAlign = Paint.Align.LEFT
    }
    private fun textAlignRight(paint: Paint) {
        paint.textAlign = Paint.Align.RIGHT
    }
    private fun Float.dpToPx() = this * resources.displayMetrics.density
    private fun Int.dpToPx() = (this * resources.displayMetrics.density).toInt()
    private fun Float.spToPx() = this * resources.displayMetrics.scaledDensity
    private fun Int.pxToDp() = (this * 160) / resources.displayMetrics.densityDpi
    fun setData(invoiceUIData: Model?) {
        this.data = invoiceUIData
    }
    fun setBackgroundPaint(templateId: Int?) {
        when (templateId) {
            1 -> titleBgPaint.color = ContextCompat.getColor(context, R.color.black)
            2 -> titleBgPaint.color = ContextCompat.getColor(context, R.color.black)
            3 -> titleBgPaint.color = ContextCompat.getColor(context, R.color.black)
            4 -> titleBgPaint.color = ContextCompat.getColor(context, R.color.black)
            else -> {
                titleBgPaint.color = ContextCompat.getColor(context, R.color.black)
            }
        }
    }
    fun generatePdf(uiData: Model?, file: FileDescriptor?) {
        val pdfDocument = PdfDocument()
        val page = pdfDocument.startPage(pageInfo(595, 842, 1))
        if (file != null) {
            designPage(page, pdfDocument, uiData, file)
        }
    }

    private fun pageInfo(pageWidth: Int, pageHeight: Int, pageNumber: Int): PdfDocument.PageInfo {
        return PdfDocument.PageInfo.Builder(pageWidth, pageHeight, pageNumber).create()
    }
    // drawing in pdf page canvas. Reuse the functions used in
// Simple template. Note: Remove dpToPx() while drawing in PDF page // canvas.
    private fun designPage(
        page: PdfDocument.Page,
        pdfDocument: PdfDocument,
        invoiceUIData: Model?,
        file: FileDescriptor

    ) {
        val canvas: Canvas = page.canvas
//        width = page.canvas.width
//        height = page.canvas.height
        setBackgroundPaint(1)
        drawHeader(canvas)
        drawCompanyInfo(canvas, invoiceUIData)
        drawDue(canvas, invoiceUIData)
        drawClientInfo(canvas, invoiceUIData)
        drawItemHeader(canvas)
        drawItems(canvas, invoiceUIData)
        drawTotal(canvas, invoiceUIData)
        drawFooter(canvas, invoiceUIData)
        pdfDocument.finishPage(page)
        writeContentToFile(file, pdfDocument)
    }
    // save the file as PDF in local storage
    private fun writeContentToFile(file: FileDescriptor, pdfDocument: PdfDocument) {
        val fos = FileOutputStream(file)
        pdfDocument.writeTo(fos)
        pdfDocument.close()
    }
}