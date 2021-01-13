Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E302F2F490A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAMKx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbhAMKx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:53:56 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC9C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:53:16 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id k30so864631vsp.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7kr9N3mbZ281uugEnYc1FKOpyfhplmHlfJ6n8Cn7fu8=;
        b=CV1/pbR+iMxcHKNR6eBAKg/QC5XwEuiYpzA99x+skrd+bbkILl6UhmWpacLG/+Emo9
         oafiekauOuh63xdQ5jYaAagGE9v1XZ6RNS9zlYDcBU6C/NMsK7X2UiKDvCK1kkR8kXJO
         pZ2EL5b6yYvBGQ5po2AhTDNqLWxBDQru1ICH10j8vNvh+mt6Ip7WZ4mq/q2NGO9syN+M
         8FLEx+d3J1+7FyTesaQOidtRX5AuzjHgajTT6bxoYF0P1A94ZCvtTb7FkTnYepNzONYc
         Z+VAzBpIZFORJuMnlTYotD3g33w0xgvM+v54qviZO6P6SdbdrB1WwJuX43Jwv0sGXCdJ
         r8Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7kr9N3mbZ281uugEnYc1FKOpyfhplmHlfJ6n8Cn7fu8=;
        b=buomdm/amC6CKRS9kAMrekD8/Vgy8KiBzXeYggOO1SoDQg8Agmar3qhyX3UCyM7hLz
         JEvfNRDLOAEA36LHK4v51AkO9rVW4JjY9VPqroX3H3np1n++HWnNl9+PLksecXQ1kaGE
         WUPJyd3qhRjNOR99ckMKmYrCisZDAU4o2fpJtCMcsRK/r+uq9CUrI7anf8EX5ZMcj2Z1
         y09uhzXnIBSF4luGKi08DVUJmS61fr7gUslcEgqYBkR5R5v728cCSCXSAp+B/nmZH3TV
         fhobY3IgHFMeZ49WCGytxNOF8X6QldYL8iL/06oUXUDiyZVdu9zsXMfR9s7xja4ops8q
         ZqsA==
X-Gm-Message-State: AOAM532DYdCMwBDNok0WeW4D67nzr84Zuj5tuHXccvAMNcB9vzKjigbx
        Gnw3agPcJg+vKCf309hG0HgZR7qsRPQc2iLITtjDjQ==
X-Google-Smtp-Source: ABdhPJyxPBHTme27uziQR2Sm4FIErpG+3Y2EEjIvNi/skqiq5U1Np/PRx+H9H1AH7OMs4Mh1uMfAd7+r/KbU1iTvjz4=
X-Received: by 2002:a67:e286:: with SMTP id g6mr1536231vsf.42.1610535195570;
 Wed, 13 Jan 2021 02:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20210106092740.5808-1-reniuschengl@gmail.com>
In-Reply-To: <20210106092740.5808-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 11:52:39 +0100
Message-ID: <CAPDyKFq1EVVfU4HU_=-7TmSRinkTCA41pKWtrMD4C+yCUPYECg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL9763E
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jan 2021 at 10:27, Renius Chen <reniuschengl@gmail.com> wrote:
>
> The R/W performance of GL9763E is low with some platforms, which
> support ASPM mechanism, due to entering L1 state very frequently
> in R/W process. Enlarge its ASPM L1 entry delay to improve the
> R/W performance of GL9763E.

What do you mean by frequently? In between a burst of request or
during a burst of request?

I am thinking that this could have an effect on energy instead, but I
guess it's not always straightforward to decide what's most important.

Anyway, what does it mean when you change to use 0x3FF? Are you
increasing the idle period? Then for how long?

Kind regards
Uffe

>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index c6a107d7c742..2d13bfcbcacf 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -88,6 +88,10 @@
>  #define PCIE_GLI_9763E_SCR      0x8E0
>  #define   GLI_9763E_SCR_AXI_REQ           BIT(9)
>
> +#define PCIE_GLI_9763E_CFG2      0x8A4
> +#define   GLI_9763E_CFG2_L1DLY    GENMASK(28, 19)
> +#define   GLI_9763E_CFG2_L1DLY_MAX 0x3FF
> +
>  #define PCIE_GLI_9763E_MMC_CTRL  0x960
>  #define   GLI_9763E_HS400_SLOW     BIT(3)
>
> @@ -792,6 +796,11 @@ static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>         value &= ~GLI_9763E_HS400_SLOW;
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_MMC_CTRL, value);
>
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG2, &value);
> +       value &= ~GLI_9763E_CFG2_L1DLY;
> +       value |= FIELD_PREP(GLI_9763E_CFG2_L1DLY, GLI_9763E_CFG2_L1DLY_MAX);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG2, value);
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &= ~GLI_9763E_VHS_REV;
>         value |= FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> --
> 2.27.0
>
