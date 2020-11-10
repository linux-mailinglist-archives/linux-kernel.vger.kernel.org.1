Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7282AE243
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgKJV4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJV4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:56:49 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F03C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:56:48 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k2so10989980wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=40omrK6jwVC+aGDjc/p56ppv0VGpUdQ0A5+JFg7+4BU=;
        b=M352Gzv0QFRwWiCLRwUwno3Jg8Xz7FeRCTZVmlV/O/l73Iy4IHTrK26aGfaVEGKdH0
         3JcMPIYM+ycOaq7AZtFqSMFyvwH5L/6tLuJgQqUO8OxjH7C/eweuJaKi/Q5vBamhW95h
         x1WXVzTDGvpX1cSHlfOh6n9AEEQLrt67YRyd6i25HbWvF3NYkrKNedhIrUFmpH/FV8si
         ySRZVtT723W+dsFnPtUUvfI7wCd4RhGjO7J4Yh2gTDycOpZKLn60ggtZp56uOH7V1enC
         FxJRrIkV6hM64e5F+tiIQH7QPh6RkbSdRy/DDXBlK03vozbBt1Ox0Ja2RawvhrGHlijA
         FpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=40omrK6jwVC+aGDjc/p56ppv0VGpUdQ0A5+JFg7+4BU=;
        b=jNofXsCTlqnI3IQ/0OrVWPFTcDiofV05LoBf4KJPx/IlkL6LJ72ll5iwf/1bx4IpMa
         oLFjqmPjPlX4XIjEnTcPxjUW1+/IuOiJov778NgHzQ7NPQb4VBqZEnLfVTUnIWZqyXJ9
         YsJZrcUwZ0g2yv/lWqnvrOgs6hVLZMf9fCnLI4YOmxGmaOf3a4VD9JYq7XtoAveucXHV
         9k1+o7KYsXeuuD8iZFzXR7a5iAgG5jdEj/j/61ll/mRj9fPJslm/F0UACmPvOC/Nydoe
         jYK8gtjyr9f1wuwh8xhtJPjSi+6JQbmLAR4ko/zdDe/h3lczo8Yay7uNQfAHw4fgFlmd
         2sZg==
X-Gm-Message-State: AOAM531FjZ4uRCmFR2HqcLIFlMxlx1zlnGVsyJ0TYX3mLkv+DGSPRzA8
        RTwXyU1kUGiJTTeTkKhiF0OoN09ko/O19UGwAM0=
X-Google-Smtp-Source: ABdhPJzDUdhiFsWJCcbbAH8zpxq3hpcRSnN+82fZTQneP9T8/MJXOJpnYQS9UGxklNwYE5q6WceWD/XEtSe88r6hrEk=
X-Received: by 2002:adf:e9c9:: with SMTP id l9mr27739118wrn.124.1605045407718;
 Tue, 10 Nov 2020 13:56:47 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org> <20201106214949.2042120-12-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 16:56:31 -0500
Message-ID: <CADnq5_OxJ+bWzvrmNGgnArGVUyZx6K=+rxZMhbpThTwA2LJ5Mg@mail.gmail.com>
Subject: Re: [PATCH 11/19] drm/radeon/radeon_drv: Source file headers are not
 good candidates for kernel-doc
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Gareth Hughes <gareth@valinux.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_drv.c:2: warning: Cannot understand  * fil=
e radeon_drv.c
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Gareth Hughes <gareth@valinux.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index 560267cc25892..bb7b33e535f81 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -1,4 +1,4 @@
> -/**
> +/*
>   * \file radeon_drv.c
>   * ATI Radeon driver
>   *
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
