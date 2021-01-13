Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510892F4A22
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbhAML1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728405AbhAML1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:27:32 -0500
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C96C061381
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:26:04 -0800 (PST)
Received: by mail-ua1-x929.google.com with SMTP id 17so578165uaq.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G9uUX9S3OVX4rZ6wYRdgXrk3nCogppGF0MA8GEuY/Eo=;
        b=bU6xDgHDA03VljnUMmlniVSQL+0j8c8khXIY8SYSejm5jZmEf0DMR8cvviAekgjnpg
         8nsfnWMQcbaMrUs6k6GasTAoOuia5YOZ1iyDVWb20Cqi5YaaoCAdB7Q7lXZqdISTwRGh
         +yAr/OYyF0dQrcO6WmmvQIoSz8GX20sRUEmAqiudqFDuZ+p/kdb4XooeioD69ncGaCXK
         AGr8JTbslgrkhZikNO1rwt+OwdITR9V+it/fgPMUZhQ6Oen58zOiI4eGiAJQ/XaIlgZ0
         YHPQcCMcTH++qBKGkUpd1PYsOE9NdlPGM4QKgWk2VEWIGvkqkcnki/Xd6QQohcTIZ2fI
         fQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G9uUX9S3OVX4rZ6wYRdgXrk3nCogppGF0MA8GEuY/Eo=;
        b=tW2eE1ydCG1P+TitDuQDl2Xgta4zd8/UqycOREBF6G9/HFMLTqErQIT6lSZo2qRroQ
         MeGHrHd7EqEhyRYRxG/BYGWVLgQhoQurk9yykaOdvO7yFIf1iGrjqxUlnHMdQiAeVVfB
         WobKSIiGfNxm/bmzDT02Wi+lgGMobhSfG7kB4sS8BZd0MG05nirwnr/UmBiiq96fsaBI
         yXyhniabKkM+RNeqjUhPy+WZ6EDR6z+Xuva0aGXp59/461ItGUQC5K5vleQZLxupdasU
         KJLRr8Ti9lmBh/4Cuyc5D2Pk+Ads/R7XPjGUVd2Yk03BiqVUGS6OLrI+t85bVpvpjPvj
         0A2w==
X-Gm-Message-State: AOAM5323ArLoOLbeKbWiY10Ce8BaZdVjpq1GdRxrm6y1LjMbffIkD4Bj
        AhC3Om5fNkgogUYsQCnSmeyFpsXlgoGBTbVW1Du7uw==
X-Google-Smtp-Source: ABdhPJzuX/Dmv6UrnVgDqjPg9laCYydPT3+Ow26Mww6AgWCZnluKMLLz+2aCvtQkShl3qtjiA+tyznGcQJytP8JGG+o=
X-Received: by 2002:ab0:4597:: with SMTP id u23mr1353390uau.100.1610537163831;
 Wed, 13 Jan 2021 03:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20210107221509.6597-1-alcooperx@gmail.com>
In-Reply-To: <20210107221509.6597-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:27 +0100
Message-ID: <CAPDyKFqK-b7B6jfhfFAwey0rs3uP=W2P9Gwt-yc0820UmypwPA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jan 2021 at 23:15, Al Cooper <alcooperx@gmail.com> wrote:
>
> Commit e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> that added a shutdown callback to the diver, is causing "mmc timeout"
> errors on S5 suspend. The problem was that the "remove" was queuing
> additional MMC commands after the "shutdown" and these caused
> timeouts as the MMC queues were cleaned up for "remove". The
> shutdown callback will be changed to calling sdhci-pltfm_suspend
> which should get better power savings because the clocks will be
> shutdown.
>
> Fixes: e7b5d63a82fe ("mmc: sdhci-brcmstb: Add shutdown callback")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-brcmstb.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index bbf3496f4495..f9780c65ebe9 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -314,11 +314,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
>
>  static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
>  {
> -       int ret;
> -
> -       ret = sdhci_pltfm_unregister(pdev);
> -       if (ret)
> -               dev_err(&pdev->dev, "failed to shutdown\n");
> +       sdhci_pltfm_suspend(&pdev->dev);
>  }
>
>  MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
> --
> 2.17.1
>
