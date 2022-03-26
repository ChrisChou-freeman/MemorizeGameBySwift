//
//  Pie.swift
//  Memorize
//
//  Created by ChrisChou on 2022/3/25.
//

import SwiftUI


// draw a pie shape
struct Pie: Shape{
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = true
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(
            center: center,
            radius: radius,
            startAngle: self.startAngle,
            endAngle: self.endAngle,
            clockwise: self.clockwise
        )
        p.addLine(to: center)
        return p
    }
}
