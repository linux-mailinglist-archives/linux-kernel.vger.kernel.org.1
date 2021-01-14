Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC002F669B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbhANRA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhANRA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:00:57 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013BEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:00:17 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id w124so6584904oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/UHww9UxEy8O5ddy3Z1qobR+2YB3UWaKDvVfxtlmBEo=;
        b=fm7879TPMuqn6zeUsgjjlbMj6T6iVc83EMD4rt0Bg4IkYlW3X88SVlgYf5dBWl7ARr
         1HElkn/Nzs7Ov7VJ5KF6sVMytePOZlP+y7ecj1clay24dyo/aHL3kMuPaoh3WVTkd/rD
         571l/xxD1SEsLpTAug7vtvHRucxSQytdov7CRIM+cORqhErs3d2HVNWkUsPQigDyr2LS
         Z2EyS6x7IJ4K4/jklK+CwCCuz/QKbGdZvVkniyb2wGemGxe1PfKrHLhRy/z4ow8Yzl3d
         x6pitrYRUIlh6ABFJOGkoplH1QR70Iy5RnNpZuw9nIldGVP9E1KUomh7vFWOiboJ3StQ
         N0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/UHww9UxEy8O5ddy3Z1qobR+2YB3UWaKDvVfxtlmBEo=;
        b=LdRL5vhrZ6LarwoTrpcSA6Qp5colJJFrdoftsyM4I7Tl2ltZueM5K1o6Lz4ltrIcmL
         Mz+T1Hmgnb88AUg+r91pNHYHAsNAF96p8l9QgLnV7H93KF8w8+5EP8L4msv3MgfZw2sI
         MXEqZYrh6basQ5GXwlHW4ge81oV50WF+5mhGcb7L/5q4WN0ehk2tdvRK3tslS4lTEaJi
         CmSHsiDtHtxSNUlvtkpdYnT/yZujJgJd9nvN5vPO002SvgfUpsFyhI3VfUu9DIiHq52F
         mJBG0w6+l2tcYKwn/FjV8L4I9T4al5ti5bqH5C3yBCZ6jyeP+zbtPzsAP97bSFur7qU1
         J59w==
X-Gm-Message-State: AOAM532rG8ntjjscM8y9W7YGZ3HluKIX4K5ZUsiAGJj5sGHbCh23pJYd
        Q2yruIppvJkd/EMzcDWuFn+sQ0L4v/6HQVTWV3U=
X-Google-Smtp-Source: ABdhPJyWraPPWDcrYW6tPAvpgVNXAKBM98P9xyKbK2CBh+Yq2e6sd3oJQFeG8LyeOlmrpo++XKxW3Qe1uLqyNwf9xco=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3048870oib.123.1610643616487;
 Thu, 14 Jan 2021 09:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-29-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-29-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:00:05 -0500
Message-ID: <CADnq5_Mi081XymGX5n-pbyx=3mgjx0M1LTBuqv--dTKPbPBBfg@mail.gmail.com>
Subject: Re: [PATCH 28/40] drm/amd/display/dc/calcs/dce_calcs: Demote
 non-conformant kernel-doc function headers
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2753: warning=
: Function parameter or member 'vbios' not described in 'is_display_configu=
ration_supported'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:2753: warning=
: Function parameter or member 'calcs_output' not described in 'is_display_=
configuration_supported'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning=
: Function parameter or member 'ctx' not described in 'bw_calcs'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning=
: Function parameter or member 'dceip' not described in 'bw_calcs'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning=
: Function parameter or member 'vbios' not described in 'bw_calcs'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning=
: Function parameter or member 'pipe' not described in 'bw_calcs'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning=
: Function parameter or member 'pipe_count' not described in 'bw_calcs'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3030: warning=
: Function parameter or member 'calcs_output' not described in 'bw_calcs'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/g=
pu/drm/amd/display/dc/calcs/dce_calcs.c
> index f69c2b84d432b..967d6d80bd38e 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -2743,7 +2743,7 @@ void bw_calcs_init(struct bw_calcs_dceip *bw_dceip,
>         kfree(vbios);
>  }
>
> -/**
> +/*
>   * Compare calculated (required) clocks against the clocks available at
>   * maximum voltage (max Performance Level).
>   */
> @@ -3014,13 +3014,12 @@ static bool all_displays_in_sync(const struct pip=
e_ctx pipe[],
>         return true;
>  }
>
> -/**
> +/*
>   * Return:
>   *     true -  Display(s) configuration supported.
>   *             In this case 'calcs_output' contains data for HW programm=
ing
>   *     false - Display(s) configuration not supported (not enough bandwi=
dth).
>   */
> -
>  bool bw_calcs(struct dc_context *ctx,
>         const struct bw_calcs_dceip *dceip,
>         const struct bw_calcs_vbios *vbios,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
