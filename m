Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82FCA286023
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgJGNaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728323AbgJGNaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:30:21 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75624C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 06:30:17 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z8so2265862lfd.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2l/9fzb03eCTZoGiByyf5gZsfF5uaw+eTCPdRAtu8g=;
        b=rMRYSy7vcf6XtGqbukLSA52hgTFeiwzpZJ6SFJLCm6vFiw4eozjl6mZrCAWZDI8L8W
         35O+K010AfwkUo7H6VIn18gON0I6c8XyE21fGlxOl+HuSs5bBoV76b7cW1ogvq989L4B
         UsrOa9j9VHYWAeYzV6FLZYCj+nJnP+sKHagyhaJ89qb4d0U/DUPzCwLXNxGOme15HkZS
         b/jYA7hvX0QGQixt6CY9j6DJABL3VqVhaoUPhz3SD0EPd8uhaoBHfmFBGaSyGZY6l1YQ
         fK4RcLlj5bsNIt5QFWU/ZO2ACTS0zYKSOm/QJ8UjG2ym6zxZElq5P0qEih+9aIjG2vxF
         Yamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2l/9fzb03eCTZoGiByyf5gZsfF5uaw+eTCPdRAtu8g=;
        b=TDTsItdsp9J2nfTSpgIGJlNGHsPsXGjs1ePBMOOYMpU0fvoKwqjFGuMef5c1bwW/BG
         f2D9f1ixUUY/hlOkd4CTbbxdIw/3QRqTl9fUF+P9sQx/UrieHZ26AupooPqUwCrN3XDa
         GNDQD5lPGJXx/6rHqcDQdZCXVJMqopnl0bpgDf1CBWsEjPjpctuxm0zsEiE+DEQ644OC
         3LnZGavbMBD+YlbxoobSQH5deljulpibmFDC12fI+J9PQwtd8KNz33yeJ9tlRFtTzmKA
         wssneoXc7zmZaDnx4Yk4CerJzk7iknn3rVRarBDxHruY5C9PSugeA4QYczjR4XKnQIdZ
         A7bA==
X-Gm-Message-State: AOAM530PA7axgWdFT+rPCyQPbn2UgDAi2eSwEptqjspJdm8vFu4zQ8lM
        yWUjZJF5AEnXKmXOs0hHKbcS1gFLv4B18ONC+t/vUw==
X-Google-Smtp-Source: ABdhPJzM6EKSUbzWZ4QoyxcoR83GT/oWoNZ86uDYC1Qwc9NmgDn95/8Lwxq9JFC4JlMW2XebEtYnqy1OpjDtjraDimk=
X-Received: by 2002:a19:e55:: with SMTP id 82mr893745lfo.571.1602077415649;
 Wed, 07 Oct 2020 06:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201006142532.2247515-1-lars.povlsen@microchip.com> <20201006142532.2247515-3-lars.povlsen@microchip.com>
In-Reply-To: <20201006142532.2247515-3-lars.povlsen@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Oct 2020 15:30:03 +0200
Message-ID: <CACRpkda+OSgma3E0XxXUk8a2yrn5Hpu3a47cBN50rOkoSMkiwQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 2/3] pinctrl: pinctrl-mchp-sgpio: Add pinctrl
 driver for Microsemi Serial GPIO
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars!

Thanks for the update, this looks much improved!

Some further hints at things I saw here:

On Tue, Oct 6, 2020 at 4:25 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:

> This adds a pinctrl driver for the Microsemi/Microchip Serial GPIO
> (SGPIO) device used in various SoC's.
>
> Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>

> +       /* 2 banks: IN/OUT */
> +       struct {
> +               struct gpio_chip gpio;
> +               struct pinctrl_desc pctl_desc;
> +               struct pinctrl_dev *pctl_dev;
> +       } bank[2];

Is it really good to use index [0,1] to refer to these?
Isnt it easier to do something like:

struct sgpio_bank {
         struct gpio_chip gpio;
         struct pinctrl_desc pctl_desc;
         struct pinctrl_dev *pctl_dev;
};

struct sgpio_priv {
        (...)
        struct sgpio_bank in;
        struct sgpio_bank out;
        (...)
};

This way you I think the code becomes clearer.

> +static inline bool sgpio_pctl_is_input(struct sgpio_priv *priv,
> +                                      struct pinctrl_dev *pctl)
> +{
> +       /* 1st index is input */
> +       return pctl == priv->bank[0].pctl_dev;
> +}
> +
> +static inline bool sgpio_gpio_is_input(struct sgpio_priv *priv,
> +                                      struct gpio_chip *gc)
> +{
> +       /* 1st index is input */
> +       return gc == &priv->bank[0].gpio;
> +}

