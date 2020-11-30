Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376512C92AF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388943AbgK3XeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388902AbgK3XeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:34:13 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B34DC0617A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:33:13 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id f12so13060340oto.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 15:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9YSKPX3Wa2hLuDINB/kZ30Spr+tcQScjsGOBJqjiUvs=;
        b=SXbcAY3Ba3LBXgdzIKgwNwkJiZfCg8qDRFILS5OxKRdTi1fkpKrylqhFVazxZW0pOv
         syUf/M7NVvusMN9bnYly9d1RVQE4Tt22p/hU4jQ/8//2iWscbS/1VuSKqZZcFJ0iZcNO
         D/QUVZdPrblEEZo/8WIlqlbowEtOEw191aY1KyFK8Z4CsvxlL6bMC0f9A9EfRog4N58A
         ZP38n2+vxjLwt5N2QxC2UxHoKY2N/R/2oGzx0IWaACyyb0U6viO7VRvopexXrBTix0aR
         kHTHhxCOf+gAKtf+Mpxk/l/iC9P5CrH88LeB5nk4ThelbzWigF3upyj332+jMn+HzNoS
         8mGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9YSKPX3Wa2hLuDINB/kZ30Spr+tcQScjsGOBJqjiUvs=;
        b=i0P60qKhQJxMhOCvzbLMlZO30/HrpOa/3Fz6yIBFNsuba2wONM8RT3zaZzxdaY1FPA
         CcmeRvKEy+xexcVeuO1xG8plT+pZ7f+w4EoYv9hoZeUiO8y99MnZdPZhnfMDbGAhV1yX
         5a2WXILcohTgElxGvdQWGjLhfeI8wY9zVpA5AwVT8sZqj2AS4IdbjqCy784GedC8FyxL
         vtp6NTXINRBOoePznhcLK6b3oxW8j4lRz2L3wPyTDShq940Ll7nJ0sg7AgWbj3Tus//P
         ZiQrcSY7J43o5yev3edVEa/iztaEyMsXN3zAovvyFKuUarEwPKB7JYfxUILuGJMP7ayg
         F7Gg==
X-Gm-Message-State: AOAM530ldTyyYbxhr/f+WVkrm4DepaKmt6VCmZVdkeTAEhCsAYkftsSu
        jtuZb1p4pa2dBSNFDnVft7lxVt0OFykf2tIV1Ao=
X-Google-Smtp-Source: ABdhPJxFvwyB6YaJM3YCDTOhqfW1B1WWsu12GphfpWFNPjeza0JdWvqM7bqf4RfGLVGbYk4LoFT/874iVmKhGppKAAE=
X-Received: by 2002:a05:6830:22e4:: with SMTP id t4mr19222578otc.23.1606779192777;
 Mon, 30 Nov 2020 15:33:12 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-13-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-13-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 18:33:01 -0500
Message-ID: <CADnq5_OfGjB+AbvKtvUV7ByRtFG3SZ2Msip8TOPfi6BNr9jhAw@mail.gmail.com>
Subject: Re: [PATCH 12/40] drm/amd/pm/powerplay/hwmgr/ppatomctrl: Remove
 unused variable 'fPowerDPMx'
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

