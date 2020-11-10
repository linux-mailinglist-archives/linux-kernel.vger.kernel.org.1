Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9402AE23B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbgKJVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJVzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:55:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CD2C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:55:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p8so13561082wrx.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u5GBjym3rJCQnWuSZFpqf2iaAs/Z53sDeT3dHdMb+hg=;
        b=a+rlA+7yejDdiDJ1N41A0WeGf5WFRpRtpLmadnxbsb1EgT0Xgo5qSDYl7J0upXNIY4
         2Zpm7kJdm8DO97O2FYVJiA2ovCEYpNbpmseJxXqQPXZKTeD5Id0OuEHeIULgH0iic2GR
         13QAgZ1VgmF4g6xoXAa10zDM/B3Oa7rTU7Za47YkTVJQXtjUA34UXNbcAZhBdB2COi6G
         gD96lDc2wpbJFINDGeeldbUTgXS/DtB9tFfFDOa03E3qTavhD3XovJnfsmC3cqODi0B1
         dlyeQdpTOz3io+9Xxxw4foS8XIYrIjO91ILrQZGANqJl3y2d8bFcW8Rr7LEJ+wqDKht1
         wyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u5GBjym3rJCQnWuSZFpqf2iaAs/Z53sDeT3dHdMb+hg=;
        b=t7hxPprxQV8hyFddGmN+23OzibgOfezcraQLYqAaw3k+/rM4Aakw+dYtwEOHrnESzy
         yxMwURYXdyVBHdFsxxIKEQ5y919hIKcgR+K+velVxvOpYRp+BepCPeX07PpXXET3KJ/F
         uUufhNmh+q5i/xbAjmvqFhc3xjIFiDAMXjh8MtKETRduyR0CZX9KSZ/qayRbrMr2GNkP
         DmDrMDeNOJI8vI/hQdVFtZ3brvw4pR862v6ap/hFCsmo5WnELZtrx5Oy2gFDxSg0h4nv
         +FtqWRg6UozqH3oXfRSljZCW4w1uC/JuxTsGzoNtdFFEXd/wuXxalFQ+P/iW4hxY87/x
         cvxg==
X-Gm-Message-State: AOAM533Zdcmn8uSeZPGSOqeNjwws7DuBPsO2UePMfbZOhR7GoykPRga6
        qFvOfzwzmWXED/cs5uZExfHBpJQIMmNCS9cowQs=
X-Google-Smtp-Source: ABdhPJwePm6TFap7im1Q+lSU6k6M6ANru3aJxBPToXCnRsuNls8yQIItyzhUJCqEhxkEbMddFz5085Z0/KT51cBCPkI=
X-Received: by 2002:adf:e350:: with SMTP id n16mr26986533wrj.419.1605045335345;
 Tue, 10 Nov 2020 13:55:35 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org> <20201106214949.2042120-8-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-8-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 16:55:24 -0500
Message-ID: <CADnq5_NrnBHFJGVzO-dbMCJrquaUOAYyCiN2zQVXJwe74xEj5w@mail.gmail.com>
Subject: Re: [PATCH 07/19] drm/radeon/radeon_kms: Include header containing
 our own prototypes
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

On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_kms.c:61:6: warning: no previous prototype=
 for =E2=80=98radeon_driver_unload_kms=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/radeon_kms.c:104:5: warning: no previous prototyp=
e for =E2=80=98radeon_driver_load_kms=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/radeon_kms.c:618:6: warning: no previous prototyp=
e for =E2=80=98radeon_driver_lastclose_kms=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/radeon_kms.c:633:5: warning: no previous prototyp=
e for =E2=80=98radeon_driver_open_kms=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/radeon_kms.c:704:6: warning: no previous prototyp=
e for =E2=80=98radeon_driver_postclose_kms=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/radeon_kms.c:755:5: warning: no previous prototyp=
e for =E2=80=98radeon_get_vblank_counter_kms=E2=80=99 [-Wmissing-prototypes=
]
>  drivers/gpu/drm/radeon/radeon_kms.c:825:5: warning: no previous prototyp=
e for =E2=80=98radeon_enable_vblank_kms=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/radeon_kms.c:852:6: warning: no previous prototyp=
e for =E2=80=98radeon_disable_vblank_kms=E2=80=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/radeon/radeon_kms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon=
/radeon_kms.c
> index 99ee60f8b604d..0d8fbabffcead 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -40,6 +40,7 @@
>
>  #include "radeon.h"
>  #include "radeon_asic.h"
> +#include "radeon_drv.h"
>
>  #if defined(CONFIG_VGA_SWITCHEROO)
>  bool radeon_has_atpx(void);
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
