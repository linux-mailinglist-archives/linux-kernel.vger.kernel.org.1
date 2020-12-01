Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CBE2C939B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbgLAAFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbgLAAFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:05:07 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A69C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:04:27 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id k26so16287750oiw.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cZtvicJF+bE/9VXkTrpcJr6TNUaoTaYis+qWtewxhNw=;
        b=ddE4eAQtfydhU0o3ivPE1e5MH6wxApoYKJfU8+gSxKX46ZgogRcPsT5uhNrVVi9BHC
         fWJLSP6L+wr7TgC3bApCbzblpIZGEk5N1pNxfsglInjFvSLEt01pSdEUfslebt4PU0R5
         LCetXSayENLMYHZEZavEyc5wHuHf/t2/6UriIOdGSdAElN8HuVN8GAA2mKTAF5I92ovO
         xS6a2g2PRYJf8X3U65NuuB+C35zrKqMHk2KQ9x22CXcNh8jeJETSajuilYi5pZ5CLCvd
         YdH6ZT+15Jka14OA/xaSgc905jfErO4Jl59XFlQ5d906F9zNwrukEWmD2V3u6lrh9/8C
         bJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cZtvicJF+bE/9VXkTrpcJr6TNUaoTaYis+qWtewxhNw=;
        b=byZt44UXpS71x6afdFymRnYPVSOJLgYt9oIpRS22UcUwS0ZLar3eAUtcZjmsUkOHvJ
         03WFejZwTYqlTPvwIfW97yEoorBL5ipNXmuTHUdu/RvP5Fy0k+asrhX7wqGUNu3oudY7
         YMJBP/r4W6uFAkT2ofPPZBJMe3EOSAp3xz4c6vUzsZr+kaLaGBo4d1Qwbrz58YJvheS9
         vJFi/K07q7uTOPg5jxOBJa5wSQRswXvXJBFA5IXM3MWwOBBY0oQOOfB8U7LAN+AjKT0/
         cW9g61Ry8dgzVaquvVYINnhIcXWg4wq6FHR+4Aaw+puYyxaKZKnxN41S+4XIg+ECQD2F
         LfZQ==
X-Gm-Message-State: AOAM53393zVc1cLtXIMHBRxorHazF4WoC7gEXhnRgqKCAmDb8gcomhpf
        OfbuQYRoGPsiUw3AJ9px+gDPf2LOvJ5U3ihVIu0=
X-Google-Smtp-Source: ABdhPJyysVUbPwkj/2omBPYRmXDPbZmc0RRXzFkq9a6WLNyTZMLo2TtmG9ksjSkT4egbm++nmbs/zp1Vcl8qefPeBL0=
X-Received: by 2002:aca:4f53:: with SMTP id d80mr49562oib.120.1606781066509;
 Mon, 30 Nov 2020 16:04:26 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-37-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-37-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 30 Nov 2020 19:04:15 -0500
Message-ID: <CADnq5_PiZ_NN_jAkw+a9LRY4-5jgdTqqNjePAzKxvC+5TPn1cQ@mail.gmail.com>
Subject: Re: [PATCH 36/40] drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu: Mark
 local functions invoked by reference as static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Nov 26, 2020 at 8:44 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:538:6=
: warning: no previous prototype for =E2=80=98pp_rv_set_wm_ranges=E2=80=99 =
[-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:590:6=
: warning: no previous prototype for =E2=80=98pp_rv_set_pme_wa_enable=E2=80=
=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:601:6=
: warning: no previous prototype for =E2=80=98pp_rv_set_active_display_coun=
t=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:614:6=
: warning: no previous prototype for =E2=80=98pp_rv_set_min_deep_sleep_dcfc=
lk=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:627:6=
: warning: no previous prototype for =E2=80=98pp_rv_set_hard_min_dcefclk_by=
_freq=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:640:6=
: warning: no previous prototype for =E2=80=98pp_rv_set_hard_min_fclk_by_fr=
eq=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
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
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/d=
rivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> index 84065c12d4b85..ac0a0539854ef 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
> @@ -535,7 +535,7 @@ bool dm_pp_get_static_clocks(
>         return true;
>  }
>
> -void pp_rv_set_wm_ranges(struct pp_smu *pp,
> +static void pp_rv_set_wm_ranges(struct pp_smu *pp,
>                 struct pp_smu_wm_range_sets *ranges)
>  {
>         const struct dc_context *ctx =3D pp->dm;
> @@ -587,7 +587,7 @@ void pp_rv_set_wm_ranges(struct pp_smu *pp,
>                                                            &wm_with_clock=
_ranges);
>  }
>
> -void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
> +static void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
>  {
>         const struct dc_context *ctx =3D pp->dm;
>         struct amdgpu_device *adev =3D ctx->driver_context;
> @@ -598,7 +598,7 @@ void pp_rv_set_pme_wa_enable(struct pp_smu *pp)
>                 pp_funcs->notify_smu_enable_pwe(pp_handle);
>  }
>
> -void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
> +static void pp_rv_set_active_display_count(struct pp_smu *pp, int count)
>  {
>         const struct dc_context *ctx =3D pp->dm;
>         struct amdgpu_device *adev =3D ctx->driver_context;
> @@ -611,7 +611,7 @@ void pp_rv_set_active_display_count(struct pp_smu *pp=
, int count)
>         pp_funcs->set_active_display_count(pp_handle, count);
>  }
>
> -void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock)
> +static void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int clock=
)
>  {
>         const struct dc_context *ctx =3D pp->dm;
>         struct amdgpu_device *adev =3D ctx->driver_context;
> @@ -624,7 +624,7 @@ void pp_rv_set_min_deep_sleep_dcfclk(struct pp_smu *p=
p, int clock)
>         pp_funcs->set_min_deep_sleep_dcefclk(pp_handle, clock);
>  }
>
> -void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int clock)
> +static void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu *pp, int cl=
ock)
>  {
>         const struct dc_context *ctx =3D pp->dm;
>         struct amdgpu_device *adev =3D ctx->driver_context;
> @@ -637,7 +637,7 @@ void pp_rv_set_hard_min_dcefclk_by_freq(struct pp_smu=
 *pp, int clock)
>         pp_funcs->set_hard_min_dcefclk_by_freq(pp_handle, clock);
>  }
>
> -void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
> +static void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
>  {
>         const struct dc_context *ctx =3D pp->dm;
>         struct amdgpu_device *adev =3D ctx->driver_context;
> @@ -661,7 +661,7 @@ static enum pp_smu_status pp_nv_set_wm_ranges(struct =
pp_smu *pp,
>         return PP_SMU_RESULT_OK;
>  }
>
> -enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
> +static enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
>  {
>         const struct dc_context *ctx =3D pp->dm;
>         struct amdgpu_device *adev =3D ctx->driver_context;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
