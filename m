Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61B92B515F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbgKPTmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbgKPTmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:42:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDADEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:42:30 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so20084899wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KTZFJMoYQUZgdpI/19BGIebojU4ukZZTbwKHE00HlzU=;
        b=elKJQiROtgbhrW+P9em1d5XxU/BilYkaRnYemQYBfQahAG2bLZwUDBqZvhqhOT6aBv
         YNTp2ePqbl4IlN55TjGAwtpAqPJppKXso+l9ARj7I0j0vPcopCtcAUbeFbc9GNhwb6lO
         L4RTJCqbAuxx36fSLavX4NIpJbitpBz86WgZ0kvbxQ7l+ykxcFd1r8Aw2tZk2N1m7Fp9
         8eY5Y/uA6u0emHuP0RUGmAZdCJuI7LrGUjZz2J3naLOVexFgOkFOGFwoGbhI5tygua15
         X8+dJBDnspmEi8aus4F0M3ZN/rpKN15hLXc5HAEhT8BiOhB+/NmeIUfE90Pam+0Lh4DG
         qYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KTZFJMoYQUZgdpI/19BGIebojU4ukZZTbwKHE00HlzU=;
        b=UyapCjGqZtESxBHU+tydTyKABBYkE+kGgzQs7QnmiCQpiSGqqRNWBeOhCsrhwc0Hib
         2TgiDrd/weDHHAA1jV85lNLf7b7rhnSLpnoTprSGHvrN6+HBB1IJPAUB2IyJeP3RIUx9
         iuCAo0hVe8k/MiSzx0jPWU4MJ92urkoveQMWAt/bUDeI5i+Ud6HhapAU+8m7ZBpzO6QO
         5yUI6G7tchmaCB0O7BCZ4dXI7tJSa8eptfkUjbPp+5NRFnZvA7XpzHnaBlKtn0epNWdq
         W3Xveo/W4mAHWk1fZKdSh957EP4NJdJS5OKuXiGM+44RvUNgiPzV7S5mg+TQlgnW1OLR
         GCsA==
X-Gm-Message-State: AOAM532HUeJss5ytUGrFg5j6xBKOh93J1w/v0Q10QgSwysdCtXjivHlE
        6ff3uGri28uov/1GStBOa24e0Vyiu8oIjqo1Ais=
X-Google-Smtp-Source: ABdhPJyVPbHew5fCWEwOHXse2oFu567Pe91sSIpcscwdSsjiCFueLZnkVOJ15/LGoBJyU4EUV5wxg1hHEykVlixY1PY=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr22208776wrn.124.1605555749750;
 Mon, 16 Nov 2020 11:42:29 -0800 (PST)
MIME-Version: 1.0
References: <20201116173005.1825880-1-lee.jones@linaro.org> <20201116173005.1825880-10-lee.jones@linaro.org>
In-Reply-To: <20201116173005.1825880-10-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:42:18 -0500
Message-ID: <CADnq5_O2PFLnsSTtDMhO+2a3_2z_s=gLHzF1JxLwqROgt8a2Ew@mail.gmail.com>
Subject: Re: [PATCH 09/43] drm/radeon/rv770: Move 'rv770_set_clk_bypass_mode'
 prototype to shared location
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

On Mon, Nov 16, 2020 at 12:30 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/rv770.c:1138:6: warning: no previous prototype fo=
r =E2=80=98rv770_set_clk_bypass_mode=E2=80=99 [-Wmissing-prototypes]
>  1138 | void rv770_set_clk_bypass_mode(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor changes.

Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/evergreen.c |  2 +-
>  drivers/gpu/drm/radeon/r600.c      |  2 +-
>  drivers/gpu/drm/radeon/rv770.c     |  1 +
>  drivers/gpu/drm/radeon/rv770.h     | 35 ++++++++++++++++++++++++++++++
>  4 files changed, 38 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/gpu/drm/radeon/rv770.h
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/=
evergreen.c
> index 1f2acca437abd..9a1e240b07234 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -31,6 +31,7 @@
>
>  #include "atom.h"
>  #include "avivod.h"
> +#include "rv770.h"
>  #include "evergreen_blit_shaders.h"
>  #include "evergreen_reg.h"
>  #include "evergreend.h"
> @@ -223,7 +224,6 @@ extern u32 si_get_csb_size(struct radeon_device *rdev=
);
>  extern void si_get_csb_buffer(struct radeon_device *rdev, volatile u32 *=
buffer);
>  extern u32 cik_get_csb_size(struct radeon_device *rdev);
>  extern void cik_get_csb_buffer(struct radeon_device *rdev, volatile u32 =
*buffer);
> -extern void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
>
>  static const u32 evergreen_golden_registers[] =3D
>  {
> diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.=
c
> index 12a918335ac7b..f09b6dc5cbeb3 100644
> --- a/drivers/gpu/drm/radeon/r600.c
> +++ b/drivers/gpu/drm/radeon/r600.c
> @@ -40,6 +40,7 @@
>  #include "atom.h"
>  #include "avivod.h"
>  #include "r600d.h"
> +#include "rv770.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_audio.h"
> @@ -112,7 +113,6 @@ void r600_fini(struct radeon_device *rdev);
>  void r600_irq_disable(struct radeon_device *rdev);
>  static void r600_pcie_gen2_enable(struct radeon_device *rdev);
>  extern int evergreen_rlc_resume(struct radeon_device *rdev);
> -extern void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
>
>  /*
>   * Indirect registers accessor
> diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv77=
0.c
> index 21f653ae1e1bb..88e29ebaad467 100644
> --- a/drivers/gpu/drm/radeon/rv770.c
> +++ b/drivers/gpu/drm/radeon/rv770.c
> @@ -39,6 +39,7 @@
>  #include "radeon_asic.h"
>  #include "radeon_audio.h"
>  #include "rv770d.h"
> +#include "rv770.h"
>
>  #define R700_PFP_UCODE_SIZE 848
>  #define R700_PM4_UCODE_SIZE 1360
> diff --git a/drivers/gpu/drm/radeon/rv770.h b/drivers/gpu/drm/radeon/rv77=
0.h
> new file mode 100644
> index 0000000000000..a3f2bb44979fe
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/rv770.h
> @@ -0,0 +1,35 @@
> +/* radeon_rv770.h -- Private header for radeon driver -*- linux-c -*-
> + *
> + * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
> + * Copyright 2000 VA Linux Systems, Inc., Fremont, California.
> + * All rights reserved.
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
> + * The above copyright notice and this permission notice (including the =
next
> + * paragraph) shall be included in all copies or substantial portions of=
 the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * PRECISION INSIGHT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR=
 OTHER
> + * DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __RADEON_RV770_H__
> +#define __RADEON_RV770_H__
> +
> +struct radeon_device;
> +
> +void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
> +
> +#endif                         /* __RADEON_RV770_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
