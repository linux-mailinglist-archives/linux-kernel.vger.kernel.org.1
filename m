Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C852B1E87
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgKMPYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbgKMPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:24:15 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCC3C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:24:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id o15so10319944wru.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RlnsgXAqhx5O+gUIkanOxQMyzGK/8K/9bXQ6x1TuhEw=;
        b=g4sghMSloA5MoXSp+2EWSlMNkDdD8L0ikVibSCuQeIb9IHT15BSMCi+lOK6+oKEInx
         AEZ6707+Yxe6+jmtTQATHLh02ny5TwbG4YsZrjQeVvxb903XG1Ii5I2R2DydpzauFvyB
         WS+N12Etx7ht/fb4YfgfTYD2BcREe+XShSPX+ZwcNeTJ3whhRv/fz12FHgZgiLerOiOA
         c3okv+J9JCqqCMFSnvmMc2LC1Vz7BkWa2fFspcGPJS90jejtchbCQZTi08u9CVheo1ah
         5R136pUCqHBEcsmGSJ6G4cLzBofszhR76jjIEfKjOGJsvb9shc88R54seCPjr5qeVDCA
         aORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RlnsgXAqhx5O+gUIkanOxQMyzGK/8K/9bXQ6x1TuhEw=;
        b=VTS1AI3HFqhrx2MI8i3FsTqlNLQe6NpJ+MPNjJ8HOqvF7daFEdIgi8hCCXTK5kiRwT
         30/78Bkp9TQ6/szFqOgwTmtwoSavJDq2lyRvJ92BplwRrl8IO1Ij4SQ1s3u/inwXlx0r
         gNP4k7iYJIMu5R92Cdtd4pp226ra4p1Nc1fFiqQ2WlhRykZj75eZOagR9U2FH3bP1NDR
         c8bGLwkRdNTuxssdST465K//GnjinaBTauZKFgpFQx/9evfWQopMRl8F0fNqC6nWXBEj
         bq0rrcwubD1Lp3iJmtFn1gnE9demYzXIs8FULGa3oAQ7PLE7WvwnXDxrMfWG/qJxdYqB
         2VWA==
X-Gm-Message-State: AOAM532ZI2iSdmJpexJJbDkoy1oXwr4ZNhMSK5kdJ3CR+AVrMUoHxm+w
        PDtwWFtyq95rFZraxVF3NkU5ntjG7ej46iObuEc=
X-Google-Smtp-Source: ABdhPJyQZCe7HtPJ3bNlUzGKK0DUuW0GKd3K8ifcOW4D4SiAIXLhs+AM0tGomadQ5bbIShqpKa7/HWeVZ37cFfWJWbg=
X-Received: by 2002:a5d:6992:: with SMTP id g18mr4084367wru.362.1605281042319;
 Fri, 13 Nov 2020 07:24:02 -0800 (PST)
MIME-Version: 1.0
References: <20201113134938.4004947-1-lee.jones@linaro.org> <20201113134938.4004947-3-lee.jones@linaro.org>
In-Reply-To: <20201113134938.4004947-3-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 Nov 2020 10:23:50 -0500
Message-ID: <CADnq5_N6iRUWZ=nYqRFWjUjsDL65WXEOg__n+yvbtqqcRSsWgQ@mail.gmail.com>
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

Can we keep all of these strings together?

Alex

> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
