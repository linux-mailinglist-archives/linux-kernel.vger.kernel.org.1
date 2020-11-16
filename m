Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A683B2B525D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732254AbgKPUU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgKPUU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:20:57 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47D8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:20:57 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id r17so20249172wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NktH7Z54pEU5BvQhLkdETJG3SnKmMNuAIzk3OHG5KlE=;
        b=pbiobcevGF9sFk5btvIswim0/5GASvSokBSAuq6xLyWSMTsbj+jIWfgrOaSp6PeStH
         UVMFnnpupm01eyG088X0P/KAcbaS/ejNkqzFiw+r1r2AXCv8xjQF1BLaFKf2Ujhj2AgU
         yWJqQNo6nq5MtF083N2DUK2UPvK7zs2lDiz9bMCHyWvZz0v5tYdo+u7v/994S0KkHbow
         HXVGKQYma2gYl58v5BlUzv7zfBjYnmQjNozOEsOhmOglTSDCOPsZdboABDFSCQCHJpNL
         qHC1xDaO6IqxHdu7Q51i1JA6HXNz7d0ZzuZr9sQPbm1kTIhmNW4V8YNGaPCmvN9kVO3k
         lDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NktH7Z54pEU5BvQhLkdETJG3SnKmMNuAIzk3OHG5KlE=;
        b=S3WsfC1bPe+ctSVoQEKv6mdikD4qNI55z5jtkeIiaW+tgKcy7NDd3kK6wzA/ynnFTR
         rjaqFyVd+lNwPcZTlKZJ/cRT+A+jESgdaullN1sWD80+EqjbCEYUO9+Ed5osaXmeEo6l
         P13vEYA44l+s+B8km16XT5P4taRkKb6Lhn+2cEHvgP3gJE1KHrgjxyTrQPqoKJMXBGQu
         DuxxBBn2sWEccmKN3yLMyqgKB21acw2F32dyCC5WQh9BbGSf5IHtcaBWRfVjZemW8nqJ
         IFU1eAbQClnyK5bu1KPhH1+73pXmw5XNcM1l8shjoIJiJUr1tvVFV0PICENG880P3dvL
         DNpA==
X-Gm-Message-State: AOAM531SuqsZaXVEqEYW2WH5jm+wu8JxApnbVWo/ug0ptOECo8lBEqd3
        5J0sFUhqpEonQJgmpXkYEoXjDQ4tpzqRiYzX9lPE0caG
X-Google-Smtp-Source: ABdhPJwG/0W9HleQrUvotIm+i7WOV+4+i795t6wQ5NhJgGafSov+skWSGFjW2Q9MBy3QSMUskHH4OyeeRWTiliX0aq8=
X-Received: by 2002:adf:9144:: with SMTP id j62mr4543129wrj.419.1605558056462;
 Mon, 16 Nov 2020 12:20:56 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-28-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-28-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:20:45 -0500
Message-ID: <CADnq5_NqdwT8SGbZCVMFY7kp=rT12ux-EzNPipuVVzVw8vtofQ@mail.gmail.com>
Subject: Re: [PATCH 27/43] drm/radeon/radeon_encoders: Move
 'radeon_atom_backlight_init's prototype to shared header
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
>  drivers/gpu/drm/radeon/atombios_encoders.c:186:6: warning: no previous p=
rototype for =E2=80=98radeon_atom_backlight_init=E2=80=99 [-Wmissing-protot=
ypes]
>  186 | void radeon_atom_backlight_init(struct radeon_encoder *radeon_enco=
der,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/radeon_atombios.h | 4 ++++
>  drivers/gpu/drm/radeon/radeon_encoders.c | 6 +-----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.h b/drivers/gpu/drm/r=
adeon/radeon_atombios.h
> index a895a7002c3d3..fd03755e6fa2c 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.h
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.h
> @@ -28,14 +28,18 @@
>  #ifndef __RADEON_ATOMBIOS_H__
>  #define __RADEON_ATOMBIOS_H__
>
> +struct drm_connector;
>  struct drm_device;
>  struct drm_display_mode;
>  struct radeon_device;
> +struct radeon_encoder;
>
>  bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
>                                 struct drm_display_mode *mode);
>  void radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_en=
um,
>                              uint32_t supported_device, u16 caps);
> +void radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
> +                               struct drm_connector *drm_connector);
>
>
>  #endif                         /* __RADEON_ATOMBIOS_H__ */
> diff --git a/drivers/gpu/drm/radeon/radeon_encoders.c b/drivers/gpu/drm/r=
adeon/radeon_encoders.c
> index b60a373d3ead3..46549d5179ee9 100644
> --- a/drivers/gpu/drm/radeon/radeon_encoders.c
> +++ b/drivers/gpu/drm/radeon/radeon_encoders.c
> @@ -31,14 +31,10 @@
>  #include <drm/radeon_drm.h>
>
>  #include "radeon.h"
> +#include "radeon_atombios.h"
>  #include "radeon_legacy_encoders.h"
>  #include "atom.h"
>
> -extern void
> -radeon_atom_backlight_init(struct radeon_encoder *radeon_encoder,
> -                          struct drm_connector *drm_connector);
> -
> -
>  static uint32_t radeon_encoder_clones(struct drm_encoder *encoder)
>  {
>         struct drm_device *dev =3D encoder->dev;
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
