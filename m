Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE342B532E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgKPUrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:47:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgKPUre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:47:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7854EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:47:34 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so595505wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1KG4FcyggD6yudjB0WPJp0njbrETKn5ez9zi8zrlX7A=;
        b=bQPZ00v3TjGZI3OSdpSQ/TuZXNE4oWxyBezFbP1C1N+pZsj0gJskRXGb1Ex9VIQ6Zk
         tJTGaaiovZvQOd9UQ/4D3aP0ozjgGelIbnJyKbdWnbHU1aGr6/rXLUULIRpcxeG1H6Tv
         v10dfYA9pInLKL23cCSM94O3IYqRfa9am3qLlRRIEIqngxv3/wPO3vGmqevrpoSDF5O0
         9DgBYHFHTVdWTwdhW33Ddc/l0nRE1vEf+85Yzvsb7SQ1wE08PbgooUDH7MUWG5ylnlXx
         ySLu+qzYQqLJ1pjmG+RW1m/Q+UmkRg9vRPyp48i1vhPlBq9yq45jg+csS+EYyQTGuc/1
         AOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1KG4FcyggD6yudjB0WPJp0njbrETKn5ez9zi8zrlX7A=;
        b=OrnkUqi4OCXvPmfxE+8Kwe2Ii61J3yQX/vjQFH8yJG1mTY0PG6zkAVxT+Ao8K37hPY
         IlHEtuyasqbiTEJrigCfBOHFUz286EWD5PYfkiSM5SVV0PqLFfl4I0JH6A3ke0ZDI4Zi
         o72ustk8pQ/LzAFNFZr3+fJmHau2VrmvnajnfXtcGDre2vC529q06Gm59rRG/sdLtSY/
         CSUQiutd2RukI2fxyINsDqEX4cRcm2kWc8cjDemx2SaU499dt3yPDDC8chQTYezAIxTu
         gEPbRYwPmwwuMBRELc4jC3OKO0Y5DOtuY3hDcXNTW/xAUTsLp/o4HYihQDLawXo2haMC
         7kMg==
X-Gm-Message-State: AOAM533jpGQFtzEQukkI9iXRbvQMc7T50m41+mJuB02k41YylAcy7XS9
        4NRGkvakQTFkktV5jYGcYWFZD/lNdn3RTHv8RxQRDouf
X-Google-Smtp-Source: ABdhPJyjzvq0NzyEt4o32vxnmLWyxFycYDXJhrjdxsD2J6njYdnIoeVhnNnA+PrrNzgSv75Rbn1JjXl/UUmDXURLf3Y=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr714240wmb.39.1605559653234;
 Mon, 16 Nov 2020 12:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-43-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-43-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:47:22 -0500
Message-ID: <CADnq5_N45=OE3etsQ2AgtLDKT5Ut1ZT44J=jZzBBKNgEz2Gt3g@mail.gmail.com>
Subject: Re: [PATCH 42/43] drm/radeon/radeon_audio: Move 'r600_*' prototypes
 into shared header
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

On Mon, Nov 16, 2020 at 12:38 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/r600_hdmi.c:177:6: warning: no previous prototype=
 for =E2=80=98r600_hdmi_update_acr=E2=80=99 [-Wmissing-prototypes]
>  177 | void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset=
,
>  | ^~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/r600_hdmi.c:217:6: warning: no previous prototype=
 for =E2=80=98r600_set_avi_packet=E2=80=99 [-Wmissing-prototypes]
>  217 | void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
>  | ^~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/r600_hdmi.c:314:6: warning: no previous prototype=
 for =E2=80=98r600_hdmi_audio_set_dto=E2=80=99 [-Wmissing-prototypes]
>  314 | void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/r600_hdmi.c:340:6: warning: no previous prototype=
 for =E2=80=98r600_set_vbi_packet=E2=80=99 [-Wmissing-prototypes]
>  340 | void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset)
>  | ^~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/r600_hdmi.c:351:6: warning: no previous prototype=
 for =E2=80=98r600_set_audio_packet=E2=80=99 [-Wmissing-prototypes]
>  351 | void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset=
)
>  | ^~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/r600_hdmi.c:393:6: warning: no previous prototype=
 for =E2=80=98r600_set_mute=E2=80=99 [-Wmissing-prototypes]
>  393 | void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool m=
ute)
>  | ^~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/r600_hdmi.c:469:6: warning: no previous prototype=
 for =E2=80=98r600_hdmi_enable=E2=80=99 [-Wmissing-prototypes]
>  469 | void r600_hdmi_enable(struct drm_encoder *encoder, bool enable)
>  | ^~~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/r600.h         | 17 +++++++++++++++++
>  drivers/gpu/drm/radeon/r600_hdmi.c    |  1 +
>  drivers/gpu/drm/radeon/radeon_audio.c | 13 +------------
>  3 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600.h b/drivers/gpu/drm/radeon/r600.=
h
> index dbdff4568516b..22db13b256195 100644
> --- a/drivers/gpu/drm/radeon/r600.h
> +++ b/drivers/gpu/drm/radeon/r600.h
> @@ -30,12 +30,29 @@
>
>  struct radeon_bo_list;
>  struct radeon_cs_parser;
> +struct r600_audio_pin;
> +struct radeon_crtc;
>  struct radeon_device;
> +struct radeon_hdmi_acr;
>
>  u32 r600_gpu_check_soft_reset(struct radeon_device *rdev);
>  int r600_ih_ring_alloc(struct radeon_device *rdev);
>  void r600_ih_ring_fini(struct radeon_device *rdev);
>
> +void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
> +                      u8 enable_mask);
> +void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> +void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
> +void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
> +                            struct radeon_crtc *crtc, unsigned int clock=
);
> +void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
> +                        unsigned char *buffer, size_t size);
> +void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> +                         const struct radeon_hdmi_acr *acr);
> +void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
> +void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
> +
>  int r600_dma_cs_next_reloc(struct radeon_cs_parser *p,
>                            struct radeon_bo_list **cs_reloc);
> +
>  #endif                         /* __R600_H__ */
> diff --git a/drivers/gpu/drm/radeon/r600_hdmi.c b/drivers/gpu/drm/radeon/=
r600_hdmi.c
> index c09549d785b54..f3551ebaa2f08 100644
> --- a/drivers/gpu/drm/radeon/r600_hdmi.c
> +++ b/drivers/gpu/drm/radeon/r600_hdmi.c
> @@ -30,6 +30,7 @@
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_audio.h"
> +#include "r600.h"
>  #include "r600d.h"
>  #include "atom.h"
>
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/rade=
on/radeon_audio.c
> index 785c23cb30589..7c5e80d03fc90 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -29,28 +29,17 @@
>  #include "evergreen_hdmi.h"
>  #include "radeon.h"
>  #include "atom.h"
> +#include "r600.h"
>  #include "radeon_audio.h"
>
> -void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
> -               u8 enable_mask);
>  void dce6_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
>                 u8 enable_mask);
>  struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
>  struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
> -void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
> -       struct radeon_crtc *crtc, unsigned int clock);
> -void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
> -       unsigned char *buffer, size_t size);
> -void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> -       const struct radeon_hdmi_acr *acr);
> -void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
> -void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> -void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
>  static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
>         struct drm_display_mode *mode);
>  static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
>         struct drm_display_mode *mode);
> -void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
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
