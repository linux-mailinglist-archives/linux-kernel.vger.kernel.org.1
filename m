Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C182F3E09
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393818AbhALWBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730091AbhALWBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:01:15 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BE6EC0617A2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:00:26 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id i6so3851277otr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fMOsJ+yCzpE8j0c8U4hOEUgeq7Kka7k0SjEEHdyP6UQ=;
        b=hycUmKEOzqPiLqOtJxG6D5fkdB9nwjQHK6Dnv6JYYzfh4UG8OCOxXjDs8opMl+BSRz
         Mw8hWO1kOUOzNstwMqrlvjGCvi41siDx5toR75bKx2CDBEg57yUsFqKpJwalsTBrrniO
         CnfbdIesuc8qxWfoJSuA7xuMWYzNYq9E42TOc88Nvu1ryorMxoPDcg9mYNQ99y20LBFT
         2/dGo2jQl9PmgwqBCa0chxKlIFXZrbXslQBxehoEnZFzFYm8f2iDlfwMStQHzy0HNsOi
         DseN5It17TBH1hoWpX+f9KwIH5IN77khiTzgFDWi0XHrl39thCYVXr8HkYrwEg61FWxm
         g+UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fMOsJ+yCzpE8j0c8U4hOEUgeq7Kka7k0SjEEHdyP6UQ=;
        b=l3dFxezX9FBprh7s6DiNwRBj53A17lJ4bppHOG4YBJyz+G6UzVOAYbt4VosABeZ0vZ
         Sx56rd9ZPINkfAG5WrkPURs5ESaCzoF53zVqLaUTi5d8PK9lvUNml9zzO7l4ePxl5sGt
         xskAQXG59R/CxVazcXDsaABjBfjvVWLvtnh5vXhS8l4tpQPDHaJfSKgvgwVNBYWsFpGo
         jNQ83EPVRQahyAnH05vlI5T/iz1o+/dnoyrqer+1OhNKtUeU8bweha6GiuO/N4hNO1eb
         VXk1wSkkWdOeVq8yqpYSvy9F3PtaETgRBE2QhYMoP+wyxaJzy7ltR4++v3anI/VW6w5b
         q9hg==
X-Gm-Message-State: AOAM533u+QiXMVYzKFjtYKQ5arolquHfYwQZ0pStXDvJMv0uFXeS82/W
        zRPqtgtiZ+x8vXlbYEYyxJCpe+6hCldPPsr4k7E=
X-Google-Smtp-Source: ABdhPJyAhZqfau2mOz0A2k5mOBxg9Wpw5j1oKcrx8V7oeErJ6wBRCxNlUTbw/uW4ABYw01eYzhk1c5lrwph3JharLg0=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr1060690ote.132.1610488825915;
 Tue, 12 Jan 2021 14:00:25 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-5-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:00:15 -0500
Message-ID: <CADnq5_NMfddmOn_42UVD8XVwXN3Q3Ag219Zz+V1RoremFb9rog@mail.gmail.com>
Subject: Re: [PATCH 04/40] drm/amd/display/dc/dce/dce_opp: Demote
 non-compliant kernel-doc headers
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

On Mon, Jan 11, 2021 at 2:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:109: warning: Fun=
ction parameter or member 'opp110' not described in 'set_truncation'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:109: warning: Fun=
ction parameter or member 'params' not described in 'set_truncation'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:154: warning: Fun=
ction parameter or member 'opp110' not described in 'dce60_set_truncation'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:154: warning: Fun=
ction parameter or member 'params' not described in 'dce60_set_truncation'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:204: warning: Fun=
ction parameter or member 'opp110' not described in 'set_spatial_dither'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:204: warning: Fun=
ction parameter or member 'params' not described in 'set_spatial_dither'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:308: warning: Fun=
ction parameter or member 'opp110' not described in 'set_temporal_dither'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:308: warning: Fun=
ction parameter or member 'params' not described in 'set_temporal_dither'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:370: warning: Fun=
ction parameter or member 'opp110' not described in 'dce110_opp_set_clampin=
g'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:370: warning: Fun=
ction parameter or member 'params' not described in 'dce110_opp_set_clampin=
g'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:430: warning: Fun=
ction parameter or member 'opp110' not described in 'dce60_opp_set_clamping=
'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:430: warning: Fun=
ction parameter or member 'params' not described in 'dce60_opp_set_clamping=
'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:478: warning: Fun=
ction parameter or member 'opp110' not described in 'set_pixel_encoding'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:478: warning: Fun=
ction parameter or member 'params' not described in 'set_pixel_encoding'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:514: warning: Fun=
ction parameter or member 'opp110' not described in 'dce60_set_pixel_encodi=
ng'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_opp.c:514: warning: Fun=
ction parameter or member 'params' not described in 'dce60_set_pixel_encodi=
ng'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/d=
rm/amd/display/dc/dce/dce_opp.c
> index 2bf8f5a2e0c22..4600231da6cbb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
> @@ -97,7 +97,7 @@ enum {
>
>
>
> -/**
> +/*
>   *     set_truncation
>   *     1) set truncation depth: 0 for 18 bpp or 1 for 24 bpp
>   *     2) enable truncation
> @@ -142,7 +142,7 @@ static void set_truncation(
>  }
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> -/**
> +/*
>   *     dce60_set_truncation
>   *     1) set truncation depth: 0 for 18 bpp or 1 for 24 bpp
>   *     2) enable truncation
> @@ -183,7 +183,7 @@ static void dce60_set_truncation(
>  }
>  #endif
>
> -/**
> +/*
>   *     set_spatial_dither
>   *     1) set spatial dithering mode: pattern of seed
>   *     2) set spatial dithering depth: 0 for 18bpp or 1 for 24bpp
> @@ -291,7 +291,7 @@ static void set_spatial_dither(
>                 FMT_SPATIAL_DITHER_EN, 1);
>  }
>
> -/**
> +/*
>   *     SetTemporalDither (Frame Modulation)
>   *     1) set temporal dither depth
>   *     2) select pattern: from hard-coded pattern or programmable patter=
n
> @@ -355,7 +355,7 @@ static void set_temporal_dither(
>                 FMT_TEMPORAL_DITHER_EN, 1);
>  }
>
> -/**
> +/*
>   *     Set Clamping
>   *     1) Set clamping format based on bpc - 0 for 6bpc (No clamping)
>   *             1 for 8 bpc
> @@ -415,7 +415,7 @@ void dce110_opp_set_clamping(
>  }
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> -/**
> +/*
>   *     Set Clamping for DCE6 parts
>   *     1) Set clamping format based on bpc - 0 for 6bpc (No clamping)
>   *             1 for 8 bpc
> @@ -465,7 +465,7 @@ static void dce60_opp_set_clamping(
>  }
>  #endif
>
> -/**
> +/*
>   *     set_pixel_encoding
>   *
>   *     Set Pixel Encoding
> @@ -501,7 +501,7 @@ static void set_pixel_encoding(
>  }
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
> -/**
> +/*
>   *     dce60_set_pixel_encoding
>   *     DCE6 has no FMT_SUBSAMPLING_{MODE,ORDER} bits in FMT_CONTROL reg
>   *     Set Pixel Encoding
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
