Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490822B1EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgKMP2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMP2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:28:39 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CD8C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:28:38 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so10348410wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lWsBIbzny/xwNajMn0klMvDCPThd3TvZoHWCU+gRxuY=;
        b=o+NeEp6/FY6XqI2xnYxSbY4r+O3vSN63IkmmkQh86acoExcNenXzBp6Ae0eeG13zyW
         r6Gi4XAdxZjLcXiE0zvKLBfZtwAd1/jhYxSgSXmxYiA0jkrAIDwvXMu8iWragqYR9EGu
         16IHNqwijiH7Rbthf3FcESTArUe5ltGxKoYR+LITMpPPUqoBbZsiBXcBy3Qwm5ksBz1B
         HvzUCm4uQ1e8p0vakEvewrpU0eeXWcCnQJQSXN14q7Uv9bqR3PeII9jk4W5MMRwxwU/K
         73Lq48Zg2nQ4NBL+3Ta+fQBOQy8O7i17YlheT1lWYWbljRuVl3XTCHDfOJEQ79dgYxx1
         +Tjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lWsBIbzny/xwNajMn0klMvDCPThd3TvZoHWCU+gRxuY=;
        b=aSKTPmPUTLDSP7Bf21OuM2AKdfshl8cLlkA5Qv7QNqdxPE3ERBV7DnlX65SdiGGVU7
         bYDlY1MQx+mYOrCRRUFHDUq2eXGC7KZG0LA62aWRl6OrgjOsDTvHePZnP91QipSsVBHf
         Q3spKVDBRRM3MLOOZIe2cP+NQRvnVu0ip5rwfBHRu7ZEluPttUM3CO5rtb9U9qitVHw2
         8cWc2jmrd3l71X/8Y85Dj/4L3LiJ19/hDXzHzRC0kHzIUJ1gp31yko5pjF6w1XSyIyUa
         sDWa62mwvNRq9m+fqiuaNm0U7GiM1dEcZE8d2sOMibQJHsQzisdwK1R5QNtc9ajzDYVv
         Ljvg==
X-Gm-Message-State: AOAM5338E8xL3bgHY3Kq91+UnzV0os0YRvZPFhz+B3f0dWh9gqpUsQA9
        Vc0rRhjTeuw+4DRyWAGjdaUeHYlNgj9oAi62BDc=
X-Google-Smtp-Source: ABdhPJwCHliBgCXs9vpIVjVSNXsT6sjATmH6wx2AhG+BNxMNJTRfn4Mon8gdGepLe7JgYnl+nXZt7hDoB8JEhLbpsLA=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr4108548wru.362.1605281312734;
 Fri, 13 Nov 2020 07:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-4-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-4-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 10:28:21 -0500
Message-ID: <CADnq5_M0ZugpOOr7gez3sySomqMgb09JWn8XxX1otiYcR=0YNA@mail.gmail.com>
Subject: Re: [PATCH 03/40] drm/amd/display/dc/core/dc_link_ddc: Move
 DP_DVI_CONVERTER_ID_{4, 5} to where they're used
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

On Fri, Nov 13, 2020 at 8:50 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> This patch fixes >200 warnings.
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:31:
>  drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22=
: warning: =E2=80=98DP_DVI_CONVERTER_ID_5=E2=80=99 defined but not used [-W=
unused-const-variable=3D]
>  126 | static const uint8_t DP_DVI_CONVERTER_ID_5[] =3D "3393N2";
>  | ^~~~~~~~~~~~~~~~~~~~~
>  drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22=
: warning: =E2=80=98DP_DVI_CONVERTER_ID_4=E2=80=99 defined but not used [-W=
unused-const-variable=3D]
>  125 | static const uint8_t DP_DVI_CONVERTER_ID_4[] =3D "m2DVIa";
>  | ^~~~~~~~~~~~~~~~~~~~~
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

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c       | 4 ++++
>  drivers/gpu/drm/amd/display/include/ddc_service_types.h | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_link_ddc.c
> index 54beda4d4e85d..c5936e0643606 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_ddc.c
> @@ -37,6 +37,10 @@
>  #include "dc_link_ddc.h"
>  #include "dce/dce_aux.h"
>
> +/*DP to Dual link DVI converter*/
> +static const uint8_t DP_DVI_CONVERTER_ID_4[] =3D "m2DVIa";
> +static const uint8_t DP_DVI_CONVERTER_ID_5[] =3D "3393N2";
> +
>  #define AUX_POWER_UP_WA_DELAY 500
>  #define I2C_OVER_AUX_DEFER_WA_DELAY 70
>  #define I2C_OVER_AUX_DEFER_WA_DELAY_1MS 1
> diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/dr=
ivers/gpu/drm/amd/display/include/ddc_service_types.h
> index b453ce5a9bfdb..4de59b66bb1a3 100644
> --- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> +++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
> @@ -117,8 +117,4 @@ struct av_sync_data {
>         uint8_t aud_del_ins3;/* DPCD 0002Dh */
>  };
>
> -/*DP to Dual link DVI converter*/
> -static const uint8_t DP_DVI_CONVERTER_ID_4[] =3D "m2DVIa";
> -static const uint8_t DP_DVI_CONVERTER_ID_5[] =3D "3393N2";
> -
>  #endif /* __DAL_DDC_SERVICE_TYPES_H__ */
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
