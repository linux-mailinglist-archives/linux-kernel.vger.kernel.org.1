Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1152B1EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgKMPon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgKMPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:44:42 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC726C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:44:41 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so10376823wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dTXSjkwW66Qf03W7taCVtyE00/bGmzmTWZgHOS2++QU=;
        b=FIQrmXH5vYvjWClB6CYn+s0Y9tveyE5WNvjtPebaR6RRiPGQFTVoTmpOl+OoeiMnm8
         UGQ37EQ31z3tpJKoF7rWRJxPe3dlrYBB9bZVzBZOzEBPvLL6OmyuvC3aHeXvY/LW3sKO
         qnop85SORXHZoHyAI0KABsBjru/bOkcbm7CnLaesLfGLOXsDCAHMC8Jre9tk5I36AGH2
         q3n+U/sZIbFbX8Soz/u0chJvuQmH+9TvvtOYxGLuTW3ORmsrH7bFFXtS45Q+SHX+5GMD
         ZzMiIpOpEjz1v4ZgvhMQennl3hOckl3Rb2pkCsFM+tyuljoSOAOxXl4x8tueFOamwUr1
         2tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dTXSjkwW66Qf03W7taCVtyE00/bGmzmTWZgHOS2++QU=;
        b=h69+DflA3osAukrG0k9wTZojbd1kg8PvvYs7graDaPf32bido4lK5Rfe2GtMQbVUIT
         rQ9PVbL7fkppUpJe9B+b9RE7+acIL47DADNSKZ3SrUeG8E5YxZ4H5hV6Mm1K+CpI9RYs
         3j3XmGgk/3V3w9vPkM3DK0YaECceDeOJK9yW2TmrJWhE6LOEdklx5N1Vp39wiHMdVfw5
         TTFah+G335uIObbjYOqS2fcn6G5y1PvuGLMnCH/v6e037EA8hw9KL3HxXEVrLN0+qGJg
         k1ve0f5XTgJ8ydlMlHpkUtG01md5ijV9Uq5bUBLr3M5c0Rk9hg6t8iMS+LH7n2q7NNG3
         JiXQ==
X-Gm-Message-State: AOAM531NNNTvDqNsU9vCAJb/dv0XtjfKS4tMPgJOkgfsDmutJNlM1/Vh
        +lsQvTu+xf5kkL16MtiLJn5jSPIPQHFZyx5Ou+M=
X-Google-Smtp-Source: ABdhPJys9RSAV9H/vK2qjqM9/OnR02ua/1fz9p8mD+VHPtiz1Y1bdBgzsXWFtXC4sehX5U0aUIvvc3KfOQLUOwGELco=
X-Received: by 2002:adf:e350:: with SMTP id n16mr4389041wrj.419.1605282275657;
 Fri, 13 Nov 2020 07:44:35 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-5-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-5-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 10:44:24 -0500
Message-ID: <CADnq5_Na3t3wY4iTSbEE3zTLCOqo=F+3thOnHqXdPgDZkso0kw@mail.gmail.com>
Subject: Re: [PATCH 04/40] drm/amd/amdgpu/amdgpu_drv: Move 'amdgpu_info_ioctl()'s
 prototype to shared header
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

On Fri, Nov 13, 2020 at 8:49 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:486:5: warning: no previous prot=
otype for =E2=80=98amdgpu_info_ioctl=E2=80=99 [-Wmissing-prototypes]
>  486 | int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct d=
rm_file *filp)
>  | ^~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Luben already sent a patch to fix this one.  I'll be picking up that one.

Alex

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h | 31 +++++++++++++++++++++++++
>  3 files changed, 33 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 1dfea15bbec36..afd357df0f886 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -43,7 +43,7 @@
>  #include "amdgpu_sched.h"
>
>  #include "amdgpu_amdkfd.h"
> -
> +#include "amdgpu_kms.h"
>  #include "amdgpu_ras.h"
>
>  /*
> @@ -1521,8 +1521,6 @@ int amdgpu_file_to_fpriv(struct file *filp, struct =
amdgpu_fpriv **fpriv)
>         return 0;
>  }
>
> -int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_fil=
e *filp);
> -
>  const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D {
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_CREATE, amdgpu_gem_create_ioctl, DRM=
_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_CTX, amdgpu_ctx_ioctl, DRM_AUTH|DRM_REND=
ER_ALLOW),
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.c
> index 98721ae931841..54c4ee6d230d8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -41,6 +41,7 @@
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gem.h"
>  #include "amdgpu_display.h"
> +#include "amdgpu_kms.h"
>  #include "amdgpu_ras.h"
>
>  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_kms.h
> new file mode 100644
> index 0000000000000..f3111aef76cae
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h
> @@ -0,0 +1,31 @@
> +/* amdgpu_kms.h -- Private header for radeon driver -*- linux-c -*-
> + *
> + * Copyright 2008 Advanced Micro Devices, Inc.
> + * Copyright 2008 Red Hat Inc.
> + * Copyright 2009 Jerome Glisse.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES=
 OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +#ifndef __AMDGPU_KMS_H__
> +#define __AMDGPU_KMS_H__
> +
> +int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_fil=
e *filp);
> +
> +#endif                         /* __AMDGPU_KMS_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
