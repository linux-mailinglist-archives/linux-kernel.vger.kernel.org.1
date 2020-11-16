Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0633C2B5178
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgKPTrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKPTrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:47:45 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F95C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:47:45 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h2so461799wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PYo+r6flmlYIu4ACRL/mcGqGmGwzw3cScxxOw0h3rm4=;
        b=JvNGOas7bw9xuCQecppvkL0SKdRoODY+KLGAFE16cgNw4/Z/zxOKKq3jKp49/rQHGj
         6XpntS7k4x2KC/22oUDGrdSQNs3CTngJQ2bnJ3fLqVGkPMoagexCTEWiJXVZFFaXoe8R
         N/xP9eSNupUEp3yjZE4aN9F+ZQupDcOpHrdvxREhM9gUWmByYKWGw5wJ839VEv1UCdvm
         S7h3Tsnj8Gou822sgctt/LLTG4P2knWlKIqKCDdUY+fcUmzC+/viJu7Pvba1c32r2NF1
         bHMQ0o0kNtyFzy0ul6WQdvxrxKUqRizP/fLnMidmBqIn/5IO/jmH4CUYNAqXYoHg0gQR
         pFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PYo+r6flmlYIu4ACRL/mcGqGmGwzw3cScxxOw0h3rm4=;
        b=bU6RKEzVSSJajeNQhD1PNBP1a3BmVGm1tB76yVBvE0R59VvhI2VJx0IiAtkJSOCTeK
         WRLJStJuFoM5SGqleD2jAMVVKEAysKKNaoeu+8e1Hm1LRXdJqdVpDmRm6eYHZPqCJ0y7
         KLhCdcCku5t1T+tVj0wWZKebH8Go7Zkm4DMRyxVfmvNLLVvRUvVgb+nvluIRzD+mjv9P
         wKfXakspKPZEXgX++RRXqNX6Ve5i6l/0okQKWS4jHWaUrOnDElE8yFqZ0ilJO+Dxoetm
         GE4X1GQVBIW0wCCfWBr2lOe5QjCHMZJ6uyTVRwlzvldEYtsmN3XZKwfc0vH1sopHxLKo
         2DBQ==
X-Gm-Message-State: AOAM531e+CA4mqWaiKWUwZcBCAXriI0e2WiJ844rdHVK/bzvrTFBDMGV
        W8Zoz5LZeWtpto3f989rBNBZsJjrzSZsEs+OJlg=
X-Google-Smtp-Source: ABdhPJwMTB9qv+PXelqfAgNqL2fIwllHgqhZdXv2TQhG8PmTPgatNhWcTyEwtrlPeiGQJbJpsbROze/58whrowTCtiQ=
X-Received: by 2002:a1c:2dc8:: with SMTP id t191mr138380wmt.73.1605556063974;
 Mon, 16 Nov 2020 11:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20201116173005.1825880-1-lee.jones@linaro.org> <20201116173005.1825880-13-lee.jones@linaro.org>
