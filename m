Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5A303D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403962AbhAZMtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391823AbhAZKAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:00:08 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87268C061354
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:58:55 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id j138so8379402vsd.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pJCLQRxrq3qEZskHQDdRGHVs/g7GsIs44v+7gnvo2ls=;
        b=FOFq8Rt4wj3ueoHnR83ehUcVd2jOut0bL1z0vDVXeQV2Rs3Vl4jGN3McmmUsSjU/ja
         wamaDid3KnCaWtLk5G90d0nwdcQUc4BlfZr9SJFqdejzfVHGeCBc/cR5KQhUvKARusF1
         ZPFskfWFCLWcp1uPPkQVOevDa63ZTw9U9oRCS0NZf9dZ/8bQWWmQCormdTj2fHKJz0Kt
         uSapIEtaovuHMj5EW1FIropN2ShVEdx071K943vd2znRgeRaB3lkm34Z1pQ2LW+YbB6m
         srbCbhRaXHf6YbJS0g8jFa2Adp3Yhfyn4zEZkLSssA2BzPFLsdpyfve88lfS+PLhUrxK
         6mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pJCLQRxrq3qEZskHQDdRGHVs/g7GsIs44v+7gnvo2ls=;
        b=N8JlDiCYXpsju4v2jj4s+RcpE+LywQbe+2fgtakBw5kLM1dA/O44yomLDcs9W26Hqz
         IAr97vK2vMMUXrfKyuuHtQ8puFnShaRmgnfHG42kuWf7CuUExtnhIw0Y4WoM6MHkZsU7
         zx+jIHHaNvn49poKqYH8VmCbYi1ninht0GVWhKfHZ7H7jVRr4xZ5Ybwt9sFcJePjTjbU
         UG7zTjP90pDHkw0JUOqLOZRyvkpakub0/pBPKamcyXN4EPcEof9csPfG6sjxMLXWaQQH
         GXf+/ROwm5zNuj25Wb8bMoNtV4sqIGWymvUi7q2qlhlL7Ti214UqFryTeMR/PL7O6xgf
         kQjQ==
X-Gm-Message-State: AOAM5309AUUXHmMQd6OixdV1Q2hsy7u+zNLA8nVP1vmuNb/A06HOSk7p
        0MALkS58ChlU1eBA4K8PNr+xeaoHBAueFs87eFxwiQ==
X-Google-Smtp-Source: ABdhPJxABc5UXW4in2s8UJsSPUcaq4oOAuUUuvd5smFLRDOyRYY5OppaOYrWw/Wc0F4v8snNQaOM8Rlku8cV1xHbXQ4=
X-Received: by 2002:a67:c787:: with SMTP id t7mr3895407vsk.48.1611655134813;
 Tue, 26 Jan 2021 01:58:54 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210125064728epcas1p3c44396f8f733463d5e0add003cc2b7eb@epcas1p3.samsung.com>
 <20210125064355.28545-1-cw9316.lee@samsung.com>
In-Reply-To: <20210125064355.28545-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jan 2021 10:58:17 +0100
Message-ID: <CAPDyKFqM+PfzoP8aznomAncAVaFqUXN8SzCVf5rauqes+jGmPQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: queue: Exclude unnecessary header file
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "(Exiting) Baolin Wang" <baolin.wang@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Coly Li <colyli@suse.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sarthak Garg <sartgarg@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        dh0421.hwang@samsung.com, sh043.lee@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 07:47, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> From the 4.19 kernel, thread related code has been removed in queue.c.
> So we can exclude unnecessary header file.
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index de7cb0369c30..c7218da6f17c 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -7,7 +7,6 @@
>  #include <linux/module.h>
>  #include <linux/blkdev.h>
>  #include <linux/freezer.h>
> -#include <linux/kthread.h>
>  #include <linux/scatterlist.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/backing-dev.h>
> --
> 2.29.0
>
