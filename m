Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E02F3FC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405300AbhALWe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbhALWeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:34:25 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E3FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:33:45 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id d189so15687oig.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CnsNnPy+bsfMKTYrwaIqDDLsmnzZ6j8Zf4XsN63EhlU=;
        b=sfDjIrahyO+tZlCCvhLOVmMHfJXby6n+dOfQGqUYDpWNA+HJRItI7sIA6glJ+oQQLW
         cprmEzHiZbtgc78VCt60Y9ydiqhmgvRLdI2weafm4pkSNHG8o4X9jJLrUwavl2ZD+Z6H
         EuI+Ry1ENElnH/toY9rJFu5Ez4KtLJ92YM7BtWDqxapmvH+YV3ikppZikdpyQzqydESj
         qqcsyyuueeYEzdwSnCVI3hXKTnu1kU1DiOyJBxrZ1eTMWg7sVVuAJmr6ui2C73jV2qBK
         tv36MBk9FgSJBrJ0U3TxyiMZavkC+PCAaYO62yzKhqj4nEq84lQkxmIp9j+wtXbKMpqM
         RMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CnsNnPy+bsfMKTYrwaIqDDLsmnzZ6j8Zf4XsN63EhlU=;
        b=n0XcD/oI7XK8ADXWdWX9DZhBeU0RFCTfJrUyF0gWMmo5qPYtyRyCfbjiAdgJG3me2N
         DEJxM8Wlprf1A1emGNNQ9EW3obF+3DEsVFSiCjXQTruJHLkAGsTdrdq1Ggp3mjZLGgO6
         gRAAGiEQQtWGKWZemPQuazTHjyz5Wqw1f5EkoJD5IEeAdLAvHMJj69Ec0jKZlm1SFxR6
         YmO3jNYLFAbU2d9vDIsESpQK1/3+FMaL5S8+SR1uzJRdGtno2ZAkeSmjxIuA2VUhA7Qo
         c/EPzFg4GgGtHz8R8x/zDWHAj0LEMM922mripyBVtHqb/ojWMLMz1Wx5/aLEsrUe4Hlo
         e1jg==
X-Gm-Message-State: AOAM532ZJg/tKj2YAmOpYPpwxpnjQiMKNFSKbHa30FCpi6uGElBJI8Sl
        0dKYCRyL6k6SpIlSoBy0SxHciHfiCt2ZXNmconk=
X-Google-Smtp-Source: ABdhPJzUHHy22Etzqthjkdgc52meKfKSSamolFRvdaCr+cih6G1UX/Tr9FYEO3Q+fi35oSwYDecSCNaszYOd2c03Opk=
X-Received: by 2002:a54:4083:: with SMTP id i3mr833397oii.120.1610490825155;
 Tue, 12 Jan 2021 14:33:45 -0800 (PST)
MIME-Version: 1.0
References: <20210111191926.3688443-1-lee.jones@linaro.org> <20210111191926.3688443-31-lee.jones@linaro.org>
In-Reply-To: <20210111191926.3688443-31-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Jan 2021 17:33:33 -0500
Message-ID: <CADnq5_OrAqWKEz1dRDectDDuRz4d+LoizAfYd4-OpOEfYADYAQ@mail.gmail.com>
Subject: Re: [PATCH 30/40] drm/amd/display/dc/dce110/dce110_timing_generator_v:
 Demote kernel-doc abuse and line up comments
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

On Mon, Jan 11, 2021 at 2:20 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator_=
v.c:54: warning: Function parameter or member 'tg' not described in 'dce110=
_timing_generator_v_enable_crtc'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_timing_generator_=
v.c:216: warning: Function parameter or member 'tg' not described in 'dce11=
0_timing_generator_v_wait_for_vactive'
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
>  .../dc/dce110/dce110_timing_generator_v.c     | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generato=
r_v.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
> index a13a2f58944e3..c509384fff543 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_timing_generator_v.c
> @@ -46,17 +46,16 @@
>   *
>   ***********************************************************************=
***********/
>
> -/**
> -* Enable CRTCV
> -*/
> +/*
> + * Enable CRTCV
> + */
>
>  static bool dce110_timing_generator_v_enable_crtc(struct timing_generato=
r *tg)
>  {
>  /*
> -* Set MASTER_UPDATE_MODE to 0
> -* This is needed for DRR, and also suggested to be default value by Syed=
.
> -*/
> -
> + * Set MASTER_UPDATE_MODE to 0
> + * This is needed for DRR, and also suggested to be default value by Sye=
d.
> + */
>         uint32_t value;
>
>         value =3D 0;
> @@ -209,9 +208,9 @@ static void dce110_timing_generator_v_wait_for_vblank=
(struct timing_generator *t
>         }
>  }
>
> -/**
> -* Wait till we are in VActive (anywhere in VActive)
> -*/
> +/*
> + * Wait till we are in VActive (anywhere in VActive)
> + */
>  static void dce110_timing_generator_v_wait_for_vactive(struct timing_gen=
erator *tg)
>  {
>         while (dce110_timing_generator_v_is_in_vertical_blank(tg)) {
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
