Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580462FDC33
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 23:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbhATWDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 17:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbhATWBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 17:01:08 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37565C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:00:28 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id p5so26732907oif.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 14:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=saDKMA0jB6EqXW9G0YL6Gf41CyarOu27mR26evtWnko=;
        b=BtvepDc1t5xMKDzkpkJDpstu6FHBOPnYBTqAWWHihI1oDL4ApXjvM6idp3egQajSz7
         fNwZ772pD1IQa6zfAhQf5X4bDazRxUDWpY73pefPy8zI5cNjEgw0VYZy4DVcwr54TflY
         OD3+YrUVc4qxJKU6r37mMI/Yd6PE+t67LTPGXrWZb/5EnQBCJhds9PuxxS9jhFagYH2F
         nipwUsTK/dU9ID4Tz0fC8TzBAE4SloyfNWQVWrJyHkqA1Io3lo5ii+f6MvQOspTg7axR
         ZHLAUCmZzqGfbGNp8hZSFWEY2zvrR3UKTU1eqvELhPCrBhhXq1zL6tdhO/atNcHyL1GF
         8ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=saDKMA0jB6EqXW9G0YL6Gf41CyarOu27mR26evtWnko=;
        b=LtJPTkxYQ33olTfZLml/+ie25LJYHqRCcddYC40XkAHhhFh2qvFzIPCoRMCxc0R9VW
         y4sGz1vlWoc1xpnzTsjW87qTlXM6bfmcP22U8IBiOmCx/Yu3NsyFX04To6q73fTYFInH
         fYoHwKZfFxw2SBoS+8EXR0aZfv52ZWoMJyid7CyjV0jc91GcKMitUvBm+RSJaOlbIvmu
         vFqR1H7YovvbSx7/ihn5QyW6CLX1Wm4aHRghpZLbiJhYuzMwA+O89R4qITLLKbUQkuxo
         K6Fwc400834+AEPI6gtOy+FGNG98/z+JFIUYdEIoyofc8E7lerFR2Ycn3XBJWEWyCvBk
         CMlg==
X-Gm-Message-State: AOAM532VX8tzAOR9OXY52+LTR+BMXcn/tudfce8Puj6Vqx6fGOfJW846
        MHEnwLCiZ6oZjfl+SdMZpFtgRgWjOjIHIu5o0Bw=
X-Google-Smtp-Source: ABdhPJzP2F7SIwkHGhdxKuUWAyKeMMGxwJDgWTGxnefy59uLaMXn/jA5IJF7QAjnU6rYRkJ4JLpq++9GBXSyjAg7zvE=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr4089486oib.123.1611180027641;
 Wed, 20 Jan 2021 14:00:27 -0800 (PST)
