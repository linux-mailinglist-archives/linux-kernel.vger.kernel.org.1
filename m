Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5062AE478
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 00:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbgKJXzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 18:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgKJXzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 18:55:43 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AACC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:55:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 10so183264wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 15:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=z+yBfCX2B+4qYUf6B+N0IjqaPLgV4glZlJWvIH+aH9I=;
        b=KTc2bfl5TBP7EGxgz0EAjsl4fik58VwFRmPpwzHLVpUXjPM/2lgnsJhlM5Nir2djh0
         ReI8TnLWoKplYnSTbn1N64UljnY87U+L7jtuLkOFi7JJZxte0fH0PwyeynEywzyD0l+H
         nol1qshwMHhP57/g/xBx5CKykOlc+kXNPr/O3HwuVgApKno7dgNS9bP4QKexSEiqqpin
         eL7uWRpsjNHcXfQDRrpkseRchJSa+6EGb2ZQ5urGw7RixA47JoTZn8Xfl8sAbWlkAkJt
         8WoseXh2v3IbsMsT9VlGZhxTeskyulLQCTXZDJune9Lvi+3sd5H9xn1qQbCSuV37iuK7
         vccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z+yBfCX2B+4qYUf6B+N0IjqaPLgV4glZlJWvIH+aH9I=;
        b=Hx6wPIxekP6Zij/jPvreufHOqSNVS/8OOd+YbaclDN1eZ1gS+07qEjczVLmenPEBHE
         KC3BDQdUPtmqGxUNyKVsHLTFTDejO+Cs5hg06jaD2NFX/KMU1XPF4QR9/U0b+FZQsblo
         5xMziYx1S/4aU1vnJdlXGep4lO02hE9bejowou3R4wTjpi6hyE4TcnR4hVITD4QUsabU
         C3LPbXCa3F9EGjpyPpEScMlRdiEpgVmse9s3vyFUshos05pN81hp3LSCjT9LissKsDLR
         jYjnYXSpz4mqdw611uJ38y+0Q7Db1AmbNxcQb3G7FGPhRSJwMtuKcIy7tA1Ba3GZg24i
         PM6g==
X-Gm-Message-State: AOAM530sc9BudNx+V1d4rqtuFWGieSy9IeIGz9nI9ajsEiUZq9eigKmC
        6wFdVJF5kF2pMv9N7SrGrb7Cwv9a8i+jjBQTGYg=
X-Google-Smtp-Source: ABdhPJzSYbuwJzedvCR1N8X8dNerQyyEPYEPZSTmw4sa+VZ+ms2v3palwlBgV1bk1M3Hj56fe2JbEmkmelE6NwTn9iQ=
X-Received: by 2002:a1c:46c6:: with SMTP id t189mr612690wma.79.1605052540270;
 Tue, 10 Nov 2020 15:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20201110193112.988999-1-lee.jones@linaro.org> <20201110193112.988999-18-lee.jones@linaro.org>
In-Reply-To: <20201110193112.988999-18-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 10 Nov 2020 18:55:28 -0500
Message-ID: <CADnq5_P29dMM7sbiDY-b0U+nyHppBXduVTY4O2OCG3r=zyEsmw@mail.gmail.com>
Subject: Re: [PATCH 17/30] drm/radeon/r600_cs: Fix some doc-rot and supply
 missing function param docs
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

On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> Fixes the following W=3D1 kernel build warning(s):
>
>  drivers/gpu/drm/radeon/r600_cs.c:793: warning: Function parameter or mem=
ber 'p' not described in 'r600_cs_packet_parse_vline'
>  drivers/gpu/drm/radeon/r600_cs.c:793: warning: Excess function parameter=
 'parser' description in 'r600_cs_packet_parse_vline'
>  drivers/gpu/drm/radeon/r600_cs.c:826: warning: Function parameter or mem=
ber 'p' not described in 'r600_cs_common_vline_parse'
>  drivers/gpu/drm/radeon/r600_cs.c:826: warning: Excess function parameter=
 'parser' description in 'r600_cs_common_vline_parse'
>  drivers/gpu/drm/radeon/r600_cs.c:968: warning: Function parameter or mem=
ber 'p' not described in 'r600_cs_check_reg'
>  drivers/gpu/drm/radeon/r600_cs.c:968: warning: Excess function parameter=
 'parser' description in 'r600_cs_check_reg'
>  drivers/gpu/drm/radeon/r600_cs.c:1473: warning: Function parameter or me=
mber 'base_offset' not described in 'r600_check_texture_resource'
>  drivers/gpu/drm/radeon/r600_cs.c:1473: warning: Function parameter or me=
mber 'mip_offset' not described in 'r600_check_texture_resource'
>  drivers/gpu/drm/radeon/r600_cs.c:1473: warning: Function parameter or me=
mber 'tiling_flags' not described in 'r600_check_texture_resource'
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
>  drivers/gpu/drm/radeon/r600_cs.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r6=
00_cs.c
> index 390a9621604ae..f20b619466816 100644
> --- a/drivers/gpu/drm/radeon/r600_cs.c
> +++ b/drivers/gpu/drm/radeon/r600_cs.c
> @@ -782,7 +782,7 @@ static int r600_cs_track_check(struct radeon_cs_parse=
r *p)
>
>  /**
>   * r600_cs_packet_parse_vline() - parse userspace VLINE packet
> - * @parser:            parser structure holding parsing context.
> + * @p:         parser structure holding parsing context.
>   *
>   * This is an R600-specific function for parsing VLINE packets.
>   * Real work is done by r600_cs_common_vline_parse function.
> @@ -801,7 +801,7 @@ static int r600_cs_packet_parse_vline(struct radeon_c=
s_parser *p)
>
>  /**
>   * r600_cs_common_vline_parse() - common vline parser
> - * @parser:            parser structure holding parsing context.
> + * @p:                 parser structure holding parsing context.
>   * @vline_start_end:    table of vline_start_end registers
>   * @vline_status:       table of vline_status registers
>   *
> @@ -956,7 +956,7 @@ static int r600_cs_parse_packet0(struct radeon_cs_par=
ser *p,
>
>  /**
>   * r600_cs_check_reg() - check if register is authorized or not
> - * @parser: parser structure holding parsing context
> + * @p: parser structure holding parsing context
>   * @reg: register we are testing
>   * @idx: index into the cs buffer
>   *
> @@ -1460,6 +1460,9 @@ static void r600_texture_size(unsigned nfaces, unsi=
gned blevel, unsigned llevel,
>   * @idx: index into the cs buffer
>   * @texture: texture's bo structure
>   * @mipmap: mipmap's bo structure
> + * @base_offset: base offset (used for error checking)
> + * @mip_offset: mip offset (used for error checking)
> + * @tiling_flags: tiling flags
>   *
>   * This function will check that the resource has valid field and that
>   * the texture and mipmap bo object are big enough to cover this resourc=
e.
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
