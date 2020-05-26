Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927B01ABCC8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 11:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbgDPJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 05:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392188AbgDPJ2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:28:04 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24B5C061A10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:28:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q19so7008734ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WsPjodFLa29jgz8fN9Fb4AffGRX4R/S0PAGXHFxg8uc=;
        b=Mcjo0LRYVYxyzbtjbCWQVN/NoJRsDH8jFlsbuCOBONMT1lR2ImkQ/9Gyi6g9ECLGD9
         W6+NvffZF/UBCbB65JSgSA15hb1DBUMVmSago9O5LFo/FlxiOs0HJ9MMXrD/bobgK0Wt
         mMVuq5ylGm8TZD27kCZcpU+ZZGgxXnxAhUmazdaIRigybhADJAXlhqCpHAnwaqebmn77
         48UsyHV+4cY856JG138S9HEb9o2gew/a6x80Z8PggjjeFafkcMesJftx8HReUBysV/gx
         GRB7jVLJBDkBbXax2F7N8etArkTLVsDT3ukSGd2g9bhBAQlzlqv6iTs7iWBiPoiBSWfj
         bFzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WsPjodFLa29jgz8fN9Fb4AffGRX4R/S0PAGXHFxg8uc=;
        b=Usv8clvAp15GP0ZUis2VPMwto1t/bnQHG6jan+eznTM54Nj5ixgVV0fCHykp+YQSIM
         d9ZV+XaRGh8L8JNeHzHN+KoCfPkdFUye/AfH595PP+q7ji0V2V6HkQ6oLvE4Wc13DYRO
         hEzMTgAIqd3NxXj/5d4mapkA1Pg9rBKw7pMN85jdNX1+EZPPshMrOY1bU8N9MIcaQIq/
         P5NwaRehRBJeqThnaJwOZcNnbsKezrTMhnLs/rIPstmneU6USQZa2xbUIlbW7u0FgmH/
         gEhCtDqRtEgLKQuKYD7DOQNo77FVe04ndV4rBXU4JRSoFjLew3GmQ5zJVB3UhFB1m6Rt
         w00Q==
X-Gm-Message-State: AGi0PuaeP57+xEZTeZvTvPFMk2QxAzFQlytqq3Hn9U1mZrolE0kvIHz1
        q0hnCu0YVeiRzkOTzPTGZfq79s68YNJ9dD8HaY0w2w==
X-Google-Smtp-Source: APiQypJMQjT4pZ+GIg1c79TG3Woa9BTCPwC3Eg2zQlaa/+IMFOuGyPsLA6Z0cx46mmNNDk/3KbeDkx0QsaVz8N768ms=
X-Received: by 2002:a2e:9ad9:: with SMTP id p25mr6015137ljj.39.1587029281103;
 Thu, 16 Apr 2020 02:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200402203656.27047-1-michael@walle.cc> <20200402203656.27047-11-michael@walle.cc>
In-Reply-To: <20200402203656.27047-11-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 16 Apr 2020 11:27:49 +0200
Message-ID: <CACRpkdaqgHhPwdKdUai4zvi21qR-cSQUKyzZ3SyfWBLPN9us3w@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using regmap
To:     Michael Walle <michael@walle.cc>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 10:37 PM Michael Walle <michael@walle.cc> wrote:

> There are quite a lot simple GPIO controller which are using regmap to
> access the hardware. This driver tries to be a base to unify existing
> code into one place. This won't cover everything but it should be a good
> starting point.
>
> It does not implement its own irq_chip because there is already a
> generic one for regmap based devices. Instead, the irq_chip will be
> instanciated in the parent driver and its irq domain will be associate
> to this driver.
>
> For now it consists of the usual registers, like set (and an optional
> clear) data register, an input register and direction registers.
> Out-of-the-box, it supports consecutive register mappings and mappings
> where the registers have gaps between them with a linear mapping between
> GPIO offset and bit position. For weirder mappings the user can register
> its own .xlate().
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Overall I really like this driver and I think we should merge is as soon
as it is in reasonable shape and then improve on top so we can start
migrating drivers to it.

> +static int gpio_regmap_to_irq(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
> +       struct gpio_regmap *gpio = data->gpio;
> +
> +       /* the user might have its own .to_irq callback */
> +       if (gpio->to_irq)
> +               return gpio->to_irq(gpio, offset);
> +
> +       return irq_create_mapping(gpio->irq_domain, offset);

I think that should at least be irq_find_mapping(), the mapping should
definately not be created by the .to_irq() callback since that is just
a convenience function.

> +       if (gpio->irq_domain)
> +               chip->to_irq = gpio_regmap_to_irq;

I don't know about this.
(...)
> + * @irq_domain:                (Optional) IRQ domain if the controller is
> + *                     interrupt-capable
(...)
> +       struct irq_domain *irq_domain;

I don't think this is a good storage place for the irqdomain, we already have
gpio_irq_chip inside gpio_chip and that has an irqdomain, we should
strive to reuse that infrastructure also for regmap GPIO I think, for now
I would just leave .to_irq() out of this and let the driver deal with any
irqs.

Yours,
Linus Walleij
