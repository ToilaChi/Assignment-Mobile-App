package com.example.inputlist

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.material3.MaterialTheme
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun InputListScreen(onNavigateCalculator: () -> Unit) {
    var input by remember { mutableStateOf("") }
    var errorMessage by remember { mutableStateOf<String?>(null) }
    var numbers by remember { mutableStateOf(listOf<Int>()) }

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

        Spacer(modifier = Modifier.height(16.dp))

        Row(verticalAlignment = Alignment.CenterVertically) {

            OutlinedTextField(
                value = input,
                onValueChange = { input = it },
                modifier = Modifier.weight(1f),
                label = { Text("Nhập vào số lượng") },
                singleLine = true
            )

            Spacer(modifier = Modifier.width(8.dp))

            Button(onClick = {
                val value = input.toIntOrNull()
                if (value == null || value <= 0) {
                    errorMessage = "Dữ liệu bạn nhập không hợp lệ"
                    numbers = emptyList()
                } else {
                    errorMessage = null
                    numbers = (1..value).toList()
                }
            }) {
                Text("Tạo")
            }
        }

        errorMessage?.let {
            Spacer(modifier = Modifier.height(8.dp))
            Text(text = it, color = Color.Red)
        }

        Spacer(modifier = Modifier.height(16.dp))

        Button(
            onClick = onNavigateCalculator,
            modifier = Modifier.fillMaxWidth()
        ) {
            Text("Sang Calculator")
        }

        LazyColumn {
            items(numbers) { number ->
                Box(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(vertical = 6.dp)
                        .background(Color.Red, RoundedCornerShape(25.dp))
                        .padding(16.dp)
                ) {
                    Text(
                        text = number.toString(),
                        color = Color.White,
                        fontSize = 18.sp,
                        textAlign = TextAlign.Center,
                        modifier = Modifier.fillMaxWidth()
                    )
                }
            }
        }
    }
}
