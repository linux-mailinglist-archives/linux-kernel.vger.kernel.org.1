Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23BB2FC581
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394686AbhASNsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 08:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389711AbhASNjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:39:06 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:38:25 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id v23so2383096uam.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 05:38:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3X3PmZf5ZFX5QGwBhsXHXX/D7L5F3b1vb/uCDlLe9wI=;
        b=jNWlkaIxY6NoZOqCqC5pGF+o4jvbMn/xb8jtfR0/d/FEbfV4idHAVkLtrjB52Lpwam
         93L5kDYFuV+AVyiP7ti//mNLviydWK75z8+6hvuL/V/fixMPB/eDGEJ535CCzoEeU4Gx
         q5Szg3zoK1wtu7FO/YDNqkh/a42G3vVViXgCXkOJI0Xl8DEbVWRQo9Aue2rwOm/3Sghq
         W0jCEH3mmwUnRbkTqM1K87HAZobs6XlCaKJJ4BcpUnrW4PBBvGLIqi5OS2uVH3NoysF9
         O/ZsUryG5wesVqgQAC7G5tIC4c9ntDxaVBaesjG/oltixMaZufVeyAqAXJCnalixm0G8
         pjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3X3PmZf5ZFX5QGwBhsXHXX/D7L5F3b1vb/uCDlLe9wI=;
        b=rtHqMxL/Rod4nhDZkKiUpWB6rS9nNAv8HLObKB0eJwKx9lj6CHcgXJtGWIiG81FsEz
         GiKwmVtSKEMd15fOoURHznYPSi9DdS2EKpIbOitUMIirZCFgD1nWqdowrcsZRFzX9Xoc
         dsJMA6YB097Csu2ks7lx8Xq7RKFNk6iJl5/Fm1lGvKO3jFyK5fx/esTEeelH7pKbvYhD
         MHShdH1shJDbQZ1vV5S+PYxrIF7gx3S8kgNnCLz+KM0nWzt9qE/J7rluIwt+pSiBgT/9
         cuh36kGwWlg3VsnGYwyEw8AhVr905kN/P4y7LeM1ddIEMatKMZmSdri6cxOJa1JPE4Lr
         TrzA==
X-Gm-Message-State: AOAM532K5bPWySb9UhULYzJHC6QOBGURzrzZNQld0sVCX9Jcg/k2MgMd
        YaubjaVOGrgfsxPD6UwB7lrDf3jY59e2HRJWYNvRLQ==
X-Google-Smtp-Source: ABdhPJw5Geqvr9FjKwnfUyEHlqjInTcQwC1+sWVIZ1SYOgY3Qb8NqNpKBWOWTA3PrYyyeNrvlFstj6HKTroeAi4t7fM=
X-Received: by 2002:ab0:768:: with SMTP id h95mr2255398uah.104.1611063504953;
 Tue, 19 Jan 2021 05:38:24 -0800 (PST)
MIME-Version: 1.0
References: <20210115032423.15108-1-peng.fan@oss.nxp.com>
In-Reply-To: <20210115032423.15108-1-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:37:48 +0100
Message-ID: <CAPDyKFr9Xan+FxgC4vz4KX2UfD15Eo7+TfCjD191YVC2Hv0wdw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: validate pinctrl before use it
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Bough Chen <haobo.chen@nxp.com>,
        Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 at 03:55, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> When imx_data->pinctrl is not a valid pointer, pinctrl_lookup_state
> will trigger kernel panic.
>
> When we boot Dual OS on Jailhouse hypervisor, we let the 1st Linux to
> configure pinmux ready for the 2nd OS, so the 2nd OS not have pinctrl
> settings.
>
> Similar to this commit b62eee9f804e ("mmc: sdhci-esdhc-imx: no fail when no pinctrl available").
>
> Reviewed-by: Bough Chen <haobo.chen@nxp.com>
> Reviewed-by: Alice Guo <alice.guo@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Looks like the documentation of DT bindings doesn't specify pinctrls
at all. Please add it and explain when they should be used.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 16ed19f47939..11d3a2244b36 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1488,7 +1488,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>
>         mmc_of_parse_voltage(np, &host->ocr_mask);
>
> -       if (esdhc_is_usdhc(imx_data)) {
> +       if (esdhc_is_usdhc(imx_data) && !IS_ERR(imx_data->pinctrl)) {
>                 imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
>                                                 ESDHC_PINCTRL_STATE_100MHZ);
>                 imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
> --
> 2.28.0
>
