Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8112B5171
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgKPTpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgKPTpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:45:40 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DBAC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:45:40 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id w24so432764wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1uCpe1byY5J38WnMdFLiTIlTnh+9QMbRg1Ws0y40+88=;
        b=fFmPxyr/y2GMNIyxinzL20IIGegusR591p7d6qtxbMk0EH7Jw29vYC+KLC8ng2sfnX
         vVJ3h3iL7iP8ZMWVX7aKzUGWxROCy8LfrddbSjVTaIUkC74enP751Re1UtUH8QekRgqh
         cpFx7jq7Up2WAtUSLg3dPojHOF2WLUOsqUjlx2fa6qDsG90CJ8Ivf3WpKHC21xQQlLz6
         /8jFbhcL0nco/bK1BnWwuF4OsKyNRjxkwM6nd4aY+NH3bMuMS5Yhs2dS8ZKV4Cb0jftO
         KgeljIXxvsrbujAkLcB5T0vQM08MeqwrHYGL0dF9c7T3Gz/zCIhmnc816dp729Hh/ttB
         S82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1uCpe1byY5J38WnMdFLiTIlTnh+9QMbRg1Ws0y40+88=;
        b=ICPu12+fkzrKurTZcD3MuDIys/6NCOVv4T7eBuy2ukswWEjzZzkpJvCsncjr3Everl
         QqBTd5iPGm61/XqQsMtBaCW0pSaRebsqYi2n5E+Y9+KY+JD0aRqWD/DISlieuMmnNptw
         HIiLbM5OewKnuke01jbm34jKbk9JHaHqHC0/PVhenT0eLEvjZNsazrLj7svXPH/n1RhE
         +mxZJLPm9gVSaqtKzkxGVe3gFRaVSlga4lAtyQBulPoiHN+nAliD9KnhqzvesmGzQC9g
         wX6EvGEyB6L/7gFLIFJLOWIzM83iyiReH+7ODenZFSRxWDIi3ke26UMFFiHUhUr1kGGQ
         C72A==
X-Gm-Message-State: AOAM531YH9mcO9SFcZZ+LNJTzXrT65ZnE5wAGAnrZgpny8woK2gv/j1B
        opax1jVLHDzwXAyWLgI5BOGy4xvFYsgrs3SPEOs=
X-Google-Smtp-Source: ABdhPJyMoaWATdgQf/8+LhTLg5ziSaFytvDZu4lnbCExubtttYTGyLTAEp1s14NYJetfC308Nw94G32gV0BzkmI6qeg=
X-Received: by 2002:a1c:f017:: with SMTP id a23mr544786wmb.56.1605555938984;
 Mon, 16 Nov 2020 11:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20201116173005.1825880-1-lee.jones@linaro.org> <20201116173005.1825880-12-lee.jones@linaro.org>
In-Reply-To: <20201116173005.1825880-12-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:45:28 -0500
Message-ID: <CADnq5_Oe3a6nHfMghgAzxXNHVPs5W4t6yfzEHP28Njo4npx2rA@mail.gmail.com>
Subject: Re: [PATCH 11/43] drm/radeon/radeon_audio: Move 'dce3_2_*' prototypes
 to shared location
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

