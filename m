Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C042F4A10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhAML0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbhAML0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:26:52 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C3C0617BA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:25:54 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id h18so903660vsg.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RY0StSf2+N5zefAWzCUaAzXJcItnmm9Fa8mEZdMQe/Y=;
        b=NqJxW9NFl6Mpmiw179v+oVixBzv5BFOOzZs4jkT6kMz7Bu4B9hEHxWecVQlqajpiDI
         u4BINGsA8Z/jvKTUpEgwHKAa91r/bE1I313SR2ab7Hkgul0pvRSbvQH/qIRaDbeq7khZ
         o2IiSd8oGNQZb+YJh6A67boEZpPAer0R4CJUz8vIHILxQwyF3c83bmAu5s6yQ0U5fT/T
         Ob/FQXbPFg5IVSFi6ijA9yZq84Wkc1fb9NJWs9ZIA2OOpsyu1HOT7gUQTriGuhN+CzeB
         bvEmoOxauMNhuyFgJX959/TywUpU15oOCWJPRsMUWL5HbLQa8Q+3uwPCrGXzC4kvbQvI
         JXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RY0StSf2+N5zefAWzCUaAzXJcItnmm9Fa8mEZdMQe/Y=;
        b=mKyKspfrhg1jeebWSCaoc7aFqoXG7cHtVG2lQfj0C2WzhCSxD0Kez8gflvg7yM1BOe
         35WbjP58CFTkl3/Lfpg3yvt4er21Ij5UE7d3hu4bT4sjv/O4sUtGWjJ1r1wsN2ygdh0j
         zgecnaYvH4VeRT2IPvcdIpiyB5/ZJwbcc16DCTZgDd+ILRzr7auJvK/XUV/CuInEPl15
         Pb/rJR+GIYcvB+HSpSMUzKUxg6Xtx3oKc1OFjY0r6P55bSgL6C+LMNbUcz1wTrW0lJMd
         i2AyxDcDkEwalfIIzFV1yKAAzBFqxAOAz4bllo2V+TTcdF4SR1VmkVc/q82Y3INRCs5N
         KFdw==
X-Gm-Message-State: AOAM530qhJai01Xb8ep5usfldHoWRUSf//bab61Mcx1UBNGS0Lo7OMge
        9H/PgJvVbf08mYj5dZC/pdHXXRQVIbhsuHSLtsIRCA==
X-Google-Smtp-Source: ABdhPJxmIxYl1NunM1cg14JUdbGuw0lAyEMiH7zhCkebWu1/bDnqufJtPRRxfcFqBrE/5wP5Gz7wdB/uYTO3CnEeUIY=
X-Received: by 2002:a67:e286:: with SMTP id g6mr1629067vsf.42.1610537153628;
 Wed, 13 Jan 2021 03:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20201230090401.12627-1-ricky_wu@realtek.com> <20201230090401.12627-2-ricky_wu@realtek.com>
In-Reply-To: <20201230090401.12627-2-ricky_wu@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:17 +0100
Message-ID: <CAPDyKFrL+ykvw85SiLQojF9PnYoYzraOOvkS8qg5w-LL7xPvNA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: rtsx: Add MMC_CAP2_NO_SDIO flag
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Dec 2020 at 10:04, <ricky_wu@realtek.com> wrote:
>
> From: Ricky Wu <ricky_wu@realtek.com>
>
> Added flag MMC_CAP2_NO_SDIO to mmc->caps2
> Card Reader not support SDIO
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index d21b99962b36..6a8b0282f272 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -1427,7 +1427,8 @@ static void realtek_init_host(struct realtek_pci_sdmmc *host)
>                 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
>         if (pcr->rtd3_en)
>                 mmc->caps = mmc->caps | MMC_CAP_AGGRESSIVE_PM;
> -       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE;
> +       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP | MMC_CAP2_FULL_PWR_CYCLE |
> +               MMC_CAP2_NO_SDIO;
>         mmc->max_current_330 = 400;
>         mmc->max_current_180 = 800;
>         mmc->ops = &realtek_pci_sdmmc_ops;
> --
> 2.17.1
>
