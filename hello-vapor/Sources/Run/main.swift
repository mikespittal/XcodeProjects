import App

/// We have isolated all of our App's logic into
/// the App module because it makes our app
/// more testable.
///
/// In general, the executable portion of our App
/// shouldn't include much more code than is presented
/// here.
///
/// We simply initialize our Droplet, optionally
/// passing in values if necessary
/// Then, we pass it to our App's setup function
/// this should setup all the routes and special
/// features of our app
///
/// .run() runs the Droplet's commands,
/// if no command is given, it will default to "serve"



let config = try Config()
try config.setup()

let drop = try Droplet(config)
try drop.setup()
try drop.run()

//drop.get{request in
//    return try JSON(node: [
//        "message" : "Hello my name is mikey"
//    ])
//}
//
//
//
//drop.get("hello") {request in
//    return "Hello my name is mikey!!!!!!!!!!!!"
//}
//
//drop.get("hello", "there") {request in
//    return "stopppppp!!"
//}
//
//drop.post("post") { request in
//    guard let name = request.data["name"]?.string else {
//        throw Abort.badRequest
//    }
//    return try JSON(node: [
//        "message" : "hello \(name)"
//        ])
//}

//drop.get("hello", Int) { request, beers in
//    return try JSON(node: [
//        "message" : "The number of beers are \(beers)"
//        ])
//}

//try drop.run()


