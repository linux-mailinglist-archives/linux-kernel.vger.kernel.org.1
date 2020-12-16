Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A892DC254
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgLPOf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgLPOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:35:56 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A631C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:35:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id i9so23416019wrc.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 06:35:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSQ515YX1lL7SdLjwXSi0+PfZjksYfxwOfIy/7hxa2Q=;
        b=M855+cec+7hhTRXCte9mdlQBN4qId6bRJgg47Kf/7eMbmLnJEsFDvuRfa4o+Ji2I0t
         aySnCxp+wx+F02X1ev/kfdgAhk3QKUZ07ZVXjf3ec1S6jK4A7KMKAtEhrxedRRYs7Ycx
         GhZUsHtxksIj/2Zz+wpjjwcpKQ/0XmrpgexYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=XSQ515YX1lL7SdLjwXSi0+PfZjksYfxwOfIy/7hxa2Q=;
        b=cXQL52K3k4Km5qtx5tM6+Be4v/UQgoJG4wW2+sTuJiAX96HLVufiZSMW9/tU7IMiND
         fDgES7mbhEOZag9nqo3Ovnd303OpZcVRhhKriAklpds4OwVXQPFmIY63u9sR0HQFT3D+
         Y5V/1qbrOyePwXzfIOVJEPMEKjT0untdGOJS40cTk9pGXsVu1SbUsoivqV9wGgmk8Klt
         3gc+zIhNNmogxtCCPOEIxbJNkCkM8rQ7b/GA/K8A/EoW4ma+OiykgzyI3DV0WkmPymsu
         AsitYOlE7OgRXf1RzhWDUOEvn+IXpvIecpu/17iedmjrXmpHmZSuYWFSW8ZvgIo50QaM
         jcIA==
X-Gm-Message-State: AOAM531c0TvZZKtRXdlveR4q41TuO5QWoswgtmsXn3y4k4Kcu+nSrgig
        h3mVZGy/wbG1KHOuGIfH1a3iiA==
X-Google-Smtp-Source: ABdhPJw6sopHtFhuCuY7z9Og6UwUsCkiLLAibKTKR25cmQkf0cApYj5FT6xFl2X2Mz1oqEAGeg7PSQ==
X-Received: by 2002:adf:f845:: with SMTP id d5mr20121128wrq.182.1608129313750;
        Wed, 16 Dec 2020 06:35:13 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 125sm2841371wmc.27.2020.12.16.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:35:12 -0800 (PST)
Date:   Wed, 16 Dec 2020 15:35:10 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        jyri.sarha@iki.fi, Sekhar Nori <nsekhar@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>, tomba@kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update addresses for TI display drivers
Message-ID: <X9obHqQ0BBtZaSyz@phenom.ffwll.local>
Mail-Followup-To: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, Jyri Sarha <jsarha@ti.com>,
        jyri.sarha@iki.fi, Sekhar Nori <nsekhar@ti.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>, tomba@kernel.org
References: <20201216075917.17481-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216075917.17481-1-tomi.valkeinen@ti.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 09:59:17AM +0200, Tomi Valkeinen wrote:
> Update the maintainer email addresses for TI display drivers.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  MAINTAINERS | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 281de213ef47..c21471497a18 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5932,8 +5932,8 @@ F:	Documentation/devicetree/bindings/display/st,stm32-ltdc.yaml
>  F:	drivers/gpu/drm/stm
>  
>  DRM DRIVERS FOR TI KEYSTONE
> -M:	Jyri Sarha <jsarha@ti.com>
> -M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> +M:	Jyri Sarha <jyri.sarha@iki.fi>
> +M:	Tomi Valkeinen <tomba@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
> @@ -5943,15 +5943,15 @@ F:	Documentation/devicetree/bindings/display/ti/ti,k2g-dss.yaml
>  F:	drivers/gpu/drm/tidss/
>  
>  DRM DRIVERS FOR TI LCDC
> -M:	Jyri Sarha <jsarha@ti.com>
> -R:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> +M:	Jyri Sarha <jyri.sarha@iki.fi>
> +R:	Tomi Valkeinen <tomba@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/display/tilcdc/
>  F:	drivers/gpu/drm/tilcdc/
>  
>  DRM DRIVERS FOR TI OMAP
> -M:	Tomi Valkeinen <tomi.valkeinen@ti.com>
> +M:	Tomi Valkeinen <tomba@kernel.org>
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/display/ti/
> -- 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