Isn't it easier to just add a

bool is_input;

to the struct gpio_bank?

> +static inline u32 sgpio_readl(struct sgpio_priv *priv, u32 rno, u32 off)
> +{
> +       u32 __iomem *reg = &priv->regs[priv->properties->regoff[rno] + off];
> +
> +       return readl(reg);
> +}
> +
> +static inline void sgpio_writel(struct sgpio_priv *priv,
> +                               u32 val, u32 rno, u32 off)
> +{
> +       u32 __iomem *reg = &priv->regs[priv->properties->regoff[rno] + off];
> +
> +       writel(val, reg);
> +}
> +
> +static inline void sgpio_clrsetbits(struct sgpio_priv *priv,
> +                                   u32 rno, u32 off, u32 clear, u32 set)
> +{
> +       u32 __iomem *reg = &priv->regs[priv->properties->regoff[rno] + off];
> +       u32 val = readl(reg);
> +
> +       val &= ~clear;
> +       val |= set;
> +
> +       writel(val, reg);
> +}

These accessors are somewhat re-implementing regmap-mmio, especially
the clrsetbits. I would consider just creating a regmap for each
struct sgpio_bank and manipulate the register through that.
(Not any requirement just a suggestion.)

> +static void sgpio_output_set(struct sgpio_priv *priv,
> +                            struct sgpio_port_addr *addr,
> +                            int value)
> +{
> +       u32 mask = 3 << (3 * addr->bit);
> +       value = (value & 3) << (3 * addr->bit);

I would spell it out a bit so it becomes clear what is going in
and use the bits helpers.

value & 3 doesn't make much sense since value here is always
0 or 1. Thus if value is 1 it in effect becomes value = 1 << (3 * addr->bit)
so with the above helper bit:

unsigned int bit = 3 * addr->bit;
u32 mask = GENMASK(bit+1, bit);
u32 val = BIT(bit);

This way it becomes clear that you set the output usin the lower
of the two bits.

Also note that I use val rather than value to avoid overwriting
the parameter: it is legal but confusing. Let the compiler optimize
register use.

> +static int sgpio_output_get(struct sgpio_priv *priv,
> +                           struct sgpio_port_addr *addr)
> +{
> +       u32 portval = sgpio_readl(priv, REG_PORT_CONFIG, addr->port);
> +       int ret;
> +
> +       ret = SGPIO_X_PORT_CFG_BIT_SOURCE(priv, portval);
> +       ret = !!(ret & (3 << (3 * addr->bit)));

Is the output direction really controlled by both bits?

ret = !!(ret & (BIT(3 * addr->bit))); ?

> +static int microchip_sgpio_get_direction(struct gpio_chip *gc, unsigned int gpio)
> +{
> +       struct sgpio_priv *priv = gpiochip_get_data(gc);
> +
> +       return sgpio_gpio_is_input(priv, gc); /* 0=out, 1=in */

You can use the #defines from <linux/gpio/driver.h> if you want to be explicit:

return sgpio_gpio_is_input(priv, gc) ? GPIO_LINE_DIRECTION_IN :
GPIO_LINE_DIRECTION_OUT;

> +static int microchip_sgpio_of_xlate(struct gpio_chip *gc,
> +                              const struct of_phandle_args *gpiospec,
> +                              u32 *flags)
> +{
> +       struct sgpio_priv *priv = gpiochip_get_data(gc);
> +       int pin;
> +
> +       if (gpiospec->args[0] > SGPIO_BITS_PER_WORD ||
> +           gpiospec->args[1] > priv->bitcount)
> +               return -EINVAL;
> +
> +       pin = gpiospec->args[1] + (gpiospec->args[0] * priv->bitcount);
> +
> +       if (pin > gc->ngpio)
> +               return -EINVAL;
> +
> +       if (flags)
> +               *flags = gpiospec->args[2];
> +
> +       return pin;
> +}

I'm still not convinced that you need the flags in args[2].

Just using the default of_gpio_simple_xlate() with one flag
should be fine. But I will go and review the bindings to figure
this out.

> +       gc->of_xlate            = microchip_sgpio_of_xlate;
> +       gc->of_gpio_n_cells     = 3;

So I'm sceptical to this.

Why can't you just use the pin index in cell 0 directly
and avoid cell 1?

Yours,
Linus Walleij
