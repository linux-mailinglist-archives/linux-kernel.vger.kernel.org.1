Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930D12B5289
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgKPU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730230AbgKPU2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:28:35 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E4EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:28:33 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 19so577622wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+THWoSFPl6DSvfYvA8QsEbw5MlJ3ABS5n8CeT+jAkE4=;
        b=b6FA40MYWSad04XTxLhayYdUj/LV99036tlWQGBsRGmFzn2txlbHe0qwCQeswMGT/u
         6YRbqPLXvPmE5gtfBuIkakWbETj6gHWBD3+TRUSm0zQfPs6Y6heP9UXbRRAjkG96dMVL
         ZAACnYZFsjBGE5Xbf5c6eTo1kWY0CGAaDw1Mm+D92Jsm9z0ruEgy4CWytQYdZW109MvW
         U/u4yqC5GU2L0XUghyYbXxhQCWLFc+cytBUZziQHpOVHUGDVAHY/m5HMQXJJ7R6yyd04
         bi6+CTnp1MKSmp3f9Qd9NmPJh8GntrzwNh1iwVM9WBtLFvEMmoD/XALEtASh6ISDZk/X
         0rOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+THWoSFPl6DSvfYvA8QsEbw5MlJ3ABS5n8CeT+jAkE4=;
        b=lMDv2M9Ldtpyi1jBeJvUP8QQ3HZCjaPW2A1N8/407jj50CW4myfeJE16zEgpQWdWdS
         b0AaBeAKmE4p8/dz46usKZxQN9d3JJNM0YH60kEcunPQY+PQj42eVcFEp0dfeN8AjWMg
         ZanOa8yHQ23rpGWc/Dm1rmSsVkXFF/OwPSHkhe6TaQhpYS3ipLQzcxQR2ouUFXSuzKvF
         b2Znk4GScgBzF5ZZq73aQyNwkQS6OTAvHuqgQL+tA9OA3O1xbKR5u9LkuFsZp83EIH6X
         SgYKHuwbKbs6xQbX/o8JeMlnl0NEQTiITPrc4shzStftZnZ+y1x+Tun5hqPc1dIEipJG
         5+IQ==
X-Gm-Message-State: AOAM5310U5j8RFQ3yOpSWeSTSE7lRB14oUR6z1jHHiuOGpyPDZ+FosQh
        CmTvhmVfnxi57L0H613+uUdEFz+zMvlB/l5gXQNW9Hlx
X-Google-Smtp-Source: ABdhPJx0owT+Ry5YxONkz541RDClR8NqfEosvC8kZOt8zVeh742FTg/sMZjS6u0uOpD4U5PDs0WgIlKawZ/hVePfJJQ=
X-Received: by 2002:a7b:c015:: with SMTP id c21mr656768wmb.79.1605558512530;
 Mon, 16 Nov 2020 12:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-33-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-33-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:28:21 -0500
Message-ID: <CADnq5_Mw48W9J=R8SBm23sqkdFhWi5kCuoBWM0yTrDWKMxiHag@mail.gmail.com>
Subject: Re: [PATCH 32/43] drm/radeon/btc_dpm: Move 'evergreen_get_pi's
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
>  drivers/gpu/drm/radeon/rv770_dpm.c:62:30: warning: no previous prototype=
 for =E2=80=98evergreen_get_pi=E2=80=99 [-Wmissing-prototypes]
