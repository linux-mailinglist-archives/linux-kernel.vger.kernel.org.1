Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81CED2AAA88
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 11:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgKHKRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 05:17:04 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:48588 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKHKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:17:04 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4FC7D80534;
        Sun,  8 Nov 2020 11:17:00 +0100 (CET)
Date:   Sun, 8 Nov 2020 11:16:59 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Vinay Simha BN <simhavcs@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH RESEND v2] drm/bridge/tc358775: Fixes bus formats read
Message-ID: <20201108101659.GE1129714@ravnborg.org>
References: <1603349147-3495-1-git-send-email-simhavcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603349147-3495-1-git-send-email-simhavcs@gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8
        a=jR0aiFpPjobASAg4OfgA:9 a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Thu, Oct 22, 2020 at 12:15:47PM +0530, Vinay Simha BN wrote:
> - atomic_check removed
> - video data input and output formats added
> - bus formats read from drm_bridge_state.output_bus_cfg.format
>   and .atomic_get_input_bus_fmts() instead of connector
> 
> Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>

could you try to find time to review this patch?

You already provided valuable feedback and it looks fine to me.
But it would be perfect if you could find time to take a look.

Thanks in advance,

	Sam

> 
> ---
> v1:
>  * Laurent Pinchart review comments incorporated
>    drm_bridge_state.output_bus_cfg.format
>    instead of connector
> v2:
>  * Laurent Pinchart review comments incorporated
>    atomic_check removed
>    video data input and output formats added
> ---
>  drivers/gpu/drm/bridge/tc358775.c | 75 ++++++++++++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
> index 2272adc..cc27570 100644
> --- a/drivers/gpu/drm/bridge/tc358775.c
> +++ b/drivers/gpu/drm/bridge/tc358775.c
> @@ -271,6 +271,20 @@ struct tc_data {
>  	struct gpio_desc	*stby_gpio;
>  	u8			lvds_link; /* single-link or dual-link */
>  	u8			bpc;
> +	u32			output_bus_fmt;
> +};
> +
> +static const u32 tc_lvds_in_bus_fmts[] = {
> +	MEDIA_BUS_FMT_RGB565_1X16,
> +	MEDIA_BUS_FMT_RGB666_1X18,
> +	MEDIA_BUS_FMT_RGB666_1X24_CPADHI,
> +	MEDIA_BUS_FMT_RBG888_1X24,
> +};
> +
> +static const u32 tc_lvds_out_bus_fmts[] = {
> +	MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
> +	MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
> +	MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
>  };
>  
>  static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
> @@ -359,19 +373,6 @@ static void d2l_write(struct i2c_client *i2c, u16 addr, u32 val)
>  			ret, addr);
>  }
>  
> -/* helper function to access bus_formats */
> -static struct drm_connector *get_connector(struct drm_encoder *encoder)
> -{
> -	struct drm_device *dev = encoder->dev;
> -	struct drm_connector *connector;
> -
> -	list_for_each_entry(connector, &dev->mode_config.connector_list, head)
> -		if (connector->encoder == encoder)
> -			return connector;
> -
> -	return NULL;
> -}
> -
>  static void tc_bridge_enable(struct drm_bridge *bridge)
>  {
>  	struct tc_data *tc = bridge_to_tc(bridge);
> @@ -380,7 +381,10 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
>  	u32 val = 0;
>  	u16 dsiclk, clkdiv, byteclk, t1, t2, t3, vsdelay;
>  	struct drm_display_mode *mode;
> -	struct drm_connector *connector = get_connector(bridge->encoder);
> +	struct drm_bridge_state *state =
> +			drm_priv_to_bridge_state(bridge->base.state);
> +
> +	tc->output_bus_fmt = state->output_bus_cfg.format;
>  
>  	mode = &bridge->encoder->crtc->state->adjusted_mode;
>  
> @@ -451,14 +455,13 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
>  	d2l_write(tc->i2c, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
>  
>  	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
> -		connector->display_info.bus_formats[0],
> +		tc->output_bus_fmt,
>  		tc->bpc);
>  	/*
>  	 * Default hardware register settings of tc358775 configured
>  	 * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
>  	 */
> -	if (connector->display_info.bus_formats[0] ==
> -		MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
> +	if (tc->output_bus_fmt == MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
>  		/* VESA-24 */
>  		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
>  		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R4, LVI_R7, LVI_R5, LVI_G0));
> @@ -590,6 +593,40 @@ static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
>  	return 0;
>  }
>  
> +static u32 *
> +tc_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
> +			     struct drm_bridge_state *bridge_state,
> +			     struct drm_crtc_state *crtc_state,
> +			     struct drm_connector_state *conn_state,
> +			     u32 output_fmt,
> +			     unsigned int *num_input_fmts)
> +{
> +	u32 *input_fmts = NULL;
> +	u8 i;
> +
> +	*num_input_fmts = 0;
> +
> +	for (i = 0 ; i < ARRAY_SIZE(tc_lvds_out_bus_fmts) ; ++i) {
> +		if (output_fmt == tc_lvds_out_bus_fmts[i])
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(tc_lvds_out_bus_fmts))
> +		return NULL;
> +
> +	*num_input_fmts = ARRAY_SIZE(tc_lvds_in_bus_fmts);
> +
> +	input_fmts = kcalloc(*num_input_fmts, ARRAY_SIZE(tc_lvds_in_bus_fmts),
> +			     GFP_KERNEL);
> +	if (!input_fmts)
> +		return NULL;
> +
> +	for (i = 0; i < ARRAY_SIZE(tc_lvds_in_bus_fmts); ++i)
> +		input_fmts[i] = tc_lvds_in_bus_fmts[i];
> +
> +	return input_fmts;
> +}
> +
>  static int tc_bridge_attach(struct drm_bridge *bridge,
>  			    enum drm_bridge_attach_flags flags)
>  {
> @@ -639,6 +676,10 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
>  }
>  
>  static const struct drm_bridge_funcs tc_bridge_funcs = {
> +	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
> +	.atomic_reset = drm_atomic_helper_bridge_reset,
> +	.atomic_get_input_bus_fmts = tc_bridge_get_input_bus_fmts,
>  	.attach = tc_bridge_attach,
>  	.pre_enable = tc_bridge_pre_enable,
>  	.enable = tc_bridge_enable,
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
