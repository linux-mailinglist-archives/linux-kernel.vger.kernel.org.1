Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241C629F738
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgJ2V5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJ2V5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:57:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 14:57:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g12so4363916wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 14:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pxEzC4iXwKkMYRjWUeZ8FVw3qPnIVhPs3JqnX8Dyn5w=;
        b=bCqhzo47jGw85rQcqtMBdPjFZCPnL9SWqPqUzPqBEnVzPT3Z4LICGCDxQVeZQ4Khg0
         +5D3fPaoSAHqAzj3tlLWqh4opQHJjXOFZ2p9vvEa/wr+Av3jF5G1dMLuV+7lMJjJM/oI
         OW/Z9rTUiGD6Adc7mAolZBJly5PSx6XtD5TCW4K2sodlrbI7kdgFQMI+xcRgJQvUnuwN
         nRr+mnDVQ9zYxP3d6Ae/IY9kc1YBFce3LpxDhjU2ofW4q7BhLmeCDh5QMvr6SoJ78LTN
         wWigLf4IV+o1bYxi8c/zzfojTwIpdYA0++YGk8OVCktHLM4y7HVHSfsBK1CwIH8doRic
         RNYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pxEzC4iXwKkMYRjWUeZ8FVw3qPnIVhPs3JqnX8Dyn5w=;
        b=K370/8il/E6A2wqYnRHuFx+NPTOaTWmZV7OuNnV64FprkwZzF1BovA9IUQNC5fXE1+
         mOw+tQeE/b+eEHLcpdxhMpBIvTh4vmS9Z9JoTBoswXh3L+ubpHVJjs76xuMtjysZDpPk
         eQ7uzdxtculeKlmCDST2NR2zDk8t1gXH9io20aAEaLA9VgJYI7pcLelyPuPg9WIama5T
         r0ASPd5P1jGIX0u1+N5FVvvkqXK6S50v4mmZdREQuMUT318/PUSEDIps3g9w9M99gWnu
         yb/Qqp3nccg/QJ3ghff12EnwpnFDzLT2vXCWU1C/3c6MzqfjRXL7tWLOvLNK4llrXUcG
         N9dQ==
X-Gm-Message-State: AOAM531tqYGtEKHwwUwoBzf4cDhlMdosjvG5D4Luuye5RPaSXTw2QlFX
        HriOL256eEQQzSp/Tr4NVyz+3V1KnG+G5q2RIPjL6rEe
X-Google-Smtp-Source: ABdhPJzpiDfy/m0lgL/SMardM6RW4/vyeaZO9phyVOLb/QqxqHg2FFqkRZqboNDMl2qBkUsZ9GU2woxJp1tGZrB69J4=
X-Received: by 2002:adf:f181:: with SMTP id h1mr4554978wro.374.1604008622873;
 Thu, 29 Oct 2020 14:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <1603874171-106841-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1603874171-106841-1-git-send-email-zou_wei@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 29 Oct 2020 17:56:51 -0400
Message-ID: <CADnq5_ML599ZrTkRWtjm64EvU=p-uTVEEeVN5rXh+Yz6UhV3vA@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove useless if/else
To:     Zou Wei <zou_wei@huawei.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Wed, Oct 28, 2020 at 2:56 PM Zou Wei <zou_wei@huawei.com> wrote:
>
> Fix the following coccinelle report:
>
> ./drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c:1367:3-5:
> WARNING: possible condition with no effect (if == else)
>
> Both branches are the same, so remove the if/else altogether.
>
> Fixes: 81875979f0b2 ("drm/amd/display: Remove extra pairs of parentheses in dce_calcs.c")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index 2c6db37..e4f29cd 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -1364,13 +1364,10 @@ static void calculate_bandwidth(
>         /*if stutter and dram clock state change are gated before cursor then the cursor latency hiding does not limit stutter or dram clock state change*/
>         for (i = 0; i <= maximum_number_of_surfaces - 1; i++) {
>                 if (data->enable[i]) {
> -                       if (dceip->graphics_lb_nodownscaling_multi_line_prefetching == 1) {
> -                               data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
> -                       }
> -                       else {
> -                               /*maximum_latency_hiding(i) = minimum_latency_hiding(i) + 1 / vsr(i) * h_total(i) / pixel_rate(i) + 0.5 * total_dmifmc_urgent_latency*/
> -                               data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i], bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
> -                       }
> +                       /*maximum_latency_hiding(i) = minimum_latency_hiding(i) + 1 / vsr(i) **/
> +                       /*      h_total(i) / pixel_rate(i) + 0.5 * total_dmifmc_urgent_latency*/
> +                       data->maximum_latency_hiding[i] = bw_add(data->minimum_latency_hiding[i],
> +                               bw_mul(bw_frc_to_fixed(5, 10), data->total_dmifmc_urgent_latency));
>                         data->maximum_latency_hiding_with_cursor[i] = bw_min2(data->maximum_latency_hiding[i], data->cursor_latency_hiding[i]);
>                 }
>         }
> --
> 2.6.2
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
