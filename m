Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9DF62B52A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbgKPUdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgKPUdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:33:45 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7189C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:33:45 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c9so566567wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Btz6RdozLm1EKlruMXS9AbUuOyX1ou2F8fQugeAO3Ic=;
        b=SzHVVwqCe5auT1qAKZ00IP7giz25FHFrBcEwxnEp+PK/wap8BiRfk4WMD/NeYvppXi
         uG9/tHQ46wAaVpX2yjP9Nw+NlYvuPpJVUjwtLlumR6B90cbmGAaTN4EWw8l0dDDL8Qc2
         5vHBaKuFKKPtqyFPBQ/v8bmFCv4nvZdhLdYOS5Lxe0vYr5SrWm+K3JZzRUbRlSfOG+cS
         i5YNYMfAWNU9NOak0U+e1WdBkH7WIsUbP5Q+srqevpW4VsA8gtveBpqj+gCRcKRD7GPr
         iyV+WGN5e5vyergV1kG4k2sqEU+elh7gNYXRG5GDbYShyx2YFBfxsJKqVkjhVguqkMK/
         rzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Btz6RdozLm1EKlruMXS9AbUuOyX1ou2F8fQugeAO3Ic=;
        b=V70VX+1bLHEVpcQmK+2XRYycV5UROXV9AAUd0BbEv/LfdZ7mFxnkhE2IRT9LyVwaMS
         5d0Wh9qo53rAITpl6q0VnNC4mpMRr8dWBlw56pXytJUsMUIDUS3viDG2gxDEkz4pD8/5
         wRrUl31AgJPvTK1GFobszyQpNg/lTVb0AgsUxFGBXAsQxUtQz03+YN+Rt2pEzFe8qNfK
         YRn31oNW4Q79OMRZKSi0MXQ4OxZKEmnydZqliDhLKySK34iY1ergvh5JyDVhFAxfyPdk
         XuEOcgHNCFOxBM6ehYXb+FZiYHkJLdMXjJKIBWA82AAp4FLOw2emdK3LQ71PG4HZha6Y
         ZhIg==
X-Gm-Message-State: AOAM531QU/LLvatqPLhM3aZXrt3ZSxgxQDY1sY83clFmnjw/VfYdxO9z
        KzNGfR3/NlPZpEH5C9sxtc/qeRYi6w9AUPI2rso=
X-Google-Smtp-Source: ABdhPJzufnhCIbr77WySdr0eTSP3nh5WfmzGRw/OVtAvNKUnx1zE9kRuEFmH+XG/2b4pCWPtVIrlimuaq55sodWMBqo=
X-Received: by 2002:a7b:c015:: with SMTP id c21mr675679wmb.79.1605558824539;
 Mon, 16 Nov 2020 12:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-38-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-38-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:33:33 -0500
Message-ID: <CADnq5_PpJ6wep=F+rKpW-N0RLby77hdGRqyViLwRmMUXZ_7Sbw@mail.gmail.com>
Subject: Re: [PATCH 37/43] drm/radeon/ci_dpm: Move 'si_*()'s prototypes to
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
>  drivers/gpu/drm/radeon/si_dpm.c:3802:4: warning: no previous prototype f=
or =E2=80=98si_get_ddr3_mclk_frequency_ratio=E2=80=99 [-Wmissing-prototypes=
]
>  3802 | u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/si_dpm.c:3815:4: warning: no previous prototype f=
or =E2=80=98si_get_mclk_frequency_ratio=E2=80=99 [-Wmissing-prototypes]
>  3815 | u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mode=
)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/si_dpm.c:3897:6: warning: no previous prototype f=
or =E2=80=98si_trim_voltage_table_to_fit_state_table=E2=80=99 [-Wmissing-pr=
ototypes]
>  3897 | void si_trim_voltage_table_to_fit_state_table(struct radeon_devic=
e *rdev,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/ci_dpm.c | 6 +-----
>  drivers/gpu/drm/radeon/si_dpm.h | 5 +++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_=
dpm.c
> index a9fc0a552736c..0dfb0ed9af89d 100644
> --- a/drivers/gpu/drm/radeon/ci_dpm.c
> +++ b/drivers/gpu/drm/radeon/ci_dpm.c
> @@ -33,6 +33,7 @@
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_ucode.h"
> +#include "si_dpm.h"
>
>  #define MC_CG_ARB_FREQ_F0           0x0a
>  #define MC_CG_ARB_FREQ_F1           0x0b
> @@ -153,11 +154,6 @@ static const struct ci_pt_config_reg didt_config_ci[=
] =3D
>  extern u8 rv770_get_memory_module_index(struct radeon_device *rdev);
>  extern int ni_copy_and_switch_arb_sets(struct radeon_device *rdev,
>                                        u32 arb_freq_src, u32 arb_freq_des=
t);
> -extern u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock);
> -extern u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mode=
);
> -extern void si_trim_voltage_table_to_fit_state_table(struct radeon_devic=
e *rdev,
> -                                                    u32 max_voltage_step=
s,
> -                                                    struct atom_voltage_=
table *voltage_table);
>  static int ci_get_std_voltage_value_sidd(struct radeon_device *rdev,
>                                          struct atom_voltage_table_entry =
*voltage_table,
>                                          u16 *std_voltage_hi_sidd, u16 *s=
td_voltage_lo_sidd);
> diff --git a/drivers/gpu/drm/radeon/si_dpm.h b/drivers/gpu/drm/radeon/si_=
dpm.h
> index 1032a68be792b..aa857906ef93d 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.h
> +++ b/drivers/gpu/drm/radeon/si_dpm.h
> @@ -234,5 +234,10 @@ struct si_power_info {
>  #define SISLANDS_CGULVPARAMETER_DFLT                    0x00040035
>  #define SISLANDS_CGULVCONTROL_DFLT                      0x1f007550
>
> +u8 si_get_ddr3_mclk_frequency_ratio(u32 memory_clock);
> +u8 si_get_mclk_frequency_ratio(u32 memory_clock, bool strobe_mode);
> +void si_trim_voltage_table_to_fit_state_table(struct radeon_device *rdev=
,
> +                                             u32 max_voltage_steps,
> +                                             struct atom_voltage_table *=
voltage_table);
>
>  #endif
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
