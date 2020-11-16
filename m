Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE52B51BD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730952AbgKPT67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgKPT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:58:59 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:58:58 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so451213wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bFL+h4NXuPoSuSMvtv0Sg7oT+u3rDrgDjKbEx0xnOLQ=;
        b=G1YxsTRfhadIWkJ35dpSnDqo9LWwhKdQaIcnejb5DfAD3AGyGCkiA1gGKURMrO+5Jc
         GMG7C/jJycfm1zeZSewyhBV51dcL1Ln42HJAv7J6WjUCtMQmx8ikqHHoe4aOj0+QqZv8
         UmfIV5B0BfgOXts130m9E3XKCBDHKqUojNvTpy3Y5maklWnKr9SkmjBYizAZAe9AsRx/
         Y5kBs3NKdH1H9tlgO8U6dAZ0PKLK2s1VaGUTpNkIyhqAjBTm05sjQ9tPQK/pYvmOr49a
         RZWZy8jBhwNSeSl3dYYnVb4579Im27sDjp+kEG8eZwNG4taQlchcH3Lt2R+BnVWprLc3
         8qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bFL+h4NXuPoSuSMvtv0Sg7oT+u3rDrgDjKbEx0xnOLQ=;
        b=Q2d5uATJk1KnH2VKK9pJ8Mw0XBEP6Zx/CzdJ+Xll5+MSfkUL4aSYVj3NFfuRbvbhpI
         JWBgxLlGAszr3r1B3sc/w4xEqYIh/y82psIqFQ8vETeyozAaMx4tVbLh4SwqwCqSRUBO
         VzukSF/ftDCBnSMCmRmuYKOui6J91vPJxkv/42YMKvCKahVRpvi7hw38rWfx+Xn+cynB
         YBbLqFIG4K7PxQ/7Wtk+v9wXf43UREbeq7SYxV1H0/1QqxLkY8o24hDeYbvdywd3ATVA
         DwOOu4UY2tLVPPrruw3kpE9Or5Zw7AurubApS3OmUyM0C5HaX2kuc8V2pk04FopLqryQ
         JR0Q==
X-Gm-Message-State: AOAM530qyIul9qijL8EFNgLtOhhRpD6UJNg7EkwwjFUKU3JfUWO4KV89
        Fjj4+Z4wwWyvZ/yhI8UvfzJDBmO3/ENxXqlVJBRNVqum
X-Google-Smtp-Source: ABdhPJwvYa7TiNdPz5rwvx37IifScNSPxNr4dkzrIRfYkQxxOqkKIIaP+wFQQNwGFK5z8itO4binMJvelPffV/FoIms=
X-Received: by 2002:a7b:c157:: with SMTP id z23mr570479wmi.70.1605556737507;
 Mon, 16 Nov 2020 11:58:57 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-17-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-17-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:58:46 -0500
Message-ID: <CADnq5_N_ip1nX7+QQckwAgrWox3emPj3TsCfgAMtEQVoG_BrWg@mail.gmail.com>
Subject: Re: [PATCH 16/43] drm/radeon/radeon_gem: Move 'radeon_gem_prime_*()'s
 prototypes to shared header
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

