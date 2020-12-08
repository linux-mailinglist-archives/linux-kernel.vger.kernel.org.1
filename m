Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA002D2729
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgLHJHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728596AbgLHJHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:07:47 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181EC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 01:07:07 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 11so15202972oty.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 01:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=suhAyysHILS0z9ssFgeQI7iHnc5/D57Rmf1ZLjPLHMo=;
        b=T6Fjrn5SyumfCtz7MO8j8oVgjzCFJKzm56NTSu92/Sgkvl6ufgWd1zmcSukSBzovSz
         kLeDi8dnZEYS3Dllrm88BofLw9Z4+H/V4dA5+kYXO/OO9ilHVpf2trVogsBqQpfDvHw6
         tN3AgbX4tJuPCFLa7adCkzppDjFNGC6tQP5MdYCOPIuo296lNpH9XWfupv/rwypWKuv+
         setWDltoxYA2fvZnWpMRKMwYG5vn4gHh72zx+Nc2yohUkKor3cSayJWH4oF9VoXzZsWl
         bKROQX8Jpa/osFb67JfmZpJFxnGPkjg+JC55saVb9ocBbjQZukBolqPv+i3ARs5bVu9S
         oTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=suhAyysHILS0z9ssFgeQI7iHnc5/D57Rmf1ZLjPLHMo=;
        b=or52KkQ1DOmSFrsiL9Q5t28ULFUt0K/xGa1FJV3LaGgV5D17j7A6zBst0hYc9u0faG
         yjiQMN1mKhvk19hhEgmGefI6oQNG8QmCrKx8n2eu1YODPBJ4GpwBaFDAyxkjJsC+a6Qw
         15JDjv1W/rKJfbOb6pn28YWUtH0i+O2lbL8nFwVcGp/Qbg26+p6VUWVacDpGG+3A7lll
         e1P7K2mfOjFUhAuugN21FwT2uNdmnZS6QYig8MNR9/NxKtb4GtAsN5IaOkAc3EaOfrjD
         mXqRayPtZMQDpbURUedzfQVpbRfUBEZCrwyyV+Z0WzoMfKgsqTTGqz7i5hnSKgX6G7y9
         FKIQ==
X-Gm-Message-State: AOAM5321agJr4QZBKJZ4t+Ihi3oi7XBiLZoeHbowaRsH0WuI6PhDcaZ2
        KJL106ot7xPDiWVgH6EFdWoBwUto0Y9ADcZSSCe5zg==
X-Google-Smtp-Source: ABdhPJyIUdXikWlknUrS+S8RFcek3mph9DWrqyVoswvRQQWw0XOuc4RUBGK5SWInd3Y22+Kfm75aEiECjrcjRLCkhLQ=
X-Received: by 2002:a9d:3dc3:: with SMTP id l61mr15794847otc.140.1607418426544;
 Tue, 08 Dec 2020 01:07:06 -0800 (PST)
MIME-Version: 1.0
References: <20201202051634.490-1-wangzhiqiang.bj@bytedance.com> <CACPK8Xf317mv_q96b7L2ohswkoiRrGDMdqs_zSCyBux99XjHEw@mail.gmail.com>
In-Reply-To: <CACPK8Xf317mv_q96b7L2ohswkoiRrGDMdqs_zSCyBux99XjHEw@mail.gmail.com>
From:   John Wang <wangzhiqiang.bj@bytedance.com>
Date:   Tue, 8 Dec 2020 17:06:55 +0800
Message-ID: <CAH0XSJuWtuO+NCw_QuU8L6t2FwTEpYmBS0h=FC6fk-2JH63r-g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 1/2] misc: Add clock control logic into
 Aspeed LPC SNOOP driver
To:     Joel Stanley <joel@jms.id.au>
Cc:     Lotus Xu <xuxiaohan@bytedance.com>,
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

