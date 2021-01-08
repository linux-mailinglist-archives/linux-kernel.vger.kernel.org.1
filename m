Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B472EFA14
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbhAHVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbhAHVPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:15:37 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EDDC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:14:57 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id n127so2705082ooa.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3E1Yy5Cr06/8H9JccZfDcY4KslfdNVAvuQfEB6XXQjg=;
        b=D1FJ2NC1oaYOtHbxRVwPfS0Py5SOZmmmPT0rNX1VYUk1ffDgGgxCo33KP813/7CuFW
         E2Var8mZ2065ibbE1J8HqnjYEB5MPj7yUA79QdPtQNEb0LD/oB2OSVPcxFyyNhF0zhhQ
         h6Hx0a/wly8IIby/XHUiZLDj3zihPneNuA355uDAnCBL3imBsVbZ3lY0z3AGR6EZAXGJ
         +pvOonX8cO3W+sPl25QEq6gwUMAnBtyJCkO62Mq2TUpsGdMa/BT5/3pV90dxIN3M4NFY
         y0OhbN0SRTrkyya9zvyJjnpfNr5QCV3YoNuUIhkwA7PHsuo4Rf3Nar4eulGXrSvSBmpI
         g0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3E1Yy5Cr06/8H9JccZfDcY4KslfdNVAvuQfEB6XXQjg=;
        b=h70MPdrQKIvPsE+V1qq4qjF/5dV6/EEcuoEtRfuB3wdsBqdSmo+SEhrBihKbsoS7v0
         jWBsrO2a7EHCwMA0dDRyGfeP0XyMwiXDM7DsGmExctrMmY/s7qXxQU6/uFj4nVw58xMg
         8x643WOFlEVvA/nA8RTcZyfhbjDMWCqnHmocRkpAfsX8m93I7kYNIlJMRkzCka6k1ot6
         cs9Q0U48Hyf5aw4kTMnaKLGDLR3so+AtFOJzbDPuA4N9ntlLvBJ0V6I20GrgvABiT51y
         qLDGRiaBNSs/qOk8L7DKQKxnnpXaDKv+9JvKTadywZhLZWXPhHWwuPP4DyQAVcSxuRMa
         sIdA==
X-Gm-Message-State: AOAM533HAeUFnOYbPnkFN7W9wg/ZZHktNv31NI2AGfD2OSvOfY4be7za
        ZyXoplW6K+JOt1gFX9p/WQlFsmKgEfPgpOFoBIw=
X-Google-Smtp-Source: ABdhPJy4x9ZvSXYQ3LbzZxy5BMut65trNV50TOkx1p50+sLQii60L/dtGv4tQzED4eKLXaAXWNlyQ1MPrq3lFi9WP+Q=
X-Received: by 2002:a4a:a2c5:: with SMTP id r5mr5570703ool.72.1610140496522;
 Fri, 08 Jan 2021 13:14:56 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-27-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-27-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:14:45 -0500
Message-ID: <CADnq5_P18PCQ5ritTaErwsLUj+9VF+rEdCZuegSQcfLPFdYWKw@mail.gmail.com>
Subject: Re: [PATCH 26/40] drm/amd/display/dc/dce/dce_clock_source: Fix
 formatting/spelling of worthy function headers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Demote the one that provides no param descriptions.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: war=
