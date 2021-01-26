Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B155D303EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404575AbhAZN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391748AbhAZJ7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:59:02 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814DC061756
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:58:21 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id w187so8710188vsw.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLEfURoFvMMPicE7Sci98/F9GqRXhnpDvzTDrgr8tH4=;
        b=JSZizunWnHFUkmtUHyAHOYnJD7wXa9KEiZveWMNJbTnIsq8DBDHrjQKEOAVIUnS48Z
         B89LBx4/bpXA2X9q/59Ie5CSj3LKHJW8WBFd/ZiMU0nbvpV36l+1/kjI3XNyFgX2CJvQ
         hMq5myY+0eEMn1T6cvm/zpTpATSRcY2hMgLA0YZ4BfwlqjcoTEu6WjHjqxpncT8ra3UL
         R/Q89uXzi+GFTylz+4amrwKIDE71qCVeU/Ml8E0so8uucmBgKVDaIF6mW6GLmW/Vohrn
         azwJ4PE5eJbhKEXypO4atxOccHGtZjJsh/Idz05fkAehRjL6+wzTRuW9nfGQGouv+fi/
         8r0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLEfURoFvMMPicE7Sci98/F9GqRXhnpDvzTDrgr8tH4=;
        b=ELdqE5AQWw03ae/ThVxUw6w4ndM1ngivPwo7LEV9YhI/fizOnr7CH/NrB0wrMLSQbH
         az4DHffl0k1oHbjhHPbwf7PcBUfTKESrujU/0BGRhMkZjIkGtXGvewi/5wUydWs8Ek8K
         MrGY4cTBG3nissOtv92zjnheSeExgmPcEb7xP1ZesjKsOLyt+o5yGDLFLA+ELZcdI38Q
         HtpLA/XMkXAbxHhlxDx7ETo0+QiAoo0hy94Frds+STY0eT5dM0cYs3LFtdL93OMSMVYC
         Er4aaqYivirYd/KwTrAhKLtqJC9GkDwjlT6YqR1oWMS4X0dT7ZbQNDj5MkeXrIBX9PV1
         7QWg==
X-Gm-Message-State: AOAM5310uDdD6LBxK9upNgh35Xc94PPDaJDHg3MAy161xws4XJveFefP
        E6Q9GOrXdPgs0iorfdWmL38nSNItxprJO2kdI4dkjw==
X-Google-Smtp-Source: ABdhPJyxGvvKaiWsvdAfgnpUMrYd5zV8ocbx1A6czDj8b/zotF18PP3KFNdesTQFGkoR6pzaz7PSef5aB7V6Asl73Ks=
X-Received: by 2002:a67:f997:: with SMTP id b23mr3471044vsq.34.1611655100162;
 Tue, 26 Jan 2021 01:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20210125122802.982-1-arnd@kernel.org>
In-Reply-To: <20210125122802.982-1-arnd@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Jan 2021 10:57:42 +0100
Message-ID: <CAPDyKFqhHw6N=j5xLuDJEiOn+D98xzR=hUYmxY81_7cq3aitdQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: aspeed: move kunit test into separate module
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 13:28, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Having both the driver and the unit test in the same module
> leads to a link failure because of the extra init/exit functions:
>
> drivers/mmc/host/sdhci-of-aspeed-test.c:98:1: error: redefinition of '__inittest'
> kunit_test_suite(aspeed_sdhci_test_suite);
>
> Make it a separate module instead.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Arnd, thanks for the patch and for your help! However, this time
Andrew already posted a similar patch [1] to fix the problem, which I
have just applied.

