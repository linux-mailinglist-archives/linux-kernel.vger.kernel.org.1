Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60702C297B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbgKXOZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388921AbgKXOZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:25:58 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76CEC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:25:57 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id a10so6863093uan.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZpokcrYiNkFKDrqesRHIwMWb2q0UieIyDPrr1PDT0g=;
        b=A/lVSz2zLoIYzKcnGI4hqoTNYMJi/cuhqeD4LKMoLjhpWJO+dbNTjQ/d0qMCnqzsHf
         owMFf/AwDR2B20tkqBKHFZ43l44GOqE5g9B4wPxNPbQNFqXhzEKInTc5u4roDg0+6KHs
         vFzW498O6l9DEzm/+2Io3MtIuOqr+yvAUSRvAE+6aNR2IlPW5gN/0qm7i/NqjUBVppP/
         EKN80ULQvItx7w5UnO5DieYnoNefjb/4oQKu7Hm+gBUmWIrWUhY7lyJibSj5MMUTNWcT
         lw3Gkg7NOi2NTNuM/RE63+C0Z9c6J0QY5+JmX6+8dCwRLEPHd94Deha9/zAAK/h/pcwI
         DpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZpokcrYiNkFKDrqesRHIwMWb2q0UieIyDPrr1PDT0g=;
        b=sQy7Y7a33gHv/qB/YskFxmHhO63ZZVEAnIer3zoiuSCHPqS9hN5C1piqzovnS8QEK9
         DhRt4aCA6M2QY4w+SQ4fdLNThrPXA7awkxJJj3Zp9r/PqUaoNBbefjbP2GHq21DgE6sX
         mQGgtLT4zO7DmqkpQYGLHe6uyhVq15ZWMiKmhNo4iTg4Ff3KOP+SC8bySYDJOv4hjnL9
         9ocuysSYKJuA9Cp6LDhB/c52OiHXZJ09CPCprMmHNG+ex3vRZcvAjU/J3lzZ4y6NOfOF
         om3qt6GjtsJYt0UYB+HkuPQI4yjRkJCeQfqD4Ea38JZvgrEXyrcJcCIOg6VgCsmy+UGJ
         Mzhw==
X-Gm-Message-State: AOAM532Nlk1KIF19r4s99GxH2zArIMOZGH+SY61vwWbkVQgHDMWBdWqu
        DapmoBUDp4s/JbNCxaAry7M6034L7SThfhf9U1IGCg==
X-Google-Smtp-Source: ABdhPJwGN9h11JcGB0t0T2NXu30qTxAsYUt9sPtNoXKotqtjo05E15lzuOauqFkaV4sGeIXw/BvauQnQWMr8nw/ivP8=
X-Received: by 2002:ab0:5859:: with SMTP id p25mr5651452uac.100.1606227957134;
 Tue, 24 Nov 2020 06:25:57 -0800 (PST)
MIME-Version: 1.0
References: <20201120233831.447365-1-jeremy.linton@arm.com>
In-Reply-To: <20201120233831.447365-1-jeremy.linton@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:19 +0100
Message-ID: <CAPDyKFq-pMKAJdS8qPpkR_QZ_QLW70Y7PPGxA=d_HOBRd-Su=A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Update firmware interface API
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Nov 2020 at 00:39, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> The device_* calls were added a few years ago to abstract
> DT/ACPI/fwnode firmware interfaces. Lets convert the two
> sdhci caps fields to use the generic calls rather than the OF
> specific ones. This has the side effect of allowing
> ACPI based devices to quirk themselves when the caps field
> is broken.
>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 592a55a34b58..feba64fbde16 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3992,10 +3992,10 @@ void __sdhci_read_caps(struct sdhci_host *host, const u16 *ver,
>         if (host->v4_mode)
>                 sdhci_do_enable_v4_mode(host);
>
> -       of_property_read_u64(mmc_dev(host->mmc)->of_node,
> -                            "sdhci-caps-mask", &dt_caps_mask);
> -       of_property_read_u64(mmc_dev(host->mmc)->of_node,
> -                            "sdhci-caps", &dt_caps);
> +       device_property_read_u64_array(mmc_dev(host->mmc),
> +                                      "sdhci-caps-mask", &dt_caps_mask, 1);
> +       device_property_read_u64_array(mmc_dev(host->mmc),
> +                                      "sdhci-caps", &dt_caps, 1);
>
>         v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
>         host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
> --
> 2.26.2
>
