Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F92D2353
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 06:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgLHFtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 00:49:47 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:59832 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgLHFtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 00:49:47 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 448C080684;
        Tue,  8 Dec 2020 06:48:57 +0100 (CET)
Date:   Tue, 8 Dec 2020 06:48:55 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/panel: Make backlight attachment lazy
Message-ID: <20201208054855.GA18863@ravnborg.org>
References: <20201208044446.973238-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208044446.973238-1-bjorn.andersson@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=KKAkSRfTAAAA:8 a=KJCBkObgxTU_UUeBqkUA:9
        a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,
On Mon, Dec 07, 2020 at 10:44:46PM -0600, Bjorn Andersson wrote:
> Some bridge chips, such as the TI SN65DSI86 DSI/eDP bridge, provides
> means of generating a PWM signal for backlight control of the attached
> panel. The provided PWM chip is typically controlled by the
> pwm-backlight driver, which if tied to the panel will provide DPMS.
> 
> But with the current implementation the panel will refuse to probe
> because the bridge driver has yet to probe and register the PWM chip,
> and the bridge driver will refuse to probe because it's unable to find
> the panel.
> 
> Mitigate this catch-22 situation by allowing the panel driver to probe
> and retry the attachment of the backlight as the panel is turned on or
> off.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/drm_panel.c | 47 +++++++++++++++++++++++++++----------
>  include/drm/drm_panel.h     |  8 +++++++
>  2 files changed, 43 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> index f634371c717a..7487329bd22d 100644
> --- a/drivers/gpu/drm/drm_panel.c
> +++ b/drivers/gpu/drm/drm_panel.c
> @@ -43,6 +43,34 @@ static LIST_HEAD(panel_list);
>   * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
>   */
>  
> +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
> +static int drm_panel_of_backlight_lazy(struct drm_panel *panel)
> +{
> +	struct backlight_device *backlight;
> +
> +	if (!panel || !panel->dev)
> +		return -EINVAL;
> +
> +	backlight = devm_of_find_backlight(panel->dev);
> +
> +	if (IS_ERR(backlight)) {
> +		if (PTR_ERR(backlight) == -EPROBE_DEFER) {
> +			panel->backlight_init_pending = true;
> +			return 0;
> +		}
> +
> +		return PTR_ERR(backlight);
Use dev_err_probe()

> +	}
> +
> +	panel->backlight = backlight;
> +	panel->backlight_init_pending = false;
> +
> +	return 0;
> +}
> +#else
> +static int drm_panel_of_backlight_lazy(struct drm_panel *panel) { return 0; }
> +#endif
> +
>  /**
>   * drm_panel_init - initialize a panel
>   * @panel: DRM panel
> @@ -161,6 +189,9 @@ int drm_panel_enable(struct drm_panel *panel)
>  			return ret;
>  	}
>  
> +	if (panel->backlight_init_pending)
> +		drm_panel_of_backlight_lazy(panel);
> +
>  	ret = backlight_enable(panel->backlight);
>  	if (ret < 0)
>  		DRM_DEV_INFO(panel->dev, "failed to enable backlight: %d\n",
> @@ -187,6 +218,9 @@ int drm_panel_disable(struct drm_panel *panel)
>  	if (!panel)
>  		return -EINVAL;
>  
> +	if (panel->backlight_init_pending)
> +		drm_panel_of_backlight_lazy(panel);
> +
>  	ret = backlight_disable(panel->backlight);
>  	if (ret < 0)
>  		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
> @@ -328,18 +362,7 @@ EXPORT_SYMBOL(of_drm_get_panel_orientation);
>   */
>  int drm_panel_of_backlight(struct drm_panel *panel)
>  {
> -	struct backlight_device *backlight;
> -
> -	if (!panel || !panel->dev)
> -		return -EINVAL;
> -
> -	backlight = devm_of_find_backlight(panel->dev);
> -
> -	if (IS_ERR(backlight))
> -		return PTR_ERR(backlight);
> -
> -	panel->backlight = backlight;
> -	return 0;
> +	return drm_panel_of_backlight_lazy(panel);
Could you update the drm_panel_of_backlight() implementation (and
do not forget the documentation) and avoid drm_panel_of_backlight_lazy()?

	Sam

>  }
>  EXPORT_SYMBOL(drm_panel_of_backlight);
>  #endif
> diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> index 33605c3f0eba..b126abebb2f3 100644
> --- a/include/drm/drm_panel.h
> +++ b/include/drm/drm_panel.h
> @@ -149,6 +149,14 @@ struct drm_panel {
>  	 */
>  	struct backlight_device *backlight;
>  
> +	/**
> +	 * @backlight_init_pending
> +	 *
> +	 * Backlight driver is not yet available so further attempts to
> +	 * initialize @backlight is necessary.
> +	 */
> +	bool backlight_init_pending;
> +

We have not done so today for other fields, but it would be good
to document this is for drm_panel use only and drivers shall not touch.

	Sam