On Mon, Nov 16, 2020 at 12:37 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_prime.c:34:18: warning: no previous protot=
ype for =E2=80=98radeon_gem_prime_get_sg_table=E2=80=99 [-Wmissing-prototyp=
es]
>  34 | struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_objec=
t *obj)
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_prime.c:42:7: warning: no previous prototy=
pe for =E2=80=98radeon_gem_prime_vmap=E2=80=99 [-Wmissing-prototypes]
>  42 | void *radeon_gem_prime_vmap(struct drm_gem_object *obj)
>  | ^~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_prime.c:55:6: warning: no previous prototy=
pe for =E2=80=98radeon_gem_prime_vunmap=E2=80=99 [-Wmissing-prototypes]
>  55 | void radeon_gem_prime_vunmap(struct drm_gem_object *obj, void *vadd=
r)
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_prime.c:62:24: warning: no previous protot=
ype for =E2=80=98radeon_gem_prime_import_sg_table=E2=80=99 [-Wmissing-proto=
types]
>  62 | struct drm_gem_object *radeon_gem_prime_import_sg_table(struct drm_=
device *dev,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_prime.c:86:5: warning: no previous prototy=
pe for =E2=80=98radeon_gem_prime_pin=E2=80=99 [-Wmissing-prototypes]
>  86 | int radeon_gem_prime_pin(struct drm_gem_object *obj)
>  | ^~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_prime.c:104:6: warning: no previous protot=
ype for =E2=80=98radeon_gem_prime_unpin=E2=80=99 [-Wmissing-prototypes]
>  104 | void radeon_gem_prime_unpin(struct drm_gem_object *obj)
>  | ^~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/radeon_prime.c:120:17: warning: no previous proto=
type for =E2=80=98radeon_gem_prime_export=E2=80=99 [-Wmissing-prototypes]
>  120 | struct dma_buf *radeon_gem_prime_export(struct drm_gem_object *gob=
j,
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied with minor changes.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_gem.c   |  1 +
>  drivers/gpu/drm/radeon/radeon_prime.c |  1 +
>  drivers/gpu/drm/radeon/radeon_prime.h | 39 +++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
>  create mode 100644 drivers/gpu/drm/radeon/radeon_prime.h
>
> diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon=
/radeon_gem.c
> index d2876ce3bc9e2..b6b21d2e72624 100644
> --- a/drivers/gpu/drm/radeon/radeon_gem.c
> +++ b/drivers/gpu/drm/radeon/radeon_gem.c
> @@ -35,6 +35,7 @@
>  #include <drm/radeon_drm.h>
>
>  #include "radeon.h"
> +#include "radeon_prime.h"
>
>  struct dma_buf *radeon_gem_prime_export(struct drm_gem_object *gobj,
>                                         int flags);
> diff --git a/drivers/gpu/drm/radeon/radeon_prime.c b/drivers/gpu/drm/rade=
on/radeon_prime.c
> index 088d39a51c0d2..dd482edc819c5 100644
> --- a/drivers/gpu/drm/radeon/radeon_prime.c
> +++ b/drivers/gpu/drm/radeon/radeon_prime.c
> @@ -30,6 +30,7 @@
>  #include <drm/radeon_drm.h>
>
>  #include "radeon.h"
> +#include "radeon_prime.h"
>
>  struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *ob=
j)
>  {
> diff --git a/drivers/gpu/drm/radeon/radeon_prime.h b/drivers/gpu/drm/rade=
on/radeon_prime.h
> new file mode 100644
> index 0000000000000..11b7f80987834
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/radeon_prime.h
> @@ -0,0 +1,39 @@
> +/* radeon_prime.h -- Private header for radeon driver -*- linux-c -*-
> + *
> + * Copyright 1999 Precision Insight, Inc., Cedar Park, Texas.
> + * Copyright 2000 VA Linux Systems, Inc., Fremont, California.
> + * All rights reserved.
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
> + * The above copyright notice and this permission notice (including the =
next
> + * paragraph) shall be included in all copies or substantial portions of=
 the
> + * Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRE=
SS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILI=
TY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SH=
ALL
> + * PRECISION INSIGHT AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAG=
ES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR=
 OTHER
> + * DEALINGS IN THE SOFTWARE.
> + *
> + */
> +
> +#ifndef __RADEON_PRIME_H__
> +#define __RADEON_PRIME_H__
> +
> +struct dma_buf *radeon_gem_prime_export(struct drm_gem_object *gobj,
> +                                       int flags);
> +struct sg_table *radeon_gem_prime_get_sg_table(struct drm_gem_object *ob=
j);
> +int radeon_gem_prime_pin(struct drm_gem_object *obj);
> +void radeon_gem_prime_unpin(struct drm_gem_object *obj);
> +void *radeon_gem_prime_vmap(struct drm_gem_object *obj);
> +void radeon_gem_prime_vunmap(struct drm_gem_object *obj, void *vaddr);
> +
> +#endif                         /* __RADEON_PRIME_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
