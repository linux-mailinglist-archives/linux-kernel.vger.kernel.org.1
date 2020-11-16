Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB9C2B52FD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbgKPUnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733259AbgKPUnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:40 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2C3C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:39 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p19so661907wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=72+My05R2K37X/7BbFpqFfgtNYcfRc+0O1hM6OEayuc=;
        b=gmI7WTo0QlgLRJ7JU/RU7V6edDxnCaPPX0ZAA/ZawXNv/4kdYhk0sN5Q8hUydfesPk
         CPNKv/T9rYXQMCYf0uHIfNudncr59D81GAAGZy4hMFh0zNOw3/OoGw8L5SOca3gratno
         8kOD1iuKd/e5t3axYvZRBH0cFftpuiSGKk6Me3n+FfzN4oF0PGKEB/HCIK8Stt1snIjx
         UgNJBBbapxT+u4muK/HXHnVJ+LP7poSQimx6vYHo7qYc6uHLU6cjQEHGaoYc4iT33OHO
         vfW+LZPFpm9ZWLCzs1VVBhqTcR3hMp+P90S9AEAgIch2ncIFeCR9tM1ILgIJuwR8syt/
         cAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=72+My05R2K37X/7BbFpqFfgtNYcfRc+0O1hM6OEayuc=;
        b=L1Js65c2iXhdAr2jul4PfdglOiYFvq5C51P5k7TxgShfP0Gm4W8jA7atbQk4QB+RTC
         m6dAzXX0L9TXcEZ2Bm6gW08WqaU73IDR27RCTVw1G2sH3BJ3mzoCeChcSSt3wFC6VRky
         r6cQWyYvj5LRbmlRMsVHHT3jfrvIiUjlo56UXDOJFncC9P5FRMlOcgdgorsqCqHECpGS
         ct9CVmVbYUJQ+BpvesBfbNguQGA3JG+xLgzFP80EawHZ5NRZHgVEtv62fA0NPp1vDJl4
         xftQAlPKyNbj+7BdC3RAKno8k/xhXWK/kSFbt3QjwjKjBx52AKv/HR0354Xheszq1R0z
         +RlQ==
X-Gm-Message-State: AOAM533jg+5QAHZUy1PPM6e5qEZ79fSZQ6B48RP3kgHbWsNJTr9UbVG3
        xr4obdLTruEEQtGR+vwhXkHqj59X7Ucv7hFsFN4=
X-Google-Smtp-Source: ABdhPJwHzp3uyl9neM+GNHxPB4K1zDE9Xeo+x7YsJc8/EFl+JJA40IifDHGsLVPsTBQtDS6WpupsxWBpu0z+HQt6GDM=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr750927wmb.56.1605559418637;
 Mon, 16 Nov 2020 12:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-40-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-40-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:43:27 -0500
Message-ID: <CADnq5_OZP_OVqbgkPoJKGnDnoEMCYpq9P3L=53LrU-nWaw9W+g@mail.gmail.com>
Subject: Re: [PATCH 39/43] drm/radeon/si_dpm: Move 'vce_v1_0_enable_mgcg()'s
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
>  drivers/gpu/drm/radeon/vce_v1_0.c:102:6: warning: no previous prototype =
for =E2=80=98vce_v1_0_enable_mgcg=E2=80=99 [-Wmissing-prototypes]
>  102 | void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable)
>  | ^~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/si_dpm.c      |  3 +--
>  drivers/gpu/drm/radeon/trinity_dpm.c |  2 +-
>  drivers/gpu/drm/radeon/vce.h         | 34 ++++++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/vce_v1_0.c    |  1 +
>  4 files changed, 37 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/radeon/vce.h
>
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index b4581392fbce9..cd07b06301b44 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -35,6 +35,7 @@
>  #include "si_dpm.h"
>  #include "si.h"
>  #include "sid.h"
> +#include "vce.h"
>
>  #define MC_CG_ARB_FREQ_F0           0x0a
>  #define MC_CG_ARB_FREQ_F1           0x0b
> @@ -1721,8 +1722,6 @@ static const struct si_powertune_data powertune_dat=
a_hainan =3D
>         true
>  };
>
> -extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable=
);
> -
>  static int si_populate_voltage_value(struct radeon_device *rdev,
>                                      const struct atom_voltage_table *tab=
le,
>                                      u16 value, SISLANDS_SMC_VOLTAGE_VALU=
E *voltage);
> diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeo=
n/trinity_dpm.c
> index e005c18aac00e..08ea1c864cb23 100644
> --- a/drivers/gpu/drm/radeon/trinity_dpm.c
> +++ b/drivers/gpu/drm/radeon/trinity_dpm.c
> @@ -29,6 +29,7 @@
>  #include "radeon_asic.h"
>  #include "trinity_dpm.h"
>  #include "trinityd.h"
> +#include "vce.h"
>
>  #define TRINITY_MAX_DEEPSLEEP_DIVIDER_ID 5
>  #define TRINITY_MINIMUM_ENGINE_CLOCK 800
> @@ -293,7 +294,6 @@ static const u32 trinity_override_mgpg_sequences[] =
=3D
>         0x00000204, 0x00000000,
>  };
>
> -extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable=
);
>  static void trinity_program_clk_gating_hw_sequence(struct radeon_device =
*rdev,
>                                                    const u32 *seq, u32 co=
unt);
>  static void trinity_override_dynamic_mg_powergating(struct radeon_device=
 *rdev);
> diff --git a/drivers/gpu/drm/radeon/vce.h b/drivers/gpu/drm/radeon/vce.h
> new file mode 100644
> index 0000000000000..1eb4f5715202e
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/vce.h
> @@ -0,0 +1,34 @@
> +/* vce.h -- Private header for radeon driver -*- linux-c -*-
> + *
> + * Copyright 2013 Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the
> + * "Software"), to deal in the Software without restriction, including
> + * without limitation the rights to use, copy, modify, merge, publish,
> + * distribute, sub license, and/or sell copies of the Software, and to
> + * permit persons to whom the Software is furnished to do so, subject to
> + * the following conditions:
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY=
 CLAIM,
> + * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> + * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR=
 THE
> + * USE OR OTHER DEALINGS IN THE SOFTWARE.
> + *
> + * The above copyright notice and this permission notice (including the
> + * next paragraph) shall be included in all copies or substantial portio=
ns
> + * of the Software.
> + */
> +
> +#ifndef __VCE_H__
> +#define __VCE_H__
> +
> +struct radeon_device;
> +
> +void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable);
> +
> +#endif                         /* __VCE_H__ */
> diff --git a/drivers/gpu/drm/radeon/vce_v1_0.c b/drivers/gpu/drm/radeon/v=
ce_v1_0.c
> index bd75bbcf5bf63..70c5da2141d75 100644
> --- a/drivers/gpu/drm/radeon/vce_v1_0.c
> +++ b/drivers/gpu/drm/radeon/vce_v1_0.c
> @@ -30,6 +30,7 @@
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "sid.h"
> +#include "vce.h"
>
>  #define VCE_V1_0_FW_SIZE       (256 * 1024)
>  #define VCE_V1_0_STACK_SIZE    (64 * 1024)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