>  62 | struct evergreen_power_info *evergreen_get_pi(struct radeon_device =
*rdev)
>  | ^~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/btc_dpm.c     | 3 +--
>  drivers/gpu/drm/radeon/cypress_dpm.c | 3 +--
>  drivers/gpu/drm/radeon/evergreen.h   | 2 ++
>  drivers/gpu/drm/radeon/ni_dpm.c      | 3 +--
>  drivers/gpu/drm/radeon/rv770_dpm.c   | 1 +
>  drivers/gpu/drm/radeon/si_dpm.c      | 3 +--
>  6 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/btc_dpm.c b/drivers/gpu/drm/radeon/bt=
c_dpm.c
> index 018949668536e..4e64ed38c439f 100644
> --- a/drivers/gpu/drm/radeon/btc_dpm.c
> +++ b/drivers/gpu/drm/radeon/btc_dpm.c
> @@ -29,6 +29,7 @@
>  #include "btc_dpm.h"
>  #include "btcd.h"
>  #include "cypress_dpm.h"
> +#include "evergreen.h"
>  #include "r600_dpm.h"
>  #include "rv770.h"
>  #include "radeon.h"
> @@ -49,8 +50,6 @@
>  #ifndef BTC_MGCG_SEQUENCE
>  #define BTC_MGCG_SEQUENCE  300
>
> -struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
> -
>  extern int ni_mc_load_microcode(struct radeon_device *rdev);
>
>  //********* BARTS **************//
> diff --git a/drivers/gpu/drm/radeon/cypress_dpm.c b/drivers/gpu/drm/radeo=
n/cypress_dpm.c
> index 6d3690bcca2d2..fdddbbaecbb74 100644
> --- a/drivers/gpu/drm/radeon/cypress_dpm.c
> +++ b/drivers/gpu/drm/radeon/cypress_dpm.c
> @@ -26,6 +26,7 @@
>
>  #include "atom.h"
>  #include "cypress_dpm.h"
> +#include "evergreen.h"
>  #include "evergreend.h"
>  #include "r600_dpm.h"
>  #include "rv770.h"
> @@ -44,8 +45,6 @@
>  #define MC_CG_SEQ_YCLK_SUSPEND      0x04
>  #define MC_CG_SEQ_YCLK_RESUME       0x0a
>
> -struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
> -
>  static void cypress_enable_bif_dynamic_pcie_gen2(struct radeon_device *r=
dev,
>                                                  bool enable)
>  {
> diff --git a/drivers/gpu/drm/radeon/evergreen.h b/drivers/gpu/drm/radeon/=
evergreen.h
> index f8d772e612a48..a829deb8b078a 100644
> --- a/drivers/gpu/drm/radeon/evergreen.h
> +++ b/drivers/gpu/drm/radeon/evergreen.h
> @@ -29,6 +29,7 @@
>  #define __RADEON_EVERGREEN_H__
>
>  struct evergreen_mc_save;
> +struct evergreen_power_info;
>  struct radeon_device;
>
>  bool evergreen_is_display_hung(struct radeon_device *rdev);
> @@ -49,5 +50,6 @@ u32 evergreen_get_number_of_dram_channels(struct radeon=
_device *rdev);
>  void evergreen_print_gpu_status_regs(struct radeon_device *rdev);
>  u32 evergreen_gpu_check_soft_reset(struct radeon_device *rdev);
>  int evergreen_rlc_resume(struct radeon_device *rdev);
> +struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
>
>  #endif                         /* __RADEON_EVERGREEN_H__ */
> diff --git a/drivers/gpu/drm/radeon/ni_dpm.c b/drivers/gpu/drm/radeon/ni_=
dpm.c
> index d39bbd9793cc2..dd5ef64937230 100644
> --- a/drivers/gpu/drm/radeon/ni_dpm.c
> +++ b/drivers/gpu/drm/radeon/ni_dpm.c
> @@ -26,6 +26,7 @@
>  #include <linux/seq_file.h>
>
>  #include "atom.h"
> +#include "evergreen.h"
>  #include "ni_dpm.h"
>  #include "nid.h"
>  #include "r600_dpm.h"
> @@ -720,8 +721,6 @@ static const u32 cayman_sysls_enable[] =3D
>  };
>  #define CAYMAN_SYSLS_ENABLE_LENGTH sizeof(cayman_sysls_enable) / (3 * si=
zeof(u32))
>
> -struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
> -
>  extern int ni_mc_load_microcode(struct radeon_device *rdev);
>
>  struct ni_power_info *ni_get_pi(struct radeon_device *rdev)
> diff --git a/drivers/gpu/drm/radeon/rv770_dpm.c b/drivers/gpu/drm/radeon/=
rv770_dpm.c
> index badd8ac6e038f..ef2f1a048cfed 100644
> --- a/drivers/gpu/drm/radeon/rv770_dpm.c
> +++ b/drivers/gpu/drm/radeon/rv770_dpm.c
> @@ -30,6 +30,7 @@
>  #include "rv770_dpm.h"
>  #include "cypress_dpm.h"
>  #include "atom.h"
> +#include "evergreen.h"
>  #include <linux/seq_file.h>
>
>  #define MC_CG_ARB_FREQ_F0           0x0a
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index 32b697965c064..b4581392fbce9 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -26,6 +26,7 @@
>  #include <linux/seq_file.h>
>
>  #include "atom.h"
> +#include "evergreen.h"
>  #include "r600_dpm.h"
>  #include "rv770.h"
>  #include "radeon.h"
> @@ -1720,8 +1721,6 @@ static const struct si_powertune_data powertune_dat=
a_hainan =3D
>         true
>  };
>
> -struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
> -
>  extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable=
);
>
>  static int si_populate_voltage_value(struct radeon_device *rdev,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
