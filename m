Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDB41ADEE5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 16:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgDQN70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 09:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730563AbgDQN7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:59:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E94C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:59:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b11so3168442wrs.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nlisnDxdgaFK9V5Dj7hV44s/k7j4LFrmWkeS7EKcVH4=;
        b=oTlzjn5Ubl4uDmSRbU3FNlxzwSOHUoZihX42C64UMjMeA6UmGMLSduRX2Njrfk0gQ8
         D7e3DDH0eGcrclA1jzGtQm1/4cSMB4Tc2YEqQJu+mL2tFgr1UGH39zK6aGvKLeDvM8pG
         Xk3RoqwzEVQLAltynnwp+6f4lM4fRkgbrkhQC+gA/+lo9QKvD+FlAv/X2YzsFuDNXUKn
         X8+yg2mJz9U1D1JKy5l93PX9ooSZuVqTgwEslE+silEkn8aEg5PkQLkGKmaiBrrM4elF
         4cltOgrlSgzxhBaXKqG5HQN/71J++ukpLMn3L86HnusRUKf/sYYZBaTz6/i57YuXt08e
         AW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nlisnDxdgaFK9V5Dj7hV44s/k7j4LFrmWkeS7EKcVH4=;
        b=lz0A7kCyUgbRS/vtwmd4oFgQhRxaSIIfH9PaG6UspnbsOvLcSVn+LxF7r7948sEsAZ
         quywZJloA1en5uHp/fOwFCNWkkmAzRQ533YJzDoCmR2vbqh/pNtRFBtKTWtfaCusElsd
         Z2CBawU4p3wN7Xg+JXsQMhXHUedctxstMAVFEkHOgPibmZaC26KY3YgJoYwVhSsCDA0S
         0Qwpv8e6MR8ghNAl9Dmi5tOCbmrs+5TREtHMrDACt2jQPWGWKU+AkJJwUuB4gvQ45pjT
         brFAqxbm4Q3mNNiZGZFJZXyUOFqMj2pLSESG+0yLu8qMHCvuOLO419JF83UWcfmPFuS3
         lv4w==
X-Gm-Message-State: AGi0PuZVc4GvspP8dxFqqAsmScVNXr9oiYnIQ2Ki9fVhkYHYXuqRLHFe
        1J8yw/+psInWUy8tFP7aJUmPRKLaeP0xupc+MOg=
X-Google-Smtp-Source: APiQypJ5RuwNjBBNOOuUN0lsUE85uoH+Wm9g7IHWfDHg4sB7twV0nxMFj7A+ytVL+34mZSl79flpnTeuNeTKWvMKWbc=
X-Received: by 2002:a5d:4106:: with SMTP id l6mr4013319wrp.111.1587131963996;
 Fri, 17 Apr 2020 06:59:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200417101247.45616-1-yuehaibing@huawei.com>
In-Reply-To: <20200417101247.45616-1-yuehaibing@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 17 Apr 2020 09:59:12 -0400
Message-ID: <CADnq5_OCqKM3EYnjti0djh5hEPbRgO3qgJFeAU5tpqWc9PZiyA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/dc: remove unused variable 'video_optimized_pixel_rates'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 9:16 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1017:50:
>  warning: =E2=80=98video_optimized_pixel_rates=E2=80=99 defined but not u=
sed [-Wunused-const-variable=3D]
>  static const struct pixel_rate_range_table_entry video_optimized_pixel_r=
ates[] =3D {
>                                                   ^~~~~~~~~~~~~~~~~~~~~~~=
~~~~
>
> commit d8cd587d2bfd ("drm/amd/display: removing MODULO change for dcn2")
> left behind this unused vairable, remove it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  Thanks!

Alex

> ---
>  .../drm/amd/display/dc/dce/dce_clock_source.c | 33 -------------------
>  1 file changed, 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c b/driv=
ers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> index 2e992fbc0d71..d2ad0504b0de 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_clock_source.c
> @@ -1014,39 +1014,6 @@ struct pixel_rate_range_table_entry {
>         unsigned short div_factor;
>  };
>
> -static const struct pixel_rate_range_table_entry video_optimized_pixel_r=
ates[] =3D {
> -       // /1.001 rates
> -       {25170, 25180, 25200, 1000, 1001},      //25.2MHz   ->   25.17
> -       {59340, 59350, 59400, 1000, 1001},      //59.4Mhz   ->   59.340
> -       {74170, 74180, 74250, 1000, 1001},      //74.25Mhz  ->   74.1758
> -       {125870, 125880, 126000, 1000, 1001},   //126Mhz    ->  125.87
> -       {148350, 148360, 148500, 1000, 1001},   //148.5Mhz  ->  148.3516
> -       {167830, 167840, 168000, 1000, 1001},   //168Mhz    ->  167.83
> -       {222520, 222530, 222750, 1000, 1001},   //222.75Mhz ->  222.527
> -       {257140, 257150, 257400, 1000, 1001},   //257.4Mhz  ->  257.1429
> -       {296700, 296710, 297000, 1000, 1001},   //297Mhz    ->  296.7033
> -       {342850, 342860, 343200, 1000, 1001},   //343.2Mhz  ->  342.857
> -       {395600, 395610, 396000, 1000, 1001},   //396Mhz    ->  395.6
> -       {409090, 409100, 409500, 1000, 1001},   //409.5Mhz  ->  409.091
> -       {445050, 445060, 445500, 1000, 1001},   //445.5Mhz  ->  445.055
> -       {467530, 467540, 468000, 1000, 1001},   //468Mhz    ->  467.5325
> -       {519230, 519240, 519750, 1000, 1001},   //519.75Mhz ->  519.231
> -       {525970, 525980, 526500, 1000, 1001},   //526.5Mhz  ->  525.974
> -       {545450, 545460, 546000, 1000, 1001},   //546Mhz    ->  545.455
> -       {593400, 593410, 594000, 1000, 1001},   //594Mhz    ->  593.4066
> -       {623370, 623380, 624000, 1000, 1001},   //624Mhz    ->  623.377
> -       {692300, 692310, 693000, 1000, 1001},   //693Mhz    ->  692.308
> -       {701290, 701300, 702000, 1000, 1001},   //702Mhz    ->  701.2987
> -       {791200, 791210, 792000, 1000, 1001},   //792Mhz    ->  791.209
> -       {890100, 890110, 891000, 1000, 1001},   //891Mhz    ->  890.1099
> -       {1186810, 1186820, 1188000, 1000, 1001},//1188Mhz   -> 1186.8131
> -
> -       // *1.001 rates
> -       {27020, 27030, 27000, 1001, 1000}, //27Mhz
> -       {54050, 54060, 54000, 1001, 1000}, //54Mhz
> -       {108100, 108110, 108000, 1001, 1000},//108Mhz
> -};
> -
>  static bool dcn20_program_pix_clk(
>                 struct clock_source *clock_source,
>                 struct pixel_clk_params *pix_clk_params,
> --
> 2.17.1
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
