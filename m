Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71DE2B51EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgKPUF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgKPUF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:05:28 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:05:28 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so20143910wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YW2dTh4oJQLSF5m9U3tffnyoQMrIy8EdVtKCNqjV66o=;
        b=AyoWFN/Gx4/CWZy+/Ov1wUI8cVmrGwqjWaPw0HpZ8nNFYG89WVMk2qu5EUOads6cJn
         MNigI33KbMIgcrd/aWqVZ6jBK8LPeWDEST4WKmxIAbeAfAyqA+6huBh92aXNh5jXo7vS
         z3IbFsMjzGoGJKXoXvEBH1AaMmSokS7HfKkzYX9jnATl6sv878rh9W9h9J/50C1IlTPh
         G6KC4H/nZo6vd++9fWJFkM/Xm1Lt5yBLmuAi0A2W5M2aVAmLptCsOhV5zytuqv5WqzBB
         lsJmAROM070IHVfJH2AvqHsaT1CmUhuIUTdIPISc4rh3DSeKTx0EqIJhX3ZS6bdRi8Hm
         wilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YW2dTh4oJQLSF5m9U3tffnyoQMrIy8EdVtKCNqjV66o=;
        b=sHDPOok0Wnm/keIm6A2Tz//6GEY1k9w8FjnfMUhYnK2nEBuZop3L6dklkRQvlEUD0R
         WVdLtLxAu/S/TQpgvHH7We8W+5/AkixKKFXbK8qHW93L2uzdqk2jUjHFJHlY4/Ql5jeL
         Vr8G1x/iXhb30tCObJXLxl68nnVOeDSmMRMCqS4Bz5ZitX/UItjz0JKLTgE0Xzeu3O7u
         IaEKE3HHNc7bK2kGYTIItlzv4HwpIS94TBflauwHmi+UEFOutgRbr38VzEHe/o4C1+Yx
         f0dsWj0fwRFqOrd5Le3o44jlA8DeShvOlZFdcPIxiDIQd91qSa8/jCO+hrCiDogRvfZh
         7Swg==
X-Gm-Message-State: AOAM531p8IfsTR0FLwW3f46T5W0CT2QfgAY9AhwksmYUGCNjM2W7TgAr
        WwRXJqdLSiSvGEZodjlQzEGCahUPKZeY/pSh4GM=
X-Google-Smtp-Source: ABdhPJwzzCO9aVGsFu4o7t68GEX/GUkTUxhFR+Q8dYAHw3iUJFTOWyz9D76ALqT4iaHqBSnhADCfOSh6H3iEyWUDCf8=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr21011934wru.362.1605557127152;
 Mon, 16 Nov 2020 12:05:27 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-19-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-19-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:05:15 -0500
Message-ID: <CADnq5_OLspVPhXDGReMr9nL0eKchaPt9KtqhXO6JG2NhGMg3yQ@mail.gmail.com>
Subject: Re: [PATCH 18/43] drm/radeon/rv770: Move 'rv770_get_*()'s prototypes
 to shared header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>,
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
>  drivers/gpu/drm/radeon/rv770_dpm.c:47:18: warning: no previous prototype=
 for =E2=80=98rv770_get_ps=E2=80=99 [-Wmissing-prototypes]
>  47 | struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps)
>  | ^~~~~~~~~~~~
>  drivers/gpu/drm/radeon/rv770_dpm.c:54:26: warning: no previous prototype=
 for =E2=80=98rv770_get_pi=E2=80=99 [-Wmissing-prototypes]
