Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8431A2F3E17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393837AbhALWCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:02:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728850AbhALWCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:02:41 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E40C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:02:00 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id a109so3858005otc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D9gsZPObytvKcn447+TF9LzV4EXZkRYI4YcY8htrsGc=;
        b=sPt7pKQaIh44JNY9YvCx6hMWeR2E6Bz+xcd4DePCjP2wtKnLVlMLLG1AQk2jzK0/B5
         gUxpcF+378A7epie+uEgghTrnXwpPmpJckPI5aVRnk7BCZ7W3tpuOi/iGlawoUpX/ZW1
         fTWGp8jVZ81bsZDeEKwXNxpBM6/zNnyh6q868F9slbXx5zMc1RtOEBsc6oZN7Hr0ZiHt
         qougKv/OLjceQGW/az+LKoOnL1KzTj3Hc7Y0DmXdTcm9aHrL/K36HQwyQsQ28z4fMzzg
         dXzwbaoIrisBAZxgvg6X2Y4/OPXZmBOeGDqc85t9GqSHhccPsgnZvbCUiM5Wn4aABUpS
         gjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D9gsZPObytvKcn447+TF9LzV4EXZkRYI4YcY8htrsGc=;
        b=JHQ5jN9UvHNDwi0hiehX562mtJkZXYuUOfHBJlg4IG7NKsgWr3qKee0mleOziqkV1p
         5+ujozfKO52UHmAIdXnxn/HN08Bo5qxQKv8SCJ+9GeTkAKEtESq0nakcsqAuu48yXwPM
         zbxhCi8ZigGeB+fjI4bZlBrWWGu9P84aeeWbxee8FCewRPuexC5gy/AHi0TNqur5f3Fc
         d1/mJc2b1wOJXLboyaxHNzOXmOI47ZYxFXOHKDFq2LUVx9nisTrJKkHdBYgCK/0NHArR
         m+bF9h7wvx49UKQMOpetJknC/uhn1M/fPlMZHsfrwYuIJPSmA0xStFSWNSBgSCSWm1qM
         NB+A==
X-Gm-Message-State: AOAM531jpQ8JbtjvXIQV8pUtd3VFRBQfZZKIe65AnlQivd4AWRAiii1L
        GGTjYcZ5zoO28yggVvcDpYAaM7/9wawShyCsT1I=
X-Google-Smtp-Source: ABdhPJyH9TmT3duJ5BJ3Q5qQc492fFRernj0HfUAJ1cYFU4Replxuz542maoEPin8PTSfYUiT22X0mAvvvAZkbMf7nM=
X-Received: by 2002:a05:6830:1b7b:: with SMTP id d27mr1066032ote.132.1610488918883;
 Tue, 12 Jan 2021 14:01:58 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-7-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:01:47 -0500
Message-ID: <CADnq5_N_b0VKC1RtpsxAYuk0FZkttzVDv8en0PoQK70rRdhQkA@mail.gmail.com>
Subject: Re: [PATCH 06/40] drm/amd/display/dc/gpio/diagnostics/hw_translate_diag:
 Include our own header containing prototypes
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

On Mon, Jan 11, 2021 at 2:19 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/gpio/diagnostics/hw_translate_d=
iag.c:37:6: warning: no previous prototype for =E2=80=98dal_hw_translate_di=
ag_fpga_init=E2=80=99 [-Wmissing-prototypes]
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
>  .../gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c  | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate=
_diag.c b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag=
.c
> index bf90688469271..e5138a5a8eb5a 100644
> --- a/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c
> +++ b/drivers/gpu/drm/amd/display/dc/gpio/diagnostics/hw_translate_diag.c
> @@ -24,6 +24,7 @@
>   */
>
>  #include "dm_services.h"
> +#include "hw_translate_diag.h"
>  #include "include/gpio_types.h"
>
>  #include "../hw_translate.h"
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
