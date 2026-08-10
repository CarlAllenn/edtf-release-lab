use pgrx::prelude::*;

::pgrx::pg_module_magic!();

/// The one thing the extension exists to do, callable from SQL.
#[pg_extern]
fn lab_answer() -> i32 {
    lab_core::answer() as i32
}

/// Names the version, so an upgraded installation can say what it runs.
#[pg_extern]
fn lab_version() -> String {
    env!("CARGO_PKG_VERSION").to_string()
}

#[cfg(any(test, feature = "pg_test"))]
#[pg_schema]
mod tests {
    use pgrx::prelude::*;

    #[pg_test]
    fn answers() {
        assert_eq!(crate::lab_answer(), 42);
    }
}

#[cfg(test)]
pub mod pg_test {
    pub fn setup(_options: Vec<&str>) {}
    pub fn postgresql_conf_options() -> Vec<&'static str> {
        vec![]
    }
}
