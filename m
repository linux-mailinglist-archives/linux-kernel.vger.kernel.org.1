Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4603D2D3731
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 00:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgLHXxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 18:53:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730466AbgLHXxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 18:53:40 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDDEC06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 15:52:54 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id a12so57535wrv.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 15:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9yTD+/MeaD/CCcKu7FX0Rr3y/QzBeLJrb2locrOBws=;
        b=Yq/tD83OrMAd0vdcNuh6MPyvpFltSPlSFL1lKo967btKwPd2FUUYh6SfoJ2f31aJGC
         CySqBAWmO8P+OMtoF1mYbFaWSPHQLRMXOZcWp5hL2FLqBBPAT9fHClBBdHkKVKpZwpN1
         n6edA3NrVBD6jig0I1zad14oz+ayopyomx0+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=y9yTD+/MeaD/CCcKu7FX0Rr3y/QzBeLJrb2locrOBws=;
        b=PHmY0iFpk5eOl5ujrm9mLCdFqf0DZOt0cALTHiQCR5kyvx6PdurQM1DEiKsjt6BipT
         EZiGAAPZn68FsjnMnPFWPsamALGAdlAeX4LDUSCpKX6/kGUpfrkRIVpwuJrT/914vUpO
         cjYAKwIrIp6nKtKuYvRBJM4taEbjoIsw4m7Isvs8HLuFMT19IecRSSFnfWRwGOm5S/y8
         dE37LJlkdEQJV7Zt7U+VoUFjwoHUVbQtWhoNy1byyP3c16OiMIg6bLq+s4IeW49EF6qy
         Wd5gEfxmEhJ8DW4pLU+uncHq8+5KfV1vwUFMthrOyOMPqMSKOldEAbkDZJYajriGndip
         NdqQ==
X-Gm-Message-State: AOAM531ZuIoBi3SHE+mxu3dtFoA25EH3bErZ2/XjaoFE3AHTunHohraQ
        FZLofIq9ddHjikt24flzPBWJSg==
X-Google-Smtp-Source: ABdhPJzHjcyKdAFAONfnq6LWCWImKlRoaz9VBSr/hFOLs9gueoH/NFfQ9Id7BD8oJYcXdHNyNSS84A==
X-Received: by 2002:adf:c990:: with SMTP id f16mr496835wrh.263.1607471572859;
        Tue, 08 Dec 2020 15:52:52 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p19sm1105702wrg.18.2020.12.08.15.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:52:51 -0800 (PST)
Date:   Wed, 9 Dec 2020 00:52:49 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/panel: Make backlight attachment lazy
Message-ID: <20201208235249.GD401619@phenom.ffwll.local>
Mail-Followup-To: Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20201208044446.973238-1-bjorn.andersson@linaro.org>
 <X891/LvEJT1bLtjH@ulmo>
 <X8/36HXL1IYPXA0J@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8/36HXL1IYPXA0J@builder.lan>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 04:02:16PM -0600, Bjorn Andersson wrote:
> On Tue 08 Dec 06:47 CST 2020, Thierry Reding wrote:
> 
> > On Mon, Dec 07, 2020 at 10:44:46PM -0600, Bjorn Andersson wrote:
> > > Some bridge chips, such as the TI SN65DSI86 DSI/eDP bridge, provides
> > > means of generating a PWM signal for backlight control of the attached
> > > panel. The provided PWM chip is typically controlled by the
> > > pwm-backlight driver, which if tied to the panel will provide DPMS.
> > > 
> > > But with the current implementation the panel will refuse to probe
> > > because the bridge driver has yet to probe and register the PWM chip,
> > > and the bridge driver will refuse to probe because it's unable to find
> > > the panel.
> > 
> > What you're describing is basically a circular dependency. Can't we get
> > rid of that in some other way? Why exactly does the bridge driver refuse
> > to probe if the panel can't be found?
> > 
> > In other words, I see how the bridge would /use/ the panel in that it
> > forward a video stream to it. But how does the panel /use/ the bridge?
> > 
> 
> Yes, this is indeed a circular dependency between the components.
> 
> The involved parts are:
> * the bridge driver that implements the PWM chip probe defers on
>   drm_of_find_panel_or_bridge() failing to find the panel.
> * the pwm-backlight driver that consumes the PWM channel probe defer
>   because the pwm_chip was not registered by the bridge.
> * the panel that uses the backlight for DPMS purposes probe defer
>   because drm_panel_of_backlight() fails to find the pwm-backlight.
> 
> I looked at means of postponing drm_of_find_panel_or_bridge() to
> drm_bridge_funcs->attach(), but at that time "deferral" would be fatal.
> I looked at registering the pwm_chip earlier, but that would depend on a
> guarantee of the pwm-backlight and panel driver to probe concurrently.
> And the current solution of not tying the backlight to the panel means
> that when userspace decides to DPMS the display the backlight stays on.
> 
> 
> The proposed solution (hack?) means that DPMS operations happening
> before the pwm-backlight has probed will be missed, so it's not perfect.
> It does however allow the backlight on my laptop to turn off, which is a
> big improvement.
> 
> But I'm certainly welcome to suggestions.

Entirely hand-waving, why doesn't the following work:

1. driver for the platform device which is the bridge loads
2. that platform driver registers the pwm
3. it registers some magic for later on (more below)
4. panel driver has deferred loading until step 2 happened
5. panel driver registers drm_panel
6. the magic from step 3 picks up (after having been deferred for a few
times probably) grabs the panel, and sets up the actual drm_bridge driver

Everyone happy, or not? From the description it looks like the problem
that the pwm that we need for the backlight is tied to the same driver as
the drm_bridge, and always torn down too if the drm_bridge setup fails
somehow for a reason. And that reason is the circular dependency this
creates.

Now for the magic in step 3, there's options:
- change DT to split out that pwm as a separate platform_device, that way
  bridge and panel can load indepedently (hopefully)

- convert bridge to a multi-function device (mfd), essentially a way to
  instantiate more devices with their drivers at runtime. Then the actual
  pwm and drm_bridge parts of your bridge driver bind against those
  sub-functions, and can defer indepedently

- we could create a callback/wait function for "pls wait for any panel to
  show up". Then your bridge driver could launch a work_struct with that
  wait function, which will do the bridge setup once the panel has shown
  up. The pwm will be registered right away. It's essentially hand-rolling
  EPROBE_DEFERRED for work_struct in drm/panel. Maybe we might even have
  that exported from the driver core, e.g.

register_bridge_fn(struct work *)
{
	do_wait_probe_defer();
	panel = drm_of_find_panel_or_bridge();
	if (!panel) {
		schedule_work(); /* want to restart the work so it can be stopped on driver unload */
		return;
	}

	/* we have the panel now, register drm_bridge */
}

- cobble something together with component.c, but that's more for
  collecting unrelated struct device into a logical one than splitting it
  up more.

tldr; I think you can split this loop here at the bridge by untangling the
pwm from the drm_bridge part sufficiently.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
