Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A327718D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgIXMuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgIXMuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:50:32 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAFDC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:50:32 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id r78so851451vke.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 05:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FV+W9qCfwLlahXA9uVHzI8exYIRdq3lpUWqEdGTM0BM=;
        b=RmvdLcHq3Gllm1JRWrmjcRNf0L0d40Et/6As1CJqJuYzhqBbH+eSiCK0x/k6s2O5By
         S8BfPjvtzN38uDOIUNsS1dCKTloVtvMQdxZocRFYbS9C+gGoLZf6aETjK6gdL+lau1TP
         bECl2GY2P9ovBmDxvbZdYNGLsgyvs3IbY9Xyoo7pG6aGervos3ES889uLnEb7SjQdqB8
         c04oQSB+PnAtVssLohRqVsNTxxpZEXMlYEYZPaIQawRcqWXpoMMCB+Ij+QaUvFXaWX+9
         EkwQURLaFTPtw3uOe88PQxDRiEQbFWGdtkez6eYqA5ZmRd2ICq0f8B5PwzMC/2IfXMJV
         3HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FV+W9qCfwLlahXA9uVHzI8exYIRdq3lpUWqEdGTM0BM=;
        b=X59zWY3fCU7yjbWbmSQ8WHN74nXkMHPHaL06nNXCUac5TiWUEbYkQOZJHllkckAeep
         5Edkx/sLyahhJh2/I8NAsx1iIlcTnOkFuT/N819aWymHRQDBIGkhfNI7NrRY3+UK4Kju
         81nYXESwlhtuLEAGDPdKXqOFTRDOdxKz67exNK4FficP82l8dOABtUGfMGW09a+xM/C0
         UCV4Uj6t7co2WWEvVQofYmP687aqPUT9stwYhCw36GItnjT8IwV098z6dcPP0MdY89gU
         yyfFEkhO9SCIV7x2xer746tBwqTM4NuA5WovGGNCxsKra/RsfZu6hHAM7IbzgL86xtf/
         9NmA==
X-Gm-Message-State: AOAM530BlBSXnJbb4v7D+Klwwggcix9WS0deVL5bozi8XjvXi9ulfq4a
        p43w448umkbCcg3kEL4XvW5DblehEYuT85qCUwq5ng==
X-Google-Smtp-Source: ABdhPJy1E77lXHw7zxYl3yAzOBYjjsrq0taGD22v7OOK8eJ5f2Oi5l3FQezUUXPcsOCVonCdRcIouLG27uOu052PqAQ=
X-Received: by 2002:a1f:1f46:: with SMTP id f67mr3562226vkf.6.1600951831604;
 Thu, 24 Sep 2020 05:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200923153739.30327-1-krzk@kernel.org> <20200923153739.30327-2-krzk@kernel.org>
In-Reply-To: <20200923153739.30327-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Sep 2020 14:49:51 +0200
Message-ID: <CAPDyKFqFrpMotaiLwj=Q1cUqVc1S-Oeqhq3kt6QqyW=A0T1Y9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci: fix indentation mistakes
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Sep 2020 at 17:38, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Fix inconsistent indenting, reported by Smatch:
>
>   drivers/mmc/host/sdhci-esdhc-imx.c:1380 sdhci_esdhc_imx_hwinit() warn: inconsistent indenting
>   drivers/mmc/host/sdhci-sprd.c:390 sdhci_sprd_request_done() warn: inconsistent indenting
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  drivers/mmc/host/sdhci-sprd.c      | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 62b3d4767916..fce8fa7e6b30 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1377,7 +1377,7 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
>                          * response, block the tuning procedure or the first command
>                          * after the whole tuning procedure always can't get any response.
>                          */
> -                        tmp |= ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
> +                       tmp |= ESDHC_TUNING_CMD_CRC_CHECK_DISABLE;
>                         writel(tmp, host->ioaddr + ESDHC_TUNING_CTRL);
>                 } else if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>                         /*
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index 1efaf602c206..58109c5b53e2 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -387,7 +387,7 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
>         if (mmc_hsq_finalize_request(host->mmc, mrq))
>                 return;
>
> -        mmc_request_done(host->mmc, mrq);
> +       mmc_request_done(host->mmc, mrq);
>  }
>
>  static struct sdhci_ops sdhci_sprd_ops = {
> @@ -433,7 +433,7 @@ static void sdhci_sprd_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  }
>
>  static int sdhci_sprd_request_atomic(struct mmc_host *mmc,
> -                                     struct mmc_request *mrq)
> +                                    struct mmc_request *mrq)
>  {
>         sdhci_sprd_check_auto_cmd23(mmc, mrq);
>
> --
> 2.17.1
>
