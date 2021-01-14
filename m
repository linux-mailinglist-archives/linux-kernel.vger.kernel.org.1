Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B052F6770
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhANRXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbhANRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:23:01 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7207C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:22:20 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id x13so6673207oic.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=37ddaPMJznDGqfBXLUSWG1nOoKmE58YLamtgoypX3IU=;
        b=p39y94sDm9dB8c0hQIsd3MfKJYptGKEW6eiAeOc6mjkiEdYdL70MNYnn6uJgAC6rFW
         avjS8S2xiptxaJYSjnB76B6lHNz7QH07yjBMWluW9B4LRnS+Bb8S6ETWOywWq/qdnGa3
         pKkEIBIOMGQYeYQJKacNXfLiHbmzY13f26NtRB/wyVF+zm4dK6Tbr93AdurRmKlyseQb
         1uDh1B9kyD48+57L9S5r096oiCnBvtqlrwstBW+DQZPI4bDPRBDZQOxz2FGljXcrPU0i
         9cMeGSRV/psIi8gFZ29x/b/Y4F6TUBuUNVgcxKmhY6z/b3jZ6qHXGARRC8hpBEuy8J0p
         BZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=37ddaPMJznDGqfBXLUSWG1nOoKmE58YLamtgoypX3IU=;
        b=qppUeVzu6L9kj4g4EPYN2lmFmS3bfy6w+a/BbDdSl4uepeGwe+6zaeWchhC05ThtPy
         rM7ROsH0Nwunf0kCclsJ2I+bNF9sy/dZq0vpt5r/lfMWjFW9MEdG9U6Z60UuvIPhg/6J
         lVgzW4ncMd+LkestylCl3Viw4eJw6dIZqfXxx36GajijYlNrp5ZsWMgFZY0vxcnprr38
         o3MuEh+wQGt9ZOcK4QA4jG6VIPmqh3vEPIvw8wsdNMjPEsetbnGADggMl2CWqkAD5FpP
         wrQcmfHA58zaQaGqIsk959AlcR6+T2JKKy1XXnbNdnL/SOFVaic/7vw/8JSJwPniHm8h
         AKew==
X-Gm-Message-State: AOAM532OioW4WX5+YBTtqV7A/tfyhhKS/yQL+pa4cITNw/PS/e/bFI6U
        MSiu+M2npY90udnZcdPvVKfWIQcdMXPkKet6VJA=
X-Google-Smtp-Source: ABdhPJy3q6REKnQtFOsH3kR612FjwY/o2f5ag9r1qFY/yokHo7wXC3LoNqqjv3P28ocWCKUXTNenI3YFtj4f6OVNFFI=
X-Received: by 2002:aca:4f97:: with SMTP id d145mr3121002oib.123.1610644940159;
 Thu, 14 Jan 2021 09:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20210113080752.1003793-1-lee.jones@linaro.org> <20210113080752.1003793-21-lee.jones@linaro.org>
