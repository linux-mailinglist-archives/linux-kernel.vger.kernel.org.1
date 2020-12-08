Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DFC2D357C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:44:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729974AbgLHVkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729627AbgLHVkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:40:40 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCBBC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:40:00 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id f132so88254oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lLzPDVteSxEGApwG/LMo/pmVaFfWGs7Yb5Crz/Q/Br4=;
        b=DXxxT9ICXu8ZDJHAYqp3HBzyD1mC1ZJ7VM8WI7eASNLHSGI+KdjygZAUtzMgzOJlQW
         N3AVw0zUJtqpcHKmTLFZRYbkBgqHj9icvVxKFhcVTZ6pZxHMd/b/8IgHvEHzCiiNkFve
         x2OPC0J3Pkdtqm5QPWqvXxvlEV4XQtPEkwQDvRSd/g0eC7SMWiaxpSqwUCi0/WwpGmjm
         Llb+DltQfTNNOfbA05co9KHEaViqvYfw/09FUOlAC0uXkl49uNZ491NIJ57tvWRpNxUB
         UWjG+qR8f1mH0De/yGZ8/v0RKzbXQblUd/CbgP8vGYKzPfi0hO//4ImcikvBmSi2f2LL
         ULoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lLzPDVteSxEGApwG/LMo/pmVaFfWGs7Yb5Crz/Q/Br4=;
        b=WrBrFruln5PDnF4yA4LyX42titkii9xS6nNgI4sWgRhBZjoDd3+tS0aXZIuZp3XQaU
         qaMT63spUGZ6PzBKLqqAGH31hqcQrb0vmpbCSuuptXF84KmUDJ3TXJ76Ktm8RmhbrQfr
         1TmUd2jY6S7rF+4MpKYM/ZTq4s+RNbUEsToPv2+/+8+1+yYG6I6DSaDCZ2+9vO+T690i
         6KIga2Xb2wOsSnGWKb0wEJpb0/2WPkWCbekbmm5bI3pI/soh5CnnZqGZNDM1j8Ij67vL
         fOZzcMEKcH4HqrKV9jpAd9ecpqnpuFx/phad30enUH/iFR5/v6T+8Dnfvz+8jQnVtJBX
         BSqg==
X-Gm-Message-State: AOAM53207xLDC6VZ/eCx3O6JVQU6ci1xblCiDRyaQhQ6kqgz6AlPFzdM
        5Dg8HdJt/oxvogcz34/GoWUWAw==
X-Google-Smtp-Source: ABdhPJycWI/9xeiSd0a5k2WLzMdBrcyoQHESJihhU+dFxsyFspmI/uNqFtKJyTff0MBSSLf7oA36hg==
X-Received: by 2002:a54:4801:: with SMTP id j1mr4267771oij.104.1607463599958;
        Tue, 08 Dec 2020 13:39:59 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k5sm44011oot.30.2020.12.08.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:39:59 -0800 (PST)
Date:   Tue, 8 Dec 2020 15:39:57 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/panel: Make backlight attachment lazy
Message-ID: <X8/yrXmEwuq6YZaD@builder.lan>
References: <20201208044446.973238-1-bjorn.andersson@linaro.org>
 <20201208054855.GA18863@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208054855.GA18863@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 Dec 23:48 CST 2020, Sam Ravnborg wrote:

