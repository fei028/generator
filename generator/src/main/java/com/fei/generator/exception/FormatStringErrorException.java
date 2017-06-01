package com.fei.generator.exception;

@SuppressWarnings("serial")
public class FormatStringErrorException extends RuntimeException {
	private String message;

	public FormatStringErrorException(String message) {
		super(message);
		this.message = message;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
}
