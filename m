Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5E2B519C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgKPTwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKPTwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:52:06 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68639C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:52:05 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id a65so451300wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wq29JeznquOyMiGvYv3bv2rp5DdAOeORT9zJBFrcDzc=;
        b=h4UHeYWxxgV39h+GY6It7+5vDavyNtIH/Tf3nWBMfQJoX9kjZv4ZMfLujxIFDE9sFl
         RLwBGhj7rWayHSZHqH23Twl51t6FTHqSCWCEyDbdQiQ79Lm7tVAGqhilZSdIHPH4mFUF
         FMB9B7KFZsEa+g4Xo452UaNSovPYrJor+KwQgSsKwVnjqfCZ8tSgPxhtZfGhE4hESllc
         +uDoThQ7W2+vIvxGblYChCjxw35MTVt3u0uH/GTfdvmvMglh1WKu2CsjpShtTjf9L1lc
         d02zeJtLBnisokfSfkP8FratED2MnRTlk5h+47lRGp18houuio/QXgTX0LtEYCVM2+/5
         JmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wq29JeznquOyMiGvYv3bv2rp5DdAOeORT9zJBFrcDzc=;
        b=EYHUkjudAXN6nwp3lsVPZ8hES84PM6VV6Wa8wbj8CAm3ZdF2FYrVdmAI8akx76Fc+P
         mPhNYbWPyYK97j7yc21Dmb5GF2cwtGXT/qiNrJdgXfG3b59+elXwyY3xD+UoTJANXiAC
         hOrH7K1Yp9jJ+tgdSiYrL/CGhW3TTv1B7YNjgrwQWDKfCdoBgwo8GV6Vk1Z+XupwqnM5
         Dj9Ln9JrG6vQP9jgKj25C1ePUJHtoT6eYUUH6zp2hz9yTskw5hIsjo+LcY9SaVsWtp7A
         t9Ja2ue792HYZlvQHIjEL7itcet9C7a/2o5POT6EVC7L2YTo2l1p2ThXDXJRLQl7ivCV
         c8lA==
X-Gm-Message-State: AOAM532WbbA5oBwPIYHwGU9d0QHykdW0GMaQSA4OsMzU6FFl16GhiKXd
        636DmYPvxNL8zwt6ct37utCnt1fd7ikD1BWE6SU=
X-Google-Smtp-Source: ABdhPJw3tjYa83/wDbt2LS1fpb/1ZTFVzVcFetg5Q3cXdirmWmVFjH+Iw4aXSbXGrXQS8TVlZstodoUlIS4q3iDeZ7s=
X-Received: by 2002:a7b:c015:: with SMTP id c21mr526817wmb.79.1605556324212;
 Mon, 16 Nov 2020 11:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-14-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-14-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:51:53 -0500
Message-ID: <CADnq5_OMb3ZEUzUUJy1_joxQGCcuALGLW+E-EXPAPFhUP9h95A@mail.gmail.com>
Subject: Re: [PATCH 13/43] drm/radeon/radeon_drv: Move 'radeon_mmap()'s
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

On Mon, Nov 16, 2020 at 12:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_ttm.c:931:5: warning: no previous prototyp=
e for =E2=80=98radeon_mmap=E2=80=99 [-Wmissing-prototypes]
>  931 | int radeon_mmap(struct file *filp, struct vm_area_struct *vma)
>  | ^~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/radeon_ttm.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon=
/radeon_drv.c
> index 536b246b9a6aa..2b9deaead99b2 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -51,6 +51,7 @@
>  #include <drm/radeon_drm.h>
>
>  #include "radeon_drv.h"
> +#include "radeon_ttm.h"
>  #include "radeon.h"
>  #include "radeon_device.h"
>
> @@ -125,7 +126,6 @@ extern int radeon_get_crtc_scanoutpos(struct drm_devi=
ce *dev, unsigned int crtc,
>                                       ktime_t *stime, ktime_t *etime,
>                                       const struct drm_display_mode *mode=
);
>  extern bool radeon_is_px(struct drm_device *dev);
> -int radeon_mmap(struct file *filp, struct vm_area_struct *vma);
>  int radeon_mode_dumb_mmap(struct drm_file *filp,
>                           struct drm_device *dev,
>                           uint32_t handle, uint64_t *offset_p);
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.h b/drivers/gpu/drm/radeon=
/radeon_ttm.h
> index 91ea7141bc812..4d7b90ee27740 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.h
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.h
> @@ -32,5 +32,6 @@ struct radeon_device;
>
>  int radeon_ttm_init(struct radeon_device *rdev);
>  void radeon_ttm_fini(struct radeon_device *rdev);
> +int radeon_mmap(struct file *filp, struct vm_area_struct *vma);
>
>  #endif                         /* __RADEON_TTM_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
