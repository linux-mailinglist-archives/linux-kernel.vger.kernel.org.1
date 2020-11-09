Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4A52AC82E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730195AbgKIWUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIWUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:20:20 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4A7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 14:20:19 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so1075538wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 14:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vGhNCc6VVewZry0wq35Lxy3zuv2TnMJ7Nic4jXYaqhI=;
        b=Rwyctf8tX7OhS2+nfu/PZZmG5jV1uAmkp3NvuHlugxKjDGKOkiQkdegHxv7l4Jyq0R
         j9B76HgpSGi8DNsIfB06YNrXIYP/mPhvJ86FkXmUNAseMftI7jPqvlJ1H7GF6UeZf5sh
         hhbE9oiXrf3wwsTtz04Z1IuFAPabpPWHn33T3GY/otaCyAEpGcxr6B5eZhbbJQR8OG9J
         JEgRid50wlGnzOEsVepBBZRPc3VBEc9e4sSWZ7P3tcj0kHJKNEXT4mFAmDefH7bowOPi
         qfRKPwokcGeVIFAtpdSi1xOlOuqgaxfRLmX+NLjdh+xMxdS11wamPtl54g96Lp/ArOFA
         8ANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vGhNCc6VVewZry0wq35Lxy3zuv2TnMJ7Nic4jXYaqhI=;
        b=T8+/c4zIgquXqWPVWi8QRydEBpfV+vXF0xkb/SiqXNxq80uvem3ACO09WQV00T/wxo
         9qHVjtomFdBa7q5gQ5oZkx6Saov3M5OkSL/RuKpGJ/BoHga+istTO+8hM06tG8agHJqy
         ydTBdSO7He5eHzdrDwzw3ECPeTo1oZK1MD6TrCerNHn54xf9JPtt7HmOffoY5huZ99HU
         IuoFBprppIXY9vBSIe1Oj3RUDo3tU8xpVElkgMNgAkEMWA9sW+dTlxyX1DJDChYgdCfW
         1MVGzohamRyzzp8T7Xll2tJSIe8o9fQC3w7JgvDvHzK5EXngJwsrlrValzBiw3UV21y+
         YI3A==
X-Gm-Message-State: AOAM532a66H5bjqtaWLiuuqwpkG/W4YYStQ7EOjHkDNbc13I3J+BkUcC
        sXEuENREUp2IXXMFYIDEA+q/lw0OEBle+++VIp7aRote
X-Google-Smtp-Source: ABdhPJxiyjZlUDPOFY3G7x+17Jo3GAkhTVvY+9kpsTfW8bz5ICtO/+F2bct4Y9onw3IT2o1baa3bcQ+fDgql5AM/Vd0=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr1309185wmb.39.1604960418386;
 Mon, 09 Nov 2020 14:20:18 -0800 (PST)
MIME-Version: 1.0
References: <20201109211855.3340030-1-lee.jones@linaro.org> <20201109211855.3340030-16-lee.jones@linaro.org>
In-Reply-To: <20201109211855.3340030-16-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 9 Nov 2020 17:20:07 -0500
Message-ID: <CADnq5_NvitEQWH3Z+5EgOH3zJn=P5YTqwHQo4LLQLi0Hj0Dpww@mail.gmail.com>
Subject: Re: [PATCH 15/20] drm/radeon/r600d: Move 'rc600_*' prototypes into
 shared header
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

On Mon, Nov 9, 2020 at 4:19 PM Lee Jones <lee.jones@linaro.org> wrote:
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
> ---
>  drivers/gpu/drm/radeon/r600d.h        | 14 ++++++++++++++
>  drivers/gpu/drm/radeon/radeon_audio.c | 11 +----------
>  2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600d.h b/drivers/gpu/drm/radeon/r600=
d.h
> index 2e00a5287bd2d..db4bcc8bee4e5 100644
> --- a/drivers/gpu/drm/radeon/r600d.h
> +++ b/drivers/gpu/drm/radeon/r600d.h
> @@ -27,6 +27,20 @@
>  #ifndef R600D_H
>  #define R600D_H
>
> +struct radeon_crtc;
> +struct radeon_hdmi_acr;
> +
> +void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> +void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
> +void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
> +       struct radeon_crtc *crtc, unsigned int clock);
> +void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
> +       unsigned char *buffer, size_t size);
> +void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> +       const struct radeon_hdmi_acr *acr);
> +void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
> +void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
> +

the *d.h headers are supposed to just be hardware definitions.  I'd
prefer to keep driver stuff out of them.

Alex


>  #define CP_PACKET2                     0x80000000
>  #define                PACKET2_PAD_SHIFT               0
>  #define                PACKET2_PAD_MASK                (0x3fffffff << 0)
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/rade=
on/radeon_audio.c
> index 8c63ccb8b6235..a2be60aa3cec4 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_crtc.h>
>  #include "radeon.h"
>  #include "atom.h"
> +#include "r600d.h"
>  #include "radeon_audio.h"
>
>  void r600_audio_enable(struct radeon_device *rdev, struct r600_audio_pin=
 *pin,
> @@ -63,8 +64,6 @@ void dce6_afmt_write_latency_fields(struct drm_encoder =
*encoder,
>  struct r600_audio_pin* r600_audio_get_pin(struct radeon_device *rdev);
>  struct r600_audio_pin* dce6_audio_get_pin(struct radeon_device *rdev);
>  void dce6_afmt_select_pin(struct drm_encoder *encoder);
> -void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
> -       struct radeon_crtc *crtc, unsigned int clock);
>  void dce3_2_audio_set_dto(struct radeon_device *rdev,
>         struct radeon_crtc *crtc, unsigned int clock);
>  void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
> @@ -75,31 +74,23 @@ void dce6_hdmi_audio_set_dto(struct radeon_device *rd=
ev,
>         struct radeon_crtc *crtc, unsigned int clock);
>  void dce6_dp_audio_set_dto(struct radeon_device *rdev,
>         struct radeon_crtc *crtc, unsigned int clock);
> -void r600_set_avi_packet(struct radeon_device *rdev, u32 offset,
> -       unsigned char *buffer, size_t size);
>  void evergreen_set_avi_packet(struct radeon_device *rdev, u32 offset,
>         unsigned char *buffer, size_t size);
> -void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> -       const struct radeon_hdmi_acr *acr);
>  void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offset,
>         const struct radeon_hdmi_acr *acr);
>  void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
>         const struct radeon_hdmi_acr *acr);
> -void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
>  void dce4_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
>  void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
>         u32 offset, int bpc);
> -void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
>  void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offset);
>  void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> -void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
>  void dce3_2_set_mute(struct drm_encoder *encoder, u32 offset, bool mute)=
;
>  void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
>  static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
>         struct drm_display_mode *mode);
>  static void radeon_audio_dp_mode_set(struct drm_encoder *encoder,
>         struct drm_display_mode *mode);
> -void r600_hdmi_enable(struct drm_encoder *encoder, bool enable);
>  void evergreen_hdmi_enable(struct drm_encoder *encoder, bool enable);
>  void evergreen_dp_enable(struct drm_encoder *encoder, bool enable);
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
