package cn.tongda.exception;

/**
 * 自定义异常类
 * @author 丁硕
 * @version 1.0
 */
public class SysException extends Exception{

    private String message;

    public SysException() {
    }

    public SysException(String message) {
        this.message = message;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