> Hi Bjorn,
> On Mon, Dec 07, 2020 at 10:44:46PM -0600, Bjorn Andersson wrote:
> > Some bridge chips, such as the TI SN65DSI86 DSI/eDP bridge, provides
> > means of generating a PWM signal for backlight control of the attached
> > panel. The provided PWM chip is typically controlled by the
> > pwm-backlight driver, which if tied to the panel will provide DPMS.
> > 
> > But with the current implementation the panel will refuse to probe
> > because the bridge driver has yet to probe and register the PWM chip,
> > and the bridge driver will refuse to probe because it's unable to find
> > the panel.
> > 
> > Mitigate this catch-22 situation by allowing the panel driver to probe
> > and retry the attachment of the backlight as the panel is turned on or
> > off.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  drivers/gpu/drm/drm_panel.c | 47 +++++++++++++++++++++++++++----------
> >  include/drm/drm_panel.h     |  8 +++++++
> >  2 files changed, 43 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index f634371c717a..7487329bd22d 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -43,6 +43,34 @@ static LIST_HEAD(panel_list);
> >   * take look at drm_panel_bridge_add() and devm_drm_panel_bridge_add().
> >   */
> >  
> > +#if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
> > +static int drm_panel_of_backlight_lazy(struct drm_panel *panel)
> > +{
> > +	struct backlight_device *backlight;
> > +
> > +	if (!panel || !panel->dev)
> > +		return -EINVAL;
> > +
> > +	backlight = devm_of_find_backlight(panel->dev);
> > +
> > +	if (IS_ERR(backlight)) {
> > +		if (PTR_ERR(backlight) == -EPROBE_DEFER) {
> > +			panel->backlight_init_pending = true;
> > +			return 0;
> > +		}
> > +
> > +		return PTR_ERR(backlight);
> Use dev_err_probe()
> 

I need special handling of EPROBE_DEFER, both in terms of remembering
that we should retry and to not pass the error back to the panel driver.

I also don't want to introduce an error print here.

> > +	}
> > +
> > +	panel->backlight = backlight;
> > +	panel->backlight_init_pending = false;
> > +
> > +	return 0;
> > +}
> > +#else
> > +static int drm_panel_of_backlight_lazy(struct drm_panel *panel) { return 0; }
> > +#endif
> > +
> >  /**
> >   * drm_panel_init - initialize a panel
> >   * @panel: DRM panel
> > @@ -161,6 +189,9 @@ int drm_panel_enable(struct drm_panel *panel)
> >  			return ret;
> >  	}
> >  
> > +	if (panel->backlight_init_pending)
> > +		drm_panel_of_backlight_lazy(panel);
> > +
> >  	ret = backlight_enable(panel->backlight);
> >  	if (ret < 0)
> >  		DRM_DEV_INFO(panel->dev, "failed to enable backlight: %d\n",
> > @@ -187,6 +218,9 @@ int drm_panel_disable(struct drm_panel *panel)
> >  	if (!panel)
> >  		return -EINVAL;
> >  
> > +	if (panel->backlight_init_pending)
> > +		drm_panel_of_backlight_lazy(panel);
> > +
> >  	ret = backlight_disable(panel->backlight);
> >  	if (ret < 0)
> >  		DRM_DEV_INFO(panel->dev, "failed to disable backlight: %d\n",
> > @@ -328,18 +362,7 @@ EXPORT_SYMBOL(of_drm_get_panel_orientation);
> >   */
> >  int drm_panel_of_backlight(struct drm_panel *panel)
> >  {
> > -	struct backlight_device *backlight;
> > -
> > -	if (!panel || !panel->dev)
> > -		return -EINVAL;
> > -
> > -	backlight = devm_of_find_backlight(panel->dev);
> > -
> > -	if (IS_ERR(backlight))
> > -		return PTR_ERR(backlight);
> > -
> > -	panel->backlight = backlight;
> > -	return 0;
> > +	return drm_panel_of_backlight_lazy(panel);
> Could you update the drm_panel_of_backlight() implementation (and
> do not forget the documentation) and avoid drm_panel_of_backlight_lazy()?
> 

That sounds reasonable, there's not really a reason for introducing a
new function for what I'm doing.

> 
> >  }
> >  EXPORT_SYMBOL(drm_panel_of_backlight);
> >  #endif
> > diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> > index 33605c3f0eba..b126abebb2f3 100644
> > --- a/include/drm/drm_panel.h
> > +++ b/include/drm/drm_panel.h
> > @@ -149,6 +149,14 @@ struct drm_panel {
> >  	 */
> >  	struct backlight_device *backlight;
> >  
> > +	/**
> > +	 * @backlight_init_pending
> > +	 *
> > +	 * Backlight driver is not yet available so further attempts to
> > +	 * initialize @backlight is necessary.
> > +	 */
> > +	bool backlight_init_pending;
> > +
> 
> We have not done so today for other fields, but it would be good
> to document this is for drm_panel use only and drivers shall not touch.
> 

Of course.

Thanks,
Bjorn
