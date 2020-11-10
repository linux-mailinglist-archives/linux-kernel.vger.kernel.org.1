Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EBE2AE42D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgKJXih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731657AbgKJXih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:38:37 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC623C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:38:36 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so144185wmm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZutQPrufGfr7YlLgQNj0QvrwUThkZK+ztyYTltmNCZk=;
        b=hs2n0APqvWN+vmIUcsnQpZ142iKWzIjoNZGyhMuos07ct2uGqr8Hss/f+FOu8VQ0kp
         VdbD5rRvv3lZoMXG/LQpxvaDMFq147lNPqcqyHJ3MUj4220I+hmy+yrDobjn/tTmmGOl
         rRLWYHVRY7OiPIZPm2m3NMJUX1VKUIryRPGd+aKNzYYhOBOA2MVct4DWuXdaU6itKfrS
         B6+v/T3y8c+okBb4yqlMaKNK3V39ohV9cWO899AsPSfF8Vw/mKCzISMTXhBny0WG5sl3
         AnRKkM53FfRuO4zMZMxVmZoAdNrhBRfimulwtAUi0dD8TC9n+rmPf+8itYDM2HWwty9U
         mkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZutQPrufGfr7YlLgQNj0QvrwUThkZK+ztyYTltmNCZk=;
        b=WqqXv73Uov+hYCcDr80df3ybCUHyemSVQ1p7f5ldTRn5zQAs0i5d8e+UzzJhSFpr4M
         5Oz6pclZ/uQgz7Z29CGxQ77Wf0nWUUQ0TZv/iAk2uvuzgEJ51KncLAwPyZw7KT5WdGmz
         dtIVCGhy3dWcg+bek6/KkeFIXEyegl2bL1jVBvDssUxZ7YVWrJG47NanfOA+XAwZBA9S
         ypIE2EUvPSGiBW7GKHB4GTEo+d/u7MSOmCUHrSk0MkIYqZAW6ckdr7medZ4SzjGRcNgL
         UhBVRizRkDztbA95GpV1p3wnao0oJUhiReyHrk04aQhWmPu7AfHDw/NICAvrRxNkTk4D
         7qOg==
X-Gm-Message-State: AOAM532Vpobnvx8Of6LFJLu30IhgOUzxAl3AskuBxj4fAuaRivCf53fU
        Ni+f1uvfalB7liuD+6W8LDc5nLeW2ygZimK0KnE=
X-Google-Smtp-Source: ABdhPJy2m8bHEXbEVMkU51+jmBCoJ3ggpUW+m6uPbCFn43PxxjQc7bBA0BDypg535Bs9DNR7IaGJu8PAqgXGp2NSnQQ=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr554021wma.79.1605051515558;
 Tue, 10 Nov 2020 15:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-7-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:38:24 -0500
Message-ID: <CADnq5_M89n3R8SLWxcMpVnsTLurgZFqB9-p2g_XrST5_4=F=Pg@mail.gmail.com>
Subject: Re: [PATCH 06/30] drm/radeon/trinity_dpm: Remove some defined but
 never used arrays
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

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/trinity_dpm.c:146:18: warning: =E2=80=98trinity_s=
ysls_default=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/trinity_dpm.c:131:18: warning: =E2=80=98trinity_m=
gcg_shls_disable=E2=80=99 defined but not used [-Wunused-const-variable=3D]
>  drivers/gpu/drm/radeon/trinity_dpm.c:120:18: warning: =E2=80=98trinity_m=
gcg_shls_enable=E2=80=99 defined but not used [-Wunused-const-variable=3D]
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
>  drivers/gpu/drm/radeon/trinity_dpm.c | 44 ----------------------------
>  1 file changed, 44 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeo=
n/trinity_dpm.c
> index 4d93b84aa7397..e005c18aac00e 100644
> --- a/drivers/gpu/drm/radeon/trinity_dpm.c
> +++ b/drivers/gpu/drm/radeon/trinity_dpm.c
> @@ -116,55 +116,11 @@ static const u32 trinity_mgcg_shls_default[] =3D
>         0x00009220, 0x00090008, 0xffffffff,
>         0x00009294, 0x00000000, 0xffffffff
>  };
> -
> -static const u32 trinity_mgcg_shls_enable[] =3D
> -{
> -       /* Register, Value, Mask */
> -       0x0000802c, 0xc0000000, 0xffffffff,
> -       0x000008f8, 0x00000000, 0xffffffff,
> -       0x000008fc, 0x00000000, 0x000133FF,
> -       0x000008f8, 0x00000001, 0xffffffff,
> -       0x000008fc, 0x00000000, 0xE00B03FC,
> -       0x00009150, 0x96944200, 0xffffffff
> -};
> -
> -static const u32 trinity_mgcg_shls_disable[] =3D
> -{
> -       /* Register, Value, Mask */
> -       0x0000802c, 0xc0000000, 0xffffffff,
> -       0x00009150, 0x00600000, 0xffffffff,
> -       0x000008f8, 0x00000000, 0xffffffff,
> -       0x000008fc, 0xffffffff, 0x000133FF,
> -       0x000008f8, 0x00000001, 0xffffffff,
> -       0x000008fc, 0xffffffff, 0xE00B03FC
> -};
>  #endif
>
>  #ifndef TRINITY_SYSLS_SEQUENCE
>  #define TRINITY_SYSLS_SEQUENCE  100
>
> -static const u32 trinity_sysls_default[] =3D
> -{
> -       /* Register, Value, Mask */
> -       0x000055e8, 0x00000000, 0xffffffff,
> -       0x0000d0bc, 0x00000000, 0xffffffff,
> -       0x0000d8bc, 0x00000000, 0xffffffff,
> -       0x000015c0, 0x000c1401, 0xffffffff,
> -       0x0000264c, 0x000c0400, 0xffffffff,
> -       0x00002648, 0x000c0400, 0xffffffff,
> -       0x00002650, 0x000c0400, 0xffffffff,
> -       0x000020b8, 0x000c0400, 0xffffffff,
> -       0x000020bc, 0x000c0400, 0xffffffff,
> -       0x000020c0, 0x000c0c80, 0xffffffff,
> -       0x0000f4a0, 0x000000c0, 0xffffffff,
> -       0x0000f4a4, 0x00680fff, 0xffffffff,
> -       0x00002f50, 0x00000404, 0xffffffff,
> -       0x000004c8, 0x00000001, 0xffffffff,
> -       0x0000641c, 0x00000000, 0xffffffff,
> -       0x00000c7c, 0x00000000, 0xffffffff,
> -       0x00006dfc, 0x00000000, 0xffffffff
> -};
> -
>  static const u32 trinity_sysls_disable[] =3D
>  {
>         /* Register, Value, Mask */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
