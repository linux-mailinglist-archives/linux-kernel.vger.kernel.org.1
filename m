Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F22E994D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 16:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbhADP4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 10:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727317AbhADP4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:56:50 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D983C061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 07:56:10 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v19so19273999pgj.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 07:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ojjc1l6W/AejcofAajUYjJSSOvbtlUclnteDVIdNZDc=;
        b=WIloWn0adoNdaa2oN5PjacQa2ItR4yLzwapyuQk6RMRpw7H1pcNFIY/12jPjmxjjLk
         oyMZZMIioDe9dUw2PJEvFdGCTJU+KFVK/3uWZ2rUgURSvk4m6djjIqBJXe9DORialz7H
         1ia3J+m9zoFX5YKUPf5ihyPg8qJRMnnFcLjLBu4a7myMw64G2c7iaOMRmuQ/m7uymWOd
         rM7cthalwKqf48WtFpoQevgwamT5IsZT47wFL+wIntjchW2M5hEkIzZ1TxezC6ymG5dA
         AzvJWTqqPazvnRQ4dNnDaz9sej2DAI6hiTGbDXJhS09OzRFoR4pV2IbWm1HAKYUokEFQ
         wnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ojjc1l6W/AejcofAajUYjJSSOvbtlUclnteDVIdNZDc=;
        b=ccdHCQc52vM0iDddiGb03TgUenFlwS4hDUchP3VnnlJXxfqZWqKUDrBK04hrbIIC8d
         K3icb+5s5d/NcAVQKYsIcwoLJwpMPwFEeK5naFw6aeqEbAG5m0W9hggzuYfLysnzgvdY
         SjG/BzQ63vt3CpSDIHilb2WtJ25ABrhp2I2kP3YwnfzWc3TYA2H63o+N3V8iM9yDEx0q
         PLhYpQHPYT1MAfd2JRf7g4yn/3j90X0bJqX0a4nvwssi2/ztvJnutIy/3EzrEpyA15+H
         WYrBr9trsW/w+vqJAJiJrJjNMA0Hs+W9y4E5vATlYcau+j4yW5IuFuYskEfNjOYbC0E9
         lRrQ==
X-Gm-Message-State: AOAM5317AZ24cn+w++S95W7TLid8+wIRzaqZXKGikAFmCjMRyOrilQHh
        tbLtcBlRamMHpXAN5TJExmaf04AzD1t3/hMQkf4=
X-Google-Smtp-Source: ABdhPJx350dU0TzVYushqcV0GSivqferapBQIEHUq7ap3PG9yf1lkLFx5hHPkbaPUheY/V+7jMjSGzThnd59YAOm1tg=
X-Received: by 2002:a63:1f10:: with SMTP id f16mr66639868pgf.111.1609775770266;
 Mon, 04 Jan 2021 07:56:10 -0800 (PST)
MIME-Version: 1.0
References: <20201225055812.2177-1-Meng.Li@windriver.com> <CA+-6iNw1pixdamS1HSPiifrppWp=qsOmxVu6NYhDHr61pC6Gkw@mail.gmail.com>
In-Reply-To: <CA+-6iNw1pixdamS1HSPiifrppWp=qsOmxVu6NYhDHr61pC6Gkw@mail.gmail.com>
From:   Jim Quinlan <jim2101024@gmail.com>
Date:   Mon, 4 Jan 2021 10:55:58 -0500
Message-ID: <CANCKTBtMcDQkAAyTY_k3h6Mh8MxQkKiav1=wpyODDChpDwzFug@mail.gmail.com>
Subject: Re: [PATCH] drivers core: Free dma_range_map when driver probe failed
To:     Jim Quinlan <james.quinlan@broadcom.com>, Meng.Li@windriver.com,
        open list <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Kexin.Hao@windriver.com, Jim Quinlan <jim2101024@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] drivers core: Free dma_range_map when driver probe failed
>
> There will be memory leak if driver probe failed. Trace as below:
>   backtrace:
>     [<000000002415258f>] kmemleak_alloc+0x3c/0x50
>     [<00000000f447ebe4>] __kmalloc+0x208/0x530
>     [<0000000048bc7b3a>] of_dma_get_range+0xe4/0x1b0
>     [<0000000041e39065>] of_dma_configure_id+0x58/0x27c
>     [<000000006356866a>] platform_dma_configure+0x2c/0x40
>     ......
>     [<000000000afcf9b5>] ret_from_fork+0x10/0x3c
>
> This issue is introduced by commit e0d072782c73("dma-mapping:
> introduce DMA range map, supplanting dma_pfn_offset "). It doesn't
> free dma_range_map when driver probe failed and cause above
> memory leak. So, add code to free it in error path.
>
> Fixes: e0d072782c73("dma-mapping: introduce DMA range map, supplanting
> dma_pfn_offset ")
> Cc: stable@vger.kernel.org
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 148e81969e04..8e4871aa34bc 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -612,6 +612,7 @@ static int really_probe(struct device *dev, struct
> device_driver *drv)
>         else if (drv->remove)
>                 drv->remove(dev);
>  probe_failed:
> +       kfree(dev->dma_range_map);
>         if (dev->bus)
>                 blocking_notifier_call_chain(&dev->bus->p->bus_notifier,
>                                              BUS_NOTIFY_DRIVER_NOT_BOUND, dev);
> --
> 2.17.1
>
> --

Hi Meng,

Sorry for the delay -- I was on vacation.  I agree with you -- thanks.
However, note that in function  device_release()  in
drivers/base/core.c  there is this line:

kfree(dev->dma_range_map);

Won't this also be called  if all of the appropriate drivers' probes
fail for this device, effecting a double kfree?  Perhaps your patch
could also set "dev->dma_range_map" to NULL after calling kfree()?

Thanks much,
Jim Quinlan
Broadcom STB
