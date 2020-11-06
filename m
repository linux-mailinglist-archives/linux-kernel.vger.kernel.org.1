Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8642A97AB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 15:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbgKFOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 09:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFOcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 09:32:16 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E71BC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 06:32:16 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id p19so1073545wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 06:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TG+grahIptnoTDeadrfkRn7emRkmhtKpvXQhWUpy47k=;
        b=CrhDurWJAeG4yK5DEGv6d9vKTLLPGIfaDJN7YD9qUnkQpoyQUsXYvGemkHpc95FY87
         pviTM6G9r8Hhf2hQUKgc22YuQg0Ss5mCLrSh9xbXMmx0fXYz4mRWJdyIA6XwOPnXVf9P
         skctiWNEDRpalRxGXR8tQzPcfJ7in7yLpP3sLfM+mroEGkpOMrz+tf6RKaWSMRTZM0Za
         F30A4x23Xj7WI1aPnn+zIU01l+RroFxRZfvuqgGlrntMzkS/zPC+d8A1Nbfmm6UK0xL+
         2ZPHj9LYGSlZ2puczY7UpBzyZtP1yhTfY5YpPk10esNMcygJdK6YH7T2fLjK8emhE7Ux
         cL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TG+grahIptnoTDeadrfkRn7emRkmhtKpvXQhWUpy47k=;
        b=f4Sbla2CYnI15FlQumaMSXn8WieTb37sAqszMGDJ5KMUWuwpiXgwXMsHh/USeGD0QP
         lZzZF2laz5eK2Th9CZj/KFmunBxnrvC+J0ldTEyW39/S9aWrtOb7u71DqQzrhzH37/Hg
         y9taogIp8ALhOhryfEhAQ598jfFVkr3nFXoZsoUC8bmtDnGt6rBVfNoEmRiXvOazYFn5
         EimJtVi7DnSvbN1Opc5Azg+TIUnlctolpeEo+NdmTxCjOIi2FKloU23Z4Psj81bPASsJ
         KdhkpakZP/9LDVGfzQNrdzX7+hm3/RgtqvzpblJgjY7S5kbhoJG4B4iEwp+ZPFiAhnis
         iUXw==
X-Gm-Message-State: AOAM530BfCyfUAmPAaQgUblFo9N1I8c2yUmFj52oHts1hHPGNJC8/05S
        NnB97y2+1LrVu5LEwXFywUF26Q==
X-Google-Smtp-Source: ABdhPJz0I4gPLyquCNwWmcmsIQGxwkz8JIey0HnDEKQCgJUtOSWDcHPzwffR+RU3ePv5LrUQVQs2ZA==
X-Received: by 2002:a1c:4646:: with SMTP id t67mr2949050wma.40.1604673134943;
        Fri, 06 Nov 2020 06:32:14 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id a185sm2567348wmf.24.2020.11.06.06.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 06:32:14 -0800 (PST)
Date:   Fri, 6 Nov 2020 14:32:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 08/19] gpu: drm: omapdrm: dss: dsi: Rework and remove a
 few unused variables
Message-ID: <20201106143212.GJ2063125@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-9-lee.jones@linaro.org>
 <74399fab-6af5-77d3-e0eb-749774eb2837@ti.com>
 <20201105180725.GO4488@dell>
 <e48964e6-4a94-4495-0217-90db19fff629@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e48964e6-4a94-4495-0217-90db19fff629@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020, Tomi Valkeinen wrote:

> On 05/11/2020 20:07, Lee Jones wrote:
> > On Thu, 05 Nov 2020, Tomi Valkeinen wrote:
> > 
> >> On 05/11/2020 16:45, Lee Jones wrote:
> >>> Fixes the following W=1 kernel build warning(s):
> >>>
> >>>  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘_dsi_print_reset_status’:
> >>>  drivers/gpu/drm/omapdrm/dss/dsi.c:1131:6: warning: variable ‘l’ set but not used [-Wunused-but-set-variable]
> >>>  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘dsi_update’:
> >>>  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:10: warning: variable ‘dh’ set but not used [-Wunused-but-set-variable]
> >>>  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:6: warning: variable ‘dw’ set but not used [-Wunused-but-set-variable]
> >>>
> >>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>> Cc: David Airlie <airlied@linux.ie>
> >>> Cc: Daniel Vetter <daniel@ffwll.ch>
> >>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>> Cc: dri-devel@lists.freedesktop.org
> >>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >>> ---
> >>>  drivers/gpu/drm/omapdrm/dss/dsi.c | 9 ++-------
> >>>  1 file changed, 2 insertions(+), 7 deletions(-)
> >>
> >> I'd use "drm/omap: dsi: " subject prefix, the current one is fine too:
> >>
> >> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>
> >> Should I pick this up or do you want to keep the series intact?
> > 
> > If you are in a position to take it, please do so.
> > 
> > I rebase every day, so it will just vanish from my working set.
> 
> I have a 56 patch series on dsi.c that I sent yesterday, and it conflicts with this one. I'll pick
> this one on top of my series.

Sounds good, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