On Mon, Nov 16, 2020 at 12:30 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/dce3_1_afmt.c:30:6: warning: no previous prototyp=
e for =E2=80=98dce3_2_afmt_hdmi_write_speaker_allocation=E2=80=99 [-Wmissin=
g-prototypes]
>  30 | void dce3_2_afmt_hdmi_write_speaker_allocation(struct drm_encoder *=
encoder,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce3_1_afmt.c:48:6: warning: no previous prototyp=
e for =E2=80=98dce3_2_afmt_dp_write_speaker_allocation=E2=80=99 [-Wmissing-=
prototypes]
>  48 | void dce3_2_afmt_dp_write_speaker_allocation(struct drm_encoder *en=
coder,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce3_1_afmt.c:66:6: warning: no previous prototyp=
e for =E2=80=98dce3_2_afmt_write_sad_regs=E2=80=99 [-Wmissing-prototypes]
>  66 | void dce3_2_afmt_write_sad_regs(struct drm_encoder *encoder,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce3_1_afmt.c:116:6: warning: no previous prototy=
pe for =E2=80=98dce3_2_audio_set_dto=E2=80=99 [-Wmissing-prototypes]
>  116 | void dce3_2_audio_set_dto(struct radeon_device *rdev,
>  | ^~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce3_1_afmt.c:170:6: warning: no previous prototy=
pe for =E2=80=98dce3_2_hdmi_update_acr=E2=80=99 [-Wmissing-prototypes]
>  170 | void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offs=
et,
>  | ^~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce3_1_afmt.c:202:6: warning: no previous prototy=
pe for =E2=80=98dce3_2_set_audio_packet=E2=80=99 [-Wmissing-prototypes]
>  202 | void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offs=
et)
>  | ^~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/radeon/dce3_1_afmt.c:223:6: warning: no previous prototy=
pe for =E2=80=98dce3_2_set_mute=E2=80=99 [-Wmissing-prototypes]
>  223 | void dce3_2_set_mute(struct drm_encoder *encoder, u32 offset, bool=
 mute)
>  | ^~~~~~~~~~~~~~~
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
>  drivers/gpu/drm/radeon/radeon_audio.c | 12 ------------
>  drivers/gpu/drm/radeon/radeon_audio.h | 12 ++++++++++++
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.c b/drivers/gpu/drm/rade=
on/radeon_audio.c
> index 8c63ccb8b6235..f6c783e19c988 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.c
> +++ b/drivers/gpu/drm/radeon/radeon_audio.c
> @@ -38,16 +38,10 @@ void dce6_audio_enable(struct radeon_device *rdev, st=
ruct r600_audio_pin *pin,
>  u32 dce6_endpoint_rreg(struct radeon_device *rdev, u32 offset, u32 reg);
>  void dce6_endpoint_wreg(struct radeon_device *rdev,
>                 u32 offset, u32 reg, u32 v);
> -void dce3_2_afmt_write_sad_regs(struct drm_encoder *encoder,
> -               struct cea_sad *sads, int sad_count);
>  void evergreen_hdmi_write_sad_regs(struct drm_encoder *encoder,
>                 struct cea_sad *sads, int sad_count);
>  void dce6_afmt_write_sad_regs(struct drm_encoder *encoder,
>                 struct cea_sad *sads, int sad_count);
> -void dce3_2_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encod=
er,
> -               u8 *sadb, int sad_count);
> -void dce3_2_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder=
,
> -               u8 *sadb, int sad_count);
>  void dce4_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encoder=
,
>                 u8 *sadb, int sad_count);
>  void dce4_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder,
> @@ -65,8 +59,6 @@ struct r600_audio_pin* dce6_audio_get_pin(struct radeon=
_device *rdev);
>  void dce6_afmt_select_pin(struct drm_encoder *encoder);
>  void r600_hdmi_audio_set_dto(struct radeon_device *rdev,
>         struct radeon_crtc *crtc, unsigned int clock);
> -void dce3_2_audio_set_dto(struct radeon_device *rdev,
> -       struct radeon_crtc *crtc, unsigned int clock);
>  void dce4_hdmi_audio_set_dto(struct radeon_device *rdev,
>         struct radeon_crtc *crtc, unsigned int clock);
>  void dce4_dp_audio_set_dto(struct radeon_device *rdev,
> @@ -81,8 +73,6 @@ void evergreen_set_avi_packet(struct radeon_device *rde=
v, u32 offset,
>         unsigned char *buffer, size_t size);
>  void r600_hdmi_update_acr(struct drm_encoder *encoder, long offset,
>         const struct radeon_hdmi_acr *acr);
> -void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> -       const struct radeon_hdmi_acr *acr);
>  void evergreen_hdmi_update_acr(struct drm_encoder *encoder, long offset,
>         const struct radeon_hdmi_acr *acr);
>  void r600_set_vbi_packet(struct drm_encoder *encoder, u32 offset);
> @@ -90,10 +80,8 @@ void dce4_set_vbi_packet(struct drm_encoder *encoder, =
u32 offset);
>  void dce4_hdmi_set_color_depth(struct drm_encoder *encoder,
>         u32 offset, int bpc);
>  void r600_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> -void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offset);
>  void dce4_set_audio_packet(struct drm_encoder *encoder, u32 offset);
>  void r600_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
> -void dce3_2_set_mute(struct drm_encoder *encoder, u32 offset, bool mute)=
;
>  void dce4_set_mute(struct drm_encoder *encoder, u32 offset, bool mute);
>  static void radeon_audio_hdmi_mode_set(struct drm_encoder *encoder,
>         struct drm_display_mode *mode);
> diff --git a/drivers/gpu/drm/radeon/radeon_audio.h b/drivers/gpu/drm/rade=
on/radeon_audio.h
> index 5c70cceaa4a6c..05e67867469b0 100644
> --- a/drivers/gpu/drm/radeon/radeon_audio.h
> +++ b/drivers/gpu/drm/radeon/radeon_audio.h
> @@ -81,4 +81,16 @@ void radeon_audio_mode_set(struct drm_encoder *encoder=
,
>  void radeon_audio_dpms(struct drm_encoder *encoder, int mode);
>  unsigned int radeon_audio_decode_dfs_div(unsigned int div);
>
> +void dce3_2_afmt_write_sad_regs(struct drm_encoder *encoder,
> +                               struct cea_sad *sads, int sad_count);
> +void dce3_2_afmt_hdmi_write_speaker_allocation(struct drm_encoder *encod=
er,
> +                                              u8 *sadb, int sad_count);
> +void dce3_2_afmt_dp_write_speaker_allocation(struct drm_encoder *encoder=
,
> +                                            u8 *sadb, int sad_count);
> +void dce3_2_audio_set_dto(struct radeon_device *rdev,
> +                         struct radeon_crtc *crtc, unsigned int clock);
> +void dce3_2_hdmi_update_acr(struct drm_encoder *encoder, long offset,
> +                           const struct radeon_hdmi_acr *acr);
> +void dce3_2_set_audio_packet(struct drm_encoder *encoder, u32 offset);
> +void dce3_2_set_mute(struct drm_encoder *encoder, u32 offset, bool mute)=
;
>  #endif
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
