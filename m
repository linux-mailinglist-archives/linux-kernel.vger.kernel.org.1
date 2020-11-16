Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3B92B5213
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbgKPUMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgKPUL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:11:59 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B3C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:11:59 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so498970wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qTxfOKQUxRdDG14wf+RWttmARnM8pSTqYzJekTnRik4=;
        b=CkhM1ToyKHuqQdiemsOnm8i1QzDqVDQGu56+Sl1AxWHp11KO4hA3YDW+PEbaHEh7Lv
         X0o4s7Tf+8IXE/Dw4yczCzyLdsCkxeJWPAfzEMLhpYGvjPeo6Lpj1JNzsDGaoSCDbaGS
         hXRCn1LCyCCcQQJ94slO6fA+B270XhZPrps5kyMp/G8+DP/V47DZg+a0kMn89WEFyuCz
         2KxDiWg7U+zKfiHXWeprloOWoCD5HjtqxfRmW26E7TCN0pVCaoNEDFoIcj0Ak7BXqgSF
         yYZn3DCShjBIjMDSniN3M4494lWvKVOY7vgUNIF+NRyEMssXxUfWQTwKoRca11WZfuWZ
         iHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qTxfOKQUxRdDG14wf+RWttmARnM8pSTqYzJekTnRik4=;
        b=j+1kPKZdnJKr7EP4EEOsymJveDRD/ezwQxdVRR0Y6wXIBDoAClxaEEE5g2aGFOipuM
         NKcqQn4T1+rQ2j7PZUnTYrHKpAz8WSJRfBn5RKOn7LDvdOxR2vvdtC+TAMFDCkdSnj5x
         RHmtczLeobPga15K8pXBIPTHc42Fckz2orbZ3gs69AjCXXY984Rk3J+g/bZDDOcXvalo
         z/XNEeX3XAVgEfIcJudRCac/JHpOrshpzgEiJq19h9Vkvu1nYrhVjZjGkmWxtNBYUbsW
         O6xipOvRVJDKabVgR4NGFCxomYI6kna/xyxPvgS92Sa5n/Fu1wERzuVhUFEkYiuSuQJI
         FO7Q==
X-Gm-Message-State: AOAM531G4a/bvmGzqZGeZOb+PFqkox+5As2tCHVGqmgAuh7EJVqqJYeU
        rCxJ2MxdCMINooEFkwf/H0gGrnsJmsMWypkyjlhDgywx
X-Google-Smtp-Source: ABdhPJw8Nck/1UGRqQzRtWHjBPqM2h910HsaKPj3G4FLmAQY7KIqvPOYAjFRZY6KgEremnUVbHscIJjuMTF3rRururo=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr617553wmi.70.1605557518183;
 Mon, 16 Nov 2020 12:11:58 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-21-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-21-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:11:47 -0500
Message-ID: <CADnq5_NRtVaipNt3v4Gn_rtY4S7Nf-=_gXpJDrHb1FW2z_qx+g@mail.gmail.com>
Subject: Re: [PATCH 20/43] drm/radeon/evergreen: Move 'cayman_*()'s prototypes
 to shared header
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
>  drivers/gpu/drm/radeon/ni.c:1378:6: warning: no previous prototype for =
=E2=80=98cayman_cp_int_cntl_setup=E2=80=99 [-Wmissing-prototypes]
>  1378 | void cayman_cp_int_cntl_setup(struct radeon_device *rdev,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/ni.c:1732:5: warning: no previous prototype for =
=E2=80=98cayman_gpu_check_soft_reset=E2=80=99 [-Wmissing-prototypes]
>  1732 | u32 cayman_gpu_check_soft_reset(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor changes.  Thanks!

Alex


> ---
>  drivers/gpu/drm/radeon/evergreen.c |  5 +---
>  drivers/gpu/drm/radeon/ni.c        |  1 +
>  drivers/gpu/drm/radeon/ni.h        | 38 ++++++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/radeon/ni.h
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/=
evergreen.c
> index f860f5ef2df88..8fb0b8c3db5b5 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -31,6 +31,7 @@
>
>  #include "atom.h"
>  #include "avivod.h"
> +#include "ni.h"
>  #include "rv770.h"
>  #include "evergreen.h"
>  #include "evergreen_blit_shaders.h"
> @@ -215,10 +216,6 @@ static void evergreen_gpu_init(struct radeon_device =
*rdev);
>  void evergreen_fini(struct radeon_device *rdev);
>  void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
>  void evergreen_program_aspm(struct radeon_device *rdev);
> -extern void cayman_cp_int_cntl_setup(struct radeon_device *rdev,
> -                                    int ring, u32 cp_int_cntl);
> -extern void cayman_vm_decode_fault(struct radeon_device *rdev,
> -                                  u32 status, u32 addr);
>  void cik_init_cp_pg_table(struct radeon_device *rdev);
>
>  extern u32 si_get_csb_size(struct radeon_device *rdev);
> diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
> index 1c9030a4631b8..ab7bd30802176 100644
> --- a/drivers/gpu/drm/radeon/ni.c
> +++ b/drivers/gpu/drm/radeon/ni.c
> @@ -33,6 +33,7 @@
>  #include "cayman_blit_shaders.h"
>  #include "clearstate_cayman.h"
>  #include "evergreen.h"
> +#include "ni.h"
>  #include "ni_reg.h"
>  #include "nid.h"
>  #include "radeon.h"
> diff --git a/drivers/gpu/drm/radeon/ni.h b/drivers/gpu/drm/radeon/ni.h
> new file mode 100644
> index 0000000000000..d63be1c88c0f1
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/ni.h
> @@ -0,0 +1,38 @@
> +/* ni.h -- Private header for radeon driver -*- linux-c -*-
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
> +#ifndef __NI_H__
> +#define __NI_H__
> +
> +struct radeon_device;
> +
> +void cayman_cp_int_cntl_setup(struct radeon_device *rdev,
> +                             int ring, u32 cp_int_cntl);
> +void cayman_vm_decode_fault(struct radeon_device *rdev,
> +                           u32 status, u32 addr);
> +
> +#endif                         /* __NI_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
