Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E82B5261
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:24:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbgKPUW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727359AbgKPUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:22:58 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBACAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:22:57 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 19so566131wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DuarJJhpDRx/9+5W9R32EPHRCg72/dsV/R3Fbi0RzDs=;
        b=n5YNkhvz2jgmhEYoGRO52BVn39NMFzJeAMVzPnk2GFxvat3OFpcsA14OgKCuzZBkGV
         J6LxhWzBrneFA7zOXzZHdtM3XGbQRTY4VwJHFxNp4+fnSSgEowpIVm1QSq0xTSrnDYJc
         0BQclXCXie08LNhNQB06y7LT5CLjni46ebzc+/FHRH1ZdoEATdjHwrM4TnTvXzlgyY5b
         arnh1JUnnuA9hW2D+8w87YanuVuFMxcWSCzAVH13iatKy6QZu9XYnYOSdggNL3+WXGoM
         GE+q9d7bNYtUDPGnM0KeExWCqU7FLaTwqRkJirujTBxZPP7wACaDB98X+e+jHC6aMJdl
         RCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DuarJJhpDRx/9+5W9R32EPHRCg72/dsV/R3Fbi0RzDs=;
        b=PcOWxXM+RaUJ4Qu7nuDNvXNucEM+e1ByYoB+uqfOByY5QZpvbop1am4i4RCGrQ/KlN
         9BZiV8Flqw35LzkNMZvuxUyx9aiuSUfgXBqKHZy50Nq3NWvPKKNp24KyRl6dSH8HE/aJ
         Sh+8wFTRdTWEa+yXyl6HuIItvIi4X67j3+kX8+j8jVqN748g9m6vGpcREn5IA4SE0gGi
         HtcYwX3+8PW8CzY3qwhQ1T7iYTrN2UxU8HoHjHdw1yuyTZLicLeOxkuXQIKPlnD1K7Rg
         hHyKZdJVZDwZLpeUwuzLX4D2cQv44eJObCbLMNUTA23ts4oHAeWJ+VO47XAfegjGPv+l
         kBkA==
X-Gm-Message-State: AOAM530rOTnqYGSr2ZdHwR1CgV7QjsC9HziwOaJJpfY83oti93IerOMj
        hg+0L3Gh91pbW/qBHWI+K0DxCLo2JzpIfP+0WkU=
X-Google-Smtp-Source: ABdhPJwz82pD94+4fHfPu9TrMqYJhfqMOndS19nP3bK3JLBd7APsbnE2rca+aktpzzLoMcga8iZC30CJFIiJqT4HWz4=
X-Received: by 2002:a1c:2dc8:: with SMTP id t191mr262491wmt.73.1605558176583;
 Mon, 16 Nov 2020 12:22:56 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-29-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-29-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:22:45 -0500
Message-ID: <CADnq5_O4CTPD=cCmeme955WHOuyFo40rDaNMjmFKpsFn_pOYzw@mail.gmail.com>
Subject: Re: [PATCH 28/43] drm/radeon/ci_dpm: Move 'ci_*()'s prototypes to
 shared header
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
>  drivers/gpu/drm/radeon/cik.c:1868:5: warning: no previous prototype for =
=E2=80=98ci_mc_load_microcode=E2=80=99 [-Wmissing-prototypes]
>  1868 | int ci_mc_load_microcode(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/cik.c:5847:6: warning: no previous prototype for =
=E2=80=98cik_enter_rlc_safe_mode=E2=80=99 [-Wmissing-prototypes]
>  5847 | void cik_enter_rlc_safe_mode(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/cik.c:5868:6: warning: no previous prototype for =
=E2=80=98cik_exit_rlc_safe_mode=E2=80=99 [-Wmissing-prototypes]
>  5868 | void cik_exit_rlc_safe_mode(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/cik.c:6286:6: warning: no previous prototype for =
=E2=80=98cik_update_cg=E2=80=99 [-Wmissing-prototypes]
>  6286 | void cik_update_cg(struct radeon_device *rdev,
>  | ^~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/ci_dpm.c |  7 +------
>  drivers/gpu/drm/radeon/cik.c    |  1 +
>  drivers/gpu/drm/radeon/cik.h    | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/gpu/drm/radeon/cik.h
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_=
dpm.c
> index 8324aca5fd006..a9fc0a552736c 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -27,6 +27,7 @@
>
>  #include "atom.h"
>  #include "ci_dpm.h"
> +#include "cik.h"
>  #include "cikd.h"
>  #include "r600_dpm.h"
>  #include "radeon.h"
> @@ -157,12 +158,6 @@ extern u8 si_get_mclk_frequency_ratio(u32 memory_clo=
ck, bool strobe_mode);
>  extern void si_trim_voltage_table_to_fit_state_table(struct radeon_devic=
e *rdev,
>                                                      u32 max_voltage_step=
s,
>                                                      struct atom_voltage_=
table *voltage_table);
> -extern void cik_enter_rlc_safe_mode(struct radeon_device *rdev);
> -extern void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
> -extern int ci_mc_load_microcode(struct radeon_device *rdev);
> -extern void cik_update_cg(struct radeon_device *rdev,
> -                         u32 block, bool enable);
> -
>  static int ci_get_std_voltage_value_sidd(struct radeon_device *rdev,
>                                          struct atom_voltage_table_entry =
*voltage_table,
>                                          u16 *std_voltage_hi_sidd, u16 *s=
td_voltage_lo_sidd);
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index 980b50d046cbc..ae020ad7b3185 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -32,6 +32,7 @@
>  #include "atom.h"
>  #include "evergreen.h"
>  #include "cik_blit_shaders.h"
> +#include "cik.h"
>  #include "cikd.h"
>  #include "clearstate_ci.h"
>  #include "r600.h"
> diff --git a/drivers/gpu/drm/radeon/cik.h b/drivers/gpu/drm/radeon/cik.h
> new file mode 100644
> index 0000000000000..297b3c1ff804f
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/cik.h
> @@ -0,0 +1,33 @@
> +/* cik.h -- Private header for radeon driver -*- linux-c -*-
> + * Copyright 2012 Advanced Micro Devices, Inc.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef __CIK_H__
> +#define __CIK_H__
> +
> +struct radeon_device;
> +
> +void cik_enter_rlc_safe_mode(struct radeon_device *rdev);
> +void cik_exit_rlc_safe_mode(struct radeon_device *rdev);
> +int ci_mc_load_microcode(struct radeon_device *rdev);
> +void cik_update_cg(struct radeon_device *rdev, u32 block, bool enable);
> +
> +#endif                         /* __CIK_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
