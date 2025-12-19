package com.example.week_3.navigation

import androidx.compose.runtime.Composable
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import com.example.calculator.CalculatorScreen
import com.example.inputlist.InputListScreen

@Composable
fun AppNavHost() {
    val navController = rememberNavController()

    NavHost(
        navController = navController,
        startDestination = Screen.InputList.route
    ) {

        composable(Screen.InputList.route) {
            InputListScreen(
                onNavigateCalculator = {
                    navController.navigate(Screen.Calculator.route)
                }
            )
        }

        composable(Screen.Calculator.route) {
            CalculatorScreen(
                onBack = {
                    navController.popBackStack()
                }
            )
        }
    }
}
