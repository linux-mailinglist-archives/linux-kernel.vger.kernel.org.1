Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20F2CAAF5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgLASmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgLASmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:42:52 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63919C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:42:12 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id n12so2681602otk.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 10:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o8Yrz8jCTUvvNG9mLNTC9WmXE/KF1ZhcQr5AMsMwdps=;
        b=aBc33o0oe6NaVoE/E0JyZA7eVWqUew8ia3eAKpGwlmDiwdUYJDm8cxS2c2uGK3EZp6
         b8opUjYb0qH9xuqBwr1igXhJU6p+DIbW4p/j4eGebWV1Kp6N1fLXUxHBIiwkneuyv2oe
         XcU3MyRz+AdoR2sN0xm2TJB8eB9lPJ21weIMS0CmTrp1vw9hSxA5c6WAhKMGcFCJZh+A
         GgG8B774p7Ifu380VV//5y1hFe431rFjfmCTca71QpYSM6eYiHbksMXrXKg6d0ZmqPZh
         sc9U8ZtXlxZVkBY5v/Jq9Bpem2xp3QV5mgoUWF0j2cshMlRPJp1gaGayxrI16fn9OcGo
         4CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o8Yrz8jCTUvvNG9mLNTC9WmXE/KF1ZhcQr5AMsMwdps=;
        b=ToFLnz14rUvWkAkw9kVVqE1I6LmuI7ymMEwhJcxws2avz8h5nslzbtJo50hw8GE0W/
         eAM2D+S94F8tJa62HbCP0lkEoD/E1sYimfN4KmIAW0JLLkIquLj8kaYKcv2YyL4mpSsB
         au6M0I8jjtPu4RL8tKVH7NAZedbXzy8/cXSFly8/zJ81KS5MjY70KS+yx/8rmHQQOu99
         7kB6yb7X1r836HyZUpQ0Hv0axUcR6nvXMDDr193ECKBHVRkxYXtDzTlmTxbEstOUuGpt
         wyaQI8UzsKfQ6TQP7A5gWYxA6DrwFf/DL3usmKNWqMTTfmh/ptz+9km9tvO5vJIRxR0f
         pKyA==
X-Gm-Message-State: AOAM530IxAW1b0c1CCiT8XjYruVPBjenzqw7Um6bD8vRwEK1AdzzZJ9n
        vA+Eya4S09MjqhOrECO+rptiyjKISRSdQCalAQgdQ5dX
X-Google-Smtp-Source: ABdhPJwPAdvf76C34gbDWPn0PpvAj/ob9qqS7TppUse2a8h8fydpmpIQPA9Da8aID2PSj86TD3qS8t2bQYY1iYisJic=
X-Received: by 2002:a9d:5388:: with SMTP id w8mr2866367otg.311.1606848131784;
 Tue, 01 Dec 2020 10:42:11 -0800 (PST)
MIME-Version: 1.0
References: <20201126134240.3214176-1-lee.jones@linaro.org> <20201126134240.3214176-35-lee.jones@linaro.org>
In-Reply-To: <20201126134240.3214176-35-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Dec 2020 13:42:00 -0500
Message-ID: <CADnq5_On90z1w=_usmjA7kHFVig3uHg4VJRecDraYZv8cmRAUQ@mail.gmail.com>
Subject: Re: [PATCH 34/40] drm/amd/display/amdgpu_dm/amdgpu_dm_helpers: Use
 'gnu_printf' format notation
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
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c: In =
function =E2=80=98dm_dtn_log_append_v=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:345:=
2: warning: function =E2=80=98dm_dtn_log_append_v=E2=80=99 might be a candi=
date for =E2=80=98gnu_printf=E2=80=99 format attribute [-Wsuggest-attribute=
=3Dformat]
>  drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_helpers.c:375:=
3: warning: function =E2=80=98dm_dtn_log_append_v=E2=80=99 might be a candi=
date for =E2=80=98gnu_printf=E2=80=99 format attribute [-Wsuggest-attribute=
=3Dformat]
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
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index b7d7ec3ba00d7..24a81642baa26 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -318,6 +318,7 @@ void dm_dtn_log_begin(struct dc_context *ctx,
>         dm_dtn_log_append_v(ctx, log_ctx, "%s", msg);
>  }
>
> +__printf(3, 4)

Can you expand a bit on what this does?

Alex

>  void dm_dtn_log_append_v(struct dc_context *ctx,
>         struct dc_log_buffer_ctx *log_ctx,
>         const char *msg, ...)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
