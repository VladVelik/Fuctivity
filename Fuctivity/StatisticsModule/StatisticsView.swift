//
//  StatisticsView.swift
//  Fuctivity
//
//  Created by Nik Y on 22.04.2023.
//

import SwiftUI
import Charts

struct StatisticView: View {
    @State private var selectedWeek = 0
    @StateObject var viewModel = StatisticsViewModel()
    @State var isLineGraph = false
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 12) {
                    let total = viewModel.data.reduce(0.0) { partialRes, item in
                        item.duration + partialRes
                    }
                    
                    HStack {
                        Text(total.hourWeekFormat)
                            .font(.title3.bold())
                        Spacer()
                    }
                    
                    AnimatedChart()
                    
                    HStack {
                        Button(action: {
                            selectedWeek -= 1
                        }) {
                            Image(systemName: "arrow.left")
                        }
                        
                        Text(viewModel.getWeekText(week: selectedWeek))
                        
                        Button(action: {
                            
                            selectedWeek += 1
                        }) {
                            Image(systemName: "arrow.right")
                        }
                    }
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                }
                
                Toggle("Линейный график", isOn: $isLineGraph)
                    .padding(.top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Статистика")
            .onAppear() {
                viewModel.getDailyDurations(week: selectedWeek)
            }
            .onChange(of: selectedWeek) { newValue in
                viewModel.getDailyDurations(week: selectedWeek)
                animateGraph(fromChange: true)
            }
        }
    }
    
    @ViewBuilder
    func AnimatedChart() -> some View {
        Chart {
            ForEach(viewModel.data) { item in
                if isLineGraph {
                    LineMark(
                        x: .value("Day", item.date, unit: .day),
                        y: .value("Dur", item.animate ? item.duration : 0)
                    )
                    .foregroundStyle(Color.blue.gradient)
                    .interpolationMethod(.catmullRom)
                } else {
                    BarMark(
                        x: .value("Day", item.date, unit: .day),
                        y: .value("Dur", item.animate ? item.duration : 0)
                    )
                    .foregroundStyle(Color.blue.gradient)
                }
                
                if isLineGraph {
                    AreaMark(
                        x: .value("Day", item.date, unit: .day),
                        y: .value("Dur", item.animate ? item.duration : 0)
                    )
                    .foregroundStyle(Color.blue.opacity(0.1).gradient)
                    .interpolationMethod(.catmullRom)
                }
            }
        }
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: 7)) { _ in
                AxisValueLabel(format: .dateTime.weekday())
                    .foregroundStyle(Color.black)
                AxisTick()
                AxisGridLine()
            }
        }
        .chartYAxis {
            AxisMarks(values: .automatic) { _ in
                AxisValueLabel()
                    .foregroundStyle(Color.black)
                AxisGridLine()
            }
        }
        .chartYScale(domain: 0...(16))
        .frame(height: 250)
        .onAppear() {
            animateGraph()
        }
    }
    
    func animateGraph(fromChange: Bool = false) {
        for (index, _) in viewModel.data.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)*(fromChange ? 0.03 : 0.05)) {
                withAnimation(fromChange ? .easeInOut(duration: 0.8) : .interactiveSpring(response: 0.8, dampingFraction: 0.8, blendDuration: 0.8)) {
                    viewModel.data[index].animate = true
                }
            }
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView()
    }
}

extension Double {
    var hourWeekFormat: String {
        return "\(Int(self)) ч. за неделю"
    }
}


struct HoursFormatStyle: FormatStyle {
    func format(_ value: Double) -> String {
        let hours = value / 3600
        return String(format: "%.2f", hours)
    }
}

extension Double {
    var hoursFormatStyle: HoursFormatStyle {
        HoursFormatStyle()
    }
}
