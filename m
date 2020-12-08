Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEB52D35C1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 23:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730530AbgLHWDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 17:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgLHWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:03:00 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93E9C061794
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 14:02:19 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id o25so201151oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 14:02:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aFLiOxATEwVPZ54YnQmIiBEk09z7ej1KbGicavDyd/4=;
        b=JR5oMMWrkAg9dt9AY6ede7oX5k900mPAfz3VEE6vi4Aodp+Mv/ZmXxwWkEVyU+O5ca
         BXjh8rkSKVV0BbEu9cnYsrZQI3ffG3PcQpW1PlkYtsV3xjAd8Rm+D8IWTJ8lO4Y7HiyF
         z8PDX7Um6dRXa1umfShWKijS/16y02R7nCsx/vlK5HojffTg8jQhQHxCcf9EsEH61U7C
         XMVR7d2CRplLo6u8Chy8e4j7PkIMciw++68T7CD0hP56A1wjrsrru3Bvuuw/KWXv/WB9
         MIii2wzQ+eHBPUj9ENe8/sFkSwtihYuT4s3QokRdI5Co+A4tf+Dl4OHE2yucvFkrTph7
         dp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFLiOxATEwVPZ54YnQmIiBEk09z7ej1KbGicavDyd/4=;
        b=K3QBiOSbxWkRlWMkWeerFecFvo3cwYXws4Jpf7P/phA02otGlNQKLrdNdutmmN89Ni
         nmF/Kt7KY2nHIvFYlnd5WAXC/RVgCWLiqiQdVN2PrL0hTq+gclwYDKvArdJHtblb/V75
         FY+lIEG3h92ofp3V38PK4Ff+1Ux3Z4aj2H9/pvZbMaUTMkQVG+oI5vNYAa87/J8ZHtqI
         PfxiLnCI6+BN0TlA74HyOx0bzdEduiWFcdPUDMb6bMXQuHiOwT/EX98vNj0RojOVTbh7
         8WKS0uk53n0rW5ySNVRa2ZYtvs7d9TK/emzd8bNgpzdktQeVMj+dfp/38ahcjYn2TSY/
         BWtQ==
X-Gm-Message-State: AOAM530Bzrqzy5Ex7c26kM/6roQitV7yKHMUfQkG88cxqT/5Lmks+jgS
        nNgnD6PGETQx2a2U+yUN78p4UA==
X-Google-Smtp-Source: ABdhPJxEBsXdgE6F4kOII6gY46qvCzgKEzVaGS1kOzteGyGNXa++TBi8fx6esKChL9Avx/cMo5bgbA==
X-Received: by 2002:aca:afd0:: with SMTP id y199mr4415574oie.7.1607464939235;
        Tue, 08 Dec 2020 14:02:19 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h7sm18126otq.21.2020.12.08.14.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 14:02:18 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:02:16 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/panel: Make backlight attachment lazy
Message-ID: <X8/36HXL1IYPXA0J@builder.lan>
References: <20201208044446.973238-1-bjorn.andersson@linaro.org>
 <X891/LvEJT1bLtjH@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X891/LvEJT1bLtjH@ulmo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 08 Dec 06:47 CST 2020, Thierry Reding wrote:

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
> 
> What you're describing is basically a circular dependency. Can't we get
> rid of that in some other way? Why exactly does the bridge driver refuse
> to probe if the panel can't be found?
> 
> In other words, I see how the bridge would /use/ the panel in that it
> forward a video stream to it. But how does the panel /use/ the bridge?
> 

Yes, this is indeed a circular dependency between the components.

The involved parts are:
* the bridge driver that implements the PWM chip probe defers on
  drm_of_find_panel_or_bridge() failing to find the panel.
* the pwm-backlight driver that consumes the PWM channel probe defer
  because the pwm_chip was not registered by the bridge.
* the panel that uses the backlight for DPMS purposes probe defer
  because drm_panel_of_backlight() fails to find the pwm-backlight.

I looked at means of postponing drm_of_find_panel_or_bridge() to
drm_bridge_funcs->attach(), but at that time "deferral" would be fatal.
I looked at registering the pwm_chip earlier, but that would depend on a
guarantee of the pwm-backlight and panel driver to probe concurrently.
And the current solution of not tying the backlight to the panel means
that when userspace decides to DPMS the display the backlight stays on.


The proposed solution (hack?) means that DPMS operations happening
before the pwm-backlight has probed will be missed, so it's not perfect.
It does however allow the backlight on my laptop to turn off, which is a
big improvement.

But I'm certainly welcome to suggestions.

Regards,
Bjorn
