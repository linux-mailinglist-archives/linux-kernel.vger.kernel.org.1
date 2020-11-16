Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EB72B5290
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732709AbgKPU3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730751AbgKPU3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:29:48 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED9AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:29:47 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id d12so20201333wrr.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WjF0+3gggL3CRxV+lz0GaLX559AxZaaqnyIMuQIwREE=;
        b=bYXFWC3hH+d2d7yRzU5tLQyCVVPymSrP9ZSuF0XEwrJ/DNRRg51hGeqoM41J1wPFhw
         FFrg9c6G6dEtFl0ivkDFOrF5M8R5OD1HQj9IllXKYNjM4x4razcDIswDwX5P2Fb7rLGp
         jJNor2Bt3Umj6Y6XHwvoLlCiKWpZ8441n5Iy/T/Sp/WTRcFnEpD8XIfajsh9+tp7aGnd
         sjDvSnxSiJznfIeDCbobfRsdmDcPfvT1QemTlzn+VuftEYpRFgLL84sLu4pQedfNbYUr
         LXipuL91qOyednqyW04B4LfbP4HlAH0tkT1E45P83fn3IP3hRfD9bmI987b4PI95w+Dg
         ca0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WjF0+3gggL3CRxV+lz0GaLX559AxZaaqnyIMuQIwREE=;
        b=LYqfrKP3B5sCAHSlTA0cvFVt/HuLkBW5MVkX5Jzq4XHsH6BAp9ri5NnOoposZKeAYT
         BDEA04vB4eVf72a7GS0SUqmRsf2U/DO+j0cyR6MrJ/Wuo0A2OqQk2zDfFX0ab/Cf8jX7
         2H0hLlRy40SqnaDJ3gRBr8kv1fihkW0sGbtsbqHz9FLQzGgdHhFwp1Pp2OVtIXYgmWk7
         v5mtyaKJR+Lab2KK2H8gnoWjun0NQkr7CR5rDn/9BbIbPvF0EXmFRgLg9/DnhNaZamfB
         aAK3s7Mc4hmr2hzKeXT9pCsAx+qjCo4XR5SDrg9FvHKIqSj10K+kt/Iu2p5Q+7+gPQDE
         sVyg==
X-Gm-Message-State: AOAM533lnF5ZAlRsH5vpp5CiYXK/Q+A31bIQ8dUwKNIJXwP2cEwnszwL
        JYgPqGQ5BUjRJWV3VhfflK443qAyZOfhAqWWc9A=
X-Google-Smtp-Source: ABdhPJy8gBCWoU/Com+s5wvBzSh2jbLDI7rBdHZHku93qeTcALOACefXO+a/MvKxLU+4yDX+j9DQ6RqdI+7VTsoCJ/M=
X-Received: by 2002:adf:e551:: with SMTP id z17mr21629520wrm.374.1605558586689;
 Mon, 16 Nov 2020 12:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-34-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-34-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:29:35 -0500