ning: Function parameter or member 'calc_pll_cs' not described in 'calculat=
e_fb_and_fractional_fb_divider'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: war=
ning: Function parameter or member 'target_pix_clk_100hz' not described in =
'calculate_fb_and_fractional_fb_divider'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: war=
ning: Function parameter or member 'ref_divider' not described in 'calculat=
e_fb_and_fractional_fb_divider'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: war=
ning: Function parameter or member 'post_divider' not described in 'calcula=
te_fb_and_fractional_fb_divider'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: war=
ning: Function parameter or member 'feedback_divider_param' not described i=
n 'calculate_fb_and_fractional_fb_divider'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:142: war=
ning: Function parameter or member 'fract_feedback_divider_param' not descr=
ibed in 'calculate_fb_and_fractional_fb_divider'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: war=
ning: Function parameter or member 'calc_pll_cs' not described in 'calc_fb_=
divider_checking_tolerance'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: war=
ning: Function parameter or member 'pll_settings' not described in 'calc_fb=
_divider_checking_tolerance'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: war=
ning: Function parameter or member 'ref_divider' not described in 'calc_fb_=
divider_checking_tolerance'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: war=
ning: Function parameter or member 'post_divider' not described in 'calc_fb=
_divider_checking_tolerance'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:200: war=
ning: Function parameter or member 'tolerance' not described in 'calc_fb_di=
vider_checking_tolerance'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:478: war=
ning: Function parameter or member 'clk_src' not described in 'dce110_get_p=
ix_clk_dividers_helper'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:478: war=
ning: Function parameter or member 'pll_settings' not described in 'dce110_=
get_pix_clk_dividers_helper'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:478: war=
ning: Function parameter or member 'pix_clk_params' not described in 'dce11=
0_get_pix_clk_dividers_helper'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  .../drm/amd/display/dc/dce/dce_clock_source.c | 57 +++++++++----------
>  1 file changed, 28 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index fb733f573715e..10938a8c9500a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -113,20 +113,19 @@ static const struct spread_spectrum_data *get_ss_da=
ta_entry(
>  }
>
>  /**
> - * Function: calculate_fb_and_fractional_fb_divider
> + * calculate_fb_and_fractional_fb_divider - Calculates feedback and frac=
tional
> + *                                          feedback dividers values
>   *
> - * * DESCRIPTION: Calculates feedback and fractional feedback dividers v=
alues
> + * @calc_pll_cs:           Pointer to clock source information
> + * @target_pix_clk_100hz:   Desired frequency in 100 Hz
> + * @ref_divider:            Reference divider (already known)
> + * @post_divider:           Post Divider (already known)
> + * @feedback_divider_param: Pointer where to store
> + *                         calculated feedback divider value
> + * @fract_feedback_divider_param: Pointer where to store
> + *                         calculated fract feedback divider value
>   *
> - *PARAMETERS:
> - * targetPixelClock             Desired frequency in 100 Hz
> - * ref_divider                  Reference divider (already known)
> - * postDivider                  Post Divider (already known)
> - * feedback_divider_param       Pointer where to store
> - *                                     calculated feedback divider value
> - * fract_feedback_divider_param Pointer where to store
> - *                                     calculated fract feedback divider=
 value
> - *
> - *RETURNS:
> + * return:
>   * It fills the locations pointed by feedback_divider_param
>   *                                     and fract_feedback_divider_param
>   * It returns  - true if feedback divider not 0
> @@ -175,22 +174,22 @@ static bool calculate_fb_and_fractional_fb_divider(
>  }
>
>  /**
> -*calc_fb_divider_checking_tolerance
> -*
> -*DESCRIPTION: Calculates Feedback and Fractional Feedback divider values
> -*              for passed Reference and Post divider, checking for toler=
ance.
> -*PARAMETERS:
> -* pll_settings         Pointer to structure
> -* ref_divider          Reference divider (already known)
> -* postDivider          Post Divider (already known)
> -* tolerance            Tolerance for Calculated Pixel Clock to be within
> -*
> -*RETURNS:
> -* It fills the PLLSettings structure with PLL Dividers values
> -* if calculated values are within required tolerance
> -* It returns   - true if error is within tolerance
> -*              - false if error is not within tolerance
> -*/
> + * calc_fb_divider_checking_tolerance - Calculates Feedback and
> + *                                      Fractional Feedback divider valu=
es
> + *                                     for passed Reference and Post div=
ider,
> + *                                      checking for tolerance.
> + * @calc_pll_cs:       Pointer to clock source information
> + * @pll_settings:      Pointer to PLL settings
> + * @ref_divider:       Reference divider (already known)
> + * @post_divider:      Post Divider (already known)
> + * @tolerance:         Tolerance for Calculated Pixel Clock to be within
> + *
> + * return:
> + *  It fills the PLLSettings structure with PLL Dividers values
> + *  if calculated values are within required tolerance
> + *  It returns - true if error is within tolerance
> + *             - false if error is not within tolerance
> + */
>  static bool calc_fb_divider_checking_tolerance(
>                 struct calc_pll_clock_source *calc_pll_cs,
>                 struct pll_settings *pll_settings,
> @@ -460,7 +459,7 @@ static bool pll_adjust_pix_clk(
>         return false;
>  }
>
> -/**
> +/*
>   * Calculate PLL Dividers for given Clock Value.
>   * First will call VBIOS Adjust Exec table to check if requested Pixel c=
lock
>   * will be Adjusted based on usage.
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
