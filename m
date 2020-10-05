Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4035B283629
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgJENET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgJENEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:04:10 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0ECDC0613AA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 05:51:34 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id d18so2217791uae.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 05:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/LfR7NJhI/H8i1pAKdmMvy4/cqEVQbECiWw0Fq0bpc=;
        b=MJJUt8VwaOPdbm4HjQXuthgVqUomQWYNK1q8/Z1X+NK+vFPBhzvXU4X82HhL+PEX51
         EMY2VN0zm9t47yr0V8DHbbl8K1I6+W4jfo360sxhwNam4im3Y8xZw+k+3x1mZP8dlNlL
         N7rm12o4IGF2Dv++YtJC+FVealjFOqidUo6gJJXg+s6o9Z/bmxKab9oFVBJinl+CEvAP
         kBFxGzFZRJ0JL9RbtB7G9JCUm2n2hMGhcxLIh1V6+mzh0Tx7PhuqGbM0iAG+h2BAhMU7
         QDY00Dr2xXBKrC5qzAElIjExQUyO+Kl4N4J7wnIQZ3iDU7CwmzWgwikOoHqdqE676YV4
         Ut0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/LfR7NJhI/H8i1pAKdmMvy4/cqEVQbECiWw0Fq0bpc=;
        b=cP/z2OCX/9j+7j2Ue73Rl9rbzSqAZWv5SQa1txLgHjaWlvqB+uGuufqEkbwN5q5qUO
         2Omo4N2XLI+rPOusNzcjdZJu9V5gVArR3qysDGwr4H06ZIEE3k6Aon4Zf3S17j8bsYy9
         rSQj2lz78fZjuV37zxvN4KFlVYVtaDk+lAkFry/e8VLLEMfbBKkEOv0Pa4VMN8B/6h//
         +O2uB9PW1aLWVkgd/WtC4t6cZpPUHIMu6t/jouvvJvWkRwggu2eeUlvgsWPJwAjdlqPf
         souV53ySMHdg2P/oGkerImzbUR6kDsKcBrycGML7w3vIEBoO5rjWh/SFsYluhozy+1F9
         gTPw==
X-Gm-Message-State: AOAM532F04hov3veJw08jntL4ZKxfXepofNYJ99wWPSZxD8e3ncPKBeB
        W7dZYpCVKj2AvhMKMb6UkorESyxUIjSA20aj2kYfXA==
X-Google-Smtp-Source: ABdhPJzPIU3rO0XQQWE8ktzHhBsePAKbz9xMOVOvI0oS3ypXApmhEF0SLXDb+F/ccePvQwO13Y1JEdc5rrt/NN8PPQw=
X-Received: by 2002:ab0:6f91:: with SMTP id f17mr7047512uav.129.1601902294152;
 Mon, 05 Oct 2020 05:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200928154718.1.Icc21d4b2f354e83e26e57e270dc952f5fe0b0a40@changeid>
 <20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid>
In-Reply-To: <20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 5 Oct 2020 14:50:58 +0200
Message-ID: <CAPDyKFrVtz29w=gONGO8_sGDQU-ZSXH2NyMuwRL7-27ae=jt_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400
 driver strength
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>, Shirish.S@amd.com,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Wang, Chris" <chris.wang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Sep 2020 at 23:59, Raul E Rangel <rrangel@chromium.org> wrote:
>
> This change will allow platform designers better control over signal
> integrity by allowing them to tune the HS200 and HS400 driver strengths.
>
> The driver strength was previously hard coded to A to solve boot
> problems with certain platforms. This driver strength does not
> universally apply to all platforms so we need a knob to adjust it.
>
> All older platforms currently have the SDR104 preset hard coded to A in
> the firmware. This means that switching from the hard coded value in
> the kernel to reading the SDR104 preset is a no-op for these platforms.
> Newer platforms will have properly set presets. So this change will
> support both new and old platforms.
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/sdhci-acpi.c | 39 ++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index d335a34ad05b3..5c9a041af5b4b 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -545,10 +545,43 @@ struct amd_sdhci_host {
>
>  static int amd_select_drive_strength(struct mmc_card *card,
>                                      unsigned int max_dtr, int host_drv,
> -                                    int card_drv, int *drv_type)
> +                                    int card_drv, int *host_driver_strength)
>  {
> -       *drv_type = MMC_SET_DRIVER_TYPE_A;
> -       return MMC_SET_DRIVER_TYPE_A;
> +       struct sdhci_host *host = mmc_priv(card->host);
> +       u16 preset, preset_driver_strength;
> +
> +       /*
> +        * This method is only called by mmc_select_hs200 so we only need to
> +        * read from the HS200 (SDR104) preset register.
> +        *
> +        * Firmware that has "invalid/default" presets return a driver strength
> +        * of A. This matches the previously hard coded value.
> +        */
> +       preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR104);
> +       preset_driver_strength =
> +               (preset & SDHCI_PRESET_DRV_MASK) >> SDHCI_PRESET_DRV_SHIFT;
> +
> +       /*
> +        * We want the controller driver strength to match the card's driver
> +        * strength so they have similar rise/fall times.
> +        *
> +        * The controller driver strength set by this method is sticky for all
> +        * timings after this method is called. This unfortunately means that
> +        * while HS400 tuning is in progress we end up with mismatched driver
> +        * strengths between the controller and the card. HS400 tuning requires
> +        * switching from HS400->DDR52->HS->HS200->HS400. So the driver mismatch
> +        * happens while in DDR52 and HS modes. This has not been observed to
> +        * cause problems. Enabling presets would fix this issue.
> +        */
> +       *host_driver_strength = preset_driver_strength;
> +
> +       /*
> +        * The resulting card driver strength is only set when switching the
> +        * card's timing to HS200 or HS400. The card will use the default driver
> +        * strength (B) for any other mode.
> +        */
> +       return preset_driver_strength;
> +
>  }
>
>  static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
> --
> 2.28.0.709.gb0816b6eb0-goog
>
