Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C552B51CD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbgKPUBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbgKPUBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:01:31 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23FAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:01:31 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id o15so20157349wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=i9rFlE2uudHRXHlUzGJW+/KB+kG0eK2nW0DHUFQV3e8=;
        b=q+JXSyXLhND8w0dYkWeaeitp2mVx9wpTTfBU7xRSH26LTJ48G01diXHvuyuLFo717T
         l2158FxGhiZC7L2W2nwfMVXCqv0sbbVgtOBayegdeHYEvz0afCsAymf8fynkWoBvCteN
         EQxUrGwMSeCPMdh5teEuKmSQyG+oBohnYPa7fFC/BnKdwNvvVEUhAlT0LYbv2wMNkQAO
         woqDTOvjWjLhIC7PZWeHCI2jWHIin2EA57R8a1kOQF6IcgrIQadVPKzIIRO0dMV5p8de
         FqoX/OQaFj//65XaPVCnimFIInBS7v1EPf3qChsPHLcnNP+wwhyhu/+ukGArLvGmFX+E
         rieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=i9rFlE2uudHRXHlUzGJW+/KB+kG0eK2nW0DHUFQV3e8=;
        b=grNn5vMToHquIbiEs0AY3cf28Rg+jrQKurXf4VaB3ZLgrkqw+Bx8hoGg4a4HC7fCLk
         YM0YhufHk/8vMkVVc92OHM+QXQFi2ah+QP3K8uXBZKKOKdHqmF6ik7oaaat2KKn++yID
         NBguT6KBw9LJKIgx5+ql+iLo2X/7QgY5lSL4ibOwxbUlpTMHi6OBSrE8SqiaWSwYjt4W
         BXYeKGuGGL86DSniPE9ynooH+xkGmM7aX5jYmK14cNqBYV7cX+DU3lBWsLPXR7i2PNR5
         RNI5NB5x6ZHpGgRrtj4DHw8bxPX6+oPSy4822mn4aQta0sHKo+JQbqurLj89AHJqtwrE
         /U3w==
X-Gm-Message-State: AOAM530pgwvuwI0zldYPcF6NQ2aBuR0+a7pmymXM/t01+YOBPIijiZlZ
        JfWyA8n95Pr6QPO5F/mZNeC58OO4cMD7DtzseMg=
X-Google-Smtp-Source: ABdhPJw/MvUfpsvlbnFT4Kd2k77E5jOI7/MIbWVoEjofECB9v1MTwKWyan5LhqxMEIXml5fzQK4kSclxi4iUM1gcNq0=
X-Received: by 2002:adf:e551:: with SMTP id z17mr21517670wrm.374.1605556890498;
 Mon, 16 Nov 2020 12:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-18-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:01:19 -0500
