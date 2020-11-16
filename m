Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332DC2B5299
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732873AbgKPUbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:31:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgKPUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:31:51 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5FBC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:31:49 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so13032376wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Xnbe336qAl1HOJVIYfBWlWuziNJAww4qOMA3InuqGFk=;
        b=V/JIjm11uut0dFL4p808EYs0bYzl3vVF01X1OKJqXTw8R+MooZH5wcEmUSoEoQxv/g
         V+PZ8mDTZKZ0MJoifd+8TReeHC7XIhz7qiAdNYJMYTFs1yeOQYSS+RK5cS7BgcZ6lmw7
         K18u0l6OWXslGSTbwkWL68etAhFhFdDHil9zqdlkZ5UwV0TC9r5GlK+KqFlWR+VnsDMa
         +EbasTX7ubHNqCSrA38luMRwDk8FwNAAZZ4gQdcPzsyuKkFrEQW/jYuAFN1s5v8ZbGtF
         1o6D9TFSocAsEd8Zue53CtxmlrC/qPQsLlGNd1uOfjsaEqSqkGNbSAg31M2Jdp7FEYzT
         Kn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Xnbe336qAl1HOJVIYfBWlWuziNJAww4qOMA3InuqGFk=;
        b=OBaiNMz1C6pMnCQlygacnzrqSFNqdq696wMyo713WMCbEqFGbbYxVIuqWNv0uUU1fo
         sPbKyL/1MoYfvRKZERW5008h8pYkP4RGZfKxHfRc2/6RN/UMgDJ2mkmBFM6tEa4FkrLi
         Abyq5wJ0146bXrG3D0E5p41ifToQiqc8krNK25SeMbBlBZZFUSI6NR9WlvkJlf9hM/VN
         71yOee2pN429e2Ou6iS1zRepCyNpOTTapwj+P+4saMdHKy5NZ/7DkIqJrG18zYxPtI9c
         a1Z5N0OXZan/GRmXdnobZcSgpJcP7Wo65KUS61Tsr6MEu/cxYJzUoZxdLfGYZKoPQsJ6
         OnHg==
X-Gm-Message-State: AOAM531n5Yg0tcU5dvHc4rsyIeDxBozi+aF5HJeh13A/QloGiicKGunG
        7/3JMCnkCiJ614aMUAtosXPMLVqqNUAQKOkd1mE=
X-Google-Smtp-Source: ABdhPJzYXz/iBnS6QhUwm9yBllNVV8cFfoQCFMJim5YSyBNlT2ZaDbvsXWY5xqwHC83ZyWmnd8xgWV0HmfBSqt8DKig=
X-Received: by 2002:adf:9144:: with SMTP id j62mr4588978wrj.419.1605558708505;
 Mon, 16 Nov 2020 12:31:48 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-36-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-36-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:31:37 -0500
Message-ID: <CADnq5_N06T3FT0jufTJR87X0LT8Xoc9mquD1KaiEk2Zf4EpgEQ@mail.gmail.com>
Subject: Re: [PATCH 35/43] drm/radeon/cik_sdma: Move 'amdgpu_cik_gpu_check_soft_reset()'s
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
>  drivers/gpu/drm/radeon/cik.c:4845:5: warning: no previous prototype for =
=E2=80=98cik_gpu_check_soft_reset=E2=80=99 [-Wmissing-prototypes]
>  4845 | u32 cik_gpu_check_soft_reset(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/cik.h      | 1 +
>  drivers/gpu/drm/radeon/cik_sdma.c | 3 +--
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.h b/drivers/gpu/drm/radeon/cik.h
> index 297b3c1ff804f..6630b9da9e7aa 100644
> --- a/drivers/gpu/drm/radeon/cik.h
> +++ b/drivers/gpu/drm/radeon/cik.h
> @@ -29,5 +29,6 @@ void cik_enter_rlc_safe_mode(struct radeon_device *rdev=
);
>  void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
>  int ci_mc_load_microcode(struct radeon_device *rdev);
>  void cik_update_cg(struct radeon_device *rdev, u32 block, bool enable);
> +u32 cik_gpu_check_soft_reset(struct radeon_device *rdev);
>
>  #endif                         /* __CIK_H__ */
> diff --git a/drivers/gpu/drm/radeon/cik_sdma.c b/drivers/gpu/drm/radeon/c=
ik_sdma.c
> index 3c709ebe8d1ab..919b14845c3c7 100644
> --- a/drivers/gpu/drm/radeon/cik_sdma.c
> +++ b/drivers/gpu/drm/radeon/cik_sdma.c
> @@ -27,14 +27,13 @@
>  #include "radeon_ucode.h"
>  #include "radeon_asic.h"
>  #include "radeon_trace.h"
> +#include "cik.h"
>  #include "cikd.h"
>
>  /* sdma */
>  #define CIK_SDMA_UCODE_SIZE 1050
>  #define CIK_SDMA_UCODE_VERSION 64
>
> -u32 cik_gpu_check_soft_reset(struct radeon_device *rdev);
> -
>  /*
>   * sDMA - System DMA
>   * Starting with CIK, the GPU has new asynchronous
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
