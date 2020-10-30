Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C04B29FC55
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 04:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJ3Dx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 23:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgJ3Dx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 23:53:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC0DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:53:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so1692554wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 20:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FD2h7D4v2HS4oDKnH1ozkl5z/Z0lmckPIvoRH81OaE=;
        b=lDwiUGqe31YYTdcVzh2ub/9hCxgwWbd4hg6znAi74KYcScH0EqreAG4C1XmeV0kkpr
         4BHK/9Z/rRbK5WVSko+DcPz1K3OA66BJL1FcM2WKFTJLpzyLYh4bMPZlt3zpL4AZ5ooQ
         O2qjHrGiWXyqLfyoxsNaWpXnF0OGpNTufvrdVm6r2UF6TuUQozh+/zKS8Xu7R5GmeC3d
         gMSFPgfX7Iuvsql+XtxR/7WZlqAuM/h+pTu5k7WTc0nJBQ+xZIbtjuxsv+H5T5vFP8ti
         RlGlPocWeEzuPBf3DvYMWXIMAi0XJe0lg1hKn0i+u04cDID55sfZMqnhL6k4/Ff3219L
         E2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FD2h7D4v2HS4oDKnH1ozkl5z/Z0lmckPIvoRH81OaE=;
        b=oNbf/0LKpIthKVvY2TFw3WTZhZ1Oc9dKK4G3TRf1LJMJRXaqTVpgKDM1TLh92g1MrY
         ncgIibbm/1yTwsdQaoFlTCRPvzeCgDfR5wxr9SXz0byz2qgf7WZE0mA98ayQcUHPPtVj
         EO184k51o7mL6oBC5OJk2vGp/4gl996Zbhsb7ONtE+IjDG9Bhtw5z98F+p/xAd0d2idi
         mfXrnWTdGbdJf8pZBvmxQVpqXRDxGE1j5tDI/wOQMco5KyfJVmHEJMcGDSU0HoWme2M0
         qt8LrU1LVSNZU2ss05IMrpznHba/sASJf4FEV5qp/hNACTmcYhuqXPYDkvfKMnJhamwI
         ENMg==
X-Gm-Message-State: AOAM532dJpUEnuRrjLiQ3yDkaqP9D8Upnehc/ZU4MQLPMNeJSlAsXjpx
        Vxq2koESWWRGh90VkApwpgh74sh4zcjSjcDUFI+cROII
X-Google-Smtp-Source: ABdhPJwmM5iqHlfZ6Cf/n9mn4d3K9CcA0cI58sMTvHlsxSEJSmOe/+uzB8GaUumH85FrOM3YWbSwfQLbgHq6ZDb7jIM=
X-Received: by 2002:a05:600c:25a:: with SMTP id 26mr247532wmj.39.1604030007030;
 Thu, 29 Oct 2020 20:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201026210039.3884312-1-arnd@kernel.org> <20201026210039.3884312-4-arnd@kernel.org>
In-Reply-To: <20201026210039.3884312-4-arnd@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Oct 2020 23:53:15 -0400
Message-ID: <CADnq5_MdJt02hpdTsvPDVwN4_1D7-1ybDexDreL6GjDipc_Yvw@mail.gmail.com>
Subject: Re: [PATCH 4/5] drm/amdgpu: fix build_coefficients() argument
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Lewis Huang <Lewis.Huang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Denis Efremov <efremov@linux.com>,
        Reza Amini <Reza.Amini@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Josip Pavic <Josip.Pavic@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 5:01 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> gcc -Wextra warns about a function taking an enum argument
> being called with a bool:
>
> drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c: In function 'apply_degamma_for_user_regamma':
> drivers/gpu/drm/amd/amdgpu/../display/modules/color/color_gamma.c:1617:29: warning: implicit conversion from 'enum <anonymous>' to 'enum dc_transfer_func_predefined' [-Wenum-conversion]
>  1617 |  build_coefficients(&coeff, true);
>
> It appears that a patch was added using the old calling conventions
> after the type was changed, and the value should actually be 0
> (TRANSFER_FUNCTION_SRGB) here instead of 1 (true).

This looks correct to me.  Harry, Leo?

Alex


>
> Fixes: 55a01d4023ce ("drm/amd/display: Add user_regamma to color module")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/amd/display/modules/color/color_gamma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> index b8695660b480..09bc2c249e1a 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> +++ b/drivers/gpu/drm/amd/display/modules/color/color_gamma.c
> @@ -1614,7 +1614,7 @@ static void apply_degamma_for_user_regamma(struct pwl_float_data_ex *rgb_regamma
>         struct pwl_float_data_ex *rgb = rgb_regamma;
>         const struct hw_x_point *coord_x = coordinates_x;
>
> -       build_coefficients(&coeff, true);
> +       build_coefficients(&coeff, TRANSFER_FUNCTION_SRGB);
>
>         i = 0;
>         while (i != hw_points_num + 1) {
> --
> 2.27.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
