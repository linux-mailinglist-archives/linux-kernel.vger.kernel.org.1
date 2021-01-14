Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8EC2F677F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbhANRY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:24:27 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8557C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:23:46 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q205so6617460oig.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MpjDvPtGE3jxQK40Dp9TpRjPqOVlxA0emJuek+JS0vI=;
        b=cL8q5Yl6JTpO9lg1m5y/cnTQ6jXQHLr4hOo5P7c6UcqLn0HApFw2OWhozGgyCBUGbC
         gREhrMzw6dTeRw9NwVkAXHEUj4HMQ6uezsmOoN6pVa4D0dZ7z3vCOAf7q5T4ZFt9EexZ
         b68RTjmemxgaz2N6DIRNTeEgRVKJXJxuuGl2is7ImtIHbVd63htve4/KfUVVcE86VMAi
         1AJcEKonE1w/E23aQH5L4cXMalyP7qR1wAoCqGLP6e7mbqUa1k4cWGlhxLD/FDLtouwc
         oSyyT2fOWR2drCO/rNpjbp0p3diIlLjR4O3tjXbJFzQJ/ja92DUJd+SKdxBpUue509T+
         OWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MpjDvPtGE3jxQK40Dp9TpRjPqOVlxA0emJuek+JS0vI=;
        b=XkTc+9VsSW+ZC8Qb7LNyTy8NZguLfVpMSCVrkdzq4Mb0c4MA8qF4jeG5xHKc+GWGmr
         9FEB0hf0QSYmFpbVJzsb1wFiKlb8LT0LDkQrtbRHEM7931BOVG3ohVpaX7axxGenFSSj
         iEzpvGvLiIAyDPd5msvZEk4PxQEch90G3pKv2ZPDMyUm4M8POZTA6sakEF7J0duW6qUj
         bxSbQBT7AL3d0QKMB1Bpoxtx+eq/ZKL1IU2IgvgmkDmODaMGY/uTM9RcmRqB1S4D2foP
         3Y/TllhNDlmpb3GspWK5+EJthvcH7uIckXJiwoSyTYq4zOV2JCNdaPnpbH4lWmDqmzO+
         +Bfg==
X-Gm-Message-State: AOAM5313oov/UnLF89oxNe8Ibiz0XIriWGLhFQJQv4F+8AKr4I7wZY8D
        FofI8vtltwCgPZ1HsxDcEokfx8d8iszLY1hZSoc=
X-Google-Smtp-Source: ABdhPJwRJ9fBj7etGLkpUidLzzwEGN6cx4RpF4hdCr5OqT6/PbRaiaq0lq5MUVBbs4QjNaxOxN2CAI+wfGTIMHjPRdw=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3154240oii.120.1610645026351;
 Thu, 14 Jan 2021 09:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-23-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-23-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:23:35 -0500
Message-ID: <CADnq5_OSHVH_4f8QUaFTFGQ=N0mhyPcrZmS6=76_Ff22rhEjsA@mail.gmail.com>
Subject: Re: [PATCH 22/30] drm/amd/display/dc/core/dc_link: Fix a couple of
 function documentation issues
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:214: warning: Fu=
nction parameter or member 'link' not described in 'dc_link_detect_sink'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:350: warning: Fu=
nction parameter or member 'link' not described in 'dc_link_is_dp_sink_pres=
ent'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:841: warning: Fu=
nction parameter or member 'link' not described in 'dc_link_detect_helper'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:841: warning: Fu=
nction parameter or member 'reason' not described in 'dc_link_detect_helper=
'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3403: warning: C=
annot understand  *********************************************************=
********************
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
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index 3366a49f11dc7..271c4f66edb56 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -206,6 +206,7 @@ static bool program_hpd_filter(const struct dc_link *=
link)
>  /**
>   * dc_link_detect_sink() - Determine if there is a sink connected
>   *
> + * @link: pointer to the dc link
>   * @type: Returned connection type
>   * Does not detect downstream devices, such as MST sinks
>   * or display connected through active dongles
> @@ -342,7 +343,7 @@ static enum signal_type get_basic_signal_type(struct =
graphics_object_id encoder,
>         return SIGNAL_TYPE_NONE;
>  }
>
> -/**
> +/*
>   * dc_link_is_dp_sink_present() - Check if there is a native DP
>   * or passive DP-HDMI dongle connected
>   */
> @@ -828,7 +829,7 @@ static bool wait_for_entering_dp_alt_mode(struct dc_l=
ink *link)
>         return false;
>  }
>
> -/**
> +/*
>   * dc_link_detect() - Detect if a sink is attached to a given link
>   *
>   * link->local_sink is created or destroyed as needed.
> @@ -3400,10 +3401,7 @@ void core_link_set_avmute(struct pipe_ctx *pipe_ct=
x, bool enable)
>  }
>
>  /**
> - ***********************************************************************=
******
> - *  Function: dc_link_enable_hpd_filter
> - *
> - *  @brief
> + *  dc_link_enable_hpd_filter:
>   *     If enable is true, programs HPD filter on associated HPD line usi=
ng
>   *     delay_on_disconnect/delay_on_connect values dependent on
>   *     link->connector_signal
> @@ -3411,9 +3409,8 @@ void core_link_set_avmute(struct pipe_ctx *pipe_ctx=
, bool enable)
>   *     If enable is false, programs HPD filter on associated HPD line wi=
th no
>   *     delays on connect or disconnect
>   *
> - *  @param [in] link: pointer to the dc link
> - *  @param [in] enable: boolean specifying whether to enable hbd
> - ***********************************************************************=
******
> + *  @link:   pointer to the dc link
> + *  @enable: boolean specifying whether to enable hbd
>   */
>  void dc_link_enable_hpd_filter(struct dc_link *link, bool enable)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
