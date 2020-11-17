Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DE32B7090
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgKQU7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgKQU7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:59:19 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F763C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:59:18 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id h23so25883077ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lhOVKceVBv7kVKCgOWNBzO70XQrC0EF5U4LspVOWhdQ=;
        b=jFWNWp2TgwOeIaJn/jRrE7BtuYTGCLhCbYE1gTAv9xgjHbnUiLNIEgwBwRvKlTP/bW
         EYstaUc5JEc0i4QC2VMllWpVxHobX2i95V0FGI/LQF35NIJjY9Pn96rE2RzgO588ungl
         EXiEGgjrT3HGHa4BzkBHA5XlatVXLUwTAANULsOvBtkNeGKIFfqsqwrxasdbzxiFLpoZ
         jOhE37cjXz3dN7vSaw2HY19SCUhSz0AkicBVW49Ovamx3xoTaRKO7MgaJkI+oTEcIeoY
         k9GBD+p52hRY5liL5DAx6xBuZH1JDEFrh6/uuxfbnU+tma0kHkEcZX2ImRsdqCo9WCZN
         t7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lhOVKceVBv7kVKCgOWNBzO70XQrC0EF5U4LspVOWhdQ=;
        b=Eh/5HoVC0D6iAyiuP6kFAxNjgMtICmPVYjWJHBZk3PyTXa+nnp0LeYie8NNVizVPZ+
         hYwVcOz+LNMMM/onEORitfk9ionLrBRufwoYfnaoH61jkIq1Opc64F3RI7Hr+CiDrmqO
         cnZucaGKi+x7AVFweZPYRmalo7TyIZB23GWJX1F7gGHtxREvALxoqyq7Ima/h6R8gFZ/
         jCYA6rBfShLnBkD/roOMxfLQJccgkd0Hyl8k6vXgArKqqkEnrMXKFuOItxU5HxaL5Eg7
         dGmZCjHUVo99xhcHlA1trpQ2+SxRo3qap7+WIxZuw7teBgEpVZQ9naeDWzKn36IoixZU
         W0iQ==
X-Gm-Message-State: AOAM533OiB+Jrcam3ocMXeafPe8Mb+K1AJcVWnQT6wf7EYgREuXtTssH
        VrqNP/1nr1XHGp9dW2p09ThK7NwCvCPgaZoy9fjRog==
X-Google-Smtp-Source: ABdhPJxjUwnRMlyZ1I6GdoT/R74osOxNheL4gleSpdaSISqhkb43ujnEF7gLzIuthlDegCWIFpbwtFMORGY7wdDa0eU=
X-Received: by 2002:a2e:321a:: with SMTP id y26mr2883348ljy.293.1605646757115;
 Tue, 17 Nov 2020 12:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20201112084057.1399983-1-nobuhiro1.iwamatsu@toshiba.co.jp> <20201112084057.1399983-3-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20201112084057.1399983-3-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 17 Nov 2020 21:59:06 +0100
Message-ID: <CACRpkdbtkLjzMqRKzd3ppmwZ9hZESL4+zGOf7-uqjuF==Wm=3A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: visoconti: Add Toshiba Visconti GPIO support
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        yuji2.ishikawa@toshiba.co.jp,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nobuhiro,

On Thu, Nov 12, 2020 at 12:42 AM Nobuhiro Iwamatsu
<nobuhiro1.iwamatsu@toshiba.co.jp> wrote:

> Add the GPIO driver for Toshiba Visconti ARM SoCs.
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

I just noticed this:

> +config GPIO_VISCONTI
> +       tristate "Toshiba Visconti GPIO support"
> +       depends on ARCH_VISCONTI || COMPILE_TEST
> +       depends on OF_GPIO
> +       select GPIOLIB_IRQCHIP
> +       help
> +         Say yes here to support GPIO on Tohisba Visconti.

Add:
select GPIO_GENERIC

Then all of these:

> +static int visconti_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +static void visconti_gpio_set(struct gpio_chip *chip, unsigned int offset, int value)
> +static int visconti_gpio_get_dir(struct gpio_chip *chip, unsigned int offset)
> +static int visconti_gpio_dir_in(struct gpio_chip *chip, unsigned int offset)
> +static int visconti_gpio_dir_out(struct gpio_chip *chip, unsigned int offset, int value)

Can be implemented by the genric MMIO GPIO library.

> +       gpio_chip = &priv->gpio_chip;
> +       gpio_chip->label = name;
> +       gpio_chip->owner = THIS_MODULE;
> +       gpio_chip->parent = dev;
> +       gpio_chip->request = gpiochip_generic_request;
> +       gpio_chip->free = gpiochip_generic_free;
> +       gpio_chip->get = visconti_gpio_get;
> +       gpio_chip->set = visconti_gpio_set;
> +       gpio_chip->get_direction = visconti_gpio_get_dir;
> +       gpio_chip->direction_input = visconti_gpio_dir_in;
> +       gpio_chip->direction_output = visconti_gpio_dir_out;
> +       gpio_chip->base = 0;
> +       gpio_chip->ngpio = VISCONTI_GPIO_NR;
> +       gpio_chip->irq.init_valid_mask = visconti_init_irq_valid_mask;

Initialized the generic helpers using the addresses of the
GPIO registers here by a call to bgpio_init().

Check this driver for an example:
drivers/gpio/gpio-ftgpio010.c

If you get uncertain about the arguments to bgpio_init()
check drivers/gpio/gpio-mmio.c, there is kerneldoc for the
function.

By doing this you get implementations of gpio_[get|set]_multiple()
for free.

Yours,
Linus Walleij
