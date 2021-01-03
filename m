Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078BA2E8CEE
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 16:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbhACPgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 10:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbhACPgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 10:36:23 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F220C0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jan 2021 07:35:43 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id p22so24629017edu.11
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jan 2021 07:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAsNHJ04qXj7NOFemNU/AVYo7sQyesbZ2/ZS+gTz3yY=;
        b=JYStzbrcOZUug6PTnGMSalnVKB1OTR2Wn9Fk4lykj36+spy/fvNmamuH0Qp7qr5v26
         sWOVY/wrLndB6durZ3aP1Cr1CwKksyviRJZFbBatqyxBxje1As3qeBB0OOqX6dPGetIY
         xoCF6ZPGFGCM9aEcmtoKUisOuSU5vqkhwAxQhNmlMv6BCzRnEV3gXlH/Lazo4T8x6uc4
         vudyTLLvpYMHqqveOQDukY3FI8/L+B8Od4+LNHVOrmVCNJsv+oV9HGmhhlHh1ldsairv
         Fy5jpMRJJNlyeSrpwGJCyUI79AYxtQEPeYAYd/bBDp4RTtpuiQU1/46TnkGpW59jGwKV
         TN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAsNHJ04qXj7NOFemNU/AVYo7sQyesbZ2/ZS+gTz3yY=;
        b=H7xvdenOCEyI5zP8AxCT9oNpbA4Ta4wTka9nE0fRVKR8HSbbwIgKgLi4RrGWFdLZC5
         wYPy8oV+B/fMQwwrPNE+J1H9ov9QCwa1SruW1pklYZpLzqqcUei1Nrq3GjIXZ3rcbGQG
         TbzrZn5pr7RzAtWZoOluy7s8NXABWC70oavzI61mTXjXzPzejgXrLUyWeCdzaU8uwXpw
         slyLe2e5mTQS8d8ImJ+b4bODijF6GQarTBJphTq5vsNMWOFk+WzkOQvWxTGcKWRrW0Yg
         UwGwdtiRSGBPe6KaklFCkaGr++dzksDw7nEjYo8fYdJWhAO4ca5Ykgde6TxmYl5dxgbq
         jj3w==
X-Gm-Message-State: AOAM532VjAGjwB+0FKyY6hsuuTm94uqZ+8oiVM67z6vOYa+ddAvd2f9z
        IILZSz+sJMjr9h9PTfNKDLOGU8+J73C1WNQjw/9Vmg==
X-Google-Smtp-Source: ABdhPJwMxYwOmRsYhEgHHAaq5bYOroyFT1dvvvSwJvL5M5H2WicUW0Grw8JRya7+wEu/oYgstGvX/9+D0eKgQk01NFg=
X-Received: by 2002:aa7:cc15:: with SMTP id q21mr67477267edt.213.1609688142047;
 Sun, 03 Jan 2021 07:35:42 -0800 (PST)
MIME-Version: 1.0
References: <1608888807-3117-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1608888807-3117-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1608888807-3117-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Sun, 3 Jan 2021 16:35:31 +0100
Message-ID: <CAMpxmJUYqprKrihc=0=MRbYh-nV+QS16jWxK95sxUPzt9Y6_tA@mail.gmail.com>
Subject: Re: [PATCH v8 08/12] gpio: bd9571mwv: Add BD9574MWF support
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     marek.vasut+renesas@gmail.com, Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        khiem.nguyen.xt@renesas.com, linux-power@fi.rohmeurope.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020 at 10:33 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>
> Add support for BD9574MWF which is similar chip with BD9571MWV.
> Note that BD9574MWF has additional features "RECOV_GPOUT",
> "FREQSEL" and "RTC_IN", but supports GPIO function only.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/gpio/gpio-bd9571mwv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-bd9571mwv.c b/drivers/gpio/gpio-bd9571mwv.c
> index 0e5395f..df6102b 100644
> --- a/drivers/gpio/gpio-bd9571mwv.c
> +++ b/drivers/gpio/gpio-bd9571mwv.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * ROHM BD9571MWV-M GPIO driver
> + * ROHM BD9571MWV-M and BD9574MWF-M GPIO driver
>   *
>   * Copyright (C) 2017 Marek Vasut <marek.vasut+renesas@gmail.com>
>   *
> @@ -10,6 +10,7 @@
>   */
>
>  #include <linux/gpio/driver.h>
> +#include <linux/mfd/rohm-generic.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>
> @@ -118,7 +119,8 @@ static int bd9571mwv_gpio_probe(struct platform_device *pdev)
>  }
>
>  static const struct platform_device_id bd9571mwv_gpio_id_table[] = {
> -       { "bd9571mwv-gpio", },
> +       { "bd9571mwv-gpio", ROHM_CHIP_TYPE_BD9571 },
> +       { "bd9574mwf-gpio", ROHM_CHIP_TYPE_BD9574 },
>         { /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, bd9571mwv_gpio_id_table);
> --
> 2.7.4
>

Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
