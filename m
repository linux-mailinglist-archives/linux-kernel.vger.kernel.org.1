Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD94218921
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 15:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729664AbgGHNdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 09:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729614AbgGHNdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:33:44 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D2DC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 06:33:44 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 64so18222916vsl.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tk41EF76dWlRas8xsGebAvCJsFIlsbIWNFweh1EZdNo=;
        b=zNu+/tGGqKUz5/jicyVSrwrbF/04PTgXFDQ2USWpWS6NTz8NHZ0w8hE9jFRlf9QK6n
         0K/1eDo6121CRDewruVvq8LIjCUi0g3gOeebsfLblRFrWZ1UYhAQJPrfBS9qTM2scVt/
         r5f6NywoWVtFgzQwidkKEty8UyiaTX9OdvBmwXJatJi1zlKAN/QkjOL0gzfMJaWFXXCQ
         eaGnNR11jB97WgJSAEqO6kQSLb6ANVdMKc/RfWVvBM/0RLh8AhxOlrPyhOKmCxwuqOOY
         XTEtkobG85H0bUeU84DLwBeKFRQc8P7tlRGUQC4QGX7xV9hw8F2pzMZxkAPGvIxPqlc5
         Wzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tk41EF76dWlRas8xsGebAvCJsFIlsbIWNFweh1EZdNo=;
        b=QSia3tIi/jC2g9sSEpUXOOnFwDQYntlARcdmmX/46XxGijHUEkpNaK+H+jd9mgMCHZ
         5cj1DAERVICbtSqfcGai+Z8U30jThrLgt99lr8dHz9RWugrk1EDaXQbZXJQ/T1j5E0LH
         ePjJtlXKOVXQs2yRxM8ZukOJAABWb8y6ydB5iNJgFufzCeN/eIIUVLf15/4Zdf3FqJXb
         UgSNjvHzpU5RDJxAXT3dQ9WIDEStXEbzJcC+fMF/WxB2H8ncCXJv0VG7Tca94vAogHW2
         omtFe45zj2QMsK/e1MzRblIDnkHA8XlwYbPhxJnEgdshqzxeEn8QBjMFKb79kkiuMNQ5
         vCRA==
X-Gm-Message-State: AOAM531Gq+x7MwrIXa2ru9LFTJri3LTyew6hVsdwWRRxuGOS+kkUF01g
        pZwt10nlok7u2hTv4tlo9MT7QeH6R+phailNVA1Vkw==
X-Google-Smtp-Source: ABdhPJzlaB5vrUOpL/q7Fp7zKcnnR5tcPNCNPyUvHhAG0+ZJ236PkwPb1+9MY0U+f/3ZBJIdGtlyqgQ2DPkCo+gUs1I=
X-Received: by 2002:a05:6102:126a:: with SMTP id q10mr25135884vsg.35.1594215223731;
 Wed, 08 Jul 2020 06:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <1594213888-2780-1-git-send-email-vbadigan@codeaurora.org> <1594213888-2780-2-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1594213888-2780-2-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 8 Jul 2020 15:33:07 +0200
Message-ID: <CAPDyKFq1=Ryeup0WYc2iqGi9vGuWrCvuvvLzBYf-A=K0Fok+6w@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Set IO pins in low power state during suspend
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 15:12, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> Configure SDHC IO pins with low power configuration when the driver
> is in suspend state.
>
> Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-msm.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 392d41d57a6e..efd2bae1430c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -15,6 +15,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/interconnect.h>
> +#include <linux/pinctrl/consumer.h>
>
>  #include "sdhci-pltfm.h"
>  #include "cqhci.h"
> @@ -1352,6 +1353,19 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>                 sdhci_msm_hs400(host, &mmc->ios);
>  }
>
> +static int sdhci_msm_set_pincfg(struct sdhci_msm_host *msm_host, bool level)
> +{
> +       struct platform_device *pdev = msm_host->pdev;
> +       int ret;
> +
> +       if (level)
> +               ret = pinctrl_pm_select_default_state(&pdev->dev);
> +       else
> +               ret = pinctrl_pm_select_sleep_state(&pdev->dev);
> +
> +       return ret;
> +}
> +
>  static int sdhci_msm_set_vmmc(struct mmc_host *mmc)
>  {
>         if (IS_ERR(mmc->supply.vmmc))
> @@ -1596,6 +1610,9 @@ static void sdhci_msm_handle_pwr_irq(struct sdhci_host *host, int irq)
>                         ret = sdhci_msm_set_vqmmc(msm_host, mmc,
>                                         pwr_state & REQ_BUS_ON);
>                 if (!ret)
> +                       ret = sdhci_msm_set_pincfg(msm_host,
> +                                       pwr_state & REQ_BUS_ON);
> +               if (!ret)
>                         irq_ack |= CORE_PWRCTL_BUS_SUCCESS;
>                 else
>                         irq_ack |= CORE_PWRCTL_BUS_FAIL;
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>
