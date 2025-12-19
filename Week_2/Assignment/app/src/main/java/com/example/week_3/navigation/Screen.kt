package com.example.week_3.navigation

sealed class Screen(val route: String) {
    data object InputList : Screen("input_list")
    data object Calculator : Screen("calculator")
}