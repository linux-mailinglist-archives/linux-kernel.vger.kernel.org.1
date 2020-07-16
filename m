Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883BD221C36
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 07:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGPF4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 01:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgGPF4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:56:32 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47529C061755;
        Wed, 15 Jul 2020 22:56:32 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p15so4022439ilh.13;
        Wed, 15 Jul 2020 22:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NKqwxZGmcFZhkY5PqY2mOI3LFTBG3HphbeVkF+HUG8I=;
        b=Sl3ESia33DmCibkAjRcraHWL27fvPEF8j8dd17Jru4nbSwqYbWexILtWJHHa4lujF6
         ZJa16QmCDxCr+AkYmjBPZP6Pi4r1RJ2OOjfj/x0YFt/dJqS8rFb71m2Iu7si3/xzSwJm
         eDW407oO1We8b1NxGhofAq2djtIjynweShZBDUticICj6+9qGcgtTq7HVaBVaNKhJWFz
         a2aP9wd3PME8RwWkLgX9KnJNRCZ9ILmgVVOIsYpT926KGWqU179QaI8l2yeHQ3OTxX39
         clLipZ/jtiF5MjCcVAhHxK2NPAea//5SdiGIJVWIS7eBGLIiDKKoaaOveCVTpIyeHNUD
         /zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NKqwxZGmcFZhkY5PqY2mOI3LFTBG3HphbeVkF+HUG8I=;
        b=cvJjJIIBAzvgWbbzNSV8p1UQLUNJSZu7LIeOu5k9rYHaOBiuZt6jIoYbCkUlWLFei/
         1kpje3f7BPGAxIniynKYfbBx6cFAFIFBFd9fPGxfenPqUarp1RyZPI5PG6q7Zk38uA5C
         yC6ohHicSkvmHvV0ZGeMRr8/RLGTOS4d9G5Q67qxosy7n3eH9nlvmJgyeLemZuSvHyLQ
         3nLt+jO8szDz33IUNyIoBwwnU0Osq8rsQjXXpmtx3c+Mn/vqUd/i9mJT5T9AMStmeOFj
         CRMEfmHw6W2c2+THRVjWK+t2rkpsPlsATV6d00/yGsqk0O0/JSZT2vhuyBGXTdcBv5Sv
         AuWA==
X-Gm-Message-State: AOAM531HH6rJfWeJZCIb8FImfwevj+7/Tx58ju4+CJ0j+oDJYqwfEFaR
        AqXqZxm2GKsVqM6ex/jURxuYBSZY57A90be5BJE=
X-Google-Smtp-Source: ABdhPJzplWKsBmnfCnlFFgUFbdLvvNrvpFk8y8sFgwWqO2bTqu25XaP4zfDj9HlbP17tw0BkEeEcAQuF3r2ybvsACjI=
X-Received: by 2002:a05:6e02:1070:: with SMTP id q16mr2836705ilj.221.1594878991645;
 Wed, 15 Jul 2020 22:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200713074243.530-1-linux.amoon@gmail.com> <20200716055050.GE55478@vkoul-mobl>
In-Reply-To: <20200716055050.GE55478@vkoul-mobl>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 16 Jul 2020 11:26:20 +0530
Message-ID: <CANAwSgRcgOxwT1+avVJp3GaX1dKzFuzoDuggUXk7-MFQ7cOG8A@mail.gmail.com>
Subject: Re: [PATCH v4] phy: samsung: Use readl_poll_timeout function
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Thu, 16 Jul 2020 at 11:20, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 13-07-20, 07:42, Anand Moon wrote:
> > Instead of a busy waiting while loop using udelay
> > use readl_poll_timeout function to check the condition
> > is met or timeout occurs in crport_handshake function.
> > readl_poll_timeout is called in non atomic context so
> > it safe to sleep until the condition is met.
> >
> > Fixes: d8c80bb3b55b ("phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5800")
> > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > ---
> > Changes v4:
> > Rebased on to of patch [0] https://patchwork.kernel.org/patch/11651673/
> > --Fix the commit message.
> > --Fix the error timeout condition for -ETIMEDOUT
> > ---
> > Changes v3:
> > --Fix the commit message.
> > --Drop the variable, used the value directly.
> > Changes v2:
> > --used the default timeout values.
> > --Added missing Fixed tags.
> > ---
> >  drivers/phy/samsung/phy-exynos5-usbdrd.c | 39 ++++++++----------------
> >  1 file changed, 12 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > index 7f6279fb4f8f..ad81aa65cdff 100644
> > --- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > +++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/of_device.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/phy/phy.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/mutex.h>
> > @@ -556,41 +557,25 @@ static int exynos5_usbdrd_phy_power_off(struct phy *phy)
> >  static int crport_handshake(struct exynos5_usbdrd_phy *phy_drd,
> >                           u32 val, u32 cmd)
> >  {
> > -     u32 usec = 100;
> >       unsigned int result;
> > +     int err;
> >
> >       writel(val | cmd, phy_drd->reg_phy + EXYNOS5_DRD_PHYREG0);
> >
> > -     do {
> > -             result = readl(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1);
> > -             if (result & PHYREG1_CR_ACK)
> > -                     break;
> > -
> > -             udelay(1);
> > -     } while (usec-- > 0);
> > -
> > -     if (!usec) {
> > -             dev_err(phy_drd->dev,
> > -                     "CRPORT handshake timeout1 (0x%08x)\n", val);
> > -             return -ETIME;
> > +     err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
> > +                     result, (result & PHYREG1_CR_ACK), 1, 100);
>
> pls align this line to opening brace of preceding line:
>
>         err = readl_poll_timeout(phy_drd->reg_phy + EXYNOS5_DRD_PHYREG1,
>                                  result, (result & PHYREG1_CR_ACK), 1, 100);
>
> This is recommended way of splitting lines, see
> Documentation/process/coding-style.rst and run checkpatch.pl with
> --strict option

Ok, I will do this, just waiting for some more feedback on these changes.
>
> thanks
> --
> ~Vinod

-Anand