Message-ID: <CADnq5_PyKMo3pH_qXTeX+hytn+2skrpBMVZynfWh4t1=6-T3NQ@mail.gmail.com>
Subject: Re: [PATCH 17/43] drm/radeon/evergreen_hdmi: Move 'evergreen_*()' and
 'dce4_*()' HDMI prototypes to shared header
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
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:37:6: warning: no previous proto=
type for =E2=80=98dce4_audio_enable=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:67:6: warning: no previous proto=
type for =E2=80=98evergreen_hdmi_update_acr=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:97:6: warning: no previous proto=
type for =E2=80=98dce4_afmt_write_latency_fields=E2=80=99 [-Wmissing-protot=
ypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:119:6: warning: no previous prot=
otype for =E2=80=98dce4_afmt_hdmi_write_speaker_allocation=E2=80=99 [-Wmiss=
ing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:137:6: warning: no previous prot=
otype for =E2=80=98dce4_afmt_dp_write_speaker_allocation=E2=80=99 [-Wmissin=
g-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:155:6: warning: no previous prot=
otype for =E2=80=98evergreen_hdmi_write_sad_regs=E2=80=99 [-Wmissing-protot=
ypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:208:6: warning: no previous prot=
otype for =E2=80=98evergreen_set_avi_packet=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:227:6: warning: no previous prot=
otype for =E2=80=98dce4_hdmi_audio_set_dto=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:270:6: warning: no previous prot=
otype for =E2=80=98dce4_dp_audio_set_dto=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:306:6: warning: no previous prot=
otype for =E2=80=98dce4_set_vbi_packet=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:317:6: warning: no previous prot=
otype for =E2=80=98dce4_hdmi_set_color_depth=E2=80=99 [-Wmissing-prototypes=
]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:354:6: warning: no previous prot=
otype for =E2=80=98dce4_set_audio_packet=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:389:6: warning: no previous prot=
otype for =E2=80=98dce4_set_mute=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:400:6: warning: no previous prot=
otype for =E2=80=98evergreen_hdmi_enable=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/radeon/evergreen_hdmi.c:440:6: warning: no previous prot=
otype for =E2=80=98evergreen_dp_enable=E2=80=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/radeon/evergreen_hdmi.c |  1 +
>  drivers/gpu/drm/radeon/evergreen_hdmi.h | 69 +++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/radeon_audio.c   | 26 +---------
>  3 files changed, 71 insertions(+), 25 deletions(-)
>  create mode 100644 drivers/gpu/drm/radeon/evergreen_hdmi.h
>
> diff --git a/drivers/gpu/drm/radeon/evergreen_hdmi.c b/drivers/gpu/drm/ra=
deon/evergreen_hdmi.c
> index 739336a48d085..5f3078f8ab950 100644
> --- a/drivers/gpu/drm/radeon/evergreen_hdmi.c
> +++ b/drivers/gpu/drm/radeon/evergreen_hdmi.c
> @@ -27,6 +27,7 @@
>  #include <linux/hdmi.h>
>
>  #include <drm/radeon_drm.h>
> +#include "evergreen_hdmi.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_audio.h"
> diff --git a/drivers/gpu/drm/radeon/evergreen_hdmi.h b/drivers/gpu/drm/ra=
deon/evergreen_hdmi.h
> new file mode 100644
> index 0000000000000..c86276b8d7f58
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/evergreen_hdmi.h
> @@ -0,0 +1,69 @@
> +/* evergreen_hdmi.h -- Private header for radeon driver -*- linux-c -*-
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
> +#ifndef __EVERGREEN_HDMI_H__
> +#define __EVERGREEN_HDMI_H__
> +
> +struct cea_sa;
> +struct cea_sad;
> +struct drm_connector;
> +struct drm_display_mode;
> +struct drm_encoder;
> +struct r600_audio_pin;
> +struct radeon_crtc;
> +struct radeon_device;
> +struct radeon_hdmi_acr;
> +
> +void evergreen_hdmi_write_sad_regs(struct drm_encoder *encoder,
> +                                  struct cea_sad *sads, int sad_count);
> +void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
> +                             unsigned char *buffer, size_t size);
> +void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> +                              const struct radeon_hdmi_acr *acr);
> +void evergreen_hdmi_enable(struct drm_encoder *encoder, bool enable);
> +void evergreen_dp_enable(struct drm_encoder *encoder, bool enable);
> +
> +void dce4_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
> +                      u8 enable_mask);
> +void dce4_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder=
,
> +                                            u8 *sadb, int sad_count);
> +void dce4_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
> +                                          u8 *sadb, int sad_count);
> +void dce4_afmt_write_latency_fields(struct drm_encoder *encoder,
> +                                   struct drm_connector *connector,
> +                                   struct drm_display_mode *mode);
> +void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
> +                            struct radeon_crtc *crtc, unsigned int clock=
);
> +void dce4_dp_audio_set_dto(struct radeon_device *rdev,
> +                          struct radeon_crtc *crtc, unsigned int clock);
> +void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
> +void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
> +                              u32 offset, int bpc);
> +void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> +void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
> +
> +#endif                         /* __EVERGREEN_HDMI_H__ */
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/rade=
on/radeon_audio.c
> index f6c783e19c988..3cc53db04d645 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -25,33 +25,24 @@
>  #include <linux/gcd.h>
>
>  #include <drm/drm_crtc.h>
> +#include "evergreen_hdmi.h"
>  #include "radeon.h"
>  #include "atom.h"
>  #include "radeon_audio.h"
>
>  void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
>                 u8 enable_mask);
> -void dce4_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
> -               u8 enable_mask);
>  void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
>                 u8 enable_mask);
>  u32 dce6_endpoint_rreg(struct radeon_device *rdev, u32 offset, u32 reg);
>  void dce6_endpoint_wreg(struct radeon_device *rdev,
>                 u32 offset, u32 reg, u32 v);
> -void evergreen_hdmi_write_sad_regs(struct drm_encoder *encoder,
> -               struct cea_sad *sads, int sad_count);
>  void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
>                 struct cea_sad *sads, int sad_count);
> -void dce4_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder=
,
> -               u8 *sadb, int sad_count);
> -void dce4_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
> -               u8 *sadb, int sad_count);
>  void dce6_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder=
,
>                 u8 *sadb, int sad_count);
>  void dce6_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
>                 u8 *sadb, int sad_count);
> -void dce4_afmt_write_latency_fields(struct drm_encoder *encoder,
> -               struct drm_connector *connector, struct drm_display_mode =
*mode);
>  void dce6_afmt_write_latency_fields(struct drm_encoder *encoder,
>                 struct drm_connector *connector, struct drm_display_mode =
*mode);
>  struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
> @@ -59,37 +50,22 @@ struct r600_audio_pin* dce6_audio_get_pin(struct rade=
on_device *rdev);
>  void dce6_afmt_select_pin(struct drm_encoder *encoder);
>  void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
>         struct radeon_crtc *crtc, unsigned int clock);
> -void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
> -       struct radeon_crtc *crtc, unsigned int clock);
> -void dce4_dp_audio_set_dto(struct radeon_device *rdev,
> -       struct radeon_crtc *crtc, unsigned int clock);
>  void dce6_hdmi_audio_set_dto(struct radeon_device *rdev,
>         struct radeon_crtc *crtc, unsigned int clock);
>  void dce6_dp_audio_set_dto(struct radeon_device *rdev,
>         struct radeon_crtc *crtc, unsigned int clock);
>  void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
>         unsigned char *buffer, size_t size);
> -void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
> -       unsigned char *buffer, size_t size);
>  void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
>         const struct radeon_hdmi_acr *acr);
> -void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> -       const struct radeon_hdmi_acr *acr);
>  void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
> -void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
> -void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
> -       u32 offset, int bpc);
>  void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> -void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
>  void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
> -void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
>  static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
>         struct drm_display_mode *mode);
>  static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
>         struct drm_display_mode *mode);
>  void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
> -void evergreen_hdmi_enable(struct drm_encoder *encoder, bool enable);
> -void evergreen_dp_enable(struct drm_encoder *encoder, bool enable);
>
>  static const u32 pin_offsets[7] =3D
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
