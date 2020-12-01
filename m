Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C262CA5F7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391642AbgLAOm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389266AbgLAOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:42:57 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165C0C0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 06:42:12 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lt17so4618833ejb.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 06:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKPA9Trb1gdcfbmvahL7WdqHhHJJ0n41ize6GvJPbig=;
        b=qlZSJBo/itDAhzQGoWneBhtkT9dtN4uwqEZvwkh8dbUVSXKK15jlFu5X/UocAE3GL8
         DdVOAKL5I5Dw7lIPGYXR3qPQMvrFUucaoYh0qWkbwjVpB+P6xW6xx5dnCNcokIxbxrrc
         UUlZAOZbOx8aIfHXLdCQ5ho9nXoM+bYE1Ci0gg1pzijDtCUTFEW2+7VNc6drazpTTeWI
         hQJdJEvKme+4icpjEnM57TsGqaJ3GUryyl5Jau/j8FN4kkXcv4fUaoLKghSQDdpU8av7
         ExD4lut8sQN6/O+rbrLn3S263RQrLqkW5y+8ziYKH6PgcpIQOEkE8Mw0N3YpQtmwbQjZ
         5CQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKPA9Trb1gdcfbmvahL7WdqHhHJJ0n41ize6GvJPbig=;
        b=qmwn4vLA3rdSIEfKFgMBe68nlssZ5p0x4lX1s06yQZGUX8pcb1g3gTj4K/ZRdifSaG
         U2RXzMZUoclUPa8doctK3OBhrA1Zvd7NP2OuiZtfP0LNsG87dyUAUTR3OtjP/E+nz6QO
         hdCpjkaxXt5rrgzS9GA4cABeT2K3rNwvENrB/5J/tOgdU6SHXo9lCA8u9JBt5TW0X1FB
         VZ9cqF10Pn9Vjg7y2STa6k3bCbzrPWrU2i50rNw2tULQ7C65r4+cgkGXuDZ4iC0ifa6i
         ek/Ucaf+b80PHIStuX6AMTGY43qw0A7+R9ZCiFQe87ZAQh2KqC42Su70f73fP4FcroCl
         cZ/w==
X-Gm-Message-State: AOAM532MT3st28XoAvDS1+vSBWA0hkylOryCZXotlZSEEQJq2b/nJQGv
        tNqQ164XEFEXZson8Ls/yqB6WSvHlsp+Jm4ajBbBPw==
X-Google-Smtp-Source: ABdhPJwJLYBGBSKQBfecB3lzNduBcx4IK6dvErjyKFHcmyGhzPtaqJWgu7Doi2dT5LcXVnwLNOIwV9BH0AGTWUXtwNo=
X-Received: by 2002:a17:906:7f01:: with SMTP id d1mr3255758ejr.429.1606833730786;
 Tue, 01 Dec 2020 06:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20201130224753.1569357-1-willmcvicker@google.com> <20201130224753.1569357-2-willmcvicker@google.com>
In-Reply-To: <20201130224753.1569357-2-willmcvicker@google.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 1 Dec 2020 15:41:59 +0100
Message-ID: <CAMpxmJUb43gNHY_pFZyNjVVhumXTQCGkH2m6uM=Aezv3L29ULQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Don't free if pin ranges are not defined
To:     Will McVicker <willmcvicker@google.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Edmond Chung <edmondchung@google.com>,
        Andrew Chant <achant@google.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:48 PM Will McVicker <willmcvicker@google.com> wrote:
>
> From: Edmond Chung <edmondchung@google.com>
>
> A similar check was added in gpiochip_generic_request, but not in free.
> This has caused an imbalance count of request vs. free calls to the
> pinctrl driver. This patch is targeted to fix that issue.
>
> Fixes: 2ab73c6d8323 ("gpio: Support GPIO controllers without pin-ranges")
> Signed-off-by: Edmond Chung <edmondchung@google.com>
> Signed-off-by: Andrew Chant <achant@google.com>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  drivers/gpio/gpiolib.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 089ddcaa9bc6..6e3c4d7a7d14 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1806,6 +1806,11 @@ EXPORT_SYMBOL_GPL(gpiochip_generic_request);
>   */
>  void gpiochip_generic_free(struct gpio_chip *gc, unsigned offset)
>  {
> +#ifdef CONFIG_PINCTRL
> +       if (list_empty(&gc->gpiodev->pin_ranges))
> +               return;
> +#endif
> +
>         pinctrl_gpio_free(gc->gpiodev->base + offset);
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_generic_free);
> --
> 2.29.2.454.gaff20da3a2-goog
>

Applied, thanks!

Bartosz
