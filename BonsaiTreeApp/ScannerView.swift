import SwiftUI
import CoreNFC
import AVFoundation

struct ScannerView: View {
    var body: some View {
        VStack {
            Button("Scan NFC Tag") {
                // Start NFC scanning
            }
            .padding()

            Button("Scan QR Code") {
                // Start QR code scanning
            }
            .padding()
        }
        .navigationTitle("Scan")
    }
}