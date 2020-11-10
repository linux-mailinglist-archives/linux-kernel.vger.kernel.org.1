Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 506072AE232
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgKJVyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJVyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:54:19 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E938AC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:54:18 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so4687557wml.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 13:54:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PYSQECYWsGYFKrZqUDhKu6w9mUnPdTNDs/R0kOX8Gp8=;
        b=Ay84fKohhNeoetn7A1noz1LMP4/JcivNMei/bL7dpmVlkC7lxjY/gPzlsJ6p8MHLjp
         HjYrSz7EKgmgvAwjdlrMwhD+Uw/N2Y2jR1CUd9vEq33NojI6kzrccb1qcsVY6e5yE5Wz
         Js6WovvWsJ6pBKS/Ue1Pl8P4fqV56u2U7e6003O6CASOJCpB8dviZwJOFPmZJdXLDALJ
         RN0cLUGO9Igynqamo4zCbKTgJVuicwWnX5mKPOtovl5caU53+K9a17vcyOGaPjq92/eh
         ofRD2UInpTnvO5Vrk3ZAL9U9g0FBW9+eviQaWwk2JoiW8SykVqhxfgjCxf0jVgbci+na
         vKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PYSQECYWsGYFKrZqUDhKu6w9mUnPdTNDs/R0kOX8Gp8=;
        b=RksmHPHVBq+JaadEDVDaYHhItWlIVSVdK3Oc83E/pog+iCTuz3iZHC/QChbaPXrkHC
         vFyx6nwDEVykRi18rPXVWF7mFXts6+TOT637r1fqCJz8DpfnQKB7j+0N64D8f9VdEQB1
         VjnqhhAMWgDLKZgTbsJnKaOM65G9QHYwZrZfe1ECXSV+rOVK433K0AAHHP/orfa/YnTj
         bQBiIPlvMklxjgPhl4hfMVLF13ZA0V4lUl1G5StX1pQf1Nm6TY5V4uFVR+fzN4bIrNff
         Ekj4rj/zGPWD/lC7H6pF0aVHtoKfNM8SMWrPtVhIn4F4Il2bQQJ6YbseHD4Sn3B29sp9
         E39w==
X-Gm-Message-State: AOAM533I/kPkajgJ2RkcDex1eePwpYAvZlKIHsPgLDS5Vr5nlAcl4vGA
        qOUvlX19jemQTw+M0mZ9Y3XWQaWwffgdEMqOODLNU2aeOeA=
X-Google-Smtp-Source: ABdhPJxf8qsJ98ELnSkIJQvo2S+iZQzFm0f6lInecTgvStPVrRxEgQySGqNRmNxwdcvwALGGfJ7EpXnbXGMFhtPwpto=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr172513wma.79.1605045257699;
 Tue, 10 Nov 2020 13:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20201106214949.2042120-1-lee.jones@linaro.org> <20201106214949.2042120-7-lee.jones@linaro.org>
In-Reply-To: <20201106214949.2042120-7-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 16:54:05 -0500
Message-ID: <CADnq5_NoRGAd+mgZT8i47-U-CnxO=bWD83FVKs0rNnKEoCYxYA@mail.gmail.com>
Subject: Re: [PATCH 06/19] drm/radeon/atom: Move prototype into shared location
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

On Fri, Nov 6, 2020 at 4:50 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Both source files include atom.h, which seems like a reasonable
> location to place an atom based function into.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/radeon_atombios.c:1791:6: warning: no previous pr=
ototype for =E2=80=98radeon_atom_get_tv_timings=E2=80=99 [-Wmissing-prototy=
pes]
>  1791 | bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int i=
ndex,
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/radeon/atom.h              | 6 ++++++
>  drivers/gpu/drm/radeon/atombios_encoders.c | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atom.h b/drivers/gpu/drm/radeon/atom.=
h
> index 1bf06c91cd959..cb93b83114dbe 100644
> --- a/drivers/gpu/drm/radeon/atom.h
> +++ b/drivers/gpu/drm/radeon/atom.h
> @@ -154,6 +154,12 @@ bool atom_parse_data_header(struct atom_context *ctx=
, int index, uint16_t *size,
>  bool atom_parse_cmd_header(struct atom_context *ctx, int index,
>                            uint8_t *frev, uint8_t *crev);
>  int atom_allocate_fb_scratch(struct atom_context *ctx);
> +
> +struct drm_display_mode;
> +struct radeon_device;
> +bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
> +                               struct drm_display_mode *mode);
> +

I'd prefer to add radeon_atombios.h for all of the stuff exported from
radeon_atombios.c.  When you add the .h file, please take the
copyright license from the .c file which implements the functions.

Thanks,

Alex

>  #include "atom-types.h"
>  #include "atombios.h"
>  #include "ObjectID.h"
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index cc5ee1b3af84f..85f903caf12e1 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -296,10 +296,6 @@ static void radeon_atom_backlight_exit(struct radeon=
_encoder *encoder)
>
>  #endif
>
> -/* evil but including atombios.h is much worse */
> -bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
> -                               struct drm_display_mode *mode);
> -
>  static bool radeon_atom_mode_fixup(struct drm_encoder *encoder,
>                                    const struct drm_display_mode *mode,
>                                    struct drm_display_mode *adjusted_mode=
)
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