MIME-Version: 1.0
References: <1611127007-39308-1-git-send-email-abaci-bugfix@linux.alibaba.com> <3e2d3292-8611-68de-e1ed-7266fd41ce76@amd.com>
In-Reply-To: <3e2d3292-8611-68de-e1ed-7266fd41ce76@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 20 Jan 2021 17:00:16 -0500
Message-ID: <CADnq5_MXyZ5O8qroFjFhEupaiauXNVu7yT4KY3CGeQnVa0BkOA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Assign boolean values to a bool variable
To:     Harry Wentland <harry.wentland@amd.com>
Cc:     Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        Eric Bernstein <Eric.Bernstein@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Ye Bin <yebin10@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Jan 20, 2021 at 10:05 AM Harry Wentland <harry.wentland@amd.com> wrote:
>
> On 2021-01-20 2:16 a.m., Jiapeng Zhong wrote:
> > Fix the following coccicheck warnings:
> >
> > ./drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c:
> > 1009:6-16: WARNING: Assignment of 0/1 to bool variable.
> >
> > ./drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c:
> > 200:2-10: WARNING: Assignment of 0/1 to bool variable.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
>
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>
>
> Harry
>
> > ---
> >   .../display/dc/dml/dcn30/display_rq_dlg_calc_30.c  | 32 +++++++++++-----------
> >   1 file changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > index 5b5916b..0f14f20 100644
> > --- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
> > @@ -165,8 +165,8 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
> >       unsigned int swath_bytes_c = 0;
> >       unsigned int full_swath_bytes_packed_l = 0;
> >       unsigned int full_swath_bytes_packed_c = 0;
> > -     bool req128_l = 0;
> > -     bool req128_c = 0;
> > +     bool req128_l = false;
> > +     bool req128_c = false;
> >       bool surf_linear = (pipe_src_param.sw_mode == dm_sw_linear);
> >       bool surf_vert = (pipe_src_param.source_scan == dm_vert);
> >       unsigned int log2_swath_height_l = 0;
> > @@ -191,37 +191,37 @@ static void handle_det_buf_split(struct display_mode_lib *mode_lib,
> >               total_swath_bytes = 2 * full_swath_bytes_packed_l;
> >
> >       if (total_swath_bytes <= detile_buf_size_in_bytes) { //full 256b request
> > -             req128_l = 0;
> > -             req128_c = 0;
> > +             req128_l = false;
> > +             req128_c = false;
> >               swath_bytes_l = full_swath_bytes_packed_l;
> >               swath_bytes_c = full_swath_bytes_packed_c;
> >       } else if (!rq_param->yuv420) {
> > -             req128_l = 1;
> > -             req128_c = 0;
> > +             req128_l = true;
> > +             req128_c = false;
> >               swath_bytes_c = full_swath_bytes_packed_c;
> >               swath_bytes_l = full_swath_bytes_packed_l / 2;
> >       } else if ((double)full_swath_bytes_packed_l / (double)full_swath_bytes_packed_c < 1.5) {
> > -             req128_l = 0;
> > -             req128_c = 1;
> > +             req128_l = false;
> > +             req128_c = true;
> >               swath_bytes_l = full_swath_bytes_packed_l;
> >               swath_bytes_c = full_swath_bytes_packed_c / 2;
> >
> >               total_swath_bytes = 2 * swath_bytes_l + 2 * swath_bytes_c;
> >
> >               if (total_swath_bytes > detile_buf_size_in_bytes) {
> > -                     req128_l = 1;
> > +                     req128_l = true;
> >                       swath_bytes_l = full_swath_bytes_packed_l / 2;
> >               }
> >       } else {
> > -             req128_l = 1;
> > -             req128_c = 0;
> > +             req128_l = true;
> > +             req128_c = false;
> >               swath_bytes_l = full_swath_bytes_packed_l/2;
> >               swath_bytes_c = full_swath_bytes_packed_c;
> >
> >               total_swath_bytes = 2 * swath_bytes_l + 2 * swath_bytes_c;
> >
> >               if (total_swath_bytes > detile_buf_size_in_bytes) {
> > -                     req128_c = 1;
> > +                     req128_c = true;
> >                       swath_bytes_c = full_swath_bytes_packed_c/2;
> >               }
> >       }
> > @@ -1006,8 +1006,8 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
> >
> >       double min_dst_y_ttu_vblank = 0;
> >       unsigned int dlg_vblank_start = 0;
> > -     bool dual_plane = 0;
> > -     bool mode_422 = 0;
> > +     bool dual_plane = false;
> > +     bool mode_422 = false;
> >       unsigned int access_dir = 0;
> >       unsigned int vp_height_l = 0;
> >       unsigned int vp_width_l = 0;
> > @@ -1021,7 +1021,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
> >       double hratio_c = 0;
> >       double vratio_l = 0;
> >       double vratio_c = 0;
> > -     bool scl_enable = 0;
> > +     bool scl_enable = false;
> >
> >       double line_time_in_us = 0;
> >       //      double vinit_l;
> > @@ -1156,7 +1156,7 @@ static void dml_rq_dlg_get_dlg_params(struct display_mode_lib *mode_lib,
> >       // Source
> >       //                       dcc_en                   = src.dcc;
> >       dual_plane = is_dual_plane((enum source_format_class)(src->source_format));
> > -     mode_422 = 0; // TODO
> > +     mode_422 = false; // TODO
> >       access_dir = (src->source_scan == dm_vert); // vp access direction: horizontal or vertical accessed
> >       vp_height_l = src->viewport_height;
> >       vp_width_l = src->viewport_width;
> >
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