>  54 | struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev)
>  | ^~~~~~~~~~~~
>
> Cc: Evan Quan <evan.quan@amd.com>
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
>  drivers/gpu/drm/radeon/btc_dpm.c     | 3 +--
>  drivers/gpu/drm/radeon/cypress_dpm.c | 3 +--
>  drivers/gpu/drm/radeon/ni_dpm.c      | 2 +-
>  drivers/gpu/drm/radeon/rv730_dpm.c   | 4 +---
>  drivers/gpu/drm/radeon/rv740_dpm.c   | 3 +--
>  drivers/gpu/drm/radeon/rv770.h       | 4 ++++
>  drivers/gpu/drm/radeon/rv770_dpm.c   | 1 +
>  drivers/gpu/drm/radeon/si_dpm.c      | 2 +-
>  8 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/btc_dpm.c b/drivers/gpu/drm/radeon/bt=
c_dpm.c
> index d1d8aaf8323c2..018949668536e 100644
> --- a/drivers/gpu/drm/radeon/btc_dpm.c
> +++ b/drivers/gpu/drm/radeon/btc_dpm.c
> @@ -30,6 +30,7 @@
>  #include "btcd.h"
>  #include "cypress_dpm.h"
>  #include "r600_dpm.h"
> +#include "rv770.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
>
> @@ -48,8 +49,6 @@
>  #ifndef BTC_MGCG_SEQUENCE
>  #define BTC_MGCG_SEQUENCE  300
>
> -struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps);
> -struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
>  struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
>
>  extern int ni_mc_load_microcode(struct radeon_device *rdev);
> diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeo=
n/cypress_dpm.c
> index 35b177d777913..6d3690bcca2d2 100644
> --- a/drivers/gpu/drm/radeon/cypress_dpm.c
> +++ b/drivers/gpu/drm/radeon/cypress_dpm.c
> @@ -28,6 +28,7 @@
>  #include "cypress_dpm.h"
>  #include "evergreend.h"
>  #include "r600_dpm.h"
> +#include "rv770.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
>
> @@ -43,8 +44,6 @@
>  #define MC_CG_SEQ_YCLK_SUSPEND      0x04
>  #define MC_CG_SEQ_YCLK_RESUME       0x0a
>
> -struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps);
> -struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
>  struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
>
>  static void cypress_enable_bif_dynamic_pcie_gen2(struct radeon_device *r=
dev,
> diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_=
dpm.c
> index 59cdadcece159..d39bbd9793cc2 100644
> --- a/drivers/gpu/drm/radeon/ni_dpm.c
> +++ b/drivers/gpu/drm/radeon/ni_dpm.c
> @@ -29,6 +29,7 @@
>  #include "ni_dpm.h"
>  #include "nid.h"
>  #include "r600_dpm.h"
> +#include "rv770.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
>
> @@ -719,7 +720,6 @@ static const u32 cayman_sysls_enable[] =3D
>  };
>  #define CAYMAN_SYSLS_ENABLE_LENGTH sizeof(cayman_sysls_enable) / (3 * si=
zeof(u32))
>
> -struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
>  struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
>
>  extern int ni_mc_load_microcode(struct radeon_device *rdev);
> diff --git a/drivers/gpu/drm/radeon/rv730_dpm.c b/drivers/gpu/drm/radeon/=
rv730_dpm.c
> index 84a3d6d724866..a9de5c953396a 100644
> --- a/drivers/gpu/drm/radeon/rv730_dpm.c
> +++ b/drivers/gpu/drm/radeon/rv730_dpm.c
> @@ -25,6 +25,7 @@
>  #include "radeon.h"
>  #include "rv730d.h"
>  #include "r600_dpm.h"
> +#include "rv770.h"
>  #include "rv770_dpm.h"
>  #include "atom.h"
>
> @@ -33,9 +34,6 @@
>  #define MC_CG_ARB_FREQ_F2           0x0c
>  #define MC_CG_ARB_FREQ_F3           0x0d
>
> -struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps);
> -struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
> -
>  int rv730_populate_sclk_value(struct radeon_device *rdev,
>                               u32 engine_clock,
>                               RV770_SMC_SCLK_VALUE *sclk)
> diff --git a/drivers/gpu/drm/radeon/rv740_dpm.c b/drivers/gpu/drm/radeon/=
rv740_dpm.c
> index 327d65a76e1f4..d57a3e1df8d63 100644
> --- a/drivers/gpu/drm/radeon/rv740_dpm.c
> +++ b/drivers/gpu/drm/radeon/rv740_dpm.c
> @@ -25,11 +25,10 @@
>  #include "radeon.h"
>  #include "rv740d.h"
>  #include "r600_dpm.h"
> +#include "rv770.h"
>  #include "rv770_dpm.h"
>  #include "atom.h"
>
> -struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
> -
>  u32 rv740_get_decoded_reference_divider(u32 encoded_ref)
>  {
>         u32 ref =3D 0;
> diff --git a/drivers/gpu/drm/radeon/rv770.h b/drivers/gpu/drm/radeon/rv77=
0.h
> index a3f2bb44979fe..0e15916d0a948 100644
> --- a/drivers/gpu/drm/radeon/rv770.h
> +++ b/drivers/gpu/drm/radeon/rv770.h
> @@ -29,7 +29,11 @@
>  #define __RADEON_RV770_H__
>
>  struct radeon_device;
> +struct radeon_ps;
>
>  void rv770_set_clk_bypass_mode(struct radeon_device *rdev);
>
> +struct rv7xx_ps *rv770_get_ps(struct radeon_ps *rps);
> +struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
> +
>  #endif                         /* __RADEON_RV770_H__ */
> diff --git a/drivers/gpu/drm/radeon/rv770_dpm.c b/drivers/gpu/drm/radeon/=
rv770_dpm.c
> index 4a0cf597c11c6..badd8ac6e038f 100644
> --- a/drivers/gpu/drm/radeon/rv770_dpm.c
> +++ b/drivers/gpu/drm/radeon/rv770_dpm.c
> @@ -24,6 +24,7 @@
>
>  #include "radeon.h"
>  #include "radeon_asic.h"
> +#include "rv770.h"
>  #include "rv770d.h"
>  #include "r600_dpm.h"
>  #include "rv770_dpm.h"
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index d1c73e9db889a..a80a21447a76d 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -27,6 +27,7 @@
>
>  #include "atom.h"
>  #include "r600_dpm.h"
> +#include "rv770.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "si_dpm.h"
> @@ -1717,7 +1718,6 @@ static const struct si_powertune_data powertune_dat=
a_hainan =3D
>         true
>  };
>
> -struct rv7xx_power_info *rv770_get_pi(struct radeon_device *rdev);
>  struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
>  struct ni_power_info *ni_get_pi(struct radeon_device *rdev);
>  struct ni_ps *ni_get_ps(struct radeon_ps *rps);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
