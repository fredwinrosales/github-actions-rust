use actix_web::{HttpResponse, Responder, web};

pub fn config(cfg: &mut web::ServiceConfig) {
    cfg.route("/ping", web::get().to(ping));
}

async fn ping() -> impl Responder {
    HttpResponse::Ok().body("pong")
}
