Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426CB2AE278
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 23:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732017AbgKJWFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 17:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJWFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 17:05:22 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CEC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:05:21 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a65so4694751wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qZToJzWvZIM70EuRiQ7NoVEKN6DZ5AQGlu/l0sYJbdo=;
        b=XjyOicW3O9YNxvhwetYYen8NIUXx6DtxhfHeM3eeS7dRqHQTVCI2YXrvlAXna8ubw4
         91hNbvU5rvEipK0xYxRb+aAFeCVhGN3sXSmKvT9uMnvyRjKZK0MVQZsLsUW0y1NuThB+
         qpIQUWf4Q0V6cxCuoEiAk5gvoYEqve6tboDkF4bzKsMEEGMaDqknFVAuHon1tPSxft88
         V067xL1LNtenmB1IGjhefnjnAd+OSJwQqSxSxYntaqlXt+tfZN5Xbu9/CPyqNV+M53Nd
         jgI1xhFvjcpsQuqb3xpH/SxHFKAFKgfzkzozf2vYODBsdHbjTBxXZ59zgeTdlvW9/9y6
         K9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qZToJzWvZIM70EuRiQ7NoVEKN6DZ5AQGlu/l0sYJbdo=;
        b=R8EcXZZ+VcWfGzSu8TVMNm2DO/q8VOPLDOdIaMX7ZXj43T13iItQXniQVN9tWZc9ah
         FIDv4xLf1t0NOHNt9HFYOKjQqXScLA2BK+yBEUjPV5sRGKOyukxdw45n2U3DE+ChdswQ
         AgBeSsHyDRyEuDxXAb4iHAL7UuIuWz8iR2SWCAi8FFZfbVYS7NE96YR509DUCW+LuQyL
         J3vFxzL5M72IXg0kPyub7uTlRQJn0XYFtDClUap80JHnVHdXOsa17jtqKXmBJcvXjRqG
         nq++Pe9K2X6b8MOvFId3ZiEZ5qCXhr5HlszOv0gAVCZNhCInQTEQj2BNoyzCkPclrzPb
         E76g==
X-Gm-Message-State: AOAM532F/0PS656odAkgVxJ0Uiy3LHqam8eGQ0B5pfd2lls98P8sIMzK
        eCcD3cLYkRa0unjqi+Gy8nQcChrVAwr/3mWwc2Y=
X-Google-Smtp-Source: ABdhPJwWqoDTPUmRVpXmlstCWEAP5RO5KfmAgKzuWQagXCBAiZ6FokJKfpjc7Kx5J2AQT9MwV7S2Guk+ZWnb/gt8JoM=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr246689wmi.70.1605045920104;
 Tue, 10 Nov 2020 14:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org> <20201109211855.3340030-2-lee.jones@linaro.org>
In-Reply-To: <20201109211855.3340030-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 17:05:07 -0500
Message-ID: <CADnq5_O2w0D3WcZjWUajYJyGfDXrt90z2PYrxuUcxGwsuwEVqw@mail.gmail.com>
Subject: Re: [PATCH 01/20] drm/radeon/radeon_ttm: Place declaration of 'rdev'
 in same clause as its use
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Jerome Glisse <glisse@freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_ttm.c: In function =E2=80=98radeon_ttm_tt_=
create=E2=80=99:
>  drivers/gpu/drm/radeon/radeon_ttm.c:611:24: warning: variable =E2=80=98r=
dev=E2=80=99 set but not used [-Wunused-but-set-variable]
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Jerome Glisse <glisse@freedesktop.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/radeon/radeon_ttm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index 95038ac3382e2..a8c915920070f 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -608,21 +608,21 @@ static void radeon_ttm_backend_destroy(struct ttm_b=
o_device *bdev, struct ttm_tt
>  static struct ttm_tt *radeon_ttm_tt_create(struct ttm_buffer_object *bo,
>                                            uint32_t page_flags)
>  {
> -       struct radeon_device *rdev;
>         struct radeon_ttm_tt *gtt;
>         enum ttm_caching caching;
>         struct radeon_bo *rbo;
> -
> -       rbo =3D container_of(bo, struct radeon_bo, tbo);
> +#if IS_ENABLED(CONFIG_AGP)
> +       struct radeon_device *rdev;
>
>         rdev =3D radeon_get_rdev(bo->bdev);
> -#if IS_ENABLED(CONFIG_AGP)
>         if (rdev->flags & RADEON_IS_AGP) {
>                 return ttm_agp_tt_create(bo, rdev->ddev->agp->bridge,
>                                          page_flags);
>         }
>  #endif
>
> +       rbo =3D container_of(bo, struct radeon_bo, tbo);
> +
>         gtt =3D kzalloc(sizeof(struct radeon_ttm_tt), GFP_KERNEL);
>         if (gtt =3D=3D NULL) {
>                 return NULL;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
