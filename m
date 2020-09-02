Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EE225A834
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgIBJDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBJDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:03:34 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD891C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 02:03:33 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id y15so1337590uan.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5non/mH33hYNnT7K/jyemSoSsUl6fyRsBJcyHttPwYs=;
        b=FdUJXWdsf6gKrFgqqh450pXH77gnb3JCbR/WfRlIaAW/X5dNYj9dl4w5er1kirJoPD
         PlunBAWov9vDuk89yZOeS8SzvjP0XTjzUuil/FV4k6IyPTSKHVwiopBnS6MV0gNTt3oy
         vpihaVWVfCEz8zxcVDke34LoqUvUJHpAJb4k1WizTWUU3LO7hphXcyxTB7+kWBrANTmg
         tShLRxYKws7zHVeyh4hWDUoh63FI/MRcOLN/btNSRIREle/dsu4WhcOaCADlSBc+J59K
         L2er0xSh0uSOjQExQ3xzKn1zPAXPGSG76uIqdfWVI9XtPVFEBSExCREQ/keCuIHJdBJA
         Sndg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5non/mH33hYNnT7K/jyemSoSsUl6fyRsBJcyHttPwYs=;
        b=f2CY5Cpn8ztpxpfs+0Ch1ogAR2/v3jThyr5OMbLmXrQxdrYUzOsf0g4vEcQ2RM7q0N
         fweBFmO0rlUfLkfXNdPuPhc25hXdgUB2LYn4JEqhCHc3NvLTmdKImpMbEVnVkuSHZS+n
         3Qk3As3D+Sa/+UJj1znFkSonVSMRseheN1hs3zq0DiH+nvTfVZpM1CLITVEiw3LAku/f
         3ZHzan7lKqIAkC2k7nys1BVlI4cCxbmJjcI+ujlOepq4vBaSgjVH6HM76McacdVYveJ4
         oMYSATp7CUoBvxObX82yshACzJoiYFZOxFyou/S1yNfqsGCp4s9S+UX9ei1GwkIV+zB7
         KYFQ==
X-Gm-Message-State: AOAM53320obtl1nkISFeZHYcl7KougYUB+KyfM62qcinIzshpe4mVKxN
        fNG9Ms6N0V/AUPzrSkhQKUPt/nboQOaJDMWhd5Bb+Q==
X-Google-Smtp-Source: ABdhPJxUhsYDJqZr+S2DnXSmktdz1rbcrmTUXe81Wm8CM3eLPWzV93DWmovX8ETkt+tgUNa/T1ptifV3FeK831DdelI=
X-Received: by 2002:ab0:2ea1:: with SMTP id y1mr1954663uay.104.1599037412847;
 Wed, 02 Sep 2020 02:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200831150517.1.I93c78bfc6575771bb653c9d3fca5eb018a08417d@changeid>
In-Reply-To: <20200831150517.1.I93c78bfc6575771bb653c9d3fca5eb018a08417d@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:02:56 +0200
Message-ID: <CAPDyKFqiOpqh+wNXx8sNtoYrNUGPNkCtHeFP2KpaFukN+nMymw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-acpi: Clear amd_sdhci_host on reset
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>,
        "Wang, Chris" <chris.wang@amd.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 23:10, Raul E Rangel <rrangel@chromium.org> wrote:
>
> commit 61d7437ed1390 ("mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040")
> broke resume for HS400. When the system suspends the eMMC controller is
> powered down. So on resume we need to reinitialize the controller.
> amd_sdhci_host was not getting cleared, so the DLL was never re-enabled
> on resume. This results in HS400 being non-functional.
>
> This change clears the tuned_clock flag, clears the dll_enabled flag and
> disables the DLL on reset.
>
> Fixes: 61d7437ed1390 ("mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040")
>
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>

Applied for fixes, by updating the commit message a bit, thanks!

Kind regards
Uffe


> ---
> - Performed 100+ suspend/resume cycles without issue.
> - Also verified tuning continues to work.
>
>  drivers/mmc/host/sdhci-acpi.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 962f074ca1742..284cba11e2795 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -551,12 +551,18 @@ static int amd_select_drive_strength(struct mmc_card *card,
>         return MMC_SET_DRIVER_TYPE_A;
>  }
>
> -static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host)
> +static void sdhci_acpi_amd_hs400_dll(struct sdhci_host *host, bool enable)
>  {
> +       struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
> +       struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
> +
>         /* AMD Platform requires dll setting */
>         sdhci_writel(host, 0x40003210, SDHCI_AMD_RESET_DLL_REGISTER);
>         usleep_range(10, 20);
> -       sdhci_writel(host, 0x40033210, SDHCI_AMD_RESET_DLL_REGISTER);
> +       if (enable)
> +               sdhci_writel(host, 0x40033210, SDHCI_AMD_RESET_DLL_REGISTER);
> +
> +       amd_host->dll_enabled = enable;
>  }
>
>  /*
> @@ -596,10 +602,8 @@ static void amd_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>                 /* DLL is only required for HS400 */
>                 if (host->timing == MMC_TIMING_MMC_HS400 &&
> -                   !amd_host->dll_enabled) {
> -                       sdhci_acpi_amd_hs400_dll(host);
> -                       amd_host->dll_enabled = true;
> -               }
> +                   !amd_host->dll_enabled)
> +                       sdhci_acpi_amd_hs400_dll(host, true);
>         }
>  }
>
> @@ -620,10 +624,23 @@ static int amd_sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         return err;
>  }
>
> +static void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> +{
> +       struct sdhci_acpi_host *acpi_host = sdhci_priv(host);
> +       struct amd_sdhci_host *amd_host = sdhci_acpi_priv(acpi_host);
> +
> +       if (mask & SDHCI_RESET_ALL) {
> +               amd_host->tuned_clock = false;
> +               sdhci_acpi_amd_hs400_dll(host, false);
> +       }
> +
> +       sdhci_reset(host, mask);
> +}
> +
>  static const struct sdhci_ops sdhci_acpi_ops_amd = {
>         .set_clock      = sdhci_set_clock,
>         .set_bus_width  = sdhci_set_bus_width,
> -       .reset          = sdhci_reset,
> +       .reset          = amd_sdhci_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>  };
>
> --
> 2.28.0.402.g5ffc5be6b7-goog
>
