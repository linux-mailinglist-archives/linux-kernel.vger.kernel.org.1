Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7014B2C2CE0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 17:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390461AbgKXQ1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 11:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390003AbgKXQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 11:27:40 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723CC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:27:40 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so3492697wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 08:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a025llBjrOgh57FwURmzXOqxqtmRhk0DL79snbqwcHs=;
        b=ChTECUklJcsQ3TMYgEboImd53xNjfpMqloeOZ4lZhjyxWxAs06Aj+G3MoJwDHoJgJ/
         9POE4CKA1o2hh7EadKWBXCst0rH00OzOJbh8/e2KWY6TUY88bRhbdTt9QLEgpkURXnPP
         n3w7xK+TOCR0KWOfItbjF+H5ethAkG+FaImhMTi0tYKATX6qg8QiAHbMwjuQ6sLM7E1S
         cfJHqul9g+j7o1gyCrulnxsyVoyAwhJHKXDCfDPJkIbX7iAJ8DPmKXKyYzLYodQ7p5Fc
         zYLo87YI/3XYhyuBoZbeXexBfVKQKzoeKrrFC+RFHxuUbEKLlbprvkD3vx5GNi14cUex
         Y2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a025llBjrOgh57FwURmzXOqxqtmRhk0DL79snbqwcHs=;
        b=EMb29RCbd0g+vaj9ZtkvpYhJt8Sl7JeWzXVwK5epIlFLZ29anI6Nx72okW68yA/wp4
         yvMJOQe3QPTwq683jq7RSoUHkF6fB0okiUPYkYVAYE6IKgSHcNsF6mc9Ty0rFgEd02Y6
         d1udCLObdMGcFMEQbAUf0/4zzm0gOC712C84+ep+b5QM1tqkS+JJ0oRNQffkHfwXChq1
         yBwLURVxvNZALK2D4l4w3/nBfy9UxJ+gYv78ORNc6SoFX/cjhbOfdpQtm11o7CxdlBP+
         9axSrQ88w9mDyyuQC543dF+u+OtkRZlfO/Vr2/kAXqufHVBEYhitZDBe2Q+bu8bnRqOC
         fKQQ==
X-Gm-Message-State: AOAM530u5TByoUjEe4ftWY+QSMfydfd3WuQRQ9ap54+PS3uFne79hFpL
        ntqAu/mpd1nRAb7wgNE1PbTVhyylOVL6/Y++eLo=
X-Google-Smtp-Source: ABdhPJykG7KoA+/cvCSiQx0SduJ3Pe5sSnnrlFsfIvCn+1uFMmBfOyFbLoqUuznnxZTbnzabnczxC0PvbEVbSUtTuA8=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr5301350wmb.56.1606235259096;
 Tue, 24 Nov 2020 08:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20201123111919.233376-1-lee.jones@linaro.org> <20201123111919.233376-40-lee.jones@linaro.org>
In-Reply-To: <20201123111919.233376-40-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 24 Nov 2020 11:27:28 -0500
Message-ID: <CADnq5_OxLOWfQ3Y=zkn7t9aP4BeeFKyHCRU9Thpv0-6=tgg1Fw@mail.gmail.com>
Subject: Re: [PATCH 39/40] drm/amd/amdgpu/gmc_v9_0: Remove unused table 'ecc_umc_mcumc_status_addrs'
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 6:20 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:382:23: warning: =E2=80=98ecc_umc_=
mcumc_status_addrs=E2=80=99 defined but not used [-Wunused-const-variable=
=3D]
>
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
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 35 ---------------------------
>  1 file changed, 35 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gmc_v9_0.c
> index 0c3421d587e87..fbee43b4ba64d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -379,41 +379,6 @@ static const uint32_t ecc_umc_mcumc_ctrl_mask_addrs[=
] =3D {
>         (0x001d43e0 + 0x00001800),
>  };
>
> -static const uint32_t ecc_umc_mcumc_status_addrs[] =3D {
> -       (0x000143c2 + 0x00000000),
> -       (0x000143c2 + 0x00000800),
> -       (0x000143c2 + 0x00001000),
> -       (0x000143c2 + 0x00001800),
> -       (0x000543c2 + 0x00000000),
> -       (0x000543c2 + 0x00000800),
> -       (0x000543c2 + 0x00001000),
> -       (0x000543c2 + 0x00001800),
> -       (0x000943c2 + 0x00000000),
> -       (0x000943c2 + 0x00000800),
> -       (0x000943c2 + 0x00001000),
> -       (0x000943c2 + 0x00001800),
> -       (0x000d43c2 + 0x00000000),
> -       (0x000d43c2 + 0x00000800),
> -       (0x000d43c2 + 0x00001000),
> -       (0x000d43c2 + 0x00001800),
> -       (0x001143c2 + 0x00000000),
> -       (0x001143c2 + 0x00000800),
> -       (0x001143c2 + 0x00001000),
> -       (0x001143c2 + 0x00001800),
> -       (0x001543c2 + 0x00000000),
> -       (0x001543c2 + 0x00000800),
> -       (0x001543c2 + 0x00001000),
> -       (0x001543c2 + 0x00001800),
> -       (0x001943c2 + 0x00000000),
> -       (0x001943c2 + 0x00000800),
> -       (0x001943c2 + 0x00001000),
> -       (0x001943c2 + 0x00001800),
> -       (0x001d43c2 + 0x00000000),
> -       (0x001d43c2 + 0x00000800),
> -       (0x001d43c2 + 0x00001000),
> -       (0x001d43c2 + 0x00001800),
> -};
> -
>  static int gmc_v9_0_ecc_interrupt_state(struct amdgpu_device *adev,
>                 struct amdgpu_irq_src *src,
>                 unsigned type,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
