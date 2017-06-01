package com.fei.generator.exception;

public class MapKeyAlreadyExistException extends RuntimeException {
	/**
	 * 
	 */
	private static final long serialVersionUID = -3821403714126730626L;
	private String message;

	public MapKeyAlreadyExistException(String message) {
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
