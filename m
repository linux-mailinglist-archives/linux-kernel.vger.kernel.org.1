Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361F52B5255
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732193AbgKPUS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730097AbgKPUSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:18:55 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88EFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:18:55 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id j7so20212236wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IM7NWRlhjN4K8P7uYjUrC25oig+0uft9W8EZBn+WlIQ=;
        b=B3i1aLF2lvlTWTWrdBJMUqCbZZdYnHF5UUcOAMwwSCcz9Ka08DjBxsRRTrf3yVRLa9
         wry6M8fS+Nz2djFxfl5ahP3IAm8icWSztlkXNBNEnQaVxbYRktxYo37gSomTwQf93m3L
         2fJKehez9p10/1sE8sKooXyLzwJ3XKPq9eI3T6xp9M+Dcxt8xuszNd5Id0thPbUP198E
         zp+Yf9bgR+hkX2wGDFh9VIlxWUCe76EdWeQ0eiN5jzJ3EfGSc+4Sv8rtokhNvZPHFHbr
         0NWm2NGYZ7YHM1csrUApTHbVlseUxYNus687h/XclzmhED+mTobAnrBVasuPBVvRSKur
         4XyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IM7NWRlhjN4K8P7uYjUrC25oig+0uft9W8EZBn+WlIQ=;
        b=WnoaS0M4OG521kESmKGNq7paRBiw27gQctiIa0FPT2f/M1UBASvSP5cONTguIPoZiH
         8DzgHHiUeWyLIDCHQzDouRorUzuRfN1/Tsxt/+otU5dWhrx3SB5jrqAacxSIrfLktSuI
         E5qOxXu0u1iutNNr1GFRrP2Zxu37cJC4Ar09SVclzHrmtmzxH6zmK4wZjcwn4+X23rEx
         +4eBuYQ1hLC0cAqNZ+dCn4X9ceVTi37IEo8he0v3FT0kFkKZzas/tkCrSTzxvHzHzMCs
         khRZWKtwwi4gPV45dz0RgVUOz1xXjyDrNfqf+BUUks0rOI2IhoTsJIvd1zuaz71RQRaY
         j8Cg==
X-Gm-Message-State: AOAM532L0c/sG4nbsa/NxpjDpSG4XtTVl2SQImy2KsbJybBSL4PA/fy7
        y4RqfKOQ2QMyD9eyWKm0rrxLprGRbMIVBiheffU=
X-Google-Smtp-Source: ABdhPJyUgjWzdvSkRQM+bwGZL8vBxQBi4Lmh6MP4R70VxPjwwcC6lb8Xy7gUJsTqSM6O19H8SC9JxSJW65m3IhN+VT0=
X-Received: by 2002:adf:8028:: with SMTP id 37mr20979051wrk.111.1605557934489;
 Mon, 16 Nov 2020 12:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-26-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-26-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:18:43 -0500
Message-ID: <CADnq5_NBngYNZyk0q=X59DuXcGm_kkwTqvEy7cuQfvpEMNwqBg@mail.gmail.com>
Subject: Re: [PATCH 25/43] drm/radeon/ni_dma: Move 'cayman_gpu_check_soft_reset()'s
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

On Mon, Nov 16, 2020 at 12:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/ni.c:1733:5: warning: no previous prototype for =
=E2=80=98cayman_gpu_check_soft_reset=E2=80=99 [-Wmissing-prototypes]
>  1733 | u32 cayman_gpu_check_soft_reset(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/ni.h     | 1 +
>  drivers/gpu/drm/radeon/ni_dma.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ni.h b/drivers/gpu/drm/radeon/ni.h
> index d63be1c88c0f1..9a5f31a05e68f 100644
> --- a/drivers/gpu/drm/radeon/ni.h
> +++ b/drivers/gpu/drm/radeon/ni.h
> @@ -34,5 +34,6 @@ void cayman_cp_int_cntl_setup(struct radeon_device *rde=
v,
>                               int ring, u32 cp_int_cntl);
>  void cayman_vm_decode_fault(struct radeon_device *rdev,
>                             u32 status, u32 addr);
> +u32 cayman_gpu_check_soft_reset(struct radeon_device *rdev);
>
>  #endif                         /* __NI_H__ */
> diff --git a/drivers/gpu/drm/radeon/ni_dma.c b/drivers/gpu/drm/radeon/ni_=
dma.c
> index c56136848360e..bd515ad4fe4cc 100644
> --- a/drivers/gpu/drm/radeon/ni_dma.c
> +++ b/drivers/gpu/drm/radeon/ni_dma.c
> @@ -25,10 +25,9 @@
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_trace.h"
> +#include "ni.h"
>  #include "nid.h"
>
> -u32 cayman_gpu_check_soft_reset(struct radeon_device *rdev);
> -
>  /*
>   * DMA
>   * Starting with R600, the GPU has an asynchronous
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