In-Reply-To: <20210113080752.1003793-21-lee.jones@linaro.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 14 Jan 2021 12:22:09 -0500
Message-ID: <CADnq5_O6QD17sFLTPBUGcKi5FKH2o8A0fkPqg5xNeadbCisw+g@mail.gmail.com>
Subject: Re: [PATCH 20/30] drm/amd/display/dc/core/dc: Fix a bunch of
 documentation misdemeanours
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
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:287: warning: Cannot =
understand  ***************************************************************=
**************
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:366: warning: Functio=
n parameter or member 'crc_window' not described in 'dc_stream_configure_cr=
c'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:430: warning: Functio=
n parameter or member 'r_cr' not described in 'dc_stream_get_crc'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:430: warning: Functio=
n parameter or member 'g_y' not described in 'dc_stream_get_crc'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:430: warning: Functio=
n parameter or member 'b_cb' not described in 'dc_stream_get_crc'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Functi=
on parameter or member 'dc' not described in 'dc_check_update_surfaces_for_=
stream'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Functi=
on parameter or member 'updates' not described in 'dc_check_update_surfaces=
_for_stream'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Functi=
on parameter or member 'surface_count' not described in 'dc_check_update_su=
rfaces_for_stream'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Functi=
on parameter or member 'stream_update' not described in 'dc_check_update_su=
rfaces_for_stream'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2026: warning: Functi=
on parameter or member 'stream_status' not described in 'dc_check_update_su=
rfaces_for_stream'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2822: warning: Functi=
on parameter or member 'dc' not described in 'dc_interrupt_set'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2822: warning: Functi=
on parameter or member 'src' not described in 'dc_interrupt_set'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2822: warning: Functi=
on parameter or member 'enable' not described in 'dc_interrupt_set'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2962: warning: Functi=
on parameter or member 'link' not described in 'dc_link_add_remote_sink'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2962: warning: Functi=
on parameter or member 'edid' not described in 'dc_link_add_remote_sink'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2962: warning: Functi=
on parameter or member 'len' not described in 'dc_link_add_remote_sink'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:2962: warning: Functi=
on parameter or member 'init_data' not described in 'dc_link_add_remote_sin=
k'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3022: warning: Functi=
on parameter or member 'link' not described in 'dc_link_remove_remote_sink'
>  drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3022: warning: Functi=
on parameter or member 'sink' not described in 'dc_link_remove_remote_sink'
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
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 33 ++++++++++++------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index 0a07e608485ff..3ee3978fae977 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -284,20 +284,16 @@ static void dc_perf_trace_destroy(struct dc_perf_tr=
ace **perf_trace)
>  }
>
>  /**
> - ***********************************************************************=
******
> - *  Function: dc_stream_adjust_vmin_vmax
> + *  dc_stream_adjust_vmin_vmax:
>   *
> - *  @brief
> - *     Looks up the pipe context of dc_stream_state and updates the
> - *     vertical_total_min and vertical_total_max of the DRR, Dynamic Ref=
resh
> - *     Rate, which is a power-saving feature that targets reducing panel
> - *     refresh rate while the screen is static
> + *  Looks up the pipe context of dc_stream_state and updates the
> + *  vertical_total_min and vertical_total_max of the DRR, Dynamic Refres=
h
> + *  Rate, which is a power-saving feature that targets reducing panel
> + *  refresh rate while the screen is static
>   *
> - *  @param [in] dc: dc reference
> - *  @param [in] stream: Initial dc stream state
> - *  @param [in] adjust: Updated parameters for vertical_total_min and
> - *  vertical_total_max
> - ***********************************************************************=
******
> + *  @dc:     dc reference
> + *  @stream: Initial dc stream state
> + *  @adjust: Updated parameters for vertical_total_min and vertical_tota=
l_max
>   */
>  bool dc_stream_adjust_vmin_vmax(struct dc *dc,
>                 struct dc_stream_state *stream,
> @@ -355,6 +351,7 @@ bool dc_stream_get_crtc_position(struct dc *dc,
>   * @dc: DC Object
>   * @stream: The stream to configure CRC on.
>   * @enable: Enable CRC if true, disable otherwise.
> + * @crc_window: CRC window (x/y start/end) information
>   * @continuous: Capture CRC on every frame if true. Otherwise, only capt=
ure
>   *              once.
>   *
> @@ -420,7 +417,9 @@ bool dc_stream_configure_crc(struct dc *dc, struct dc=
_stream_state *stream,
>   * dc_stream_get_crc() - Get CRC values for the given stream.
>   * @dc: DC object
>   * @stream: The DC stream state of the stream to get CRCs from.
> - * @r_cr, g_y, b_cb: CRC values for the three channels are stored here.
> + * @r_cr: CRC value for the first of the 3 channels stored here.
> + * @g_y:  CRC value for the second of the 3 channels stored here.
> + * @b_cb: CRC value for the third of the 3 channels stored here.
>   *
>   * dc_stream_configure_crc needs to be called beforehand to enable CRCs.
>   * Return false if stream is not found, or if CRCs are not enabled.
> @@ -2012,7 +2011,7 @@ static enum surface_update_type check_update_surfac=
es_for_stream(
>         return overall_type;
>  }
>
> -/**
> +/*
>   * dc_check_update_surfaces_for_stream() - Determine update type (fast, =
med, or full)
>   *
>   * See :c:type:`enum surface_update_type <surface_update_type>` for expl=
anation of update types
> @@ -2815,7 +2814,7 @@ enum dc_irq_source dc_interrupt_to_irq_source(
>         return dal_irq_service_to_irq_source(dc->res_pool->irqs, src_id, =
ext_id);
>  }
>
> -/**
> +/*
>   * dc_interrupt_set() - Enable/disable an AMD hw interrupt source
>   */
>  bool dc_interrupt_set(struct dc *dc, enum dc_irq_source src, bool enable=
)
> @@ -2949,7 +2948,7 @@ static bool link_add_remote_sink_helper(struct dc_l=
ink *dc_link, struct dc_sink
>         return true;
>  }
>
> -/**
> +/*
>   * dc_link_add_remote_sink() - Create a sink and attach it to an existin=
g link
>   *
>   * EDID length is in bytes
> @@ -3012,7 +3011,7 @@ struct dc_sink *dc_link_add_remote_sink(
>         return NULL;
>  }
>
> -/**
> +/*
>   * dc_link_remove_remote_sink() - Remove a remote sink from a dc_link
>   *
>   * Note that this just removes the struct dc_sink - it doesn't
> --
> 2.25.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
