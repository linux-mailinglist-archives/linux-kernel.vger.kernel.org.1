Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F0B2FDAB9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 21:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389274AbhATUXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388495AbhATN63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:58:29 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE81C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:57:32 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id t15so7865506ual.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQRUNaC5+h0p4y2UVASnStt5pCZ++1OHwy904QFlDOU=;
        b=YmKwnOpeJW4eDGtKIslo97cWH9y3TeYb8DX/Vbu89eB8jz3hfa0yhw37AKWLEUhNWd
         mt3IwgaDym8aJRq9Uz7lV6K8iNHAMwk2fJ+r+8K0olNYvHJzDEyDG4vkPw9y7mkBaGnk
         lH8ym/UWGq5LphZM0VqjKC49dRyr42PaAz8+VR/Uxysqyr68nVD1SSnriakNF2W/xEmk
         8GOjJLQeOgHpw+jxwsd3OmuYxjZrCzbWBa1L/gKkrUlOj7tCITYhgfzlrYTc05H5W2Xp
         LkliuoROmVlBiW6V4n9iDOJEzqerJVNCnmfz/3uGpfFKAgHPHvVD6E2LlwAlmAIWpjN+
         HITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQRUNaC5+h0p4y2UVASnStt5pCZ++1OHwy904QFlDOU=;
        b=Uc1mcgb0dGgk1ZToVXLH+3Azvyl4clxfoOYYAYErmTmh0kc1KXnT3XMJxWbon7DhuR
         RBYd9Fw2qGJpjgIR4oSAtzJU1xPA1AysgMd+SOBueTTlc27Th/5jq98Wwxrp/Lhk+4dE
         5KMEId2jpEMr2shsI0gFTIJ3AqF+TtorCqkhaKJx6siizUo+IuHQgf/KbdiWoCMzxATk
         wy5SPjY6PeoSU9M0y5lTRXR5KxVmFQ9caQ8Ht59jw9t310evFL3Sgekr6S/I6QZTUKx6
         RP0cPm9WNJQ2CxRdAaILelHfud12ZdwuhMJnkRJN0I8f4aLHez06ZJryGdvMB8XI6jBk
         3m/Q==
X-Gm-Message-State: AOAM533Q+z+fJWidBmZzZ9krq/JIviXKE4uFEg/aLkDbDsiInpDopgai
        6w1gAku6w2Ft8DwpwQSlTuJnHSDVF3QOwb96f0FJqg==
X-Google-Smtp-Source: ABdhPJwMO/0D8TqJK6Fkbz71C7eV0brQdczzonmnmAX0at6juF1yaKbw/I3Yc90cQE95Mkb1cMyQpmukFxP54jUO160=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr5752752uam.19.1611151051471;
 Wed, 20 Jan 2021 05:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20210114031433.2388532-1-andrew@aj.id.au>
In-Reply-To: <20210114031433.2388532-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 14:56:55 +0100
Message-ID: <CAPDyKFqBOWLBbAxZNhN5r=qjXTG9+3tX4nT8+Gz+Xbppsxh5_g@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        ryan_chen@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 at 04:14, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> This series implements support for the MMC core clk-phase-* devicetree bindings
> in the Aspeed SD/eMMC driver. The relevant register was exposed on the AST2600
> and is present for both the SD/MMC controller and the dedicated eMMC
> controller.
>
> v7 is just a small change to the the kunit testing in response to Adrian's
> feedback.
>
> I've just done a quick build test of v7 given the small change and more
> extensive testing done with v5.
>
> v6 can be found here:
>
> https://lore.kernel.org/linux-mmc/20201218035338.1130849-1-andrew@aj.id.au/
>
> Please review!
>
> Cheers,
>
> Andrew
>
> Andrew Jeffery (6):
>   mmc: core: Add helper for parsing clock phase properties
>   mmc: sdhci-of-aspeed: Expose clock phase controls
>   mmc: sdhci-of-aspeed: Add AST2600 bus clock support
>   mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
>   MAINTAINERS: Add entry for the ASPEED SD/MMC driver
>   ARM: dts: rainier: Add eMMC clock phase compensation
>
>  MAINTAINERS                                  |   9 +
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |   1 +
>  drivers/mmc/core/host.c                      |  44 ++++
>  drivers/mmc/host/Kconfig                     |  14 +
>  drivers/mmc/host/sdhci-of-aspeed-test.c      |  98 +++++++
>  drivers/mmc/host/sdhci-of-aspeed.c           | 255 ++++++++++++++++++-
>  include/linux/mmc/host.h                     |  13 +
>  7 files changed, 423 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c
>

Applied patch 1 to patch 5 applied for next (patch 6 should go via arm
soc), thanks!

Thanks for stepping and helping with maintenance as well!

Kind regards
Uffe
