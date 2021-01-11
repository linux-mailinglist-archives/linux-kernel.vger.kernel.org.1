Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B8C2F1D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 19:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390142AbhAKSHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 13:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390108AbhAKSHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:07:31 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5A1C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:06:49 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id 73so123500uac.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 10:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ceLUFE0xEYsyzIqgA0y0vAyTYpccrGoaC3NMKTv7ZM=;
        b=aaQtCTIJrOMGeByW9fyp87whoUutWwkp1LIX2+WpLuWMO1X32PJf/oR7ZM31rx696q
         53iLC8f7Gu1XUDzvB/FWcuTJEJGTZWEa+LQPn3Rre5m9cjdhIlcuHu0tBj2bRRwmwhli
         XjLbtDPmExf/ezMfJU2bgsgB+Bg72SvU6BJ2nnKebJq+IuP1uHySQkl9hDmrMHMZEti6
         da9eApkw18w/RRlozBpAhEnw3o5Rl6q7UMvuhPNkhDUaKnE7NfuNfQ4DUUjj/aRCCzod
         zk7q9Wd0qNYI1XrSFAsSKFLpGrfrh9GaISajnl1PV5QgoZnLoc8Vbs5kf2EN65qaGZa0
         D1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ceLUFE0xEYsyzIqgA0y0vAyTYpccrGoaC3NMKTv7ZM=;
        b=eVQyadkqIIkBn8oncvcaiCdhLKSN3fJ44rO1ZbmKDJe4QR7N0C/lAYL01MSJp7VmZA
         44A6B+ioMGHFTWpZ4IJPgi95Dmimgex/ulyg2GuVcVIiWymV7TT1MILuf4PAzIa/VPFM
         j3RMUIwwbkpahf3hX0uN3LCWAxvkjIYW2E/ST5GaraMvdfYWSgfrjQ5TUPJ4YySQL2qL
         z4jfwlWIUlyr4Agwp25IqKKxV4YrdvOEwDRSNbeLFHQP78Ny6TNXKe2cI+m3H0/VJqd/
         NRxOJTgLVX5DO0NmvurhnjzNX8k9JNJnYTWhO094MH5FC23ZY0JK89r75WitOVN2gpdF
         sMGA==
X-Gm-Message-State: AOAM530eAqVeSCa2jHJukr9xnlY2+W0pb6QTwPaO7XIsTwbW6UUl9uPH
        npl9uyVlG5CmrGlp8U7xUqZSU5fjREkdO+2Wk70WfQ==
X-Google-Smtp-Source: ABdhPJwlJ/IQ+m0K7SGd2Bs6vVItjRMIJWrTqC0VF25endRRivF7KO62s7TsSEBjHpe3QFAa8ctUWKXl9J25CaeqZb0=
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr718845uaa.104.1610388408471;
 Mon, 11 Jan 2021 10:06:48 -0800 (PST)
MIME-Version: 1.0
References: <20201210165510.76b917e5@xhacker.debian>
In-Reply-To: <20201210165510.76b917e5@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 11 Jan 2021 19:05:58 +0100
Message-ID: <CAPDyKFri-WMWeE7HOQRFipsyGiqttRmM2agNP5-_VNk5W0k75Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-dwcmshc: set SDHCI_QUIRK2_PRESET_VALUE_BROKEN
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 at 09:55, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> The SDHCI_PRESET_FOR_* registers are not set(all read as zeros), so
> set the quirk.
>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 4b673792b5a4..500040253de2 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -87,6 +87,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>  static const struct sdhci_pltfm_data sdhci_dwcmshc_pdata = {
>         .ops = &sdhci_dwcmshc_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>  };
>
>  static int dwcmshc_probe(struct platform_device *pdev)
> --
> 2.29.2
>
