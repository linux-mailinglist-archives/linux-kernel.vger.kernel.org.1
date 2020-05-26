Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6611B4977
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 18:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgDVQEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 12:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgDVQEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:04:39 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0339C03C1AB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:04:39 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id f59so2183736uaf.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/cP8XVqt/xrM6smjanv0aHXjrlwOSLxLfTMt/NqGVzE=;
        b=Z4aMnoy/ZVB07dbXDok7KjZPOJ2h1vkz4objHI/15Tf4u+VtT5U3pH8FO5m92YjSDM
         BH2cMUQL6fAX4FktgSRRayv0dQRUp4fEkBkCFEXbmgF5z339Qrd3xKfmvrRulaKSe6ld
         /Cg9lCt/rg583e1+PlG9EtgIo/bJ5WcpZb2OJuJUULh6waljaWs7Vjyg7e9tbNG1zFkI
         yMjVeXwV7bZ8FeKdD0TImiDWs6c1xYkt9omeqOvmTkITnoGFC61ZT411rj3CSVi53EXg
         iusd4S1g62p+chlWNJpMRxByZl1vOpmxhwMToTNKJD5i6lurxWXQqPe6/xk53ahQrzyf
         GT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/cP8XVqt/xrM6smjanv0aHXjrlwOSLxLfTMt/NqGVzE=;
        b=bp271jSuD2mJXLRBDFCpnqmawUPmA/S1YYchn78has21vVSCj0b0cNY1XFp7gCRtA/
         aBxio2C8GgsZNrKDKt8spJEgciV77AQzIu2+O4zoKKW7SwqFhXL3oN1O8JZwjIrNyZd2
         jbH+FMynvKMtwxwXEh4rqDu+HfVTVj7pf7EeIY1CxkOgXehJeTSUMOkS+GmMJJmROedr
         qnx6MNRr+uNbMOIiaV+KHAHNoZl2XMicG6L35sOsyH7r4QIRgSUNCBX/mCOLUqQRO0mt
         EuR57tUpBsIWta5XgeAV/us6QbSHeiYYT2mDLdsxoUS9pBk5NvybTROh9hB8yvgmRsT+
         GTLQ==
X-Gm-Message-State: AGi0PubouU1qIX/idOmZavgfKKQ8clqcHstNMSPW0Hthw6OZvijsaNKA
        Z2xOM6xVmUDIxNujgcUlN+hGK6OeljmHEY5cnwsVmg==
X-Google-Smtp-Source: APiQypJWMaZC4FSnpq5XwOmbJBjLbeyzLISOahTGgc/vgHCQqjQejfLQtbUxRUPnqG1L695riRbIRsjbHQWoF4zPu8M=
X-Received: by 2002:ab0:544a:: with SMTP id o10mr16863075uaa.15.1587571478685;
 Wed, 22 Apr 2020 09:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200422153401.7913-1-yamada.masahiro@socionext.com>
In-Reply-To: <20200422153401.7913-1-yamada.masahiro@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Apr 2020 18:04:02 +0200
Message-ID: <CAPDyKFp3p7JMQG6fm_9FcNo=phE=bYfHqoOjVU83V8G5c_e7dw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: make MMC_SDHCI_OF_AT91 depend on HAVE_CLK
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Takao Orito <orito.takao@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        YueHaibing <yuehaibing@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 17:34, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> If sdhci-of-at91.c is compiled without CONFIG_HAVE_CLK, the line
>
>   caps1 |= FIELD_PREP(SDHCI_CLOCK_MUL_MASK, clk_mul);
>
> ... emits "FIELD_PREP: value too large for the field" warning.
>
> The compiler seems to decide clk_mul is constant (unsigned int)-1,
> because clk_get_rate() returns 0 when CONFIG_HAVE_CLK is disabled.
>
> Add HAVE_CLK to the depenency since this driver does not work without
> the clock APIs anyway.
>
> Link: https://lkml.org/lkml/2020/4/17/613
> Fixes: linux-next ("mmc: sdhci: use FIELD_GET/PREP for capabilities bit masks")

I don't know about these, but I just decided to drop them.

> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
> Ulf,
>
> I do not know how to fill the Fixes tag.
> It is currently 8da1ff4f68a2 in linux-next, but I am not sure it is
> stable. I just added 'linux-next'.

...and there are no usefull commit hash to use from my tree either, as
I am occasionally rebasing my next branch.


>
> If you have a preferred way, please modify it.
>
>
>
>
>
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 462b5352fea7..2aee844722d6 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -171,7 +171,7 @@ config MMC_SDHCI_OF_ASPEED
>  config MMC_SDHCI_OF_AT91
>         tristate "SDHCI OF support for the Atmel SDMMC controller"
>         depends on MMC_SDHCI_PLTFM
> -       depends on OF
> +       depends on OF && HAVE_CLK
>         help
>           This selects the Atmel SDMMC driver
>
> --
> 2.25.1
>
