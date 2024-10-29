import SwiftUI

struct AssignmentDetail: View {
    var selectedAssignment: Assignment
    @State private var textColor: Color = .primary
    @State private var totalRemainingTime: Int // Total time in seconds
    @State private var timerRunning = false
    @State private var timer: Timer?

    init(selectedAssignment: Assignment) {
        self.selectedAssignment = selectedAssignment
        
        // Calculate total remaining time in seconds
        self._totalRemainingTime = State(initialValue: selectedAssignment.time * 60) // Converting minutes to seconds
    }

    var body: some View {
        VStack { // Detail Page for each Assignment
            Text(selectedAssignment.name)
                .font(.largeTitle)
                .foregroundColor(textColor)
                .padding()
            
            Text(selectedAssignment.description)
                .font(.body)
                .foregroundColor(textColor)
                .padding()
            
            // Calculate minutes and seconds for display purposes
            let minutes = totalRemainingTime / 60
            let seconds = totalRemainingTime % 60
            
            // Display the time remaining as MM:SS
            Text("Estimated Time Remaining: \(minutes):\(String(format: "%02d", seconds))")
                .font(.subheadline)
                .foregroundColor(textColor)
                .padding()
            
            Spacer()
        }
        .onTapGesture {
            // Toggle text color
            textColor = (textColor == .primary) ? .blue : .primary
            
            // Start or stop the timer based on its current state
            if timerRunning {
                stopTimer()
            } else {
                startTimer()
            }
        }
        .onDisappear {
            // Clean up timer when the view disappears
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func stopTimer() {
        timer?.invalidate() // Stop the timer
        timer = nil // Clean up the timer reference
        timerRunning = false
    }
    
    // Starts the countdown timer
    private func startTimer() {
        timerRunning = true
        
        // Start a timer that ticks every second
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if totalRemainingTime > 0 {
                totalRemainingTime -= 1 // Decrement total time
            } else {
                // Stop the timer when it reaches zero
                stopTimer()
            }
        }
    }
}

// Preview
struct AssignmentDetail_Previews: PreviewProvider {
    static var previews: some View {
        AssignmentDetail(selectedAssignment: Assignment(id: "123", name: "Sample Assignment", description: "This is a sample description", time: 2)) // Sample with 2 minutes
    }
}

