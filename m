Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B296D2F66F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbhANRI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbhANRIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:08:25 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F58C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:07:44 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id s75so6637404oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7486gkH3QYVYP1H7a3/P8S4AjfVYRwRaV8aYoWWDGU4=;
        b=UPXqgGLLhjZHqaA/0z5zTaUcyuLGro//8Cc4RYeqs1kp31Mr5SuL1TDokyXoCeyUyV
         vuPwMN3/mfHoKebzVSGpnd/5HNB//w2TsPSdtzA+Fc02kg2h42pQQlwviKRESqehT/x9
         svv+ThIMiglBFXfm2+NAED1J4zWGfvsWC2mc1iWRSz+u4iwxeXLuinLe+6wYzv4ZzohF
         vzXSHAYwbRB2Uq7bXFKCrIQaJ7wtx29MlqE/+hefnvbjCEKoOHGFdx5RTW5Se7ra+XyZ
         UtTxWju6k73K1lqGiGw3W1OmQiQISI7jtuDTTvFL7oW7T9jtCPsGiwa0QSvqxmREPcqC
         l2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7486gkH3QYVYP1H7a3/P8S4AjfVYRwRaV8aYoWWDGU4=;
        b=My/HM4+K4wqsnUExzeWwNocFfsAk5eeyGqYiGUorF+UL8MRCT5dOwN9N8GcqtC3f3M
         BnsEbbyYCQJOv8iWRa/4BP5dRs3ydmJzcBEcLzf4aF2gz6P35+WFGEmjwcanHxAOO4NE
         4FFl29nsTz0+7FiN7qG5y6EErnWF1wRedPXEvuLc/aOhyNjIsGiF6LZQeSRCg8mhxj/D
         UDL78U8OTs8zMttUz7cNZOS+SjEk364H5Nu5KMWBheLntI1GKAsB9RE6U7UhTkS7n34U
         Zdyh7aSyALwvlqdrtlDeQp8XUUu7vYJopZn8jJR8FqhK0uwXw6ZPNoJXFR+6M1/DyYOH
         l+1w==
X-Gm-Message-State: AOAM532akeffVq9xyJpsxz8/JGz+VejnyvtzyzIE0hB9xHh9ThCY0Ihu
        WR8I4yaNseabG8RJJWPPQu6kwRUqSPR4/xc9htU=
X-Google-Smtp-Source: ABdhPJy3CSJg6Y3Nrh+dYHt/7/ZiW1PsBoYoCx8IQlmCtRjk+2wRG///PbZmKyl2TxgtmBac9rTmSeaur/4vTKkBGFY=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3107195oii.120.1610644064266;
 Thu, 14 Jan 2021 09:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-7-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:07:33 -0500
Message-ID: <CADnq5_PDmfpf_gQAtNq19jfWSc2NqZNcDahwFN4jzQ7O-boaBg@mail.gmail.com>
Subject: Re: [PATCH 06/30] drm/amd/display/dc/core/dc_resource: Staticify
 local functions
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1120:5: warn=
ing: no previous prototype for =E2=80=98shift_border_left_to_dst=E2=80=99 [=
-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:1131:6: warn=
ing: no previous prototype for =E2=80=98restore_border_left_from_dst=E2=80=
=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 07c22556480be..d423092c45dcd 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1117,7 +1117,7 @@ static void calculate_inits_and_adj_vp(struct pipe_=
ctx *pipe_ctx)
>   * We also need to make sure pipe_ctx->plane_res.scl_data.h_active uses =
the
>   * original h_border_left value in its calculation.
>   */
> -int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
> +static int shift_border_left_to_dst(struct pipe_ctx *pipe_ctx)
>  {
>         int store_h_border_left =3D pipe_ctx->stream->timing.h_border_lef=
t;
>
> @@ -1128,8 +1128,8 @@ int shift_border_left_to_dst(struct pipe_ctx *pipe_=
ctx)
>         return store_h_border_left;
>  }
>
> -void restore_border_left_from_dst(struct pipe_ctx *pipe_ctx,
> -                                  int store_h_border_left)
> +static void restore_border_left_from_dst(struct pipe_ctx *pipe_ctx,
> +                                        int store_h_border_left)
>  {
>         pipe_ctx->stream->dst.x -=3D store_h_border_left;
>         pipe_ctx->stream->timing.h_border_left =3D store_h_border_left;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
