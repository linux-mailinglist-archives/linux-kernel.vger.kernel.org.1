Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7F2D20B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgLHCUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgLHCUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:20:04 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82413C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 18:19:24 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id a6so8634511qtw.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 18:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fO52pUkJlN6AoDogKEqqkgiecTp8LWVBd7vtkWUxWdI=;
        b=T3DbAd5xf2dIMA5cx/Wu1DAv0tqoL52nTodBmCjcVt75jGw5iksNr8SnDxuN4zOlgO
         lARgX79dbdt60OW2B7uT5rKFN75geTkZgLBG+/SC20vV93ygG7u3m2tkCfarGn/wMmSw
         3iOYHKs5KDKMeTIT5fup/GQpu2KRjBeb6sy0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fO52pUkJlN6AoDogKEqqkgiecTp8LWVBd7vtkWUxWdI=;
        b=N7fgKwJo12e4DpAxCzmPqOwl5dM21OIMBoLPPP5vMmVQJfyOqePqQdYMoay+9OfXhE
         5u0wrXIxk8yyoDX5S0U4CAAL/WLdpPoc/6Un01Q/j1Zu/bXilQnfo1GITBI6nXLSkOBP
         uIHP86PUB0rlI3VUuwCG4M43Ua47s2p7k8pzA+W9Bf6tRyJpWFwj8XpuB7lFhybR8ozY
         9pct63UWyXE026VCo4QgbD/Nj/XB2vqKs6JpITrwtkFugeXEB+DUkclxRWm6Ju2P5NkA
         KAY/StJhiBuV6/cdQTPUXYi0TDMdbLVyP2lHm/YoTGOE9XvnXNaD1oXJ6UVoUEikefki
         AO7A==
X-Gm-Message-State: AOAM532/KwF/UkqWa9bUsipTX6ZrMW8SAPZad7N9xYzPRJDaFwP3GXrh
        EVd2Cxv/ZkZpIIjEFHAGrT3H1v2yg4ZQLeekRbM=
X-Google-Smtp-Source: ABdhPJzjrpkK3MTHJW6l1VEnz+NDNE3QBwSZFU0/8Mp8PzXMDzGOcpDwOk7TernzHHzMQtSp2LSKAeG/26XRZzJIsLc=
X-Received: by 2002:aed:2f64:: with SMTP id l91mr27646487qtd.363.1607393963552;
 Mon, 07 Dec 2020 18:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20201202051634.490-1-wangzhiqiang.bj@bytedance.com>
In-Reply-To: <20201202051634.490-1-wangzhiqiang.bj@bytedance.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 8 Dec 2020 02:19:10 +0000
Message-ID: <CACPK8Xf317mv_q96b7L2ohswkoiRrGDMdqs_zSCyBux99XjHEw@mail.gmail.com>
Subject: Re: [PATCH 1/2] misc: Add clock control logic into Aspeed LPC SNOOP driver
To:     John Wang <wangzhiqiang.bj@bytedance.com>
Cc:     xuxiaohan@bytedance.com,
        =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Dec 2020 at 05:16, John Wang <wangzhiqiang.bj@bytedance.com> wrote:
>
> From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
>
> If LPC SNOOP driver is registered ahead of lpc-ctrl module, LPC
> SNOOP block will be enabled without heart beating of LCLK until
> lpc-ctrl enables the LCLK. This issue causes improper handling on
> host interrupts when the host sends interrupt in that time frame.
> Then kernel eventually forcibly disables the interrupt with
> dumping stack and printing a 'nobody cared this irq' message out.
>
> To prevent this issue, all LPC sub-nodes should enable LCLK
> individually so this patch adds clock control logic into the LPC
> SNOOP driver.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks for sending these John. It is an excellent idea to upstream
fixes that have been developed.

I assume we will have the same issue for all devices that use the LPC
bus? eg. vuart, bt, kcs, lpc2ahb? It looks like only the lpc-ctrl
(lpc2ahb) does this so far:

git grep -l clk drivers/soc/aspeed/aspeed-p2a-ctrl.c
drivers/soc/aspeed/aspeed-lpc-ctrl.c
drivers/char/ipmi/kcs_bmc_aspeed.c drivers/char/ipmi/bt-bmc.c
drivers/soc/aspeed/aspeed-lpc-ctrl.c




> ---
>  drivers/soc/aspeed/aspeed-lpc-snoop.c | 30 ++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> index 682ba0eb4eba..20acac6342ef 100644
> --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include <linux/bitops.h>
> +#include <linux/clk.h>
>  #include <linux/interrupt.h>
>  #include <linux/fs.h>
>  #include <linux/kfifo.h>
> @@ -67,6 +68,7 @@ struct aspeed_lpc_snoop_channel {
>  struct aspeed_lpc_snoop {
>         struct regmap           *regmap;
>         int                     irq;
> +       struct clk              *clk;
>         struct aspeed_lpc_snoop_channel chan[NUM_SNOOP_CHANNELS];
>  };
>
> @@ -282,22 +284,42 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>
> +       lpc_snoop->clk = devm_clk_get(dev, NULL);
> +       if (IS_ERR(lpc_snoop->clk)) {
> +               rc = PTR_ERR(lpc_snoop->clk);
> +               if (rc != -EPROBE_DEFER)
> +                       dev_err(dev, "couldn't get clock\n");
> +               return rc;
> +       }
> +       rc = clk_prepare_enable(lpc_snoop->clk);
> +       if (rc) {
> +               dev_err(dev, "couldn't enable clock\n");
> +               return rc;
> +       }
> +
>         rc = aspeed_lpc_snoop_config_irq(lpc_snoop, pdev);
>         if (rc)
> -               return rc;
> +               goto err;
>
>         rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 0, port);
>         if (rc)
> -               return rc;
> +               goto err;
>
>         /* Configuration of 2nd snoop channel port is optional */
>         if (of_property_read_u32_index(dev->of_node, "snoop-ports",
>                                        1, &port) == 0) {
>                 rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 1, port);
> -               if (rc)
> +               if (rc) {
>                         aspeed_lpc_disable_snoop(lpc_snoop, 0);
> +                       goto err;
> +               }
>         }
>
> +       return 0;
> +
> +err:
> +       clk_disable_unprepare(lpc_snoop->clk);
> +
>         return rc;
>  }
>
> @@ -309,6 +331,8 @@ static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
>         aspeed_lpc_disable_snoop(lpc_snoop, 0);
>         aspeed_lpc_disable_snoop(lpc_snoop, 1);
>
> +       clk_disable_unprepare(lpc_snoop->clk);
> +
>         return 0;
>  }
>
> --
> 2.25.1
>
