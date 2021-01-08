Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BDC2EFA2D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbhAHVRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbhAHVRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:17:53 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E5CC061757
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:17:13 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q25so12878234oij.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TY5MROL71NTqtli+NhUZvNx26dK4LplFxHZHvvWoZHQ=;
        b=KXRjsjvsExLfCARy7KK9m+0XV0SKmGxUUtt2u9BNbYZI++GnbFPmoQjfrKKo0dyDTR
         ds1i/3jzjmCBX/UBVR7pSYUWZXyMWYRScnt/lqtMr16eaJFc8iSsAmU4V3xZOk75dwtA
         BRl6IdrL0fZfWlF8UnAwQas+ARr164VIrc3nZXKOaNc92DElQIfCqgELYs6TAO08jYdg
         8FVhg/WqgBsE7oWuSuZxqpIJ8O9dTeDeQdymbF+bIyvM+AfBm+Qf1wdMKbh7AKvjJ53E
         37Hz7C7KwNGpXmPJD7IPv86hrysCFk/NLqtGlwhWBdFdFQXPKOZohf7dSMfthA9ZaRZM
         YVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TY5MROL71NTqtli+NhUZvNx26dK4LplFxHZHvvWoZHQ=;
        b=hGdV4AzVA9xDsUYAfQFVIACAjTIuA1/n/ZKjcoc689KAaWsXAiCulzvz/dFqht77NB
         mDpF8/B4f/YnAibwYzHY1RTAM3QCJY0JpLLMieAPqVGdXetT7IH2xDQ3E/lA78NoSlEV
         chw9sBQ0PRjqhst4Cvge7ncOuv/WEKWKG7GP/4Sq0P5Gux+Hcr3kAaGfrMA8GM73Pzo/
         0T0qXwEeF4Ifl8Q/OqMsYDwg81IGECr+WvnY/oUbMZ7NgIyyfwUMaZjFtfkD1cfko+Wd
         F5azMCjEIYDkuJvQn9ZaXr6eooXIeZXOjy5/01TS6P+O2eYucTVXWlybR1ad162YPxG+
         A4Nw==
X-Gm-Message-State: AOAM531MJKGlcAXFR5QQXX3hSOq2v3nHFVq0xCegaDWhovliQAMYzi36
        amC3b5FD2M8XQTva7/3WmX+6R7ITeYM9ygnp8vE=
X-Google-Smtp-Source: ABdhPJyhD+1eZavw/5ZhQ+L6btJZdBTm0qdWVrGs2C97Duv9DDnWKyEaTnnz+VNgy3s5DbUzUANVq7ApaZ7tsSUQSgA=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3509847oib.123.1610140632586;
 Fri, 08 Jan 2021 13:17:12 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-29-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-29-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:17:01 -0500
Message-ID: <CADnq5_NtvngjE2UUL9MEeBXrb_XJz-3FjAK6D1bcEtOyHbDD7w@mail.gmail.com>
Subject: Re: [PATCH 28/40] drm/amd/display/dc/dce/dce_transform: Remove 3
 unused/legacy variables
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c: In functio=
n =E2=80=98dce60_transform_set_scaler=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:496:7: warn=
ing: variable =E2=80=98filter_updated=E2=80=99 set but not used [-Wunused-b=
ut-set-variable]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c: In functio=
n =E2=80=98dce60_transform_set_pixel_storage_depth=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:1040:19: wa=
rning: variable =E2=80=98expan_mode=E2=80=99 set but not used [-Wunused-but=
-set-variable]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_transform.c:1040:6: war=
ning: variable =E2=80=98pixel_depth=E2=80=99 set but not used [-Wunused-but=
-set-variable]
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
>  drivers/gpu/drm/amd/display/dc/dce/dce_transform.c | 13 -------------
>  1 file changed, 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers=
/gpu/drm/amd/display/dc/dce/dce_transform.c
> index 130a0a0c83329..6121bb7b009b8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
> @@ -493,7 +493,6 @@ static void dce60_transform_set_scaler(
>  {
>         struct dce_transform *xfm_dce =3D TO_DCE_TRANSFORM(xfm);
>         bool is_scaling_required;
> -       bool filter_updated =3D false;
>         const uint16_t *coeffs_v, *coeffs_h;
>
>         /*Use whole line buffer memory always*/
> @@ -558,7 +557,6 @@ static void dce60_transform_set_scaler(
>
>                         xfm_dce->filter_v =3D coeffs_v;
>                         xfm_dce->filter_h =3D coeffs_h;
> -                       filter_updated =3D true;
>                 }
>         }
>
> @@ -1037,34 +1035,23 @@ static void dce60_transform_set_pixel_storage_dep=
th(
>         const struct bit_depth_reduction_params *bit_depth_params)
>  {
>         struct dce_transform *xfm_dce =3D TO_DCE_TRANSFORM(xfm);
> -       int pixel_depth, expan_mode;
>         enum dc_color_depth color_depth;
>
>         switch (depth) {
>         case LB_PIXEL_DEPTH_18BPP:
>                 color_depth =3D COLOR_DEPTH_666;
> -               pixel_depth =3D 2;
> -               expan_mode  =3D 1;
>                 break;
>         case LB_PIXEL_DEPTH_24BPP:
>                 color_depth =3D COLOR_DEPTH_888;
> -               pixel_depth =3D 1;
> -               expan_mode  =3D 1;
>                 break;
>         case LB_PIXEL_DEPTH_30BPP:
>                 color_depth =3D COLOR_DEPTH_101010;
> -               pixel_depth =3D 0;
> -               expan_mode  =3D 1;
>                 break;
>         case LB_PIXEL_DEPTH_36BPP:
>                 color_depth =3D COLOR_DEPTH_121212;
> -               pixel_depth =3D 3;
> -               expan_mode  =3D 0;
>                 break;
>         default:
>                 color_depth =3D COLOR_DEPTH_101010;
> -               pixel_depth =3D 0;
> -               expan_mode  =3D 1;
>                 BREAK_TO_DEBUGGER();
>                 break;
>         }
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
