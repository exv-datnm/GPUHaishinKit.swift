import GPUImage
import HaishinKit
import Foundation

public extension NetStream {
  private static let tag: String = "com.haishinkit.GPUHaishinKit.GPUImageRawOutput"
  private static let size: CGSize = CGSize(width: 355, height: 288)
  
  var rawDataOutput: GPUImageRawDataOutput {
    if let output:HaishinGPUImageRawOutput = metadata[NetStream.tag] as? HaishinGPUImageRawOutput {
      return output
    }
    
    var size:CGSize?
    if let width: CGFloat = videoSettings[H264Encoder.Option.width] as? CGFloat,
       let height:CGFloat = videoSettings[H264Encoder.Option.height] as? CGFloat {
      size = CGSize(width: width, height: height)
    }
    let output:HaishinGPUImageRawOutput = HaishinGPUImageRawOutput(imageSize: size ?? NetStream.size)
    output.delegate = self
    metadata[NetStream.tag] = output
    return output
  }
  
  #if os(iOS)
  func attachGPUImageVideoCamera(_ camera: GPUImageVideoCamera) {
    mixer.session = camera.captureSession
  }
  #endif
}