[1]
https://patchwork.kernel.org/project/linux-mmc/patch/20210122114852.3790565-1-andrew@aj.id.au/

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig                |  2 +-
>  drivers/mmc/host/Makefile               |  1 +
>  drivers/mmc/host/sdhci-of-aspeed-test.c |  5 +++++
>  drivers/mmc/host/sdhci-of-aspeed.c      | 11 ++++-------
>  drivers/mmc/host/sdhci-of-aspeed.h      | 10 ++++++++++
>  5 files changed, 21 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-of-aspeed.h
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index d6f00d1d6251..a248f9f6be91 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -169,7 +169,7 @@ config MMC_SDHCI_OF_ASPEED
>           If unsure, say N.
>
>  config MMC_SDHCI_OF_ASPEED_TEST
> -       bool "Tests for the ASPEED SDHCI driver"
> +       tristate "Tests for the ASPEED SDHCI driver"
>         depends on MMC_SDHCI_OF_ASPEED && KUNIT=y
>         help
>           Enable KUnit tests for the ASPEED SDHCI driver. Select this
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 451c25fc2c69..5cc7e5f13587 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -90,6 +90,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)          += sdhci-dove.o
>  obj-$(CONFIG_MMC_SDHCI_TEGRA)          += sdhci-tegra.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)      += sdhci-of-arasan.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)      += sdhci-of-aspeed.o
> +obj-$(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)  += sdhci-of-aspeed-test.o
>  obj-$(CONFIG_MMC_SDHCI_OF_AT91)                += sdhci-of-at91.o
>  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)       += sdhci-of-esdhc.o
>  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)                += sdhci-of-hlwd.o
> diff --git a/drivers/mmc/host/sdhci-of-aspeed-test.c b/drivers/mmc/host/sdhci-of-aspeed-test.c
> index 34070605b28b..e7e42991534a 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed-test.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed-test.c
> @@ -2,6 +2,7 @@
>  /* Copyright (C) 2020 IBM Corp. */
>
>  #include <kunit/test.h>
> +#include "sdhci-of-aspeed.h"
>
>  static void aspeed_sdhci_phase_ddr52(struct kunit *test)
>  {
> @@ -96,3 +97,7 @@ static struct kunit_suite aspeed_sdhci_test_suite = {
>         .test_cases = aspeed_sdhci_test_cases,
>  };
>  kunit_test_suite(aspeed_sdhci_test_suite);
> +
> +MODULE_DESCRIPTION("Unit test for the ASPEED SD/SDIO/SDHCI Controllers");
> +MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> index 3b0d381e1215..dcc80099f528 100644
> --- a/drivers/mmc/host/sdhci-of-aspeed.c
> +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/spinlock.h>
>
> +#include "sdhci-of-aspeed.h"
>  #include "sdhci-pltfm.h"
>
>  #define ASPEED_SDC_INFO                        0x00
> @@ -42,7 +43,6 @@ struct aspeed_sdc {
>  struct aspeed_sdhci_tap_param {
>         bool valid;
>
> -#define ASPEED_SDHCI_TAP_PARAM_INVERT_CLK      BIT(4)
>         u8 in;
>         u8 out;
>  };
> @@ -123,8 +123,8 @@ aspeed_sdc_set_phase_taps(struct aspeed_sdc *sdc,
>  #define ASPEED_SDHCI_NR_TAPS           15
>  /* Measured value with *handwave* environmentals and static loading */
>  #define ASPEED_SDHCI_MAX_TAP_DELAY_PS  1253
> -static int aspeed_sdhci_phase_to_tap(struct device *dev, unsigned long rate_hz,
> -                                    int phase_deg)
> +int aspeed_sdhci_phase_to_tap(struct device *dev, unsigned long rate_hz,
> +                             int phase_deg)
>  {
>         u64 phase_period_ps;
>         u64 prop_delay_ps;
> @@ -158,6 +158,7 @@ static int aspeed_sdhci_phase_to_tap(struct device *dev, unsigned long rate_hz,
>
>         return inverted | tap;
>  }
> +EXPORT_SYMBOL_GPL(aspeed_sdhci_phase_to_tap);
>
>  static void
>  aspeed_sdhci_phases_to_taps(struct device *dev, unsigned long rate,
> @@ -579,10 +580,6 @@ static void __exit aspeed_sdc_exit(void)
>  }
>  module_exit(aspeed_sdc_exit);
>
> -#if defined(CONFIG_MMC_SDHCI_OF_ASPEED_TEST)
> -#include "sdhci-of-aspeed-test.c"
> -#endif
> -
>  MODULE_DESCRIPTION("Driver for the ASPEED SD/SDIO/SDHCI Controllers");
>  MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
>  MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> diff --git a/drivers/mmc/host/sdhci-of-aspeed.h b/drivers/mmc/host/sdhci-of-aspeed.h
> new file mode 100644
> index 000000000000..931e70781d08
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-of-aspeed.h
> @@ -0,0 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +#ifndef _SDHCI_OF_ASPEED_H
> +#define _SDHCI_OF_ASPEED_H
> +
> +struct device;
> +int aspeed_sdhci_phase_to_tap(struct device *dev, unsigned long rate_hz,
> +                             int phase_deg);
> +#define ASPEED_SDHCI_TAP_PARAM_INVERT_CLK      BIT(4)
> +
> +#endif /* _SDHCI_OF_ASPEED_H */
> --
> 2.29.2
>
