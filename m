Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F1A2D38A8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 03:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgLICSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 21:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgLICSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 21:18:34 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD4AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 18:17:53 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 143so671026qke.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 18:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RchfEUxlIXCvXQN3+UYuWNoN8tixWT1ubeZpsHm4KC0=;
        b=aHyykAcG+oJpZsoVUkvKq9j0qjaueWORS/JstpqCyeWkVeqvVNgOwnaNda8evE7cDT
         EB1MJgCLVJBL549P5iDLL8MwA9qmKo5eyPBvRzfcflq/6BpCdrYM+oXQtNw6EhumHsA3
         G5+RjQPPGHQ1xlH/8fyN5vYU668JIsQXJchAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RchfEUxlIXCvXQN3+UYuWNoN8tixWT1ubeZpsHm4KC0=;
        b=jVAbXJeiKj1OG4zP3ABPDGDHwvwJfe0B74il79NomMFaG/oU0mLYaiA6cuVjNsMaL3
         GAlGRLbF1gaJkW29v3oRRQt89ZtzFj6qHCLLQ/HpIfU0Qi9ussB0uhD+vbYn8wGzGYhT
         T4XHXLz2Zsr3dBn9DZpdDdty0NZ0Br65ZVLWa87eqLHYPtt1ctQfO9Sbk1HDlf9VPnm3
         cAevIQHQSWpeVxGMLZAxcr5ZC73IidWrIDDf8lCdVypPfYngxXDPSHeYNl+GzXnWsURp
         6lPyyGw2veOc1EIj8fD3CR9Wxbq7sc9P/DL3JWf3jfnzlNx8X+OFIEr5XBX01oD4hYUB
         /fXw==
X-Gm-Message-State: AOAM531OGRhnt8N6dPCJWKk/CSYkqh2jf4mbG0DjKrlbmDPulmVYDbzX
        Ccd8CSI5J+tm+R/y5ukb4ove4uqvaXnIjDg4Vlo=
X-Google-Smtp-Source: ABdhPJz5VfxoBA7BSnjZ4eLGjv3bDURJD0HjKPP58xDqbDJFGYMxaK4pEo4lCBNohZLLeaxSa5yV2CU0Q5gc9fj3TKo=
X-Received: by 2002:a37:a085:: with SMTP id j127mr289877qke.273.1607480273131;
 Tue, 08 Dec 2020 18:17:53 -0800 (PST)
MIME-Version: 1.0
References: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
In-Reply-To: <20201208091748.1920-1-wangzhiqiang.bj@bytedance.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Dec 2020 02:17:40 +0000
Message-ID: <CACPK8XePhJj8HzbLB4QgJQCjTuH_kPq=sWyOhdcGPmptqD6Aqw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] misc: Add clock control logic into Aspeed LPC
 SNOOP driver
To:     John Wang <wangzhiqiang.bj@bytedance.com>,
        SoC Team <soc@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     xuxiaohan@bytedance.com,
        =?UTF-8?B?6YOB6Zu3?= <yulei.sh@bytedance.com>,
        Jae Hyun Yoo <jae.hyun.yoo@intel.com>,
        Vernon Mauery <vernon.mauery@linux.intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Patrick Venture <venture@google.com>,
        Robert Lippert <rlippert@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Fair <benjaminfair@google.com>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Dec 2020 at 09:17, John Wang <wangzhiqiang.bj@bytedance.com> wrote:
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
> Fixes: 3772e5da4454 ("drivers/misc: Aspeed LPC snoop output using misc
> chardev")
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Arnd, can you merge this for v5.11, or would you prefer me to do a pull request?

The device tree patch from this series also needs to be added.

Cheers,

Joel

> ---
> v2:
>   reword: Add fixes line
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
