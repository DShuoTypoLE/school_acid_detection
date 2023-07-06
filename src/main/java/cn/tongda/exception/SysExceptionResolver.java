package cn.tongda.exception;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 异常处理器
 * @author 丁硕
 * @version 1.0
 */
public class SysExceptionResolver implements HandlerExceptionResolver {

    /**
     * 跳转到具体的错误页面的方法
     * @param httpServletRequest
     * @param httpServletResponse
     * @param o
     * @param e
     * @return
     */
    @Override
    public ModelAndView resolveException(HttpServletRequest httpServletRequest,
                                         HttpServletResponse httpServletResponse,
                                         Object o, Exception e) {
        e.printStackTrace();
        SysException mye = null;
        // 获取到异常对象
        if(e instanceof SysException) {
            mye = (SysException) e;
        }else {
            mye = new SysException("页面走丢啦!请联系管理员");
        }
        ModelAndView mv = new ModelAndView();
        // 存入错误的提示信息
        mv.addObject("message", mye.getMessage());
        // 跳转的Jsp页面
        mv.setViewName("error");
        return mv;
    }
}
