Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F0C2A1A98
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 21:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgJaU4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 16:56:24 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:58924 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgJaU4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 16:56:24 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D6C2080501;
        Sat, 31 Oct 2020 21:56:18 +0100 (CET)
Date:   Sat, 31 Oct 2020 21:56:17 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 2/2] drm/bridge: hx8837: add a Himax HX8837 display
 controller driver
Message-ID: <20201031205617.GA1111106@ravnborg.org>
References: <20201030030800.1036888-1-lkundrak@v3.sk>
 <20201030030800.1036888-3-lkundrak@v3.sk>
 <20201031080137.GB1044557@ravnborg.org>
 <20201031201259.GA294060@demiurge.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031201259.GA294060@demiurge.local>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=yQnS-YR962e6U0jWTX0A:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lubomir.

> > 
> > > +	select BACKLIGHT_CLASS_DEVICE
> > Please use a depends - using select on a symbol with a prompt is always
> > wrong. Yeah, I know you then need to enable backlight to see this
> > driver. Sorry, but this is the best we can do now.
> > Many other drivers can cope with depends here.
> 
> This results in a dependency loop:
> 
>   drivers/video/fbdev/Kconfig:12:error: recursive dependency detected!
>   drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
>   drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
>   drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_HIMAX_HX8837
>   drivers/gpu/drm/bridge/Kconfig:51:      symbol DRM_HIMAX_HX8837 depends on BACKLIGHT_CLASS_DEVICE
>   drivers/video/backlight/Kconfig:143:    symbol BACKLIGHT_CLASS_DEVICE is selected by FB_BACKLIGHT
>   drivers/video/fbdev/Kconfig:187:        symbol FB_BACKLIGHT depends on FB
> 
> Unfortunately I have no idea how to resolve it at the moment.
> 
> I suppose I can look further into it if necessary. Or is it okay if I
> leave it at select BACKLIGHT_CLASS_DEVICE for now?

Sigh, leave it as a select then :-(
The "sigh" is not directed at you but the mess this
BACKLIGHT_CLASS_DEVICE is and the limitations of Kconfig.

	Sam
