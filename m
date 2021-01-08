Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2960A2EFA0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbhAHVOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbhAHVOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:14:21 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2529C061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 13:13:40 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id w124so12914635oia.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 13:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B+8hnVZITAMIkeafbj19vWqz4gaQsqmqqDzoGimH9ao=;
        b=tE/gVRzmGZ/6pMkoQIhOgaMPi0Ic5aaIXYvui3z4H+8orGwuphAlkCNt7VJRbPyjZ6
         QLkxZvuM7XVChAnlAGBUa6jvnMJKSHMeVrUWsXyTnnDzN9DA/Za0K6NqkBO+pJXce+3M
         WgwXXGH+JEARnOzAB92+VCmCUUz6X3gD8Lu59o6ATeK8QE1l3RJEqDnpEEh0Pis3MMFu
         THSJH/Tge3KjjYwphFxVYBAotowaHYQIGn38N3W+1+08v4nVb9NKynN3MdM0HFSPi4S5
         +lLYQ42/wNcYWwM76DznGmNunYkOWG2OuLJmhzs7n7VGgwBess8gV1FEAWVmnwjePOv/
         nKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B+8hnVZITAMIkeafbj19vWqz4gaQsqmqqDzoGimH9ao=;
        b=saIL11Hj2DioNtp41xoIw98JMwFyePfLjOOSdNKAAZtYbx2cbui3veXOodNsXzG22x
         7A085gR4QgnP9VlOu9Qk7aiBkfcQ7CfKtCri2bttyDZNSXJqdgY9tTsbELS84n+7GX+K
         1+I806JSISdhDpVBjKHDZa2jEfJ+uT+17P4jWQMpPaVVh9RE6Y9Ph7pmc6JucVgbim0Z
         sjvI9Ht8Z3k5TNvuCE0RgDELHP4MHAdgc2OfF1ZdKwkidkM7mDWwheBFuau4x7NdIhon
         1sygSuFKPx2C+vb4AN0D+YMCRPlfYRkELUrzEsOa8z6N7NdLybT80qd8Id7oFupKpyeR
         YJgw==
X-Gm-Message-State: AOAM531VjjfU3kwvBzxNnr213ItfYuwMKvEQYi/cKqTnxcQ0KBqQg5fG
        CBIsvKkrOCbEpFyMGdVgy+9dp7Au4VDoEREzW+M=
X-Google-Smtp-Source: ABdhPJww350+9N9LUdUp2F3/FBMccu07YTAbrdlVovNeowk5hu7ZrXoBnvSqbjZxtgdi3/moNtRBojEjjPGsvKluDq4=
X-Received: by 2002:a54:4083:: with SMTP id i3mr3484762oii.120.1610140420341;
 Fri, 08 Jan 2021 13:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20210108201457.3078600-1-lee.jones@linaro.org> <20210108201457.3078600-26-lee.jones@linaro.org>
In-Reply-To: <20210108201457.3078600-26-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 8 Jan 2021 16:13:29 -0500
Message-ID: <CADnq5_N7pcv4Dx85n5QygAHX=Bx=FhEqJMpnQ3m_uuKtuGCPKQ@mail.gmail.com>
Subject: Re: [PATCH 25/40] drm/amd/display/dc/dce/dce_link_encoder: Make
 functions invoked by reference static
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Leo Li <sunpeng.li@amd.com>, Mauro Rossi <issor.oruam@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Jan 8, 2021 at 3:15 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1200:6: =
warning: no previous prototype for =E2=80=98dce60_link_encoder_enable_dp_ou=
tput=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1239:6: =
warning: no previous prototype for =E2=80=98dce60_link_encoder_enable_dp_ms=
t_output=E2=80=99 [-Wmissing-prototypes]
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_link_encoder.c:1429:6: =
warning: no previous prototype for =E2=80=98dce60_link_encoder_dp_set_phy_p=
attern=E2=80=99 [-Wmissing-prototypes]
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Leo Li <sunpeng.li@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian K=C3=B6nig" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Mauro Rossi <issor.oruam@gmail.com>
> Cc: amd-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> index 210466b2d8631..0ef2f4d9d8bf3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> @@ -1197,7 +1197,7 @@ void dce110_link_encoder_enable_dp_mst_output(
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
>  /* enables DP PHY output */
> -void dce60_link_encoder_enable_dp_output(
> +static void dce60_link_encoder_enable_dp_output(
>         struct link_encoder *enc,
>         const struct dc_link_settings *link_settings,
>         enum clock_source_id clock_source)
> @@ -1236,7 +1236,7 @@ void dce60_link_encoder_enable_dp_output(
>  }
>
>  /* enables DP PHY output in MST mode */
> -void dce60_link_encoder_enable_dp_mst_output(
> +static void dce60_link_encoder_enable_dp_mst_output(
>         struct link_encoder *enc,
>         const struct dc_link_settings *link_settings,
>         enum clock_source_id clock_source)
> @@ -1426,7 +1426,7 @@ void dce110_link_encoder_dp_set_phy_pattern(
>
>  #if defined(CONFIG_DRM_AMD_DC_SI)
>  /* set DP PHY test and training patterns */
> -void dce60_link_encoder_dp_set_phy_pattern(
> +static void dce60_link_encoder_dp_set_phy_pattern(
>         struct link_encoder *enc,
>         const struct encoder_set_dp_phy_pattern_param *param)
>  {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
