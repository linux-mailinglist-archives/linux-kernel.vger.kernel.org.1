Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E822854E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 01:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgJFXUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 19:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJFXUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 19:20:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C711AC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 16:20:02 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q63so566556qkf.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IWB1ebee9pteOb/1MXVwCCrbMEWDB3ppGDM3SA6pBOI=;
        b=RhcyxEe1FSxdVyWWjik5L8oP0dlBRmNhl8eHTKZPcwOmfonQ13IokUdXJRuKCJ6SPh
         dHxp7bXBRxe79JznPcgush7ktPkgNsiGgO2fACJlaqwsTwroLQAgYh28Qv7Xk9Iqr4NM
         y4NzZw/l+Zf7ndDdCnCkPHptsNmLIhBOzvef0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IWB1ebee9pteOb/1MXVwCCrbMEWDB3ppGDM3SA6pBOI=;
        b=efk5n2hRs8eMe+CILVCb2QSfZZY/NTHNS2CiO3xdShvR+oQbRVJhgpgunMqt4XAic2
         nlPS8GF4ZsLMgtDsQJmryv+6l+wBSPuVGfftaspF2chCmIe3UxuRGpfnlF09xIT1FVVC
         gspixEdUUnMtorCiMW+LvTIzFHzFnVgT8pY3JlJ5v7KlVlJPIToYArtAMULIvVRTNRYU
         HRl9zzjPUMC6u4ItLHbQ871X7WrUHgSqxcPMK9Hj6ENfytD7n6Tg9atA0FTb6pvBDaoF
         H8+0wPEJVdjwxP1d1SDzEltd52pzfHm8AmQ73biDPPPowflDmjWxRHB+/MdKqxYQ2QUi
         qCwg==
X-Gm-Message-State: AOAM531iQNanCzZKOfuUTlgBFVM9cYTRRYA+5WNOIGWEFtEOl53FpCMJ
        1LtueCB+ZJx+8tkm3U5Tfey9Dkj2tmUIEre5ZaQ=
X-Google-Smtp-Source: ABdhPJwr2Fnlr684SJmgZQPRnrOuC932FRlVujDc1a96wpgQ80hGE45C/QVYuxFsMyeJJ11qvjuGrYXtSqY1Td3/YtE=
X-Received: by 2002:a37:48cc:: with SMTP id v195mr242091qka.66.1602026401689;
 Tue, 06 Oct 2020 16:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200930235611.6355-1-bert@biot.com> <20201001063421.qcjdikj2tje3jn6k@ti.com>
 <801445c9-4f59-5300-3a03-b48a3d631efe@biot.com>
In-Reply-To: <801445c9-4f59-5300-3a03-b48a3d631efe@biot.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 6 Oct 2020 23:19:49 +0000
Message-ID: <CACPK8XfBqLA0e+tx6WN16G-v8+PY6UFH4jvP_YmOjiK8EhZ8Cg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix 3-or-4 address byte mode logic
To:     Bert Vermeulen <bert@biot.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Oct 2020 at 22:23, Bert Vermeulen <bert@biot.com> wrote:
>
> On 10/1/20 8:34 AM, Pratyush Yadav wrote:
> > So using an address width of 4 here is not necessarily the right thing
> > to do. This change would break SMPT parsing for all flashes that use
> > 3-byte addressing by default because SMPT parsing can involve register
> > reads/writes. One such device is the Cypress S28HS flash. In fact, this
> > was what prompted me to write the patch [0].
> >
> > Before that patch, how did MX25L25635F decide to use 4-byte addressing?
>
> The SoCs I'm dealing with have an SPI_ADDR_SEL pin, indicating whether it
> should be in 3 or 4-byte mode. The vendor's hacked-up U-Boot sets the mode
> accordingly, as does their BSP. It seems to me like a misfeature, and I want
> to just ignore it and do reasonable JEDEC things, but I have the problem
> that the flash chip can be in 4-byte mode by the time it gets to my spi-nor
> driver.
>
> > Coming out of BFPT parsing addr_width would still be 0. My guess is that
> > it would go into spi_nor_set_addr_width() with addr_width still 0 and
> > then the check for (nor->mtd.size > 0x1000000) would set it to 4. Do I
> > guess correctly?
>
> No, it comes out of that with addr_width=3 because the chip publishes 3_OR_4
> and hence gets 3, even if that's nonsensical for a 32MB chip to publish.
>
> Certainly that's the problem, I just want to solve it in a more general case
> than just a fixup for this chip.
>
> > In that case maybe we can do a better job of deciding what gets priority
> > in the if-else chain. For example, giving addr_width from nor->info
> > precedence over the one configured by SFDP can solve this problem. Then
> > all you have to do is set the addr_width in the info struct, which is
> > certainly easier than adding a fixup hook. There may be a more elegant
> > solution to this but I haven't given it much thought.

Thanks for starting this conversation Bert. I had intended on
mentioning this broke our systems but didn't get to it. It broke a few
different Aspeed platforms where the flashes are >= 32MB.

We are running with a revert of the 3_OR_4 patch in OpenBMC kernels:

 https://github.com/openbmc/linux/commit/ee41b2b489259f01585e49327377f62b76a24748

>
> Since Tudor doesn't want the order of sfdp->info changed, how about
> something like this instead?
>
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -3028,13 +3028,15 @@ static int spi_nor_set_addr_width(struct spi_nor *nor)
>          /* already configured from SFDP */
>      } else if (nor->info->addr_width) {
>          nor->addr_width = nor->info->addr_width;
> -   } else if (nor->mtd.size > 0x1000000) {
> -       /* enable 4-byte addressing if the device exceeds 16MiB */
> -       nor->addr_width = 4;
>      } else {
>          nor->addr_width = 3;
>      }
>
> +   if (nor->addr_width == 3 && nor->mtd.size > 0x1000000) {
> +       /* enable 4-byte addressing if the device exceeds 16MiB */
> +       nor->addr_width = 4;
> +   }
> +
>
> Still fixes the general case, but I'm not sure what the SMPT parsing problem
> is -- would this still trigger it?

I tested this change you proposed and it fixed the issue for me.

Cheers,

Joel

>
>
> --
> Bert Vermeulen
> bert@biot.com
