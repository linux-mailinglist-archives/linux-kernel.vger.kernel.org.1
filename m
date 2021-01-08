Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161F22EFA43
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbhAHVUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbhAHVUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:20:31 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D76C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:19:51 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id n42so11024658ota.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xpKOTSO9z0/uA/jBdJXRuqf0OMCjnmCkNWQ+uc2BgYY=;
        b=VMpglM/KLM6PpwbpnUURqHJ2NMGbf3vFOpVW2E8vqbPEk9W0drSgp5EE0ScKJ1e2mA
         yQ4HWIOVcE7pX47hfHHIR7KvxcfC5HoJSBS4I6OEPOEoq7/SNUuALIXJTAbTN6kN4T+2
         A/OC38cvU/LeXdvxrIm6ltMSilr3xoTnCNHrwIWZmIfNXlPqzu4/gS5HIMITEnBOG/eT
         /PbK/uHbf4j9vUq9M5uvIeEi2+63SDJMFaF4gdiVN5AWdUwFvTXqrpG/MvvAUMcM3ZFp
         kAy6Cl7xr5kEESXN4oA+gT08/J5Lo7CaNgkvkJNUHosqWUM5sRaTfRFqkUUAWdNVN1rs
         YseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xpKOTSO9z0/uA/jBdJXRuqf0OMCjnmCkNWQ+uc2BgYY=;
        b=CH1nhrM6AMo1p+e14UCDa3MkRRylL0tKQzABkujzYdlVQSuN9+ddSnfDWOhhKnYKLi
         CMoOHvD2p3kGPESjLyLEPZpJPB6NtAwAv8mroi6bn7yTXagQLlkB/BHh8UqVtW7UzxxY
         jIXhnVcGOVUqFgDneK3Gixuhf+PjvpYlayvHle1DL85rHGKmrhzDdHiLKFJviSc9DUXm
         giaVHNU1D21fAKs6WVezZHixqWLnfb74EeoEt3CG+CIV48BsTxF1EOqcvev3305g/XRW
         WM/wUBTjhdtwfNeNwm5p4sKgS9p2vyakR7EyCfy4rP2XNfMny1xdbSnigZUj0BkrKDK4
         mAng==
X-Gm-Message-State: AOAM531elLq5N2O4ghiowKXMG+Rsw2DNjiDIe1oNsxQWc2J/tVNZEPJc
        hgpY6pRD5/Id2grWK6yp8kqcAjm9t3H7fmFmlGw=
X-Google-Smtp-Source: ABdhPJz+KDO44Y+LyCgARS0TkKG2wSDL0xKv2rNXv+hHBBZXTWDoLvv/qDajd7DRk1MPvTWpPmhqR8xyzAW6bl9/+Hw=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr3902944otl.311.1610140790582;
 Fri, 08 Jan 2021 13:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-32-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-32-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:19:39 -0500
Message-ID: <CADnq5_N-OrDEhJ_jPqgrXfHKqxruUVxH7baJ=cZ50_q_GjUG8g@mail.gmail.com>
Subject: Re: [PATCH 31/40] drm/amd/display/dc/dce/dce_opp: Make local
 functions and ones invoked by reference static
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:427:6: warning: n=
o previous prototype for =E2=80=98dce60_opp_set_clamping=E2=80=99 [-Wmissin=
g-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:548:6: warning: n=
o previous prototype for =E2=80=98dce60_opp_program_bit_depth_reduction=E2=
=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:571:6: warning: n=
o previous prototype for =E2=80=98dce60_opp_program_clamping_and_pixel_enco=
ding=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:681:6: warning: n=
o previous prototype for =E2=80=98dce60_opp_program_fmt=E2=80=99 [-Wmissing=
-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_opp.c
> index e459ae65aaf76..2bf8f5a2e0c22 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> @@ -424,7 +424,7 @@ void dce110_opp_set_clamping(
>   *             7 for programable
>   *     2) Enable clamp if Limited range requested
>   */
> -void dce60_opp_set_clamping(
> +static void dce60_opp_set_clamping(
>         struct dce110_opp *opp110,
>         const struct clamping_and_pixel_encoding_params *params)
>  {
> @@ -545,7 +545,7 @@ void dce110_opp_program_bit_depth_reduction(
>  }
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> -void dce60_opp_program_bit_depth_reduction(
> +static void dce60_opp_program_bit_depth_reduction(
>         struct output_pixel_processor *opp,
>         const struct bit_depth_reduction_params *params)
>  {
> @@ -568,7 +568,7 @@ void dce110_opp_program_clamping_and_pixel_encoding(
>  }
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> -void dce60_opp_program_clamping_and_pixel_encoding(
> +static void dce60_opp_program_clamping_and_pixel_encoding(
>         struct output_pixel_processor *opp,
>         const struct clamping_and_pixel_encoding_params *params)
>  {
> @@ -678,7 +678,7 @@ void dce110_opp_program_fmt(
>  }
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> -void dce60_opp_program_fmt(
> +static void dce60_opp_program_fmt(
>         struct output_pixel_processor *opp,
>         struct bit_depth_reduction_params *fmt_bit_depth,
>         struct clamping_and_pixel_encoding_params *clamping)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
