Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656E829ADAA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752483AbgJ0Nmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:42:36 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44931 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbgJ0Nmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:42:35 -0400
Received: by mail-vs1-f66.google.com with SMTP id u7so865955vsq.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lF1BfHar/r1OSmm5wTIr7B7jVJxijYAoAAWj/k6sxxs=;
        b=D/SMN1X7nR5nWFZAQeWhWWV1yQwEqxe2HGp00zua+Yj59NYXyWmt0vZoH50qWxstwV
         NYO6uSpDmtueEztLIK5s4eFnmgtsHhlxb0sDVTk1gwg/O8fn2hziUzx9TPHfc3KEDo7M
         EKA0H8BkFgjEu26YGeQ3M1eAwm6Jsv0VG/pmRAuPAf2EtAA1GZNMM2Jt+GJldzP6T6rZ
         +14hwq57kzzKqa4r92IHWqQM+J1PeqfISf3vJyAUeKviJNGptmMBS+SRp0pkcwHFP/9v
         XnEceWw/uMojbP1kOR+ols/oFsO8QdBf3WABCTTvvBI1B1DEB7D29DO4QKo9VvRRtfXM
         D6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lF1BfHar/r1OSmm5wTIr7B7jVJxijYAoAAWj/k6sxxs=;
        b=I6rXT1LjYTyYe4OfrsPESGsEPibWOmXEtRuz12WzfrRQlmOVadK9BuMdZ1a9xUv/vG
         K9tmyfF0oRa1426rbch2tBnnIkTKke64XBwPq4I4KlQgpW/MtC/ADOyLR3IUW9PrLL/R
         yy0XPIHWDe9uI3kKTl94ngOoj5UKTh7jFDxWR81ZxwDGv28KVZLedwAHjna480CDhIVx
         ImSkAaaxE0fyVoWWwcjBwcSPmAkLfy77J+EpiK8tLwjCTWEkh9nbF+pfnhewd/L3rkKb
         1LFkwRtAvNZYnhOaj9zeQY9NyggjOasb0kVFS7v0xyRCkOhWzMR96uScr6QxpMzRYSwX
         LCcw==
X-Gm-Message-State: AOAM530QSKXRIGbuELg2581JmBH5+vHjbhUmQTD9Wb4bv1DLXmuUI6Zb
        gBbgv9rLd1sfm4qEiWYPI3NQ7cSk9inH8EFOES5J/tH60YCp7w==
X-Google-Smtp-Source: ABdhPJw6TmF4N27XLpQNt4o/nJ2l6gXkofBFfhmsHcwHenrVY1ehrbL+xJ8x9D2WfXn5JlknUmG/mupqI0JuKvY6tqk=
X-Received: by 2002:a67:f24e:: with SMTP id y14mr1398541vsm.55.1603806153369;
 Tue, 27 Oct 2020 06:42:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201027084612.528301-1-victording@google.com>
In-Reply-To: <20201027084612.528301-1-victording@google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 14:41:56 +0100
Message-ID: <CAPDyKFo=jA84Zr9AM7sXR_VxpGsi9n-aGJJMRcY7uFBcRWrf4g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-acpi: AMDI0040: Allow changing HS200/HS400
 driver strength
To:     Victor Ding <victording@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 at 09:46, Victor Ding <victording@google.com> wrote:
>
> From: Raul E Rangel <rrangel@chromium.org>
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
> Signed-off-by: Victor Ding <victording@google.com>

Applied for next, thanks!

Note that I amended the patch to fix the white-space issue, as pointed
out by Adrian.

Kind regards
Uffe


>
> ---
>
> Changes in v2:
> By Victor Ding <victording@google.com>
>  - Rebased the patch by using FIELD_GET for preset value bit masks.
>  - (No functional changes).
>
> The original patch was developed by Raul E Rangel.
> https://patchwork.kernel.org/project/linux-mmc/patch/20200928154718.2.Ic6b6031366f090393d00a53fd69e1ada31ceb29e@changeid/
>
>  drivers/mmc/host/sdhci-acpi.c | 39 ++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 54205e3be9e8..225cb34cf1b9 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2012, Intel Corporation.
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/init.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
> @@ -545,10 +546,42 @@ struct amd_sdhci_host {
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
> +       preset_driver_strength = FIELD_GET(SDHCI_PRESET_DRV_MASK, preset);
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
> 2.29.0.rc2.309.g374f81d7ae-goog
>
