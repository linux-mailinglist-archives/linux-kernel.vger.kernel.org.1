Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3C42B5271
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732338AbgKPUYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730428AbgKPUYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:24:22 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D322FC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:24:21 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 19so569083wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o3Z+43KIEICEWS2L8j2bmVE/5+HRWrEhS/yLpOikoIM=;
        b=sCpQc4ahqDRT3np/JQ6Beh9fP6YZ8V6G7+ssWGWNP74sNXIQeCaz5kkqFQcEYLDm6Z
         3EaTDKBUTYFfZnejsb2BIzRIAomsmTb6Afsy/jR48vwVjGDRDfKETnSTLAlNoN0inPXO
         8qiPc1GYSVHMys19d8ZlosMijFAycvlMQTsP36T1Bh4kSriMOfD4FvhiWXev6yigqJfk
         HgqIRJLd6LV0yGgdVhYhFcfGF9UbPhvkCody+Ac7jJouRtIWjODnOuCG6qmt4Gd0/pyw
         +NkJ1FSh/N2yRQt0dLaz8p745VeneXuahBE7wej7AKE63K7gP14buRsj09PSnAPhWyVO
         iS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o3Z+43KIEICEWS2L8j2bmVE/5+HRWrEhS/yLpOikoIM=;
        b=VdYF/GcdER5uTjLbS68i5UzcdU3SKGbaZ4KvWH1oojRdLTwep/tlJWIkAeguJ7ONOl
         aPzg4NiJ01ocgvTzVgK4cl03WLtQD1jB35k+VLQ6YBi9iyCupLV7DbnhRyamxLL7/eIm
         3HQgQ5DWhgBf9KL+znbJ0xZ8jYKiB/ZAm/qoaMvtw6rplMjlJqYBPVFoRJRY61zbT/ft
         vtt9y6KBfoVg7ErwA79/7iNB2idiwqODNWWb1anzkfwoa+8dKAdpChtPRYL43VDTooYz
         w1+4FbD53KihOg/Ijf80Pwd5PPv7sachNUGuwlFmhlX8p0ZaIn/WtZ/hiKyGgwPW5vpN
         sSdw==
X-Gm-Message-State: AOAM533LQ74TcoJpkvV3E5o5b1hjSOZP1E2F/SO4U64Ttsfyk9HOs66p
        c64QPXXEWg1irO4zIPZjWTX7N7LP0yLChvJfSAQ=
X-Google-Smtp-Source: ABdhPJyu4W8gYrZdZFx4N8IBWXzzjYuaxtGP9pzEfpctgiXMe5i6OvPoeHbrqrhbVmQr8zkJzkeIVC6ykK96E1qmIj8=
X-Received: by 2002:a1c:1c3:: with SMTP id 186mr635655wmb.39.1605558260600;
 Mon, 16 Nov 2020 12:24:20 -0800 (PST)
MIME-Version: 1.0
References: <20201116173700.1830487-1-lee.jones@linaro.org> <20201116173700.1830487-30-lee.jones@linaro.org>
In-Reply-To: <20201116173700.1830487-30-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 16 Nov 2020 15:24:09 -0500
Message-ID: <CADnq5_OCfgqoa6oGwM+YnO6T7WVVMSu3xRi4R7tYczfBAB1LLQ@mail.gmail.com>
Subject: Re: [PATCH 29/43] drm/radeon/si_dpm: Move 'si_mc_load_microcode()'s
 prototype to shared header
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
>  drivers/gpu/drm/radeon/si.c:1570:5: warning: no previous prototype for =
=E2=80=98si_mc_load_microcode=E2=80=99 [-Wmissing-prototypes]
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
>  drivers/gpu/drm/radeon/si.c     |  1 +
>  drivers/gpu/drm/radeon/si.h     | 31 +++++++++++++++++++++++++++++++
>  drivers/gpu/drm/radeon/si_dpm.c |  2 +-
>  3 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/radeon/si.h
>
> diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
> index d0407145c07b5..88731b79c8f57 100644
> --- a/drivers/gpu/drm/radeon/si.c
> +++ b/drivers/gpu/drm/radeon/si.c
> @@ -39,6 +39,7 @@
>  #include "radeon_audio.h"
>  #include "radeon_ucode.h"
>  #include "si_blit_shaders.h"
> +#include "si.h"
>  #include "sid.h"
>
>
> diff --git a/drivers/gpu/drm/radeon/si.h b/drivers/gpu/drm/radeon/si.h
> new file mode 100644
> index 0000000000000..0a5018ef166e2
> --- /dev/null
> +++ b/drivers/gpu/drm/radeon/si.h
> @@ -0,0 +1,31 @@
> +/* si.h -- Private header for radeon driver -*- linux-c -*-
> + *
> + * Copyright 2011 Advanced Micro Devices, Inc.
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
> + */
> +
> +#ifndef __SI_H__
> +#define __SI_H__
> +
> +struct radeon_device;
> +
> +int si_mc_load_microcode(struct radeon_device *rdev);
> +
> +#endif                         /* __SI_H__ */
> diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_=
dpm.c
> index c68ab2fb1ac23..32b697965c064 100644
> --- a/drivers/gpu/drm/radeon/si_dpm.c
> +++ b/drivers/gpu/drm/radeon/si_dpm.c
> @@ -32,6 +32,7 @@
>  #include "radeon_asic.h"
>  #include "ni_dpm.h"
>  #include "si_dpm.h"
> +#include "si.h"
>  #include "sid.h"
>
>  #define MC_CG_ARB_FREQ_F0           0x0a
> @@ -1721,7 +1722,6 @@ static const struct si_powertune_data powertune_dat=
a_hainan =3D
>
>  struct evergreen_power_info *evergreen_get_pi(struct radeon_device *rdev=
);
>
> -extern int si_mc_load_microcode(struct radeon_device *rdev);
>  extern void vce_v1_0_enable_mgcg(struct radeon_device *rdev, bool enable=
);
>
>  static int si_populate_voltage_value(struct radeon_device *rdev,
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
