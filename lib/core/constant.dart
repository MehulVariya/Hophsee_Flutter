const host = "http://192.168.121.108:8000";
//const host = "http://192.168.137.254:8000";
//const host = "http://localhost:8000";
//const host = "http://192.168.56.1:8000";

const userEp = "$host/users";
const loginUserEp = "$userEp/login";

const doctorEp = "$host/doctors";
const loginDoctorEp = "$doctorEp/login";

const paymentEp = "$host/payments";

const appoEp = "$host/appoinments";

const DOCTOR_ID_PREFERENCE = "doctor_id";
const USER_ID_PREFERENCE = "user_id";
const NAME_PREFERENCE = "name";
const IMAGE_URL_PREFERENCE = "image_url";
const IS_DOCTOR_PREFERENCE = "is_doctor";
const IS_LOGIN_PREFERENCE = "is_login";
const APPO_DATE_PREFERENCE = "appo_date";
const APPO_TIME_PREFERENCE = "appo_time";
