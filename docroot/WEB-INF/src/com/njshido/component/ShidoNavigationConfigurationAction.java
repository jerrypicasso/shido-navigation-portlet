package com.njshido.component;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

public class ShidoNavigationConfigurationAction extends DefaultConfigurationAction {
	
	public static final String SHIDO_NAVIGATION_TITLE = "SHIDO_NAVIGATION_TITLE";
	public static final String SHIDO_NAVIGATION_LINK = "SHIDO_NAVIGATION_LINK";
	
	public static final String SHIDO_NAVIGATION_HEIGHT = "SHIDO_NAVIGATION_HEIGHT";
	public static final String SHIDO_NAVIGATION_BG_COLOR = "SHIDO_NAVIGATION_BG_COLOR";
	public static final String SHIDO_NAVIGATION_FONT_COLOR = "SHIDO_NAVIGATION_FONT_COLOR";
	public static final String SHIDO_NAVIGATION_FONT_SIZE = "SHIDO_NAVIGATION_FONT_SIZE";
	
	private static final String CONFIG_JSP = "/WEB-INF/config/config.jsp";
	private static final String SUCCESS = "success";
	
	public static final String SHIDO_NAVIGATION_HEIGHT_DEFAULT_VAL = "120";
	public static final String SHIDO_NAVIGATION_BG_COLOR_DEFAULT_VAL = "#f7f7f7";
	public static final String SHIDO_NAVIGATION_FONT_COLOR_DEFAULT_VAL = "#000000";
	public static final String SHIDO_NAVIGATION_FONT_SIZE_DEFAULT_VAL = "18";
	
	@Override
	public String render(PortletConfig portletConfig, RenderRequest renderRequest, RenderResponse renderResponse)
			throws Exception {
		String portletId = renderRequest.getParameter("portletResource");
		PortletPreferences preferences = PortletPreferencesFactoryUtil.getPortletSetup(renderRequest, portletId);
		renderRequest.setAttribute(SHIDO_NAVIGATION_TITLE, preferences.getValues(SHIDO_NAVIGATION_TITLE, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_NAVIGATION_LINK, preferences.getValues(SHIDO_NAVIGATION_LINK, StringPool.EMPTY_ARRAY));
		renderRequest.setAttribute(SHIDO_NAVIGATION_HEIGHT, preferences.getValue(SHIDO_NAVIGATION_HEIGHT, SHIDO_NAVIGATION_HEIGHT_DEFAULT_VAL));
		renderRequest.setAttribute(SHIDO_NAVIGATION_BG_COLOR, preferences.getValue(SHIDO_NAVIGATION_BG_COLOR, SHIDO_NAVIGATION_BG_COLOR_DEFAULT_VAL));
		renderRequest.setAttribute(SHIDO_NAVIGATION_FONT_COLOR, preferences.getValue(SHIDO_NAVIGATION_FONT_COLOR, SHIDO_NAVIGATION_FONT_COLOR_DEFAULT_VAL));
		renderRequest.setAttribute(SHIDO_NAVIGATION_FONT_SIZE, preferences.getValue(SHIDO_NAVIGATION_FONT_SIZE, SHIDO_NAVIGATION_FONT_SIZE_DEFAULT_VAL));
		return CONFIG_JSP;
	}
	
	@Override
	public void processAction(PortletConfig portletConfig,
			ActionRequest actionRequest, ActionResponse actionResponse)
			throws Exception {
		String portletResource = ParamUtil.getString(actionRequest, "portletResource");
		PortletPreferences preferences = PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource);
		if (Validator.isNotNull(preferences)) {
			String[] titles = ParamUtil.getParameterValues(actionRequest, SHIDO_NAVIGATION_TITLE);
			String[] links = ParamUtil.getParameterValues(actionRequest, SHIDO_NAVIGATION_LINK);
			String height = ParamUtil.getString(actionRequest, SHIDO_NAVIGATION_HEIGHT);
			String bgColor = ParamUtil.getString(actionRequest, SHIDO_NAVIGATION_BG_COLOR);
			String fontColor = ParamUtil.getString(actionRequest, SHIDO_NAVIGATION_FONT_COLOR);
			String fontSize = ParamUtil.getString(actionRequest, SHIDO_NAVIGATION_FONT_SIZE);
			
			preferences.setValue(SHIDO_NAVIGATION_BG_COLOR, bgColor);
			preferences.setValue(SHIDO_NAVIGATION_FONT_COLOR, fontColor);
			preferences.setValue(SHIDO_NAVIGATION_HEIGHT, height);
			preferences.setValue(SHIDO_NAVIGATION_FONT_SIZE, fontSize);
			preferences.setValues(SHIDO_NAVIGATION_TITLE, titles);
			preferences.setValues(SHIDO_NAVIGATION_LINK, links);
			preferences.store();
			
			SessionMessages.add(actionRequest, SUCCESS);
		}
		super.processAction(portletConfig, actionRequest, actionResponse);
	}
	
}
