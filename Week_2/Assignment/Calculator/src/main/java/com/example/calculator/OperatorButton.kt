package com.example.calculator

import androidx.compose.foundation.background
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

@Composable
fun OperatorButton(
    symbol: String,
    selectedOp: String,
    onClick: () -> Unit
) {
    val bgColor = if (symbol == selectedOp) Color.Black else Color.LightGray
    val textColor = if (symbol == selectedOp) Color.White else Color.Black

    Box(
        modifier = Modifier
            .size(60.dp)
            .background(bgColor, RoundedCornerShape(8.dp))
            .clickable { onClick() },
        contentAlignment = Alignment.Center
    ) {
        Text(
            text = symbol,
            color = textColor,
            fontSize = 20.sp
        )
    }
}
