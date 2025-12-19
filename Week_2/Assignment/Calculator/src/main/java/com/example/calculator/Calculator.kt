package com.example.calculator

import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun CalculatorScreen(onBack: () -> Unit) {

    var num1 by remember { mutableStateOf("") }
    var num2 by remember { mutableStateOf("") }
    var selectedOp by remember { mutableStateOf("+") }
    var result by remember { mutableStateOf<String?>(null) }

    fun calculate() {
        val a = num1.toDoubleOrNull()
        val b = num2.toDoubleOrNull()

        if (a == null || b == null) {
            result = "Dữ liệu không hợp lệ"
            return
        }

        result = when (selectedOp) {
            "+" -> (a + b).toString()
            "-" -> (a - b).toString()
            "*" -> (a * b).toString()
            "/" -> if (b == 0.0) "Không chia được cho 0" else (a / b).toString()
            else -> ""
        }
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp)
            .padding(top = 40.dp)
    ) {

        Text(
            text = "Phạm Minh Chí",
            style = MaterialTheme.typography.titleLarge,
            modifier = Modifier.align(Alignment.CenterHorizontally)
        )

        Spacer(modifier = Modifier.height(20.dp))

        // Số thứ nhất
        OutlinedTextField(
            value = num1,
            onValueChange = {
                num1 = it
                calculate()
            },
            modifier = Modifier.fillMaxWidth(),
            label = { Text("Số thứ nhất") },
            singleLine = true
        )

        Spacer(modifier = Modifier.height(12.dp))

        // Các nút phép toán
        Row(
            modifier = Modifier.fillMaxWidth(),
            horizontalArrangement = Arrangement.SpaceBetween
        ) {
            OperatorButton("+", selectedOp) {
                selectedOp = "+"
                calculate()
            }
            OperatorButton("-", selectedOp) {
                selectedOp = "-"
                calculate()
            }
            OperatorButton("*", selectedOp) {
                selectedOp = "*"
                calculate()
            }
            OperatorButton("/", selectedOp) {
                selectedOp = "/"
                calculate()
            }
        }

        Spacer(modifier = Modifier.height(12.dp))

        // Số thứ hai
        OutlinedTextField(
            value = num2,
            onValueChange = {
                num2 = it
                calculate()
            },
            modifier = Modifier.fillMaxWidth(),
            label = { Text("Số thứ hai") },
            singleLine = true
        )

        Spacer(modifier = Modifier.height(16.dp))

        // Kết quả
        Text(
            text = "Kết quả: ${result ?: ""}",
            fontSize = 18.sp
        )

        Button(
            onClick = onBack,
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Back")
        }
    }
}
