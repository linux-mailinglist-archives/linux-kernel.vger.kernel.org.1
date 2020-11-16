Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F122B5337
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgKPUuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKPUuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:50:18 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D721C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:50:17 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so20257519wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+p+lwTAkx0WkxKPZ4xVckDZCPwAFxnOPzsImUi2cyA=;
        b=GUGSBhgLZOtfL7rQYotQSp6ZL/vNWyg8KehLOStBKNbuGO/dmM4FIk77geFIddKKvd
         hGBs5gSjUtjGn6Qw+pRAQnfcXgs3kqH2CvwFamtuwrAdSa24sy3TONWME4QfZgs/y/M2
         wPagNgwv6qhjOD9mFu5TWSoeg2YMqVZq9xV4O8EVKQwRrKkVVzim/FqCQHz5gMw8ySzk
         G8NffHdg/f2O0ekrXOP9GsmQFdre6/7aqlvk+4eSbbpEJb0N5BxaoFk9K8QVOBPmJbr+
         f1vjp+hibBADcSzqP/FuJsmiLuGYmiAtQ6D1iXCdKCu/DhzM48WzK6xtpyAYbzq0mXcr
         B9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+p+lwTAkx0WkxKPZ4xVckDZCPwAFxnOPzsImUi2cyA=;
        b=oiE55MYKp0Qo85m6Ti264UL33NIiXJFLnpQVep5QPO8L9gGh0mZUDwM+d3I/bIHKEO
         zlBaOskTafcA2DvoQHp8sTLFaZr3yObxqHE1tDIvf03DY8+V0cxs1P/KC4Pv0kWOEaLn
         akdy/lfs9hX71nGt4O3Xrhco239gBbMVjlxrC05UZ0qlui3Me89aMDvfSv86bBRv1SJA
         5Sl1WvM22kwcHmyDKGOAq4QVN0G8lUA655T/Xm3rDxwLghnafISzhZmyPwWfv2bp0hAe
         gGq0v9duMlWonGqPxc8oB7pN2jOMD8A0RGPeELtWQZ763GGMep9Is7HGuI51BBk46glv
         Hz2w==
X-Gm-Message-State: AOAM530PdqLXbPSvsR8UmokoHe86IBFNTwjex/c+NMMgiGbu+g8+R1m5
        +qsm1eCWgjTcmZxvtCmiHNfH+ZCiXSza8jQod9PLt3cp
X-Google-Smtp-Source: ABdhPJxwnuvWeaJotgk7P7QCmD0P5Avbs5HEAHeBcaRXxSdZpoy3y5G0ow1/CdAi0vXkticNqq2Y70MbrvPjFOxooX0=
X-Received: by 2002:adf:9144:: with SMTP id j62mr4657270wrj.419.1605559816179;
 Mon, 16 Nov 2020 12:50:16 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-44-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-44-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:50:05 -0500
Message-ID: <CADnq5_M64-_VQKUmBCusCreZgPAoyW8-oM3S+Hf66iH151c2GQ@mail.gmail.com>
Subject: Re: [PATCH 43/43] drm/radeon/radeon_drv: Move 'radeon_gem_prime_import_sg_table()'s
 prototype to shared header
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

On Mon, Nov 16, 2020 at 12:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_prime.c:43:24: warning: no previous protot=
ype for =E2=80=98radeon_gem_prime_import_sg_table=E2=80=99 [-Wmissing-proto=
types]
>  43 | struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_=
device *dev,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/radeon_drv.c   | 4 +---
>  drivers/gpu/drm/radeon/radeon_prime.h | 3 +++
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index 211932d73b191..7a0989b397da1 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -55,6 +55,7 @@
>  #include "radeon_ttm.h"
>  #include "radeon.h"
>  #include "radeon_device.h"
> +#include "radeon_prime.h"
>
>  /*
>   * KMS wrapper.
> @@ -129,9 +130,6 @@ int radeon_mode_dumb_mmap(struct drm_file *filp,
>  int radeon_mode_dumb_create(struct drm_file *file_priv,
>                             struct drm_device *dev,
>                             struct drm_mode_create_dumb *args);
> -struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_devic=
e *dev,
> -                                                       struct dma_buf_at=
tachment *,
> -                                                       struct sg_table *=
sg);
>
>  /* atpx handler */
>  #if defined(CONFIG_VGA_SWITCHEROO)
> diff --git a/drivers/gpu/drm/radeon/radeon_prime.h b/drivers/gpu/drm/rade=
on/radeon_prime.h
> index 11b7f80987834..24ddfd4b48a6d 100644
> --- a/drivers/gpu/drm/radeon/radeon_prime.h
> +++ b/drivers/gpu/drm/radeon/radeon_prime.h
> @@ -35,5 +35,8 @@ int radeon_gem_prime_pin(struct drm_gem_object *obj);
>  void radeon_gem_prime_unpin(struct drm_gem_object *obj);
>  void *radeon_gem_prime_vmap(struct drm_gem_object *obj);
>  void radeon_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
> +struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_devic=
e *dev,
> +                                                       struct dma_buf_at=
tachment *,
> +                                                       struct sg_table *=
sg);
>
>  #endif                         /* __RADEON_PRIME_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
