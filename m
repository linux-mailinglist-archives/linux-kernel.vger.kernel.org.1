Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D12A26AD98
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgIOT32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgIOT1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:27:54 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF68C061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:18:39 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so555811wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 12:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/X0kPNzrsM6p6b+lxt3nMCOYmOHQKIBg29Sofy0KXM=;
        b=uF0v2qSS9zDREj+6qqNypGZh8hcdiqOqlYhQer2PYoZWyE2Ld6v1CUhFqykffdALD6
         qUq83ch4WvQATgF3c2qjQRDoc/M51bgwXMERec/TwtHs60IAVtYUa5lEThYNppJxII1h
         LWjpI3YmwFdKja7JosS2mqmV5qYAfbpg2RPVVVclLdxaMwMiszeLgHypUV0zem80pbRM
         9b7iFG6oWl9szHZ/AJzL1iKFj5DQ8G+JEhldt7D1i6jO96MlYv1um0Sbyr5Av0/u4vJT
         0LWrsoydArYLmz3EMXfI3MTud7ibPZkBD03ZF+yOxCaLeGTHvk/0xoiaZZG+ImnRzztl
         nJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/X0kPNzrsM6p6b+lxt3nMCOYmOHQKIBg29Sofy0KXM=;
        b=kVJRA5kbnJji5JQLFhIQfgtmCmceBtc5ybPtGSooSNMYKkfN6ze5mw4Pq6+N1g67Zx
         jCdPe/2BlPvsT6KTFktV/Ke2vcjBKI4JtLOxnohJeDLylcsPMGam0d3a9Zf4hOy5FaVr
         P7JbcVC2baC8BlqdjeZZfXPFnS+gehD4z2d3+0Yg+Y+i2FifyBQNL84OzqUr8bCvArGP
         co3Z9gQzXe6rqbkVOt8HFx+W5vQlQYrsT/zHpRrIeG1PvL8CzcaNzdM/QFKX+XyElnrL
         JrAL+QCU8toyNm44vdiub2/gkT0ktxZ1UZzJXv1nFq7X3xRpCi419hPecNKh9Y8HAuHG
         KIRA==
X-Gm-Message-State: AOAM53020rqfK2n5bjC/fhLnhx3OTqHTvdLQaKLReN0ai4otfeQhJ6+A
        Qdh67GkdQswFeC4HDC1XmBLumfKguOYRMSXffT8=
X-Google-Smtp-Source: ABdhPJxgHA6GYBXBtpwTuEnRRMJTLGbVacOxKpOGXOEt+I2uucTSssj2I4MLSQEl07O7b7daVG90ScPubjl2P3IuJmk=
X-Received: by 2002:a7b:c141:: with SMTP id z1mr853417wmi.79.1600197517755;
 Tue, 15 Sep 2020 12:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200910020520.9973-1-bernard@vivo.com>
In-Reply-To: <20200910020520.9973-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 15 Sep 2020 15:18:26 -0400
Message-ID: <CADnq5_P4an7Jx0vPxBY9Mt8OHNOZsyx0MxCG4Mi8XVdMX-70yA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: optimize code runtime a bit
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Wenjing Liu <wenjing.liu@amd.com>, Aric Cyr <aric.cyr@amd.com>,
        abdoulaye berthe <abdoulaye.berthe@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        jinlong zhang <jinlong.zhang@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Sep 10, 2020 at 3:23 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> In fnction is_cr_done & is_ch_eq_done, when done = false
> happened once, no need to circle left ln_count.
> This change is to make the code run a bit fast.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> index b2be6ad5101d..53e30be8b66a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
> @@ -373,34 +373,30 @@ static void dpcd_set_lt_pattern_and_lane_settings(
>  static bool is_cr_done(enum dc_lane_count ln_count,
>         union lane_status *dpcd_lane_status)
>  {
> -       bool done = true;
>         uint32_t lane;
>         /*LANEx_CR_DONE bits All 1's?*/
>         for (lane = 0; lane < (uint32_t)(ln_count); lane++) {
>                 if (!dpcd_lane_status[lane].bits.CR_DONE_0)
> -                       done = false;
> +                       return false;
>         }
> -       return done;
> -
> +       return true;
>  }
>
>  static bool is_ch_eq_done(enum dc_lane_count ln_count,
>         union lane_status *dpcd_lane_status,
>         union lane_align_status_updated *lane_status_updated)
>  {
> -       bool done = true;
>         uint32_t lane;
>         if (!lane_status_updated->bits.INTERLANE_ALIGN_DONE)
> -               done = false;
> +               return false;
>         else {
>                 for (lane = 0; lane < (uint32_t)(ln_count); lane++) {
>                         if (!dpcd_lane_status[lane].bits.SYMBOL_LOCKED_0 ||
>                                 !dpcd_lane_status[lane].bits.CHANNEL_EQ_DONE_0)
> -                               done = false;
> +                               return false;
>                 }
>         }
> -       return done;
> -
> +       return true;
>  }
>
>  static void update_drive_settings(
> --
> 2.28.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
