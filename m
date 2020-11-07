Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E102AA631
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 16:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgKGPOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 10:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgKGPOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 10:14:43 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EABC0613D2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 07:14:43 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so4190308wmm.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 07:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5Yfpcznfq7zUC+nbLYSd5qw9mgk2f1+fj8pB/pC5wlY=;
        b=OdxcA/HWczLQ90m1mnY48hp3qEOBvLprtrlUSRDiLVQPdiPIaKMmmXp/mQLsSd0sKK
         mOVPeIQ4LT8aH8g8HdwQItMt4AUvV+6siH4x51zO91HFX3HysYW0LmzGthb1pFGr1brY
         awUYslxY/OgiFK5LReEhL6axPFWgesZxAV/DiqUILXxjBnEFRXHVt6Ld1BXWtb5hbgsX
         n3zFf+NsdBb6KHxE4JwYCdTIq/jUj9tkLIGmV4gXqhxKBsMSwK/ZS4LiB49MYVSaVfOn
         wpxVIz322u55aL2OIiCtrOZXNlM2ABvBav6YcdbDPHvYqcAcVJDR5Lh770fj0JQs3wvD
         NwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5Yfpcznfq7zUC+nbLYSd5qw9mgk2f1+fj8pB/pC5wlY=;
        b=YIQDsAFTNvJtTsRXh/wUV2rykUrxGBtLIDfRaaROI6bgtlDsJxhNGq3yPSHAUOteuP
         mB5bDqq3aj0rlY3Jgvvn3Dg//M3dPkn1Q6bgTYHrtKjTYvKldYxLC/14RO/IkH8PcJJs
         tGeOs85dPBwEmbjhKfb9QZHOlJRmOC2Z45ZO7JWnoIDj/f1TctGS9VWD0FprhNgx9B0Q
         ovMfDF7jSPsQ46jd/yploD+xPZJFXZljmObHhegntqp68bt7RRH3BnTNkr7GtRZ1vzN8
         CNZb4jfdb3nFx04qcoTUFXjRjwPa37sWP8NWGYTB5kcMsjV3IQTE5+E7IyRmMnYtSyFl
         g79w==
X-Gm-Message-State: AOAM532kaxJ7b/1ENnr1/xYUE6nnlNjLE2verMqEike7zI1p9rot295o
        r0NWHssGy2YukHRGfe3veDBgxg==
X-Google-Smtp-Source: ABdhPJxPCaNJ0MahQ/W3b9fSaGgk7MqXhKrOOHN2l3VTEbRE4u5vnj39pfkLusOtw7OARbYyPzCG8A==
X-Received: by 2002:a7b:c848:: with SMTP id c8mr2974808wml.86.1604762082229;
        Sat, 07 Nov 2020 07:14:42 -0800 (PST)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id f20sm6370386wmc.26.2020.11.07.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 07:14:41 -0800 (PST)
Date:   Sat, 7 Nov 2020 15:14:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 10/19] drm/radeon/radeon: Move prototype into shared
 header
Message-ID: <20201107151424.GR2063125@dell>
References: <20201106214949.2042120-1-lee.jones@linaro.org>
 <20201106214949.2042120-11-lee.jones@linaro.org>
 <20201107142651.GA1014611@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201107142651.GA1014611@ravnborg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020, Sam Ravnborg wrote:

> Hi Lee,
> 
> On Fri, Nov 06, 2020 at 09:49:40PM +0000, Lee Jones wrote:
> > Unfortunately, a suitable one didn't already exist.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/gpu/drm/radeon/radeon_device.c:637:6: warning: no previous prototype for ‘radeon_device_is_virtual’ [-Wmissing-prototypes]
> >  637 | bool radeon_device_is_virtual(void)
> >  | ^~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-media@vger.kernel.org
> > Cc: linaro-mm-sig@lists.linaro.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/gpu/drm/radeon/radeon_device.c |  1 +
> >  drivers/gpu/drm/radeon/radeon_device.h | 32 ++++++++++++++++++++++++++
> >  drivers/gpu/drm/radeon/radeon_drv.c    |  3 +--
> >  3 files changed, 34 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/gpu/drm/radeon/radeon_device.h
> 
> Other public functions in radeon_device.c have their prototype in
> radeon.h - for example radeon_is_px()
> 
> Add radeon_device_is_virtual() there so we avoiid this new header.

I'm happy to do that, if it's deemed better.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
