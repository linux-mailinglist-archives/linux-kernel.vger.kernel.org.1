Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1129528CEF4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 15:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728504AbgJMNLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 09:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgJMNLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 09:11:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D40C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:11:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e17so23947334wru.12
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 06:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hP4I1TSE0iiKe4uFVvPyKh5ZjOZU39ztMJs9eGzKphE=;
        b=d7rK4C8mM7F7Mme2iU2+7ZjVgizAOHZSsRSZe5ZPmBkFa7mDw5CR4Z/BftFM5EMzSn
         5A6rRSaYV9xFqjcsRSWKas27xMHogPcTggZkiLuwP96It/VGrrLF1KBgyKV6OtGNlsFK
         VjmRlV5FgTBf2LYV1MEXXTqpR3rIaiD4xgM7gPLQ/TfEOrpUnXicpnFfbXQKoJ0Gu4WM
         aNy/qZKePQWr+spaE7cwccOBkp/F/ZqsRO2UVEvDk6iM5m2hF1DQC98fPByh9Xacd5Vd
         FJJgWhfTHkZgWBM9ZjStW/z3oGUQIRDoSpoBHi8avv2MHVIomMrvaxvknNf15MYnqnXD
         GtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hP4I1TSE0iiKe4uFVvPyKh5ZjOZU39ztMJs9eGzKphE=;
        b=IVqk3e+IhLLQhKhJFZBbBS85Ggr1KnCZnxOHUKJcMxiIEKKWANlrmhq1V9U+8wQHqa
         A+qB07St4EJwO5PlZD2dGdp2me4QvbDPLx7jcMCbw5QoHpF1Lla3LV92NX2M7fhtu1G9
         EItRV+5xCjN/+3+jSrd0rxAs6kdf6HBjY74aEp+XwdM6VbClFtnd0yXyNJSKR/lTwI0Y
         j77G/JSd9qAPPvS+n5cTMK93f5eVu6yFftJaN3xfwu36QC19Xe615Hbb47UWygspkWqc
         YQMdlI+zMSgfzdrr0PuGWl2QKQveOnSaa4gD+NkVsG8d40xEaFq+Ruok6o/2KI6W0md4
         A/cg==
X-Gm-Message-State: AOAM533uczYYxUusTMRjECazlvgDCx5C/JGiIYqqiF6J2xR00SYjZpm0
        6/VA2ZX6S/p+qgpwcL/KLK87/25g2Ldx6D093lc=
X-Google-Smtp-Source: ABdhPJwCH8a1D0+3oh4RSFSUGPQPJdoPQvQkpSD/avgAkn1KFZidf8NIXW/31BQm3MiFaQm16TPeo37b3nLk2KIkeY4=
X-Received: by 2002:adf:f246:: with SMTP id b6mr29643949wrp.111.1602594707982;
 Tue, 13 Oct 2020 06:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201012114623.8583-1-bernard@vivo.com>
In-Reply-To: <20201012114623.8583-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 13 Oct 2020 09:11:36 -0400
Message-ID: <CADnq5_MH2EYWuumqtZ+UPF-5TAW_+91F6mHFEu3MScTGQOQ0Dg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove no need return value
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        Jun Lei <jun.lei@amd.com>, Samson Tam <Samson.Tam@amd.com>,
        Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
        Reza Amini <Reza.Amini@amd.com>,
        Brandon Syu <Brandon.Syu@amd.com>,
        Charlene Liu <Charlene.Liu@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Wyatt Wood <wyatt.wood@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Oct 12, 2020 at 9:44 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Functions (disable_all_writeback_pipes_for_stream &
> dc_enable_stereo & dc_post_update_surfaces_to_stream)
> always return true, there is no need to keep the return value.
> This change is to make the code a bit more readable.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c   | 17 +++++------------
>  drivers/gpu/drm/amd/display/dc/dc.h        |  2 +-
>  drivers/gpu/drm/amd/display/dc/dc_stream.h |  2 +-
>  3 files changed, 7 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 92eb1ca1634f..8dc598a632b5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -761,7 +761,7 @@ static bool dc_construct(struct dc *dc,
>         return false;
>  }
>
> -static bool disable_all_writeback_pipes_for_stream(
> +static void disable_all_writeback_pipes_for_stream(
>                 const struct dc *dc,
>                 struct dc_stream_state *stream,
>                 struct dc_state *context)
> @@ -770,8 +770,6 @@ static bool disable_all_writeback_pipes_for_stream(
>
>         for (i = 0; i < stream->num_wb_info; i++)
>                 stream->writeback_info[i].wb_enabled = false;
> -
> -       return true;
>  }
>
>  void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *context, struct dc_stream_state *stream, bool lock)
> @@ -1213,13 +1211,12 @@ bool dc_validate_seamless_boot_timing(const struct dc *dc,
>         return true;
>  }
>
> -bool dc_enable_stereo(
> +void dc_enable_stereo(
>         struct dc *dc,
>         struct dc_state *context,
>         struct dc_stream_state *streams[],
>         uint8_t stream_count)
>  {
> -       bool ret = true;
>         int i, j;
>         struct pipe_ctx *pipe;
>
> @@ -1234,8 +1231,6 @@ bool dc_enable_stereo(
>                                 dc->hwss.setup_stereo(pipe, dc);
>                 }
>         }
> -
> -       return ret;
>  }
>
>  /*
> @@ -1448,18 +1443,18 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
>         return false;
>  }
>
> -bool dc_post_update_surfaces_to_stream(struct dc *dc)
> +void dc_post_update_surfaces_to_stream(struct dc *dc)
>  {
>         int i;
>         struct dc_state *context = dc->current_state;
>
>         if ((!dc->optimized_required) || dc->optimize_seamless_boot_streams > 0)
> -               return true;
> +               return;
>
>         post_surface_trace(dc);
>
>         if (is_flip_pending_in_pipes(dc, context))
> -               return true;
> +               return;
>
>         for (i = 0; i < dc->res_pool->pipe_count; i++)
>                 if (context->res_ctx.pipe_ctx[i].stream == NULL ||
> @@ -1472,8 +1467,6 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
>
>         dc->optimized_required = false;
>         dc->wm_optimized_required = false;
> -
> -       return true;
>  }
>
>  struct dc_state *dc_create_state(struct dc *dc)
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index f50ef4255020..f79a3c318757 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -962,7 +962,7 @@ struct dc_flip_addrs {
>         bool triplebuffer_flips;
>  };
>
> -bool dc_post_update_surfaces_to_stream(
> +void dc_post_update_surfaces_to_stream(
>                 struct dc *dc);
>
>  #include "dc_stream.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> index d9888f316da6..0047ab33f88e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
> @@ -391,7 +391,7 @@ enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
>   * Enable stereo when commit_streams is not required,
>   * for example, frame alternate.
>   */
> -bool dc_enable_stereo(
> +void dc_enable_stereo(
>         struct dc *dc,
>         struct dc_state *context,
>         struct dc_stream_state *streams[],
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
