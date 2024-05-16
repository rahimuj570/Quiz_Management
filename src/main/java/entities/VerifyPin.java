package entities;

import java.util.Date;

public class VerifyPin {
	long user_id;
	String pin_code;
	Date expire_date = new Date(new Date().getTime() + 600000);

	public VerifyPin() {
		super();
	}

	public long getUser_id() {
		return user_id;
	}

	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}

	public String getPin_code() {
		return pin_code;
	}

	public void setPin_code(String pin_code) {
		this.pin_code = pin_code;
	}

	public Date getExpire_date() {
		return expire_date;
	}

	public void setExpire_date(Date expire_date) {
		this.expire_date = expire_date;
	}

	@Override
	public String toString() {
		return "VerifyPin [user_id=" + user_id + ", pin_code=" + pin_code + ", expire_date=" + expire_date + "]";
	}

}
