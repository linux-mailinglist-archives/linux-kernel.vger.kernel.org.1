Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650B82A7F57
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgKEM7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730940AbgKEM7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:59:46 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D85C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 04:59:46 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id x11so687977vsx.12
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 04:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DQxEJYTnrFPdkb+SIqKXmZODsTPacZYJuDmLfP+J2k4=;
        b=XQxXbboDDYrNgWb5CeYdrF3FGkC+5Q6+wRSBmI+FXAaIwdtq+UdzWdpcVK4KKPTotX
         lE7KRoRGBMfJzRZ4iEfwFrNjq3PAjuXTq0Q2ZDiGkONZJx2AUtZac89l3kd7pT+oNtjc
         Im3lb7ynBI+i5nHFnIgI4ppc8jKGJQ0VFmhPvRfTeoIkKqYEvc2Bpe9hfzb7aLPtluDJ
         9q6LJkblDFdkgAyjDZp55LZczfikI2/vTSc6Et88yzN9TJWwhMbV/wEjdiG+JFVqeGeF
         BWSOLvGc+hKOskSC56Cit1Iq3rkj8x1+JgMsOtrftLz8VbeWFGteAO0Kpx0A+NDUr8IA
         w3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DQxEJYTnrFPdkb+SIqKXmZODsTPacZYJuDmLfP+J2k4=;
        b=E+/N6O0CWqFaBCCLILs1/AfgmTyawOV1tH7I2Ynp1IKqjEeuzeX8FiMlOVA7tVYw+6
         JadypPMik8SfaRllkgslSqD8ZCf4GUHX1hIcpeVwwyiLBBF0L4byUIeW2nzElYxvJWQt
         NtvhkGY5s4shgJ7AU1VkWHBFldXjtCN5OTURB/8gSk3zVxCyFTr4kuKBwvSGAVPS6SLs
         59WWqrd5uCbu8JlwgSmpOBf7ACSfkrs38nzsVdZ2i+ogYjVdH+DnuUJziMbbwN6Xtw2C
         cPs4eutKzH3AiGRqiCTaqbTxcpnsJ9tkLnJYb7k9fBkSYarbcg4sf1mZgiaAxSAKFrbQ
         5ggA==
X-Gm-Message-State: AOAM533RCl42+yunzA1od5VBQeixqHI5wqdXUT17EmlIF8l+t4J6SptY
        rXeoFQHaXlBuK/KSw8mYszhwhqGuOEvKWJJS978JfoX70Bk=
X-Google-Smtp-Source: ABdhPJw9TiQhWBq5dN8EcB5mPqGr915+EBTr3nV6C4ziDQvzTbuZsaADvlcFFOVWGJ5j7vJZsK29Ln/YI1RA9wP46j4=
X-Received: by 2002:a67:3256:: with SMTP id y83mr1116773vsy.48.1604581185547;
 Thu, 05 Nov 2020 04:59:45 -0800 (PST)
MIME-Version: 1.0
References: <1604375323-33556-1-git-send-email-tiantao6@hisilicon.com>
In-Reply-To: <1604375323-33556-1-git-send-email-tiantao6@hisilicon.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 5 Nov 2020 13:59:09 +0100
Message-ID: <CAPDyKFqT9OtZorNmi8OVNAFsbV14UgqZoDNCdkvZUvcHOEnG0w@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: replace spin_lock_irqsave by
 spin_lock in hard IRQ
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 at 04:48, Tian Tao <tiantao6@hisilicon.com> wrote:
>
> The code has been in a irq-disabled context since it is hard IRQ. There
> is no necessity to do it again.
>
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-mx-sdio.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 1c5299c..d4a4891 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -418,10 +418,9 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
>  {
>         struct meson_mx_mmc_host *host = (void *) data;
>         u32 irqs, send;
> -       unsigned long irqflags;
>         irqreturn_t ret;
>
> -       spin_lock_irqsave(&host->irq_lock, irqflags);
> +       spin_lock(&host->irq_lock);
>
>         irqs = readl(host->base + MESON_MX_SDIO_IRQS);
>         send = readl(host->base + MESON_MX_SDIO_SEND);
> @@ -434,7 +433,7 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
>         /* finally ACK all pending interrupts */
>         writel(irqs, host->base + MESON_MX_SDIO_IRQS);
>
> -       spin_unlock_irqrestore(&host->irq_lock, irqflags);
> +       spin_unlock(&host->irq_lock);
>
>         return ret;
>  }
> --
> 2.7.4
>