On Tue, Dec 8, 2020 at 10:19 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 2 Dec 2020 at 05:16, John Wang <wangzhiqiang.bj@bytedance.com> wrote:
> >
> > From: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> >
> > If LPC SNOOP driver is registered ahead of lpc-ctrl module, LPC
> > SNOOP block will be enabled without heart beating of LCLK until
> > lpc-ctrl enables the LCLK. This issue causes improper handling on
> > host interrupts when the host sends interrupt in that time frame.
> > Then kernel eventually forcibly disables the interrupt with
> > dumping stack and printing a 'nobody cared this irq' message out.
> >
> > To prevent this issue, all LPC sub-nodes should enable LCLK
> > individually so this patch adds clock control logic into the LPC
> > SNOOP driver.
> >
> > Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@intel.com>
> > Signed-off-by: Vernon Mauery <vernon.mauery@linux.intel.com>
> > Signed-off-by: John Wang <wangzhiqiang.bj@bytedance.com>
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> Thanks for sending these John. It is an excellent idea to upstream
> fixes that have been developed.
>
> I assume we will have the same issue for all devices that use the LPC
> bus? eg. vuart, bt, kcs, lpc2ahb? It looks like only the lpc-ctrl
> (lpc2ahb) does this so far:

ok that's on my todo list.  :)

>
> git grep -l clk drivers/soc/aspeed/aspeed-p2a-ctrl.c
> drivers/soc/aspeed/aspeed-lpc-ctrl.c
> drivers/char/ipmi/kcs_bmc_aspeed.c drivers/char/ipmi/bt-bmc.c
> drivers/soc/aspeed/aspeed-lpc-ctrl.c
>
>
>
>
> > ---
> >  drivers/soc/aspeed/aspeed-lpc-snoop.c | 30 ++++++++++++++++++++++++---
> >  1 file changed, 27 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/soc/aspeed/aspeed-lpc-snoop.c b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > index 682ba0eb4eba..20acac6342ef 100644
> > --- a/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > +++ b/drivers/soc/aspeed/aspeed-lpc-snoop.c
> > @@ -11,6 +11,7 @@
> >   */
> >
> >  #include <linux/bitops.h>
> > +#include <linux/clk.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/fs.h>
> >  #include <linux/kfifo.h>
> > @@ -67,6 +68,7 @@ struct aspeed_lpc_snoop_channel {
> >  struct aspeed_lpc_snoop {
> >         struct regmap           *regmap;
> >         int                     irq;
> > +       struct clk              *clk;
> >         struct aspeed_lpc_snoop_channel chan[NUM_SNOOP_CHANNELS];
> >  };
> >
> > @@ -282,22 +284,42 @@ static int aspeed_lpc_snoop_probe(struct platform_device *pdev)
> >                 return -ENODEV;
> >         }
> >
> > +       lpc_snoop->clk = devm_clk_get(dev, NULL);
> > +       if (IS_ERR(lpc_snoop->clk)) {
> > +               rc = PTR_ERR(lpc_snoop->clk);
> > +               if (rc != -EPROBE_DEFER)
> > +                       dev_err(dev, "couldn't get clock\n");
> > +               return rc;
> > +       }
> > +       rc = clk_prepare_enable(lpc_snoop->clk);
> > +       if (rc) {
> > +               dev_err(dev, "couldn't enable clock\n");
> > +               return rc;
> > +       }
> > +
> >         rc = aspeed_lpc_snoop_config_irq(lpc_snoop, pdev);
> >         if (rc)
> > -               return rc;
> > +               goto err;
> >
> >         rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 0, port);
> >         if (rc)
> > -               return rc;
> > +               goto err;
> >
> >         /* Configuration of 2nd snoop channel port is optional */
> >         if (of_property_read_u32_index(dev->of_node, "snoop-ports",
> >                                        1, &port) == 0) {
> >                 rc = aspeed_lpc_enable_snoop(lpc_snoop, dev, 1, port);
> > -               if (rc)
> > +               if (rc) {
> >                         aspeed_lpc_disable_snoop(lpc_snoop, 0);
> > +                       goto err;
> > +               }
> >         }
> >
> > +       return 0;
> > +
> > +err:
> > +       clk_disable_unprepare(lpc_snoop->clk);
> > +
> >         return rc;
> >  }
> >
> > @@ -309,6 +331,8 @@ static int aspeed_lpc_snoop_remove(struct platform_device *pdev)
> >         aspeed_lpc_disable_snoop(lpc_snoop, 0);
> >         aspeed_lpc_disable_snoop(lpc_snoop, 1);
> >
> > +       clk_disable_unprepare(lpc_snoop->clk);
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.25.1
> >