Message-ID: <CADnq5_MkvKNMxPJ8Z=mawLY-Bq5KLb_n+QviWwhdvK+qZbXUoQ@mail.gmail.com>
Subject: Re: [PATCH 33/43] drm/radeon/radeon_audio: Move 'dce6_*()'s
 prototypes to shared header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     David Airlie <airlied@linux.ie>,
        Slava Grigorev <slava.grigorev@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
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
>  drivers/gpu/drm/radeon/dce6_afmt.c:32:5: warning: no previous prototype =
for =E2=80=98dce6_endpoint_rreg=E2=80=99 [-Wmissing-prototypes]
>  32 | u32 dce6_endpoint_rreg(struct radeon_device *rdev,
>  | ^~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce6_afmt.c:46:6: warning: no previous prototype =
for =E2=80=98dce6_endpoint_wreg=E2=80=99 [-Wmissing-prototypes]
>  46 | void dce6_endpoint_wreg(struct radeon_device *rdev,
>  | ^~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce6_afmt.c:110:6: warning: no previous prototype=
 for =E2=80=98dce6_afmt_select_pin=E2=80=99 [-Wmissing-prototypes]
>  110 | void dce6_afmt_select_pin(struct drm_encoder *encoder)
>  | ^~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce6_afmt.c:123:6: warning: no previous prototype=
 for =E2=80=98dce6_afmt_write_latency_fields=E2=80=99 [-Wmissing-prototypes=
]
>  123 | void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce6_afmt.c:152:6: warning: no previous prototype=
 for =E2=80=98dce6_afmt_hdmi_write_speaker_allocation=E2=80=99 [-Wmissing-p=
rototypes]
>  152 | void dce6_afmt_hdmi_write_speaker_allocation(struct drm_encoder *e=
ncoder,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce6_afmt.c:177:6: warning: no previous prototype=
 for =E2=80=98dce6_afmt_dp_write_speaker_allocation=E2=80=99 [-Wmissing-pro=
totypes]
>  177 | void dce6_afmt_dp_write_speaker_allocation(struct drm_encoder *enc=
oder,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce6_afmt.c:202:6: warning: no previous prototype=
 for =E2=80=98dce6_afmt_write_sad_regs=E2=80=99 [-Wmissing-prototypes]
>  202 | void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce6_afmt.c:268:6: warning: no previous prototype=
 for =E2=80=98dce6_hdmi_audio_set_dto=E2=80=99 [-Wmissing-prototypes]
>  268 | void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce6_afmt.c:287:6: warning: no previous prototype=
 for =E2=80=98dce6_dp_audio_set_dto=E2=80=99 [-Wmissing-prototypes]
>  287 | void dce6_dp_audio_set_dto(struct radeo_device *rdev,
>  | ^~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Slava Grigorev <slava.grigorev@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/radeon/dce6_afmt.c    |  1 +
>  drivers/gpu/drm/radeon/dce6_afmt.h    | 52 +++++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/radeon_audio.c | 17 +--------
>  3 files changed, 54 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/gpu/drm/radeon/dce6_afmt.h
>
> diff --git a/drivers/gpu/drm/radeon/dce6_afmt.c b/drivers/gpu/drm/radeon/=
dce6_afmt.c
> index eec5d7a627388..4a1d5447eac17 100644
> --- a/drivers/gpu/drm/radeon/dce6_afmt.c
> +++ b/drivers/gpu/drm/radeon/dce6_afmt.c
> @@ -22,6 +22,7 @@
>   */
>  #include <linux/hdmi.h>
>
> +#include "dce6_afmt.h"
>  #include "radeon.h"
>  #include "radeon_audio.h"
>  #include "sid.h"
> diff --git a/drivers/gpu/drm/radeon/dce6_afmt.h b/drivers/gpu/drm/radeon/=
dce6_afmt.h
> new file mode 100644
> index 0000000000000..176a538664a27
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/dce6_afmt.h
> @@ -0,0 +1,52 @@
> +/* dce6_afmt.h -- Private header for radeon driver -*- linux-c -*-
> + *
> + * Copyright 2013 Advanced Micro Devices, Inc.
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
> + *
> + */
> +
> +#ifndef __DCE6_AFMT_H__
> +#define __DCE6_AFMT_H__
> +
> +struct cea_sad;
> +struct drm_connector;
> +struct drm_display_mode;
> +struct drm_encoder;
> +struct radeon_crtc;
> +struct radeon_device;
> +
> +u32 dce6_endpoint_rreg(struct radeon_device *rdev, u32 offset, u32 reg);
> +void dce6_endpoint_wreg(struct radeon_device *rdev, u32 offset, u32 reg,=
 u32 v);
> +void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
> +                             struct cea_sad *sads, int sad_count);
> +void dce6_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder=
,
> +                                            u8 *sadb, int sad_count);
> +void dce6_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
> +                                          u8 *sadb, int sad_count);
> +void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
> +                                   struct drm_connector *connector,
> +                                   struct drm_display_mode *mode);
> +void dce6_afmt_select_pin(struct drm_encoder *encoder);
> +void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
> +                            struct radeon_crtc *crtc, unsigned int clock=
);
> +void dce6_dp_audio_set_dto(struct radeon_device *rdev,
> +                          struct radeon_crtc *crtc, unsigned int clock);
> +
> +#endif                         /* __DCE6_AFMT_H__ */
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/rade=
on/radeon_audio.c
> index 3cc53db04d645..785c23cb30589 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -25,6 +25,7 @@
>  #include <linux/gcd.h>
>
>  #include <drm/drm_crtc.h>
> +#include "dce6_afmt.h"
>  #include "evergreen_hdmi.h"
>  #include "radeon.h"
>  #include "atom.h"
> @@ -34,26 +35,10 @@ void r600_audio_enable(struct radeon_device *rdev, st=
ruct r600_audio_pin *pin,
>                 u8 enable_mask);
>  void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
>                 u8 enable_mask);
> -u32 dce6_endpoint_rreg(struct radeon_device *rdev, u32 offset, u32 reg);
> -void dce6_endpoint_wreg(struct radeon_device *rdev,
> -               u32 offset, u32 reg, u32 v);
> -void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
> -               struct cea_sad *sads, int sad_count);
> -void dce6_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder=
,
> -               u8 *sadb, int sad_count);
> -void dce6_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
> -               u8 *sadb, int sad_count);
> -void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
> -               struct drm_connector *connector, struct drm_display_mode =
*mode);
>  struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
>  struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
> -void dce6_afmt_select_pin(struct drm_encoder *encoder);
>  void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
>         struct radeon_crtc *crtc, unsigned int clock);
> -void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
> -       struct radeon_crtc *crtc, unsigned int clock);
> -void dce6_dp_audio_set_dto(struct radeon_device *rdev,
> -       struct radeon_crtc *crtc, unsigned int clock);
>  void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
>         unsigned char *buffer, size_t size);
>  void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
