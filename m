Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430862F3F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438316AbhALWSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730212AbhALWSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:18:38 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B63CC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:17:58 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id x5so3537465otp.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HvUmJxi/g8blsoQI26oqN2rM0SAy7RtATDDau+9vtBg=;
        b=V1VvugWsKg02SnRwM/ZoIpIdve/zHjFD0Y4LFtgV4T7KnxkqTyVdld2O6v4RZ78iAg
         fiXUwKUNVQEKyB7L812A0aIr98YO44lGQ+Mzw35rhaEjqZbi3/v9DwScmxJtZAg3QxvG
         ImhtGjfecYHIpoiHlNxVMqbasuYx9GUdBIVT1eazYRu8rD1WJv1y5bH2uSJjKss/pzWn
         +gjZfG3R7f319fSnqQ9NIIyR39nMm2YNC8LzZCMhi1Mg1WO/AuzqloJQUQoM1+4m7GgH
         3CY7Tjp4xvW8ZHdZ23vTR5ufQxc6qih4AyWeLZ71m5VpbNXuiUszJwwT+eE2Ci8u/RIk
         7BHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HvUmJxi/g8blsoQI26oqN2rM0SAy7RtATDDau+9vtBg=;
        b=sN8oBpbpbAbp8RQ5WAD7rxfEdfQ2ZvUYH9pOtiB64wQNcp05x0paLHta97i4YPAskd
         +tXmSrK64EW633upYhvFucWGHxNniDhcjsqGpQeCTGXk5gr7Lb5z5hGKKCdFnHLhcRNT
         w2Y+xd9XokP97MA73ftgmknBPvyp9RjbT6rFuevxvBIS5DpzGanwqu5iIBKYrrxaq8fb
         D8uKB5Hs4o7myvYPxVot18xXadCnZSGaJS0cYykzYVcEH3xR5NZdmxwkluEdJRBoPNUm
         vhMyWXRAH9yODHVqSGl/BUwo8ea04LOqlgGQ+RsdIjnL7ENWacYuj1YgSEhk1d80Us41
         bcOg==
X-Gm-Message-State: AOAM532qGfW1hke194tZe/6YbQAHPzaB03kA0EUcKD5saxyMBfLc3gas
        grQJ1MMEPh0fYmJKdyots2CgRL6qPiIcJ9ssiDoB9dn0
X-Google-Smtp-Source: ABdhPJxGM6vKfRyjIjVJ+tzwpnd5zKmX94O0o8s9X/BqallXC62zfkCYcOvfDzbX7lxCumFm5kKTObterRb+gA1ypmc=
X-Received: by 2002:a9d:2ac2:: with SMTP id e60mr1034057otb.23.1610489877610;
 Tue, 12 Jan 2021 14:17:57 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-20-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-20-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:17:43 -0500
Message-ID: <CADnq5_NtPZs4cCypB0nphJqEVVQp7OojJVGLzNH0hP=+JWrr6g@mail.gmail.com>
Subject: Re: [PATCH 19/40] drm/amd/display/dc/dce/dce_opp: Remove duplicate
 entries causing 'field overwritten' issues
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dc=
e112_resource.c:59:
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
480:62: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:96:16: note: in e=
xpansion of macro =E2=80=98FMT_BIT_DEPTH_CONTROL__FMT_TEMPORAL_DITHER_EN__S=
HIFT=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:114:2: note: in e=
xpansion of macro =E2=80=98OPP_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:148:2: note: in e=
xpansion of macro =E2=80=98OPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:321:2:=
 note: in expansion of macro =E2=80=98OPP_COMMON_MASK_SH_LIST_DCE_112=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
480:62: note: (near initialization for =E2=80=98opp_shift.FMT_TEMPORAL_DITH=
ER_EN=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:96:16: note: in e=
xpansion of macro =E2=80=98FMT_BIT_DEPTH_CONTROL__FMT_TEMPORAL_DITHER_EN__S=
HIFT=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:114:2: note: in e=
xpansion of macro =E2=80=98OPP_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:148:2: note: in e=
xpansion of macro =E2=80=98OPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:321:2:=
 note: in expansion of macro =E2=80=98OPP_COMMON_MASK_SH_LIST_DCE_112=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
479:60: warning: initialized field overwritten [-Woverride-init]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:96:16: note: in e=
xpansion of macro =E2=80=98FMT_BIT_DEPTH_CONTROL__FMT_TEMPORAL_DITHER_EN_MA=
SK=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:114:2: note: in e=
xpansion of macro =E2=80=98OPP_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:148:2: note: in e=
xpansion of macro =E2=80=98OPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce112/dce112_resource.c:325:2:=
 note: in expansion of macro =E2=80=98OPP_COMMON_MASK_SH_LIST_DCE_112=E2=80=
=99
>  drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dce/dce_11_2_sh_mask.h:10=
479:60: note: (near initialization for =E2=80=98opp_mask.FMT_TEMPORAL_DITHE=
R_EN=E2=80=99)
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:96:16: note: in e=
xpansion of macro =E2=80=98FMT_BIT_DEPTH_CONTROL__FMT_TEMPORAL_DITHER_EN_MA=
SK=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:114:2: note: in e=
xpansion of macro =E2=80=98OPP_SF=E2=80=99
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.h:148:2: note: in e=
xpansion of macro =E2=80=98OPP_COMMON_MASK_SH_LIST_DCE_COMMON_BASE=E2=80=99
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_opp.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_opp.h
> index 4d484ef60f357..bf1ffc3629c7f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
> @@ -111,7 +111,6 @@ enum dce110_opp_reg_type {
>         OPP_SF(FMT_DITHER_RAND_R_SEED, FMT_RAND_R_SEED, mask_sh),\
>         OPP_SF(FMT_DITHER_RAND_G_SEED, FMT_RAND_G_SEED, mask_sh),\
>         OPP_SF(FMT_DITHER_RAND_B_SEED, FMT_RAND_B_SEED, mask_sh),\
> -       OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_EN, mask_sh),\
>         OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_RESET, mask_sh)=
,\
>         OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_OFFSET, mask_sh=
),\
>         OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_DEPTH, mask_sh)=
,\
> @@ -219,7 +218,6 @@ enum dce110_opp_reg_type {
>         OPP_SF(FMT_DITHER_RAND_R_SEED, FMT_RAND_R_SEED, mask_sh),\
>         OPP_SF(FMT_DITHER_RAND_G_SEED, FMT_RAND_G_SEED, mask_sh),\
>         OPP_SF(FMT_DITHER_RAND_B_SEED, FMT_RAND_B_SEED, mask_sh),\
> -       OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_EN, mask_sh),\
>         OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_RESET, mask_sh)=
,\
>         OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_OFFSET, mask_sh=
),\
>         OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_DEPTH, mask_sh)=
,\
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
