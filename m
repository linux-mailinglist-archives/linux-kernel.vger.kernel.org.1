Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8A22F6762
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbhANRSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbhANRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:17:59 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B5C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:17:18 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id s2so6666072oij.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o7k9+/ImOTT6+O+qwUq3epvb/TE+j4Ep2dyuyw1DcuA=;
        b=GdRk7PiAEQ2racZn2Yzx9pBj0WEiHaF3uwKHS3reKPG1MTiN6y+MVTLxKkAdvRMha0
         Z3CQVHbWYxlXCeRPxZzv/bTr0cUtQOcXPQy49V8xjgqS5aTznmBg/XUeuBzXuO5XsLHR
         JojfAOML0XuvM3KiZCEt4PDyiM3KOrToOypLxrP7pYN+YuOMyZlS0Fgvhxrlw1/Y8sjC
         FFjlER+x5mHVSWWTkLUWI27PbrO5PWHfhIA1rmsf1f5R0AmjKB+De9RgvsQ9Y7cpwrPh
         zwWxXqNCHeQbzEGGVojA1gizs7EBU6owOXHT+2gaSB4dnWY0uzHDtcBqjm+w9i/u3RPm
         kzjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o7k9+/ImOTT6+O+qwUq3epvb/TE+j4Ep2dyuyw1DcuA=;
        b=Z+Vkdb8LSRx+fJwcV7mMvzNiH3OkQyACLF5ahKoPyhcD5gzJQdYw5+TMdj6zPuwmZj
         jsH4pCATqF8m4VXoGg1Hrht2fN2/f1xzGl7eL4ZgjPqmcn8RgRYCvPBeYJrKrxtTE4Pr
         T1PxpAqBPj3B1BUbC9eJDnAdLbiH7Uy1hbW6dTW6qJhCf0Cf61nItn8dhv+GKLCV/5xT
         DY9oJpQJhOxVo3WxNMt+fyjWF7CQcAElirvtkvEag+TXUro/Y+VmfJibxgR79kViTB7w
         PrkJuBG0VsTN3Fkd+stKWJ2yUYmM5/sY1jRW3J9sNeZPlYjuoFSyFH93Sp3N7GlZ+Rtq
         BAbA==
X-Gm-Message-State: AOAM5323WGvp8EPmpNUTjmsktLRhC/OVB0n7EVLQ5lsX+Sa5+uyz/MRL
        tFp3CdKDObV10+yytCUcNg96KV9irl0UR9aTgkc=
X-Google-Smtp-Source: ABdhPJwsFTzqKJOb92K9lMAKQ2TAuKfznueOrtNTEENsEck3k6NwpbJfi1zNkDGWF7xDukXcd1864+GPnAVpno9t1T0=
X-Received: by 2002:aca:6202:: with SMTP id w2mr3020084oib.5.1610644638152;
 Thu, 14 Jan 2021 09:17:18 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-19-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-19-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:17:07 -0500
Message-ID: <CADnq5_P7zmV5sTmOTPQHRjnPmr2oTb=rupsBUNXZEDeW7eaz_Q@mail.gmail.com>
Subject: Re: [PATCH 18/30] drm/amd/display/dc/core/dc_link: Move some local
 data from the stack to the heap
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

On Wed, Jan 13, 2021 at 3:08 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c: In function =E2=
=80=98dc_link_construct=E2=80=99:
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:1588:1: warning:=
 the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-tha=
n=3D]
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
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index 8ccda8b9ac2eb..3366a49f11dc7 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1364,13 +1364,17 @@ static bool dc_link_construct(struct dc_link *lin=
k,
>         struct dc_context *dc_ctx =3D init_params->ctx;
>         struct encoder_init_data enc_init_data =3D { 0 };
>         struct panel_cntl_init_data panel_cntl_init_data =3D { 0 };
> -       struct integrated_info info =3D {{{ 0 }}};
> +       struct integrated_info *info;
>         struct dc_bios *bios =3D init_params->dc->ctx->dc_bios;
>         const struct dc_vbios_funcs *bp_funcs =3D bios->funcs;
>         struct bp_disp_connector_caps_info disp_connect_caps_info =3D { 0=
 };
>
>         DC_LOGGER_INIT(dc_ctx->logger);
>
> +       info =3D kzalloc(sizeof(info), GFP_KERNEL);
> +       if (!info)
> +               goto create_fail;
> +
>         link->irq_source_hpd =3D DC_IRQ_SOURCE_INVALID;
>         link->irq_source_hpd_rx =3D DC_IRQ_SOURCE_INVALID;
>
> @@ -1532,12 +1536,12 @@ static bool dc_link_construct(struct dc_link *lin=
k,
>         }
>
>         if (bios->integrated_info)
> -               info =3D *bios->integrated_info;
> +               memcpy(info, bios->integrated_info, sizeof(*info));
>
>         /* Look for channel mapping corresponding to connector and device=
 tag */
>         for (i =3D 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
>                 struct external_display_path *path =3D
> -                       &info.ext_disp_conn_info.path[i];
> +                       &info->ext_disp_conn_info.path[i];
>
>                 if (path->device_connector_id.enum_id =3D=3D link->link_i=
d.enum_id &&
>                     path->device_connector_id.id =3D=3D link->link_id.id =
&&
> @@ -1584,6 +1588,8 @@ static bool dc_link_construct(struct dc_link *link,
>                 link->hpd_gpio =3D NULL;
>         }
>
> +       kfree(info);
> +
>         return false;
>  }
>
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
