Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D302ECCB4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbhAGJ1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbhAGJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:27:41 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D1C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:27:00 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s26so13005780lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoDMsvYXa70UWArHKTJNuJgJhGoQWTo5CHFUczlmKcc=;
        b=lugrBsDg+zK3blzjMfrsMEbtXwt3JkqdDWN1W93Qie2wGqNrSf0Jymbc8oigQAlXkb
         vo4HB+eORRfGFd1PZ/XYoQY7q1tMnSDtg+CYt1Te1YZEbHOCrWfzfrNawZ11iugdIkXO
         fXSFStUzKSM6AHgWPszVZvYtCciSRF/+BPVKW9PrP8kc8gjHHGIRKs9HZcwmfwALpTTP
         Lxqgq7MeqgsQYi1SaU0f0OgaHXQMxA1obpbZrfQqno0j9MW9gldS/KBUZvlLi5JtNQud
         i3iYU5wlZCxu5Zvr/dUp+XJvqykl1NbFKOxcVvOtAKRungd8169ExeBkbKeKJCtXsmqj
         YTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoDMsvYXa70UWArHKTJNuJgJhGoQWTo5CHFUczlmKcc=;
        b=Kr4VA3lx3wd37BWzAHO6Os/SVVGGeQiUdEgKwis5wUlpGGFEd4wRKbQypwyXLI4n7H
         gPOaTRttBSyIJtCIfeaZ4jKYBPCMTwjGvrgtHLcRuwUJ6QkuBI+Ae0YPY53TS6IlD2Zl
         ahFT9SxAK5UaChR1IlZoLMp/H33sBgOzlgoR9j+XwcbZEZHLs+g6jf08ToREwd5ps2dl
         vC+aj1MKEn8QmU4I6BGE82H2s2CBzx6mzsV00D864OljTQA1sewjvgrKGWklGH1COA5b
         7hNf042rSmtgBZybJDb1sdYsVZ5AZQ+ftB9XuVUNJidrZ6gK4EKNhRvbMxJt0Mu8jnzj
         Qnmw==
X-Gm-Message-State: AOAM533pLuPolCpB4YCsiNw8ev66l0w48EZ5arjH1GxYdFj4Mug4Rwkd
        b9GBfkb1b6A/xJhT6lfHZd98ipAnmgmzbRT7waAdbf1iOnZxWQ==
X-Google-Smtp-Source: ABdhPJwIncDn6ClxhRQFYw0pHeV3FeDwi+3Bf3GCwrnNNce5PHybbF7rVhUEmlynOt6u2VmwrAjDvCyVuUaS65BWl8E=
X-Received: by 2002:a2e:586:: with SMTP id 128mr4104916ljf.273.1610011618990;
 Thu, 07 Jan 2021 01:26:58 -0800 (PST)
MIME-Version: 1.0
References: <1609936000-28378-1-git-send-email-srinivas.neeli@xilinx.com> <1609936000-28378-4-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1609936000-28378-4-git-send-email-srinivas.neeli@xilinx.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 7 Jan 2021 10:26:48 +0100
Message-ID: <CACRpkdYRJH8hO2W8D6waaUEHib7nPj_7ogLr-BzTYdXX_1-7ag@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] gpio: gpio-xilinx: Add interrupt support
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        sgoud@xilinx.com, Robert Hancock <hancock@sedsystems.ca>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 1:27 PM Srinivas Neeli <srinivas.neeli@xilinx.com> wrote:

> Adds interrupt support to the Xilinx GPIO driver so that rising and
> falling edge line events can be supported. Since interrupt support is
> an optional feature in the Xilinx IP, the driver continues to support
> devices which have no interrupt provided.
> Depends on OF_GPIO framework for of_xlate function to translate
> gpiospec to the GPIO number and flags.
>
> Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
(...)

>  config GPIO_XILINX
>         tristate "Xilinx GPIO support"
> +       select GPIOLIB_IRQCHIP
> +       select IRQ_DOMAIN_HIERARCHY

Why do you select IRQ_DOMAIN_HIERARCHY?

You don't seem to use it.

> +#include <linux/of_gpio.h>

No modern driver should include this header. I suspect you
can just drop it.

See drivers/gpio/TODO

> +       /* Update cells with gpio-cells value */
> +       if (of_property_read_u32(np, "#gpio-cells", &cells))
> +               dev_dbg(&pdev->dev, "Missing gpio-cells property\n");
> +
>         /*
>          * Check device node and parent device node for device width
>          * and assume default width of 32
> @@ -343,6 +545,7 @@ static int xgpio_probe(struct platform_device *pdev)
>         chip->gc.parent = &pdev->dev;
>         chip->gc.direction_input = xgpio_dir_in;
>         chip->gc.direction_output = xgpio_dir_out;
> +       chip->gc.of_gpio_n_cells = cells;

This looks a bit dangerous. What actually happens if this is something
like 3. The translate function is not going to work. I would just dev_err()
and bail out if #gpio-cells != 2.

Other than that this looks good!

Yours,
Linus Walleij
