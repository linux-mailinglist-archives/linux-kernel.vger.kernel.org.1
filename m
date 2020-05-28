Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95331E5CE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 12:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387819AbgE1KQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 06:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387698AbgE1KPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:15:22 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20ABC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:15:21 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id 14so9447774uaq.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ud/RiagjQwezZ9O6WViaS3IQ8v4tVVsn5ht8/yzb11s=;
        b=DhWW2TZaU6JSigxodhdP2DkzM4mSPNd/RucxhTUXSsjV2pHcFpvc8dEh3Ov7JMQxW6
         fsUmTCaDFFHufNAajsvLIzzYGP27pmDxmGitL7edYHfBuuBBtFXfv/oGTsfoH/k9HpXO
         YFjP318+AFWQO5KHD3GxtTJLxRgCuuogI11pGC2wv09t42wptDew4J71VpJrkm0yNN7X
         ztL9NDef6xu6ZxXatZVug/HPuCc7NzpsKknCfdtuZQ8WKAaG23yuNJ8T6dCSkBhWfVJQ
         5pvbOSmYg8z0luYXa051rY+OPSqgN1Sl+Hdx8FpAGQhONh4SiM57g8CEvgyQT3b44vPz
         3pNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ud/RiagjQwezZ9O6WViaS3IQ8v4tVVsn5ht8/yzb11s=;
        b=rJVyhXeaRb+AeltS8RBuGKReYFAyAygi85zX8v6ZEEM+1zM6oEgVIGI1y8HlLUHRs8
         7UWgVID+gp1NpZ49Z4VWDIQr2xWUIBqkccC+sbUHx61U5jv/jVzoU0CPcDiK+W7ZUgjh
         WD9YqDoGQvQ5sFuPFCdjFYkPoTupq6YV5nrSM0PNuS0Pm8UhuyYPvAvlkN9hYHY1yySQ
         rLsr8foqaKIAEWD4sNUd+y1+MiJiTIpmgSt1SLT3HGV5tO1rLUJV8Hk6e1RQnpoVgw1P
         8ftrgr41Tm84ACoJw6DwY0hIk1+l9S+vpwLeiM7KlSAQmU82EjMKAoNyFu/rmHRkfjFo
         mUqA==
X-Gm-Message-State: AOAM531ti54TK9zmJiwBDbTjcPAgOLO4IxR8PiQOmaODZysbz+h/5xTv
        onx7H4HZZOab1LWNb5BFO+ueD+M5bDk2QWk8x8/MXw==
X-Google-Smtp-Source: ABdhPJzzUCLBDPc9vy6c4Wlx/ry5lzfnFWaQGL62VHDyVauoVjIMYJ4ubcUNE8X304skZQRC7fxZJhLStDrVyXFD/q4=
X-Received: by 2002:a9f:3701:: with SMTP id z1mr1467376uad.100.1590660920925;
 Thu, 28 May 2020 03:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200527105659.142560-1-eugen.hristev@microchip.com>
In-Reply-To: <20200527105659.142560-1-eugen.hristev@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:44 +0200
Message-ID: <CAPDyKFrQXNVbwKrt10kZUBd-edGq+GbLM2rB+vsRrnd+JE_gLw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-at91: fix CALCR register being rewritten
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 12:57, Eugen Hristev <eugen.hristev@microchip.com> wrote:
>
> When enabling calibration at reset, the CALCR register was completely
> rewritten. This may cause certain bits being deleted unintentedly.
> Fix by issuing a read-modify-write operation.
>
> Fixes: 727d836a375a ("mmc: sdhci-of-at91: add DT property to enable calibration on full reset")
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>

Applied for next and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-at91.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
> index 25f4e0f4f53b..1ece2c50042c 100644
> --- a/drivers/mmc/host/sdhci-of-at91.c
> +++ b/drivers/mmc/host/sdhci-of-at91.c
> @@ -121,9 +121,12 @@ static void sdhci_at91_reset(struct sdhci_host *host, u8 mask)
>             || mmc_gpio_get_cd(host->mmc) >= 0)
>                 sdhci_at91_set_force_card_detect(host);
>
> -       if (priv->cal_always_on && (mask & SDHCI_RESET_ALL))
> -               sdhci_writel(host, SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
> +       if (priv->cal_always_on && (mask & SDHCI_RESET_ALL)) {
> +               u32 calcr = sdhci_readl(host, SDMMC_CALCR);
> +
> +               sdhci_writel(host, calcr | SDMMC_CALCR_ALWYSON | SDMMC_CALCR_EN,
>                              SDMMC_CALCR);
> +       }
>  }
>
>  static const struct sdhci_ops sdhci_at91_sama5d2_ops = {
> --
> 2.25.1
>
