//
//  LocalCoreRpcMethod.swift
//  redundant-peer-helper
//
//  Created by Alex Bosworth on 9/30/16.
//  Copyright © 2016 Adylitica. All rights reserved.
//

import Foundation

/** Core RPC Methods
 */
enum LocalCoreRpcMethod {
    /** Determine a fee given max blocks to wait
     */
    case estimateFee(givenMaxBlocksToWait: Int)
    
    /** Retrieve the best block hash
     */
    case getBestBlockHash
    
    /** Retrieve information about the local Blockchain
     */
    case getBlockchainInfo
    
    /** Map block height to hash
     */
    case getBlockHash(forHeight: Int)
    
    /** Pull an individual block
     */
    case getHexSerializedBlock(hash: BlockHash)
    
    /** Get mempool transactions
    */
    case getMempoolTransactions
    
    /** Determine peer info
     */
    case getPeerInfo
    
    /** Push block into local Blockchain
     */
    case importBlock(hexSerializedBlock: HexSerializedBlock)
    
    /** Get the JSON request parameters
     */
    var jsonParams: AnyObject {
        let params: [AnyObject]
        
        switch self {
        case .estimateFee(let maxBlockCount):
            params = [NSNumber(value: maxBlockCount)]
            
        case .getBestBlockHash, .getBlockchainInfo, .getPeerInfo:
            params = []
            
        case .getBlockHash(forHeight: let height):
            params = [NSNumber(value: height)]
            
        case .getHexSerializedBlock(let hash):
            params = [hash.asString as NSString, NSNumber(value: false)]
            
        case .getMempoolTransactions:
            params = [NSNumber(value: true)]
            
        case .importBlock(let serializedBlock):
            params = [serializedBlock.stringValue as NSString]
        }
        
        return params.isEmpty ? NSNull() : params as NSArray
    }
    
    /** Get the RPC method call name
     */
    var rpcName: String {
        switch self {
        case .estimateFee( _):
            return "estimatefee"
            
        case .getBestBlockHash:
            return "getbestblockhash"
            
        case .getBlockchainInfo:
            return "getblockchaininfo"
            
        case .getBlockHash(forHeight: _):
            return "getblockhash"
            
        case .getHexSerializedBlock(hash: _):
            return "getblock"
            
        case .getMempoolTransactions:
            return "getrawmempool"
            
        case .getPeerInfo:
            return "getpeerinfo"
            
        case .importBlock(hexSerializedBlock: _):
            return "submitblock"
        }
    }
}