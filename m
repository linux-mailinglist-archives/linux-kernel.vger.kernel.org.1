Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0100F2B1E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgKMP1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgKMP1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:27:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69EBC0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:27:45 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so10312653wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yxHsF+KemCYkb6AEPL2z/e19oUNusseMU7Gcvc/FfJ4=;
        b=eSiE5xwUbwEotdWdSzSCyuIt9amSHoyu9DOpwLgNXMMZh94m1n/0JxqJ8UkU4bZDsF
         YYa8eNuXZUYHW67i1OPfvcIPR4LdnTJ/aL6TrCtdVJHjgEj6lWSkAOIVBhLUrQQ4s6t1
         zXoSDFS3rYAm97nwNOsQSRNWW+8IwfbBXQMDHakJDX243TVRpWDV0ugbqoUW7u4tXcOX
         9ULWE7fYNmaau80ZAn9XBbc4uNOprp2pPql76OoBbkA4CStbbThIpEPRIDE1a6yvHeCW
         f0Pg0bZJv+DIiITlQmncNeTFXAwCsfMWMhTQCGj2ZeLzUz/062ZF20zS949XUnxokf5y
         eTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yxHsF+KemCYkb6AEPL2z/e19oUNusseMU7Gcvc/FfJ4=;
        b=lRRK2iNQtACF8dBmJN1x/hDJNvzUFI+gFkn5FvqSZEhx2R162QxVZ2y0as8d/6ba2w
         oJOm3RQoTyCm3gVyzRN/s5PvBgcNOoM8XXTO356sClDafoW4fUI+EhjvL4Z1uv4GASTc
         reUaW+tpTNh/m50p9Os+p1F113qCKzc/o/lJUsB/K3FwGxNsiFFfACzGQBei2SOvrELD
         8hFyBFT+J1u6pQ3HwR//iFPYdi+bUDmqY/aYKzw2+zGGg6xlxo9ZvBpJBKRNY8h6u+S1
         eA3EN5zZ3eH0vwOTQWcB2wC6qD9PsBF6Oony3L5zscF5MMEFN+2ISvzM4UYl/9KtE+/l
         heIA==
X-Gm-Message-State: AOAM533hafusRukBie46MUhHcYA2DF747hcW6kBTEWqoE1tQH4nydStP
        I0tLU4cmqQXIwwLvsyO/hXe9HeXGH4kuz52mgEI=
X-Google-Smtp-Source: ABdhPJzfJSnTs25NUi0XwRgIqaVNtK+qdLfhBSC2A1tVepq+Caq0ZEAWFJQJJWjUHUYeF7Cm6Bs+M/GD5SFhedhk1eI=
X-Received: by 2002:adf:e551:: with SMTP id z17mr4197640wrm.374.1605281259590;
 Fri, 13 Nov 2020 07:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-3-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-3-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 10:27:28 -0500
Message-ID: <CADnq5_Nn+a-idC__uZtw=XHjac9mRX1Wwustphf6zZS188DQWA@mail.gmail.com>
Subject: Re: [PATCH 02/40] drm/amd/display/dc/core/dc_link_dp: Move
 DP_VGA_LVDS_CONVERTER_ID_{2, 3} to where they're used
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 8:49 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> This patch fixes >200 warnings.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22=
: warning: =E2=80=98DP_VGA_LVDS_CONVERTER_ID_3=E2=80=99 defined but not use=
d [-Wunused-const-variable=3D]
>  123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] =3D "dnomlA";
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22=
: warning: =E2=80=98DP_VGA_LVDS_CONVERTER_ID_2=E2=80=99 defined but not use=
d [-Wunused-const-variable=3D]
>  121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] =3D "sivarT";
>
> NB: Repeated ~100 times - snipped for brevity
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c        | 5 +++++
>  drivers/gpu/drm/amd/display/include/ddc_service_types.h | 4 ----
>  2 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/g=
pu/drm/amd/display/dc/core/dc_link_dp.c
> index 6c60c1fdebdc1..f2023d2b53234 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -15,6 +15,11 @@
>  #include "dc_dmub_srv.h"
>  #include "dce/dmub_hw_lock_mgr.h"
>
> +/*Travis*/
> +static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] =3D "sivarT";
> +/*Nutmeg*/
> +static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] =3D "dnomlA";
> +
>  #define DC_LOGGER \
>         link->ctx->logger
>  #define DC_TRACE_LEVEL_MESSAGE(...) /* do nothing */
> diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/dr=
ivers/gpu/drm/amd/display/include/ddc_service_types.h
> index c9be899cd25cd..b453ce5a9bfdb 100644
> --- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> +++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> @@ -117,10 +117,6 @@ struct av_sync_data {
>         uint8_t aud_del_ins3;/* DPCD 0002Dh */
>  };
>
> -/*Travis*/
> -static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] =3D "sivarT";
> -/*Nutmeg*/
> -static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] =3D "dnomlA";
>  /*DP to Dual link DVI converter*/
>  static const uint8_t DP_DVI_CONVERTER_ID_4[] =3D "m2DVIa";
>  static const uint8_t DP_DVI_CONVERTER_ID_5[] =3D "3393N2";
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