On Thu, Nov 26, 2020 at 8:43 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  In file included from drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/p=
patomctrl.c:31:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c: In functi=
on =E2=80=98atomctrl_calculate_voltage_evv_on_sclk=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/ppatomctrl.c:702:22: wa=
rning: variable =E2=80=98fPowerDPMx=E2=80=99 set but not used [-Wunused-but=
-set-variable]
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
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c b/driver=
s/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> index c2fee6796bd93..2cb913ab77f26 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/ppatomctrl.c
> @@ -699,7 +699,7 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>         fInt fMargin_RO_a, fMargin_RO_b, fMargin_RO_c, fMargin_fixed, fMa=
rgin_FMAX_mean, fMargin_Plat_mean, fMargin_FMAX_sigma, fMargin_Plat_sigma, =
fMargin_DC_sigma;
>         fInt fLkg_FT, repeat;
>         fInt fMicro_FMAX, fMicro_CR, fSigma_FMAX, fSigma_CR, fSigma_DC, f=
DC_SCLK, fSquared_Sigma_DC, fSquared_Sigma_CR, fSquared_Sigma_FMAX;
> -       fInt fRLL_LoadLine, fPowerDPMx, fDerateTDP, fVDDC_base, fA_Term, =
fC_Term, fB_Term, fRO_DC_margin;
> +       fInt fRLL_LoadLine, fDerateTDP, fVDDC_base, fA_Term, fC_Term, fB_=
Term, fRO_DC_margin;
>         fInt fRO_fused, fCACm_fused, fCACb_fused, fKv_m_fused, fKv_b_fuse=
d, fKt_Beta_fused, fFT_Lkg_V0NORM;
>         fInt fSclk_margin, fSclk, fEVV_V;
>         fInt fV_min, fV_max, fT_prod, fLKG_Factor, fT_FT, fV_FT, fV_x, fT=
DP_Power, fTDP_Power_right, fTDP_Power_left, fTDP_Current, fV_NL;
> @@ -731,36 +731,28 @@ int atomctrl_calculate_voltage_evv_on_sclk(
>
>         switch (dpm_level) {
>         case 1:
> -               fPowerDPMx =3D Convert_ULONG_ToFraction(le16_to_cpu(getAS=
ICProfilingInfo->usPowerDpm1));
>                 fDerateTDP =3D GetScaledFraction(le32_to_cpu(getASICProfi=
lingInfo->ulTdpDerateDPM1), 1000);
>                 break;
>         case 2:
> -               fPowerDPMx =3D Convert_ULONG_ToFraction(le16_to_cpu(getAS=
ICProfilingInfo->usPowerDpm2));
>                 fDerateTDP =3D GetScaledFraction(le32_to_cpu(getASICProfi=
lingInfo->ulTdpDerateDPM2), 1000);
>                 break;
>         case 3:
> -               fPowerDPMx =3D Convert_ULONG_ToFraction(le16_to_cpu(getAS=
ICProfilingInfo->usPowerDpm3));
>                 fDerateTDP =3D GetScaledFraction(le32_to_cpu(getASICProfi=
lingInfo->ulTdpDerateDPM3), 1000);
>                 break;
>         case 4:
> -               fPowerDPMx =3D Convert_ULONG_ToFraction(le16_to_cpu(getAS=
ICProfilingInfo->usPowerDpm4));
>                 fDerateTDP =3D GetScaledFraction(le32_to_cpu(getASICProfi=
lingInfo->ulTdpDerateDPM4), 1000);
>                 break;
>         case 5:
> -               fPowerDPMx =3D Convert_ULONG_ToFraction(le16_to_cpu(getAS=
ICProfilingInfo->usPowerDpm5));
>                 fDerateTDP =3D GetScaledFraction(le32_to_cpu(getASICProfi=
lingInfo->ulTdpDerateDPM5), 1000);
>                 break;
>         case 6:
> -               fPowerDPMx =3D Convert_ULONG_ToFraction(le16_to_cpu(getAS=
ICProfilingInfo->usPowerDpm6));
>                 fDerateTDP =3D GetScaledFraction(le32_to_cpu(getASICProfi=
lingInfo->ulTdpDerateDPM6), 1000);
>                 break;
>         case 7:
> -               fPowerDPMx =3D Convert_ULONG_ToFraction(le16_to_cpu(getAS=
ICProfilingInfo->usPowerDpm7));
>                 fDerateTDP =3D GetScaledFraction(le32_to_cpu(getASICProfi=
lingInfo->ulTdpDerateDPM7), 1000);
>                 break;
>         default:
>                 pr_err("DPM Level not supported\n");
> -               fPowerDPMx =3D Convert_ULONG_ToFraction(1);
>                 fDerateTDP =3D GetScaledFraction(le32_to_cpu(getASICProfi=
lingInfo->ulTdpDerateDPM0), 1000);
>         }
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
