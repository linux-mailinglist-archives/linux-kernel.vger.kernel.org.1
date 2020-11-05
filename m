Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4722A85B4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgKESHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKESHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:07:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB98C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:07:29 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id x12so2832039wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d1inljLFK+JaRhB9KNZIg3IoNamPlcVu2A0CttkNcBw=;
        b=OEtFpYNMWECXs8vospWA+5QAYXWVJxspuz8X8Cop2NEBzQPRcaWjzUQfKnH8wNvPg9
         PZfPCm32EFukv70xI7uVxzGI02mZS9q9tXZa8BRUZ0F1as/c5Cg+ncQpvGCzRmM48i0J
         HyzCCOYvB+38Y5tpjCr1C2CzeKDEr6RsQHuIakffEqC923AkJDk9JqxPfjeuGUICVlQP
         qtG4Ra6j/vKYXeAJq+37LhOMb/6TSiOIUFR1mq9UzI4yrzWXygixzhQ1UJJqLi9ZdUw5
         3CA0HZCjjooCTh0PhPaa5hFw8Q6NiJpgmXX9vX4fNoDfaDYqDJpHP4goZ0UHr2at61K1
         a9Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d1inljLFK+JaRhB9KNZIg3IoNamPlcVu2A0CttkNcBw=;
        b=TYfRrLF8t357xxQuNqKsaXd9W+dfV+QGKmFskNTc7Ufcn5e3gM7rT3wzJYJfzarA6U
         O35wmrepvceFqj9s56F6KuIznZ/iUUPwAG4urSaEn1uxqePg+zzSqoDtZUudkD46yY68
         AMp1bNOcV+3OClThv3+ECSgsZO1mvGRtfkzTIWMKrN42VVN08ivCcGZOQm5PZSrtsMQO
         viLAugJuUyn04qHidh+3tb5ubNaL4Ido4U5hVtIC3UrWQptVVjlPHhE971vzVPlAd16X
         ab/HnZT4yH9Uvn1INXTyN7vEQ2gUwIXGxhJQoj5B6rRTkNDUQpgf8Tn1exaNhoBKUjcg
         8k2w==
X-Gm-Message-State: AOAM530361uhaGYNfCfGT0EPlyBJu3YHQ9HnfJFFI1bUoC6v7r0WQK48
        LMgpA7sF5sL4J5e7O0zhQ3G4JFc8zvCA96VQ
X-Google-Smtp-Source: ABdhPJxPuM4D9vpAN18NV+Ds+4RJzWtjyP3sPDcasmK67rp1Vn8gnLSLHhoFx4XXvDsazFpPQsvsdw==
X-Received: by 2002:a5d:4ac1:: with SMTP id y1mr4545973wrs.27.1604599647755;
        Thu, 05 Nov 2020 10:07:27 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id a17sm4042380wra.61.2020.11.05.10.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 10:07:27 -0800 (PST)
Date:   Thu, 5 Nov 2020 18:07:25 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 08/19] gpu: drm: omapdrm: dss: dsi: Rework and remove a
 few unused variables
Message-ID: <20201105180725.GO4488@dell>
References: <20201105144517.1826692-1-lee.jones@linaro.org>
 <20201105144517.1826692-9-lee.jones@linaro.org>
 <74399fab-6af5-77d3-e0eb-749774eb2837@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74399fab-6af5-77d3-e0eb-749774eb2837@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020, Tomi Valkeinen wrote:

> On 05/11/2020 16:45, Lee Jones wrote:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘_dsi_print_reset_status’:
> >  drivers/gpu/drm/omapdrm/dss/dsi.c:1131:6: warning: variable ‘l’ set but not used [-Wunused-but-set-variable]
> >  drivers/gpu/drm/omapdrm/dss/dsi.c: In function ‘dsi_update’:
> >  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:10: warning: variable ‘dh’ set but not used [-Wunused-but-set-variable]
> >  drivers/gpu/drm/omapdrm/dss/dsi.c:3943:6: warning: variable ‘dw’ set but not used [-Wunused-but-set-variable]
> > 
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/omapdrm/dss/dsi.c | 9 ++-------
> >  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> I'd use "drm/omap: dsi: " subject prefix, the current one is fine too:
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Should I pick this up or do you want to keep the series intact?

If you are in a position to take it, please do so.

I rebase every day, so it will just vanish from my working set.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
