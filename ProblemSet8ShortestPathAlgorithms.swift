// MARK: Only [743. Network Delay Time] passed. The rest failed.
import Foundation

// MARK: networkDelayTime - WORKS
func networkDelayTime(_ times: [[Int]], _ n: Int, _ k: Int) -> Int {
//    struct Edge {
//        let v: Int
//        let w: Int
//    }

    func dijkstra(_ adj: [[(v: Int, w: Int)]], _ src: Int) -> [Int] {
        let n = adj.count-1 // number of vertices.
        var d = [Int](repeating: Int.max, count: n+1)
        var c = [Bool](repeating: false, count: n+1)
        
        var minVertex = src
        d[src] = 0
        c[src] = true
        
//        print(d)
//        print(c)
//        print("--")
        
        // do n-1 times!
        for _ in 0..<n-1 {
            
//            print(d)
//            print(c)
//            print("--")
            
            // all edges that this min vertex flows to!
            for edge in adj[minVertex] {
                let v = edge.v
//                print("--")
                if d[v] > d[minVertex] + edge.w {
                    d[v] = d[minVertex] + edge.w
                }
            }
            
//            print(d)
//            print(c)
//            print("--")
            c[minVertex] = true
            
            // go through all n vertex to get min, BUT only non-checked ones!
            var minValue = Int.max
            for v in 1...n {
                if !c[v] && d[v] < minValue {
                    minValue = d[v]
                    minVertex = v
                }
            }
            
//            print("minValue", minValue)
//            print("minVertex", minVertex)
            
//            print(d)
//            print(c)
//            print("--")
        }
        
        return d
    }
    
    var adj = [[(v: Int, w: Int)]](repeating: [], count: n+1)
//    adj[1].append((v: 2, w: 3))
    for time in times {
        adj[time[0]].append((v: time[1], w: time[2]))
    }
    
//    print(times)
//    print(n)
//    print(k)
    
//    for (i, edge) in adj.enumerated() {
//        print(i, edge)
//    }
    
    var d = dijkstra(adj, k)
    d.removeFirst()
    let res = d.max(by: <)!
    
    if res == Int.max {
        return -1
    }
    
    return res
}

// MARK: findCheapestPrice - This timeouts!! - has cycle!!
func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ k: Int) -> Int {

    var adj = [[(v: Int, w: Int)]](repeating: [], count: n)
    for edge in flights {
        adj[edge[0]].append((v: edge[1], w: edge[2]))
    }
    
    for edge in adj {
        print(edge)
    }
    
    var res = Int.max
    
    func dfs(_ u: Int, _ dst: Int, _ k: Int, _ dist: Int, _ step: Int) {
        
        if u == dst && step <= k+1 && res > dist {
            print(u, dist, step)
            res = dist
            return
        }
        
        if u == dst || step > k+1 {
            return
        }
        
        for edge in adj[u] {
            var d = dist + edge.w
            var s = step + 1
            print(u, edge.v, d, s)
            dfs(edge.v, dst, k, d, s)
        }
    }
    
    dfs(src, dst, k, 0, 0)
    print(res)
    
    return res == Int.max ? -1 : res
}

// MARK: maxProbability - Doesn't work!
func maxProbability(_ n: Int, _ edges: [[Int]], _ succProb: [Double], _ start: Int, _ end: Int) -> Double {
    
    func dijkstra(_ adj: [[(v: Int, w: Double)]], _ src: Int) -> [Double] {
        let n = adj.count-1 // number of vertices.
        var d = [Double](repeating: 0.0, count: n+1)
        var c = [Bool](repeating: false, count: n+1)
        
        var maxVertex = src
        d[src] = 1
        c[src] = true
        
//        print(d)
//        print(c)
//        print("--")
        
        // do n-1 times!
        for _ in 0..<n-1 {
            
//            print(d)
//            print(c)
//            print("--")
            
            // all edges that this min vertex flows to!
            for edge in adj[maxVertex] {
                let v = edge.v
//                print("--")
                if d[v] < (d[maxVertex] * edge.w) {
                    d[v] = (d[maxVertex] * edge.w)
                }
            }
            
//            print(d)
//            print(c)
//            print("--")
            c[maxVertex] = true
            
            // go through all n vertex to get min, BUT only non-checked ones!
            var maxValue = 0.0
            for v in 1...n {
                if !c[v] && d[v] >= maxValue {
                    maxValue = d[v]
                    maxVertex = v
                }
            }
            
            print("maxValue", maxValue)
            print("maxVertex", maxVertex)
            
//            print(d)
//            print(c)
            print("--")
        }
        
        return d
    }
    
    var adj = [[(v: Int, w: Double)]](repeating: [], count: n+1)
//    adj[1].append((v: 2, w: 3))
    for i in 0..<edges.count {
        adj[edges[i][0]+1].append((v: edges[i][1]+1, w: succProb[i]))
        adj[edges[i][1]+1].append((v: edges[i][0]+1, w: succProb[i]))
    }
    
//    print(times)
//    print(n)
//    print(k)
    
    for (i, edge) in adj.enumerated() {
        print(i, edge)
    }
    
    for a in adj {
        print(a)
    }
    
    var d = dijkstra(adj, start+1)
    print(d)
//    d.removeFirst()
//    let res = d.max(by: <)!
//
//    if res == Int.max {
//        return -1
//    }
//
//    return res
    return -1
}
