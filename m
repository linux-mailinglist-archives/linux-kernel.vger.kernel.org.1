Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AC32DAA91
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgLOKCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgLOKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:02:22 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE43C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:01:35 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r3so19252814wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=T5oGv0G7I5GRBdSZoMEquZtD9DLE+SjefBj4bPO/vkI=;
        b=frynj94H7IGy/9Q8RPr61N+F8nH4OVFjsMrrWHFryJI2FloGO8luDqS/9YOa9BHf3x
         o4LyUHBYBoIHBolRzD9XoXVf0kozqTNkMNZRdiXlytdeWeLqToZiO8QyHbBvMGoVsT5L
         PGSA6rEkuaWCLTqjwPzhJezFJMqobMIOlxGPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=T5oGv0G7I5GRBdSZoMEquZtD9DLE+SjefBj4bPO/vkI=;
        b=pF7dNc/cFMEX+6zYtlKDMwSUf+LvqLtAoa2PbSU+x6mxnKPQ+gnAw+vCriRcTFX43b
         Kc3IsO+bvj1KKxVo8HrVZsrJm5PW55ibwTiIk01KVlWWa9L/fUKpVKpCL5X9gTBZD07L
         cw7Kfxcg+MqeDO0FVCTnbwKV1wnQ6U5bekRNDJGgCBTHRpWc6U/1SxFfPjGAEEtM4qmn
         twPivF1NgUd5j1S29ab0j2N7bSF99k580v2ZYir+Y+JXSR8VmbMZhB8cdkPfIBfOP8tL
         JkL415itVOVyMcsZRz9z2q6zJos5xJ0YvDPCnYuZ+BI40VFTAdCx4BKAKK3qxTtmm+we
         Qaqg==
X-Gm-Message-State: AOAM533jUGeajSQ/e6ImEQEJ+LQ9BFKFOPjWiPrJZSo8O+CACULcUl/Z
        OWJgPD46nsH++Q31Y6ayb7mcjQ==
X-Google-Smtp-Source: ABdhPJzZXFapJWgWIfvKcJ3+/UdAj25+uaJRo93WQmS+BF8W09ylZz40b903EwBp/2EysM9KsYlwCw==
X-Received: by 2002:a5d:61ca:: with SMTP id q10mr33297033wrv.124.1608026494688;
        Tue, 15 Dec 2020 02:01:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b14sm36489094wrx.77.2020.12.15.02.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 02:01:33 -0800 (PST)
Date:   Tue, 15 Dec 2020 11:01:31 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm: mxsfb: Silence -EPROBE_DEFER while waiting
 for bridge
Message-ID: <X9iJe2GdJ2VteOwl@phenom.ffwll.local>
Mail-Followup-To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
        David Airlie <airlied@linux.ie>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1608020391.git.agx@sigxcpu.org>
 <d5761eb871adde5464ba112b89d966568bc2ff6c.1608020391.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d5761eb871adde5464ba112b89d966568bc2ff6c.1608020391.git.agx@sigxcpu.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 09:23:38AM +0100, Guido Günther wrote:
> It can take multiple iterations until all components for an attached DSI
> bridge are up leading to several:
> 
> [    3.796425] mxsfb 30320000.lcd-controller: Cannot connect bridge: -517
> [    3.816952] mxsfb 30320000.lcd-controller: [drm:mxsfb_probe [mxsfb]] *ERROR* failed to attach bridge: -517
> 
> Silence this by checking for -EPROBE_DEFER and using dev_err_probe() so
> we set a deferred reason in case a dependency fails to probe (which
> quickly happens on small config/DT changes due to the rather long probe
> chain which can include bridges, phys, panels, backights, leds, etc.).
> 
> This also removes the only DRM_DEV_ERROR() usage, the rest of the driver
> uses dev_err().
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Fixes: c42001e357f7 ("drm: mxsfb: Use drm_panel_bridge")

Queued up for 5.11, thanks for your patch.
-Daniel

> ---
>  drivers/gpu/drm/mxsfb/mxsfb_drv.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> index 6faf17b6408d..6da93551e2e5 100644
> --- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> +++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
> @@ -134,11 +134,8 @@ static int mxsfb_attach_bridge(struct mxsfb_drm_private *mxsfb)
>  		return -ENODEV;
>  
>  	ret = drm_bridge_attach(&mxsfb->encoder, bridge, NULL, 0);
> -	if (ret) {
> -		DRM_DEV_ERROR(drm->dev,
> -			      "failed to attach bridge: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(drm->dev, ret, "Failed to attach bridge\n");
>  
>  	mxsfb->bridge = bridge;
>  
> @@ -212,7 +209,8 @@ static int mxsfb_load(struct drm_device *drm,
>  
>  	ret = mxsfb_attach_bridge(mxsfb);
>  	if (ret) {
> -		dev_err(drm->dev, "Cannot connect bridge: %d\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(drm->dev, "Cannot connect bridge: %d\n", ret);
>  		goto err_vblank;
>  	}
>  
> -- 
> 2.29.2
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
