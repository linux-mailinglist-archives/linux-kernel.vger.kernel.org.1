Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC90E2C3D28
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKYKET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgKYKES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:04:18 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9197AC061A4D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 02:04:18 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id n189so363824vkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 02:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IoCTnhDdmiyu7Di22E5w97TgLxSYJBtIV21K0S5sGl4=;
        b=qFeJoVJSvbS05seM+zDaJZKd+q2yG+sk6A8GszNHA9lE/OIq1Sj0FRC1VEN2jO7xID
         LiXX5TvRWjExYuw0naWrF/6M1mvy3CiiEdJRiG+DM3xlZ9mkt5GJ0dkc5WAvM4zTPOUo
         5CdaXlNxQgZ7LqA7tqwCU8BQoTdqadVxtD+xkhmvtZ3mbTB0AsyYqsMtYi0llg1vfVWt
         EiF67f9zL5t4nrzx8+PO7D0Jacg6rT+uN5hm/UDFd33Oc/6kwL1KCXOG02ewFxbxm4ej
         dvvMWGnzxvk25bPaozM0diZhm8w9lUTlT1Y1MdxlWqxZEXDed7yuwaKO/gwzN7286WJy
         k+aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IoCTnhDdmiyu7Di22E5w97TgLxSYJBtIV21K0S5sGl4=;
        b=EQU6y4DGWVsuEGgQV/bweB+yKTztNNfhz3cTxF6FBlxfH1wsiHQB4nN8si0EHwAmvN
         jXpkmWwn6ywNLgxc9BE4lwpi/6w5RliDCpT4hENhlqA5Jc8ruOOJtPpz8OI7Wp7MBUob
         T2GtPFQU/aBouRBjY2DesWTjizS03Jrnt2VOz0eVsHdwkdx95+bdI4s6l1TGMyhP6uMu
         8pcPZslLlZE1Q5MTaCXurrQ0zPSbHvU4dPH5bqnqMbbJjN0B24S74SSnp/Y5o5AQkvvp
         vC59HdSg/3hHB9IL+gupi2aXmKKQQdPiqXj4R6GWN5z7YzmRRI6JJaLVmPoCh5k7xmt8
         WMyA==
X-Gm-Message-State: AOAM5309j4YOplirNK0JrYWGbas26zY8PnkuyBmZNLSlwFyy6bzSnzeD
        XcVdXchA+bueRrUTgV04cva2gqFkpb8jVVlHIdJW6A==
X-Google-Smtp-Source: ABdhPJwd3HM+w1CxiEdPo/CW5K0JMpnjXCgTmByiTgthqXSiBjUH6rZIRvwws3vZA6mdSE6uu9lNksyg9rnQeP9TzmM=
X-Received: by 2002:a1f:2cd4:: with SMTP id s203mr1615929vks.6.1606298657728;
 Wed, 25 Nov 2020 02:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20201125100004.1288-1-benchuanggli@gmail.com>
In-Reply-To: <20201125100004.1288-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Nov 2020 11:03:40 +0100
Message-ID: <CAPDyKFp_3Vpq6ZRm5Qm1Zningz9tDqQLS_E78a8ChYHVbofB9g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable slow mode in HS400 mode for GL9763E
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 at 10:59, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The GL9763E uses 150Mhz (slow mode) by default in HS400 mode. In order
> to make HS400 mode run at 200Mhz, the slow mode needs to be turned off.
>
> Fixes: 1ae1d2d6e555 ("mmc: sdhci-pci-gli: Add Genesys Logic GL9763E support")

Why a fixes tag? This patch looks like an improvement and not a fix, right?

Kind regards
Uffe

> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 9887485a4134..d45d7e529150 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -87,6 +87,9 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCIE_GLI_9763E_MMC_CTRL  0x960
> +#define   GLI_9763E_HS400_SLOW     BIT(3)
> +
>  #define SDHCI_GLI_9763E_CQE_BASE_ADDR   0x200
>  #define GLI_9763E_CQE_TRNS_MODE           (SDHCI_TRNS_MULTI | \
>                                     SDHCI_TRNS_BLK_CNT_EN | \
> @@ -764,6 +767,10 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value |= GLI_9763E_SCR_AXI_REQ;
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_SCR, value);
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, &value);
> +       value &= ~GLI_9763E_HS400_SLOW;
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
>         value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> --
> 2.29.2
>
