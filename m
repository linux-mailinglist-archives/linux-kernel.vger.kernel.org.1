Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C55F2B5107
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729409AbgKPTZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729366AbgKPTZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:25:14 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A7AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:25:14 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id c9so367689wml.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Mg9GFMofk+sNZIbonQjgi+ktaHQagod8RuLC5zHvQK0=;
        b=rB+vEPl48Ca+f8EI7f5SO2q5/LWEbc7bSHAJFRsPimkl1j36X/0nzRpHjlCiydJnfC
         CucGh4QUOtpZgxue52ccVifl2nPuI7uSEbLRGQFk+ABL+uTErfD2mOa7yX4ErdxLEk76
         hp/pyV5Wv5/0XTWfR+pDstfw1hh+ujOFB4OOFPgDYvXrcHMfMDiJHRtPnXUK62EwhDFZ
         9uoac2oh4WipImhJSkHG1s+/bZ2QPe3Gs8Lu2TbxCQkE072uNBxWMEhBMntfsLmgG8HA
         fDUVQA9MGKibcMakQr1LF37EVK5EK/IKTD5ark56QHlTpDdAR1qoKG1+1K6WMzZ2wnAX
         jOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Mg9GFMofk+sNZIbonQjgi+ktaHQagod8RuLC5zHvQK0=;
        b=Uc7mPIhbMqtSxyMngb6gJ66OIy1B9U42sAJkdwc8TtQ+JSYOvixl95Qn82w/MtdL7C
         S4Xwu1ycz7QRIGRycMn0F4wHLcU6ahPLDcLk/f2vRDqI4fezH5vQVQynlXLmDfFmCw9n
         8PVQnXsSwGylw92f3tfGUOMWrLZviXrH7kIjTcXXhIwqAePQTUGeNKYyZrIpLrczTtmC
         X0dBQz/vg7edOn7hOOoeNZ5vpY8BKp0v23Ef/CJqWL3FybQei8Avdlx2hvhzJJ4Rz0qG
         9jq8yqt+kUn20hIXgw5uHLhWFJ7SMt5NqyBIvRCz89p69cdJAP99MUYe4Ml29GbpzONq
         cbMw==
X-Gm-Message-State: AOAM532AALh1C6DPe10SGRdWPVnxtvpcq/J4O1w7q9QUnUjTAm3BcBPC
        SmJUufzR9Y+xiP5ksJ+1k41DK84N/iHMtexoE6s=
X-Google-Smtp-Source: ABdhPJz0HZu46+nxNC8z8L+/DfcnRH3UuWmiHnBVvanfqFzICAnYk6XZyIPNfEadutzPlrSwLNJ7M1XR78sOdKUBGZk=
X-Received: by 2002:a1c:2dc8:: with SMTP id t191mr56014wmt.73.1605554713457;
 Mon, 16 Nov 2020 11:25:13 -0800 (PST)
MIME-Version: 1.0
References: <20201116173005.1825880-1-lee.jones@linaro.org> <20201116173005.1825880-2-lee.jones@linaro.org>
In-Reply-To: <20201116173005.1825880-2-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 14:25:02 -0500
Message-ID: <CADnq5_NnPiySfPv4Jgk4j8rvzxYkoVxRBGUAjdQJW_tL2RuTBA@mail.gmail.com>
Subject: Re: [PATCH 01/43] drm/radeon/atombios_encoders: Move
 'radeon_atom_get_tv_timings()'s prototype into shared location
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

On Mon, Nov 16, 2020 at 12:30 PM Lee Jones <lee.jones@linaro.org> wrote:
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

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/atombios_encoders.c |  5 +--
>  drivers/gpu/drm/radeon/radeon_atombios.c   |  1 +
>  drivers/gpu/drm/radeon/radeon_atombios.h   | 37 ++++++++++++++++++++++
>  3 files changed, 39 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/gpu/drm/radeon/radeon_atombios.h
>
> diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm=
/radeon/atombios_encoders.c
> index cc5ee1b3af84f..683de198e18d9 100644
> --- a/drivers/gpu/drm/radeon/atombios_encoders.c
> +++ b/drivers/gpu/drm/radeon/atombios_encoders.c
> @@ -33,6 +33,7 @@
>  #include <drm/radeon_drm.h>
>
>  #include "atom.h"
> +#include "radeon_atombios.h"
>  #include "radeon.h"
>  #include "radeon_asic.h"
>  #include "radeon_audio.h"
> @@ -296,10 +297,6 @@ static void radeon_atom_backlight_exit(struct radeon=
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
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/r=
adeon/radeon_atombios.c
> index 5d25917251892..71bf2ed172697 100644
> --- a/drivers/gpu/drm/radeon/radeon_atombios.c
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.c
> @@ -34,6 +34,7 @@
>  #include "atom.h"
>  #include "atom-bits.h"
>  #include "radeon_asic.h"
> +#include "radeon_atombios.h"
>
>  extern void
>  radeon_add_atom_encoder(struct drm_device *dev, uint32_t encoder_enum,
> diff --git a/drivers/gpu/drm/radeon/radeon_atombios.h b/drivers/gpu/drm/r=
adeon/radeon_atombios.h
> new file mode 100644
> index 0000000000000..b7c76920feb7d
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/radeon_atombios.h
> @@ -0,0 +1,37 @@
> +/* radeon_atombios.h -- Private header for radeon driver -*- linux-c -*-
> + *
> + * Copyright 2007-8 Advanced Micro Devices, Inc.
> + * Copyright 2008 Red Hat Inc.
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
> + * Authors: Dave Airlie
> + *          Alex Deucher
> + */
> +
> +#ifndef __RADEON_ATOMBIOS_H__
> +#define __RADEON_ATOMBIOS_H__
> +
> +struct drm_display_mode;
> +struct radeon_device;
> +
> +bool radeon_atom_get_tv_timings(struct radeon_device *rdev, int index,
> +                               struct drm_display_mode *mode);
> +
> +#endif                         /* __RADEON_ATOMBIOS_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
