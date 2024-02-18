package com.example.shop_app

data class Model(
    val number: Long = 0,
    val date: String = "",
    val dueDate: String = "",
    val userName : String = "",
    val userLocation : String = "",
    val userEmail : String = "",
    val client: Client? = null,
    val items: List<Item>? = null,
)

data class Client(
    val name: String,
    val address: String,
    val email: String,
)

data class Item(
    val name: String,
    val rate: Double,
    val hours: Long,
)