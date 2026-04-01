package com.nyangnyang.water

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class WaterWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.water_widget)

            val currentMl = widgetData.getInt("currentMl", 0)
            val goalMl = widgetData.getInt("goalMl", 2000)
            val percent = widgetData.getInt("percent", 0)
            val catMessage = widgetData.getString("catMessage", "물 마시자! 💧") ?: "물 마시자! 💧"

            views.setTextViewText(R.id.tv_progress, "${percent}%")
            views.setTextViewText(R.id.tv_amount, "${currentMl}ml / ${goalMl}ml")
            views.setTextViewText(R.id.tv_message, catMessage)

            // Cat emoji based on progress
            val catEmoji = when {
                percent >= 100 -> "😸"
                percent >= 70 -> "😺"
                percent >= 30 -> "🐱"
                else -> "😿"
            }
            views.setTextViewText(R.id.tv_cat, catEmoji)

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
