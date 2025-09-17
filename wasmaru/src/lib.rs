wit_bindgen::generate!({
    // the name of the world in the `*.wit` input file
    world: "host",
});

// Define a custom type and implement the generated `Guest` trait for it which
// represents implementing all the necessary exported interfaces for this
// component.
struct MyHost;

impl Guest for MyHost {
    fn run(name: String) -> u32 {
        let msg = format!("Hello, {}!", name);
        print(&msg);

        name.len().try_into().unwrap_or(99)
    }
}

// export! defines that the `MyHost` struct defined below is going to define
// the exports of the `world`, namely the `run` function.
export!(MyHost);
