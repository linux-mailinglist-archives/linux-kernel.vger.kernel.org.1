Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54DA2F67FC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbhANRmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:42:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbhANRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:42:19 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FD3C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:41:39 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id d8so5934031otq.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yZPtLF2dgwtYAx1TmKj7odMtDrqK/Ohq/q+D+rVa6A4=;
        b=TLIeA3UaMz5+tl+wSOxPwxf3If/iTw7OJUGFbRHXDRypWHQn2d8jJ/JuDYdj8eGneb
         +w6/YwbyFx4iNmi8ociz44tEkr6KTsL4DoiR/Q2ki1QA2pQ8t6MxPSW+J03ZbABdxHnw
         c430B40XM2qOfPYMyGhX8JsGxp9naiwbanbabVJSWEsLApnVuacZQNKOrCTYrS8Zd3kj
         VbGOAfrtMFplYh4tYVOkDxWXsrzMGvXLbpFqujQBUf/8wyjaVJzpf2yf9OfugUHXvgTd
         QP/k0+sB7KpfMUKTObqoexpBd4mPwXGeGjngIjA5uR9T5jhqbHJB/q/ZHiDgV3orsMWs
         9d0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yZPtLF2dgwtYAx1TmKj7odMtDrqK/Ohq/q+D+rVa6A4=;
        b=RNhrhzq5QFxHD603qjdVYCV27Qj/QpmyTJm5DKFp6BGQemVSCVeQdpJBfNHnw0Y+SS
         by46L7KrXW2JSxT3L+FQvq8Ulf/Rw/uKWB7ngCK4RVplwyh588R5rlkN8ZVnFdq453wy
         y+wcan7ENIb6DMxyJKcrFK0YA9DKqlorzutbJM6sztcoSM2E0WGbzBBFWOao6vWDB+T0
         rKKGyA3KPX7N8WGGBln7RH6xHEnyXLFh/2Ff/LiVrmFirs8/dbMYCf+PftOwaEeqzKj6
         S1iXgaNVsM43cRRrRj8uJcSTjmSty1FdL+feGCCSSJbeFqIiVlLTI3cGHxjFOinHjPal
         dYYQ==
X-Gm-Message-State: AOAM532B/LJS9YHmI39I/KgW7P/c/Mq/fNnj7/l/Or+U++qWjIin7uhA
        XOovV5eTVNXvC8GsCqBf0apWA+meLyglOF9DPGA=
X-Google-Smtp-Source: ABdhPJzsRi4cgwbG4fQaEhSiIMVFgLf/Qc0wTAfEtuD/mGakUOeiO/PqLuEnTVZ7CvoEOt4zKEprnmEBklSM22MhY+Q=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr5369048otl.311.1610646099154;
 Thu, 14 Jan 2021 09:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20210114074755.45539-1-zhangzhijie@loongson.cn>
In-Reply-To: <20210114074755.45539-1-zhangzhijie@loongson.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:41:28 -0500
Message-ID: <CADnq5_MXq6kRx=RdfH=uko81+VFnqpmzpgOvH2nt-vNj6npCTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Repeat assignment to max_slave_planes
To:     "ZhiJie.Zhang" <zhangzhijie@loongson.cn>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 4:29 AM ZhiJie.Zhang <zhangzhijie@loongson.cn> wrote:
>
> Signed-off-by: ZhiJie.Zhang <zhangzhijie@loongson.cn>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> index 3f63822b8e28..9a86d43a6233 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c
> @@ -1272,7 +1272,6 @@ static bool underlay_create(struct dc_context *ctx, struct resource_pool *pool)
>
>         /* update the public caps to indicate an underlay is available */
>         ctx->dc->caps.max_slave_planes = 1;
> -       ctx->dc->caps.max_slave_planes = 1;
>
>         return true;
>  }
> --
> 2.29.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