In-Reply-To: <20201116173005.1825880-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:47:32 -0500
Message-ID: <CADnq5_NZ0gaYtr8GVYz+fndYnk6AtmzSXChuhnOxnpzdS3nOjQ@mail.gmail.com>
Subject: Re: [PATCH 12/43] drm/radeon/evergreen: Move 'evergreen_*' and
 'sumo_*' prototypes out to shared location
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
>  drivers/gpu/drm/radeon/evergreen.c:1281:6: warning: no previous prototyp=
e for =E2=80=98evergreen_fix_pci_max_read_req_size=E2=80=99 [-Wmissing-prot=
otypes]
>  1281 | void evergreen_fix_pci_max_read_req_size(struct radeon_device *rd=
ev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:2664:6: warning: no previous prototyp=
e for =E2=80=98evergreen_mc_stop=E2=80=99 [-Wmissing-prototypes]
>  2664 | void evergreen_mc_stop(struct radeon_device *rdev, struct evergre=
en_mc_save *save)
>  | ^~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:2762:6: warning: no previous prototyp=
e for =E2=80=98evergreen_mc_resume=E2=80=99 [-Wmissing-prototypes]
>  2762 | void evergreen_mc_resume(struct radeon_device *rdev, struct everg=
reen_mc_save *save)
>  | ^~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:2850:6: warning: no previous prototyp=
e for =E2=80=98evergreen_mc_program=E2=80=99 [-Wmissing-prototypes]
>  2850 | void evergreen_mc_program(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:3710:5: warning: no previous prototyp=
e for =E2=80=98evergreen_mc_init=E2=80=99 [-Wmissing-prototypes]
>  3710 | int evergreen_mc_init(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:3769:6: warning: no previous prototyp=
e for =E2=80=98evergreen_print_gpu_status_regs=E2=80=99 [-Wmissing-prototyp=
es]
>  3769 | void evergreen_print_gpu_status_regs(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:3797:6: warning: no previous prototyp=
e for =E2=80=98evergreen_is_display_hung=E2=80=99 [-Wmissing-prototypes]
>  3797 | bool evergreen_is_display_hung(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:4009:6: warning: no previous prototyp=
e for =E2=80=98evergreen_gpu_pci_config_reset=E2=80=99 [-Wmissing-prototype=
s]
>  4009 | void evergreen_gpu_pci_config_reset(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:4110:6: warning: no previous prototyp=
e for =E2=80=98sumo_rlc_fini=E2=80=99 [-Wmissing-prototypes]
>  4110 | void sumo_rlc_fini(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:4153:5: warning: no previous prototyp=
e for =E2=80=98sumo_rlc_init=E2=80=99 [-Wmissing-prototypes]
>  4153 | int sumo_rlc_init(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:4381:5: warning: no previous prototyp=
e for =E2=80=98evergreen_rlc_resume=E2=80=99 [-Wmissing-prototypes]
>  4381 | int evergreen_rlc_resume(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/evergreen.c:4670:6: warning: no previous prototyp=
e for =E2=80=98evergreen_irq_suspend=E2=80=99 [-Wmissing-prototypes]
>  4670 | void evergreen_irq_suspend(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~~~~~~~~~~
>
> NB: Lots more of these - snipped for brevity
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
>  drivers/gpu/drm/radeon/cik.c       |  6 +---
>  drivers/gpu/drm/radeon/evergreen.c |  1 +
>  drivers/gpu/drm/radeon/evergreen.h | 51 ++++++++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/ni.c        | 16 +---------
>  drivers/gpu/drm/radeon/si.c        |  7 +---
>  5 files changed, 55 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/gpu/drm/radeon/evergreen.h
>
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index abf370e16bd9f..315c4f3df3656 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -30,6 +30,7 @@
>  #include <drm/drm_vblank.h>
>
>  #include "atom.h"
> +#include "evergreen.h"
>  #include "cik_blit_shaders.h"
>  #include "cikd.h"
>  #include "clearstate_ci.h"
> @@ -126,11 +127,6 @@ MODULE_FIRMWARE("radeon/mullins_sdma.bin");
>
>  extern int r600_ih_ring_alloc(struct radeon_device *rdev);
>  extern void r600_ih_ring_fini(struct radeon_device *rdev);
> -extern void evergreen_mc_stop(struct radeon_device *rdev, struct evergre=
en_mc_save *save);
> -extern void evergreen_mc_resume(struct radeon_device *rdev, struct everg=
reen_mc_save *save);
> -extern bool evergreen_is_display_hung(struct radeon_device *rdev);
> -extern void sumo_rlc_fini(struct radeon_device *rdev);
> -extern int sumo_rlc_init(struct radeon_device *rdev);
>  extern void si_vram_gtt_location(struct radeon_device *rdev, struct rade=
on_mc *mc);
>  extern void si_rlc_reset(struct radeon_device *rdev);
>  extern void si_init_uvd_internal_cg(struct radeon_device *rdev);
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/=
evergreen.c
> index 9a1e240b07234..f860f5ef2df88 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -32,6 +32,7 @@
>  #include "atom.h"
>  #include "avivod.h"
>  #include "rv770.h"
> +#include "evergreen.h"
>  #include "evergreen_blit_shaders.h"
>  #include "evergreen_reg.h"
>  #include "evergreend.h"
> diff --git a/drivers/gpu/drm/radeon/evergreen.h b/drivers/gpu/drm/radeon/=
evergreen.h
> new file mode 100644
> index 0000000000000..30c9ca99ced90
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/evergreen.h
> @@ -0,0 +1,51 @@
> +/* radeon_evergreen.h -- Private header for radeon driver -*- linux-c -*=
-
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
> +#ifndef __RADEON_EVERGREEN_H__
> +#define __RADEON_EVERGREEN_H__
> +
> +struct evergreen_mc_save;
> +struct radeon_device;
> +
> +bool evergreen_is_display_hung(struct radeon_device *rdev);
> +void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
> +void evergreen_mc_stop(struct radeon_device *rdev, struct evergreen_mc_s=
ave *save);
> +void evergreen_mc_resume(struct radeon_device *rdev, struct evergreen_mc=
_save *save);
> +int evergreen_mc_wait_for_idle(struct radeon_device *rdev);
> +void evergreen_mc_program(struct radeon_device *rdev);
> +void evergreen_irq_suspend(struct radeon_device *rdev);
> +int evergreen_mc_init(struct radeon_device *rdev);
> +void evergreen_fix_pci_max_read_req_size(struct radeon_device *rdev);
> +void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
> +void evergreen_program_aspm(struct radeon_device *rdev);
> +void sumo_rlc_fini(struct radeon_device *rdev);
> +int sumo_rlc_init(struct radeon_device *rdev);
> +void evergreen_gpu_pci_config_reset(struct radeon_device *rdev);
> +u32 evergreen_get_number_of_dram_channels(struct radeon_device *rdev);
> +void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
> +
> +#endif                         /* __RADEON_EVERGREEN_H__ */
> diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
> index 564a775b4b90c..1c9030a4631b8 100644
> --- a/drivers/gpu/drm/radeon/ni.c
> +++ b/drivers/gpu/drm/radeon/ni.c
> @@ -32,6 +32,7 @@
>  #include "atom.h"
>  #include "cayman_blit_shaders.h"
>  #include "clearstate_cayman.h"
> +#include "evergreen.h"
>  #include "ni_reg.h"
>  #include "nid.h"
>  #include "radeon.h"
> @@ -190,21 +191,6 @@ static const u32 tn_rlc_save_restore_register_list[]=
 =3D
>         0x802c,
>  };
>
> -extern bool evergreen_is_display_hung(struct radeon_device *rdev);
> -extern void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
> -extern void evergreen_mc_stop(struct radeon_device *rdev, struct evergre=
en_mc_save *save);
> -extern void evergreen_mc_resume(struct radeon_device *rdev, struct everg=
reen_mc_save *save);
> -extern int evergreen_mc_wait_for_idle(struct radeon_device *rdev);
> -extern void evergreen_mc_program(struct radeon_device *rdev);
> -extern void evergreen_irq_suspend(struct radeon_device *rdev);
> -extern int evergreen_mc_init(struct radeon_device *rdev);
> -extern void evergreen_fix_pci_max_read_req_size(struct radeon_device *rd=
ev);
> -extern void evergreen_pcie_gen2_enable(struct radeon_device *rdev);
> -extern void evergreen_program_aspm(struct radeon_device *rdev);
> -extern void sumo_rlc_fini(struct radeon_device *rdev);
> -extern int sumo_rlc_init(struct radeon_device *rdev);
> -extern void evergreen_gpu_pci_config_reset(struct radeon_device *rdev);
> -
>  /* Firmware Names */
>  MODULE_FIRMWARE("radeon/BARTS_pfp.bin");
>  MODULE_FIRMWARE("radeon/BARTS_me.bin");
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index de0792842af89..45076c27d7ded 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -32,6 +32,7 @@
>
>  #include "atom.h"
>  #include "clearstate_si.h"
> +#include "evergreen.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_audio.h"
> @@ -129,12 +130,6 @@ extern void sumo_rlc_fini(struct radeon_device *rdev=
);
>  extern int sumo_rlc_init(struct radeon_device *rdev);
>  extern int r600_ih_ring_alloc(struct radeon_device *rdev);
>  extern void r600_ih_ring_fini(struct radeon_device *rdev);
> -extern void evergreen_fix_pci_max_read_req_size(struct radeon_device *rd=
ev);
> -extern void evergreen_mc_stop(struct radeon_device *rdev, struct evergre=
en_mc_save *save);
> -extern void evergreen_mc_resume(struct radeon_device *rdev, struct everg=
reen_mc_save *save);
> -extern u32 evergreen_get_number_of_dram_channels(struct radeon_device *r=
dev);
> -extern void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
> -extern bool evergreen_is_display_hung(struct radeon_device *rdev);
>  static void si_enable_gui_idle_interrupt(struct radeon_device *rdev,
>                                          bool enable);
>  static void si_init_pg(struct radeon_device *rdev);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
