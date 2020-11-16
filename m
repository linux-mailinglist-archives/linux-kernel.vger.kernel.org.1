Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6902B51A8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbgKPTzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKPTzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:55:31 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199DC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:55:31 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id b6so20137067wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ieMDkwhFMRgQMoG4LON5xMpvolWPw85UMs/kp/BTl1k=;
        b=uOXnOVeez3L/RdM0gIcy6HQVxXkHEXXp8FCpwi1sH96FYO/qa/9+ZqcPYORn6BUNB0
         QFczzJTVavBW8aZAZxbUAJDm1p0jE308vWCCX8jhwnvksl9Qba9sRF2Q7Z0g8XffOwfN
         juZAnre+5YTl+MR7H6ypmPVHLIYNfkp5TedoywpqNEHnz+mhCzJJs9ePf+ZGl5rqctui
         RyHXxs/q2jIoE8VYKQ0maeeLN8Q279/ks7nJXdwzD2ddmXrL2NM6pswver1Q02Pzi+ma
         vloE98JIO+K+rS/eqBbBgfFAwWdcpvUvJIC7/epHsXRQkYI9VO16CTsaWi1RBbBJ4PMQ
         HiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ieMDkwhFMRgQMoG4LON5xMpvolWPw85UMs/kp/BTl1k=;
        b=rdu20ygt48tU5+XZlV3lLYVqEbFsixDSXjKQcKJNbZNCVLHldCIHVhVnjMp/NXlFS9
         QK5NpvRHa7EPwQHGIWwp0+17Hj1w1m2GxkuGXucOgQb0g8VIwxNWp2jYfopLbPOOqSdl
         puBe8RFI0rfMr7nuAOHmbVEsRlq8uM6RDulLbRDndCJPYSWTnHuA7nA/FSZBDu/opjR3
         SS6vIRArbSgyx+LdpZr+3jt+LDb/8qhHNhp1C0YKaL7Vtnru7w4HwuFgnh8BfJ9X+r1y
         P9cLhFf0I6JpKjp+a4k5ZeT0c2fh6mWkEbeB0uZIWLUZwGh+Oh2QOQ8jpv01hduDFmPU
         R8ZA==
X-Gm-Message-State: AOAM530yqtW0PT0vU0T6Tp2SZVKmUknetNfsUXoAow20wY6f8I+1dzkk
        RKqlhwN+yvxguH/yA2/agoUQtwOB9rihfSbF/Kr3f9Ve
X-Google-Smtp-Source: ABdhPJyUE0BkITc5mwt6PskNgmLMpO3EECXLt2iiCsIl5RJ5OurJCyTEQan8bOLvP9FKrMgIzsu0uXKl2WAaDTd6sXw=
X-Received: by 2002:adf:e551:: with SMTP id z17mr21494266wrm.374.1605556530272;
 Mon, 16 Nov 2020 11:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-15-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-15-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:55:19 -0500
Message-ID: <CADnq5_P1Sv9OPMkpPR_Vm_UjWTZpgWdUXrNBqQC1+6wNyXuxBA@mail.gmail.com>
Subject: Re: [PATCH 14/43] drm/radeon/radeon_drv: Move 'radeon_driver_irq_handler_kms's
 prototype into shared header
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

On Mon, Nov 16, 2020 at 12:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_irq_kms.c:53:13: warning: no previous prot=
otype for =E2=80=98radeon_driver_irq_handler_kms=E2=80=99 [-Wmissing-protot=
ypes]
>  53 | irqreturn_t radeon_driver_irq_handler_kms(int irq, void *arg)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_irq_kms.c:120:6: warning: no previous prot=
otype for =E2=80=98radeon_driver_irq_preinstall_kms=E2=80=99 [-Wmissing-pro=
totypes]
>  120 | void radeon_driver_irq_preinstall_kms(struct drm_device *dev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_irq_kms.c:152:5: warning: no previous prot=
otype for =E2=80=98radeon_driver_irq_postinstall_kms=E2=80=99 [-Wmissing-pr=
ototypes]
>  152 | int radeon_driver_irq_postinstall_kms(struct drm_device *dev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_irq_kms.c:171:6: warning: no previous prot=
otype for =E2=80=98radeon_driver_irq_uninstall_kms=E2=80=99 [-Wmissing-prot=
otypes]
>  171 | void radeon_driver_irq_uninstall_kms(struct drm_device *dev)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/radeon_drv.c     | 5 +----
>  drivers/gpu/drm/radeon/radeon_irq_kms.c | 1 +
>  drivers/gpu/drm/radeon/radeon_kms.h     | 5 +++++
>  3 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index 2b9deaead99b2..211932d73b191 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -51,6 +51,7 @@
>  #include <drm/radeon_drm.h>
>
>  #include "radeon_drv.h"
> +#include "radeon_kms.h"
>  #include "radeon_ttm.h"
>  #include "radeon.h"
>  #include "radeon_device.h"
> @@ -117,10 +118,6 @@
>  int radeon_suspend_kms(struct drm_device *dev, bool suspend,
>                        bool fbcon, bool freeze);
>  int radeon_resume_kms(struct drm_device *dev, bool resume, bool fbcon);
> -void radeon_driver_irq_preinstall_kms(struct drm_device *dev);
> -int radeon_driver_irq_postinstall_kms(struct drm_device *dev);
> -void radeon_driver_irq_uninstall_kms(struct drm_device *dev);
> -irqreturn_t radeon_driver_irq_handler_kms(int irq, void *arg);
>  extern int radeon_get_crtc_scanoutpos(struct drm_device *dev, unsigned i=
nt crtc,
>                                       unsigned int flags, int *vpos, int =
*hpos,
>                                       ktime_t *stime, ktime_t *etime,
> diff --git a/drivers/gpu/drm/radeon/radeon_irq_kms.c b/drivers/gpu/drm/ra=
deon/radeon_irq_kms.c
> index a242b6053d47e..b8b7f627f0a9c 100644
> --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> @@ -38,6 +38,7 @@
>
>  #include "atom.h"
>  #include "radeon.h"
> +#include "radeon_kms.h"
>  #include "radeon_reg.h"
>
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.h b/drivers/gpu/drm/radeon=
/radeon_kms.h
> index 36e73cea92154..913c8239d5d8d 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.h
> +++ b/drivers/gpu/drm/radeon/radeon_kms.h
> @@ -32,4 +32,9 @@ u32 radeon_get_vblank_counter_kms(struct drm_crtc *crtc=
);
>  int radeon_enable_vblank_kms(struct drm_crtc *crtc);
>  void radeon_disable_vblank_kms(struct drm_crtc *crtc);
>
> +irqreturn_t radeon_driver_irq_handler_kms(int irq, void *arg);
> +void radeon_driver_irq_preinstall_kms(struct drm_device *dev);
> +int radeon_driver_irq_postinstall_kms(struct drm_device *dev);
> +void radeon_driver_irq_uninstall_kms(struct drm_device *dev);
> +
>  #endif                         /* __RADEON_KMS_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
