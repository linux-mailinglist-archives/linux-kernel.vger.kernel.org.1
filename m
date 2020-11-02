Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD752A336F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgKBS6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgKBS6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:58:09 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0865C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 10:58:08 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id n15so15893910wrq.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 10:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxeRfZAIWbudLvp9kWivxncFadrsvxo56vZJQ20jKs4=;
        b=kOusrNgTcZm1MxA3iSkro72CMD3oLdxo8P3rycLbCduVu8veVm0Za2ckbpRMXgneNS
         t0jAYOqI7qTcxjAbWh1edM/wwKBrnQVG0pEqHbK5AXtsQtNn2FH01tkDKBQuth2FHmES
         1BLS7z9rEV8/45Df9hWoCjIpdKYTDYoD/OgjAsmv+udkLzBYvOHhzn4fUeHhZLhszA56
         5oYxXxKI86lgXMqPyA2qC5+e6lkz/cQtUo+6y3RZgK5AOTJ8GnqXLMTaRtPqwc4HKm1q
         WaoE72ypwkyIN8H9zt/dpOTz8lQeDuqulJqnCyfmCuJPMipsIqEfEHkm9ThmeiVeNWk+
         hlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxeRfZAIWbudLvp9kWivxncFadrsvxo56vZJQ20jKs4=;
        b=Ppy78PFvQGmj0DqGcFT3PaQeobRDszjXAXbBVRPfiLWQcCSjktCsGGxqFwajmEDKfM
         TQj9+0RMauJkhbC3r3Zk/pgN6U/wkLDqzFXZnOrj2JbaeMoXJFGGue1FanhmElhkCHMf
         ae0miUPu7Em95x1MOAU6VCaMQSo8RjKEXrN4eXUPNOr5a+kRDYJZ2qi32uKaB2s8VGva
         Mer6gd3hShyBfb4uf8np6VqbyT7rf7xd1SVZlnrWNIhHsIxn0YWxrq6Ax3Mz7/TJ9hyN
         B2p5pBs/ykqQJVn86XigkvJ0knOpv3U3cctOWLViqh0QfZmwjL+YWSHrimzD4kUfu5qN
         YcuA==
X-Gm-Message-State: AOAM533Td/HcCjYcsSU3Ysn/wQhyr6meSx8lqW3slVFNe9P3LNqj7Qb4
        Y7wgWEIT7MqvYA+ghfglKmxn3SFBRNyHT206hpY=
X-Google-Smtp-Source: ABdhPJxvq18UhGQenFga2zX3xGzDEm+8E1qLSRDidKYDfnqifZoOx6NvrWF8WShy3ONm0wckJIZeC2DOkSqQ6RsC+og=
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr23253688wrl.124.1604343487472;
 Mon, 02 Nov 2020 10:58:07 -0800 (PST)
MIME-Version: 1.0
References: <20201102125747.6420-1-bernard@vivo.com>
In-Reply-To: <20201102125747.6420-1-bernard@vivo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 2 Nov 2020 13:57:56 -0500
Message-ID: <CADnq5_PwBLibCGs_feeUGnJrTs1=2ezW_kyev=-aXm3V15QNUg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: fix typoes
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Colin Ian King <colin.king@canonical.com>,
        zhengbin <zhengbin13@huawei.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Nov 2, 2020 at 8:43 AM Bernard Zhao <bernard@vivo.com> wrote:
>
> Fix typoes.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index 2c6db379afae..e994d233aa21 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -1980,7 +1980,7 @@ static void calculate_bandwidth(
>         else {
>                 data->latency_for_non_mcifwr_clients = bw_int_to_fixed(0);
>         }
> -       /*dmif mc urgent latency suppported in high sclk and yclk*/
> +       /*dmif mc urgent latency supported in high sclk and yclk*/
>         data->dmifmc_urgent_latency_supported_in_high_sclk_and_yclk = bw_div((bw_sub(data->min_read_buffer_size_in_time, data->dmif_burst_time[high][s_high])), data->total_dmifmc_urgent_trips);
>         /*dram speed/p-state change margin*/
>         /*in the multi-display case the nb p-state change watermark cannot exceed the average lb size plus the dmif size or the cursor dcp buffer size*/
> --
> 2.29.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
