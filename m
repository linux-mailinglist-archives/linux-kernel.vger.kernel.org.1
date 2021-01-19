Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C862FB87C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390016AbhASMqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390685AbhASMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:38:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C38C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:37:45 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s11so14020108edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uX05RLrFNDFR+8S7xOfs8UI8fZ3dszKDQDSS1Mm1oRI=;
        b=tJ+U52IBIWNDfTK5zo8brqLp/GYfXWl5QdtKyMVwTp7+1APyQLJAlq3mPN+6zTdkzu
         PSMp/aXe4e/Wn9Qq8/oLh8NJKIlSDQDz/jHafpQvz7CkXy2yAhOONt00w16tirntt0mu
         SqTROIu7CfCRcnqGRdKiH+aFO4a5FVZEja5fV/LTMT4+sqmwy4Swh7DBWhwzR+H4JrG2
         yfiL92ZtY7QHSA3JZU6gcz8U4ItrUdqFnjHYfsAyXAxGIrkv5vBWS6lbMEVLIYNWNrWo
         fST5y6jADs22N+P1o+WQYTvLdC5Q0Nk6yQRqsKvkzCA42s1MFdt77iAoQXzmJgT8PXGG
         pUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uX05RLrFNDFR+8S7xOfs8UI8fZ3dszKDQDSS1Mm1oRI=;
        b=H4onnoCIFL8ih0UmJShEW6V0sTFaEdfcv67d+Sj8Zo+1C4L1WhDKTbzmXlIsuKeQqw
         C4w+0pdj+eQ5z+Y1lJNX1sWFJx4KHxVweq/uCFxI966MTHwRl4M+W4xtyfJtuEOc4Au7
         iLNo6LiQwDOALXC7rUxJjXJMvUoDjomofXPStYRnl9O3rplcnnfrROG8/eeRLBGH3B90
         YYbKATmCS0l2sek4bIgVaZw/WbCytAZwgoU+2kcIj75ugVFSMkdhOwU6+deyzojiawA4
         XpaGtn8z/+///DIdMqDagRUPZ0mVpsD7EzxNaJVdCwPAlcQDpyir1IAxdMa5lvblJY11
         +SLg==
X-Gm-Message-State: AOAM531PqgitMJ/usngp6tj00u4iJ+/VPpTW8HTaH6rioywBIeB7PB2K
        uR6Fuxz57e0rYs7TJ6qicCKNKM0c7ZDPDg5WGosNiw==
X-Google-Smtp-Source: ABdhPJzwyxjvwMiQLzkqllYCKMU6mEWJaYJ/J+ypPwfmQL+Gmfrg8A6ZcRXembuqo8a+XYju0LZ2W7wS0upW6uhFrVg=
X-Received: by 2002:aa7:d401:: with SMTP id z1mr3199321edq.213.1611059864353;
 Tue, 19 Jan 2021 04:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20210118194925.819610-1-thierry.reding@gmail.com>
In-Reply-To: <20210118194925.819610-1-thierry.reding@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 19 Jan 2021 13:37:33 +0100
Message-ID: <CAMpxmJW4uAJggA+yuO8Ntgi_px1fmZ3e3WCtszvc+prpYY=DGA@mail.gmail.com>
Subject: Re: [PATCH] gpio: tegra: Add missing dependencies
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 8:49 PM Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Commit efcdca286eef ("gpio: tegra: Convert to gpio_irq_chip") moved the
> Tegra GPIO driver to the generic GPIO IRQ chip infrastructure and made
> the IRQ domain hierarchical, so the driver needs to pull in the support
> infrastructure via the GPIOLIB_IRQCHIP and IRQ_DOMAIN_HIERARCHY Kconfig
> options.
>
> Fixes: efcdca286eef ("gpio: tegra: Convert to gpio_irq_chip")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/gpio/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 75f6c37620ea..013a1055939d 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -597,6 +597,8 @@ config GPIO_TEGRA
>         default ARCH_TEGRA
>         depends on ARCH_TEGRA || COMPILE_TEST
>         depends on OF_GPIO
> +       select GPIOLIB_IRQCHIP
> +       select IRQ_DOMAIN_HIERARCHY
>         help
>           Say yes here to support GPIO pins on NVIDIA Tegra SoCs.
>
> --
> 2.30.0
>

Applied, thanks!

Bartosz
