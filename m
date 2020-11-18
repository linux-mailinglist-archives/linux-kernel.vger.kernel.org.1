Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB5B2B7B35
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgKRKYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgKRKYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:24:24 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1620BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 02:24:23 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 23so3817184wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 02:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RizomVxi/SqVipgoUDsBcF8oqMw4CmvO41It6Vysev4=;
        b=Eu+S5WEquExviHKpbRKTLZ/f/t4cXK+yhc23ZUjnMGdIj//YeWCuaqVCr64NKFaj2h
         k8kAmFv/x/wC9QYlu2EknIsbi8gyJqbzbMtmVIdWfKC3BtXBhwpim8hZKN91u0is4adL
         cbRNuGT6JYQvNVxdBrQ3KhOCoCuT+PVDWQkZfJ3irEWQrwrJCbZTv1DBRp/3p6YzGQEM
         /cCPnJE1jGUTNxG7tQ4OblnnnOFaB7Dk9K+KDDbU1mDqZi8Hq8LfvLySWkAxMamP8AnH
         76wL4FBzlYI+3/50+x+XnZIsngF6MYXNcWNZxMqOsViCsYrFAsbD96XJnelbyuoSyYsf
         Gq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RizomVxi/SqVipgoUDsBcF8oqMw4CmvO41It6Vysev4=;
        b=T8cjmimKkmH7B6AeReh92wNw59UAcgRNy6FaOig1KlwNOH7t5RbGwEAbe7NvPEAgwB
         11lzjtcEx2DDiDMkULIFZFJj/tbalAofPBJrgfy9X34vBMCX0tgOiB6R+wDYVqcpuRyS
         EdPyXJb1s73UFWoU4jS8z44QcJO42AdZrtzOcybZ3dNdhagg8TuuTagswt/U7jKj/YWP
         YZNVM9AR4cL37APMLGl+0QsWyOkqvVhAw8Wb4cN3eRo7iLgJvBn5rqnaax42XiG7D+a+
         S0KeyYoFSgo3149h7VatZjDB3z3Fg53W8zHwfyVi5pHVCYKn7j/DljrSmmpg9s1JElWi
         B2Ow==
X-Gm-Message-State: AOAM532wpnMFZ/rBA/n/oWV+D9Q2IUj/sG/9vCO51uFUm/ErI2PYTH6W
        wILlJ04+rkbxFBPdfpOHLty/zA==
X-Google-Smtp-Source: ABdhPJyE7zy64ZZNtttMQhyiHbNnKxsTEugVrbehjVT8/VRtqPZyO9Fl5c1YsqbQJuoeUGxFx5kteg==
X-Received: by 2002:a1c:2583:: with SMTP id l125mr3618352wml.50.1605695061834;
        Wed, 18 Nov 2020 02:24:21 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id w17sm8412544wru.82.2020.11.18.02.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 02:24:21 -0800 (PST)
Date:   Wed, 18 Nov 2020 10:24:19 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 04/40] drm/amd/amdgpu/amdgpu_drv: Move
 'amdgpu_info_ioctl()'s prototype to shared header
Message-ID: <20201118102419.GR1869941@dell>
References: <20201113134938.4004947-1-lee.jones@linaro.org>
 <20201113134938.4004947-5-lee.jones@linaro.org>
 <CADnq5_Na3t3wY4iTSbEE3zTLCOqo=F+3thOnHqXdPgDZkso0kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Na3t3wY4iTSbEE3zTLCOqo=F+3thOnHqXdPgDZkso0kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Nov 2020, Alex Deucher wrote:

> On Fri, Nov 13, 2020 at 8:49 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c:486:5: warning: no previous prototype for ‘amdgpu_info_ioctl’ [-Wmissing-prototypes]
> >  486 | int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
> >  | ^~~~~~~~~~~~~~~~~
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Luben already sent a patch to fix this one.  I'll be picking up that one.

FYI: Looks like this is still broken in today's -next.

> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  4 +---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  1 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h | 31 +++++++++++++++++++++++++
> >  3 files changed, 33 insertions(+), 3 deletions(-)
> >  create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > index 1dfea15bbec36..afd357df0f886 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> > @@ -43,7 +43,7 @@
> >  #include "amdgpu_sched.h"
> >
> >  #include "amdgpu_amdkfd.h"
> > -
> > +#include "amdgpu_kms.h"
> >  #include "amdgpu_ras.h"
> >
> >  /*
> > @@ -1521,8 +1521,6 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
> >         return 0;
> >  }
> >
> > -int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> > -
> >  const struct drm_ioctl_desc amdgpu_ioctls_kms[] = {
> >         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_CREATE, amdgpu_gem_create_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> >         DRM_IOCTL_DEF_DRV(AMDGPU_CTX, amdgpu_ctx_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > index 98721ae931841..54c4ee6d230d8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> > @@ -41,6 +41,7 @@
> >  #include "amdgpu_amdkfd.h"
> >  #include "amdgpu_gem.h"
> >  #include "amdgpu_display.h"
> > +#include "amdgpu_kms.h"
> >  #include "amdgpu_ras.h"
> >
> >  void amdgpu_unregister_gpu_instance(struct amdgpu_device *adev)
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h
> > new file mode 100644
> > index 0000000000000..f3111aef76cae
> > --- /dev/null
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.h
> > @@ -0,0 +1,31 @@
> > +/* amdgpu_kms.h -- Private header for radeon driver -*- linux-c -*-
> > + *
> > + * Copyright 2008 Advanced Micro Devices, Inc.
> > + * Copyright 2008 Red Hat Inc.
> > + * Copyright 2009 Jerome Glisse.
> > + *
> > + * Permission is hereby granted, free of charge, to any person obtaining a
> > + * copy of this software and associated documentation files (the "Software"),
> > + * to deal in the Software without restriction, including without limitation
> > + * the rights to use, copy, modify, merge, publish, distribute, sublicense,
> > + * and/or sell copies of the Software, and to permit persons to whom the
> > + * Software is furnished to do so, subject to the following conditions:
> > + *
> > + * The above copyright notice and this permission notice shall be included in
> > + * all copies or substantial portions of the Software.
> > + *
> > + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> > + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> > + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
> > + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
> > + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> > + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> > + * OTHER DEALINGS IN THE SOFTWARE.
> > + */
> > +
> > +#ifndef __AMDGPU_KMS_H__
> > +#define __AMDGPU_KMS_H__
> > +
> > +int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
> > +
> > +#endif                         /* __AMDGPU_KMS_H__ */
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
