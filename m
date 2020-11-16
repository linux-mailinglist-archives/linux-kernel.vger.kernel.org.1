Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402322B5275
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732456AbgKPUZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKPUZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:25:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52BFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:25:14 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so20189633wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nnbsn/6MZC8cOPvW0sf0bSCu/xUsIbv7iUluqCOgYTo=;
        b=G7oVcuCCkohTKkSckG7CHyvER32oIQ6kZhsPFRJjxSjBiP6YXp9Cf5cBWCcjFYwGBK
         FtL+dV9qgQ5nwNpxFQzlvtbhMWrOHpB87xx9YO9DMXf3YaOYa4m753otPfn5n5+bSclo
         F8U72h7ggxwqSdnLJZQuLtbLO2YXxyr9Z3PIVTadtb8StkSUlbpqpk3FQNGVkFvF9/fW
         dupIItocEjLp2yVsvUaKIQrkEki4UTjM/bAt+qckSNnhO/e+F3/PmJkcUwrkOPO4s5Oo
         ZIX2kuhubv9L6oeDoN8mOgppI/pdEZWpC6KEuZgwfYtjuotg1VzIAuP7LcAcxx2NNtbP
         uZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nnbsn/6MZC8cOPvW0sf0bSCu/xUsIbv7iUluqCOgYTo=;
        b=sz42q+tyjc2kL4E5nrhidZvf7ovsUByTm11MuEWRJSUvvi6Tv2ah95+GglAb5tKG2o
         t4y9Nj5HuMdoWOGtVqwP7PGq3T8iWx7uF6YhlKhlSJ0bdXcAPrczkyAW+oaJ/7C0smY4
         WojZi1OsoXytKLo+IkpyfWb8iymtaRuBbQMgqH5/tKQqhUlTxqcP4KrQv4ez96cYwotZ
         8gMJ/vseMS10gPVcjH5v61AA74Yt/gkifRCj/pYwVRl/q2YorNQID3EeyVeYCBIRZQPj
         bZL0NIJkLl6K7l8f6tGjkUNasaSz97ewSwh+XxBex/XdfRMIQTT73qRCdOCw69OhWtAY
         NfnQ==
X-Gm-Message-State: AOAM5317cUB+WyLLRr14sRyfoMoU+S0B45UucrA/qsHNaC9owThQiSM5
        NFefTQMmh4ip2wm/cYhuPHUlcCDe3gDqW1bI2Dc=
X-Google-Smtp-Source: ABdhPJyD5x1GeFN4w1yLVo2gSPZGSpWxF4MwonVC4co75yGWQhwzh5KvVMRHs+YveOf+VwzNE1+ZNCP/EXx+A+XYDQQ=
X-Received: by 2002:adf:e551:: with SMTP id z17mr21610130wrm.374.1605558313754;
 Mon, 16 Nov 2020 12:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-31-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-31-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:25:02 -0500
Message-ID: <CADnq5_OnhvfuzhuzxwrTJob0Cxo326s4Gjvy+J1txockePM0NA@mail.gmail.com>
Subject: Re: [PATCH 30/43] drm/radeon/si_dma: Move 'si_gpu_check_soft_reset()'s
 prototype to shared header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 12:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/si.c:3768:5: warning: no previous prototype for =
=E2=80=98si_gpu_check_soft_reset=E2=80=99 [-Wmissing-prototypes]
>  3768 | u32 si_gpu_check_soft_reset(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/si.h     | 1 +
>  drivers/gpu/drm/radeon/si_dma.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/si.h b/drivers/gpu/drm/radeon/si.h
> index 0a5018ef166e2..a1751ae560f02 100644
> --- a/drivers/gpu/drm/radeon/si.h
> +++ b/drivers/gpu/drm/radeon/si.h
> @@ -27,5 +27,6 @@
>  struct radeon_device;
>
>  int si_mc_load_microcode(struct radeon_device *rdev);
> +u32 si_gpu_check_soft_reset(struct radeon_device *rdev);
>
>  #endif                         /* __SI_H__ */
> diff --git a/drivers/gpu/drm/radeon/si_dma.c b/drivers/gpu/drm/radeon/si_=
dma.c
> index d2fa302a5be9f..645897d1bfc31 100644
> --- a/drivers/gpu/drm/radeon/si_dma.c
> +++ b/drivers/gpu/drm/radeon/si_dma.c
> @@ -25,10 +25,9 @@
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_trace.h"
> +#include "si.h"
>  #include "sid.h"
>
> -u32 si_gpu_check_soft_reset(struct radeon_device *rdev);
> -
>  /**
>   * si_dma_is_lockup - Check if the DMA engine is locked up
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
