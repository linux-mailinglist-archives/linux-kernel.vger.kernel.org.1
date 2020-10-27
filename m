Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC8829C60F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825693AbgJ0SMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:12:37 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:43317 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1825662AbgJ0SMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:12:25 -0400
Received: by mail-il1-f196.google.com with SMTP id k1so2343987ilc.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGv1Y/0reu20DBr8S7i4JOZE8sfHN0Ia0VoWgcxjJq4=;
        b=JMe8vNVo3R2gGH6hqxz3WmFJwUEBTwiTGu9xMdWnrNLe6fle4LBhd0K6gTtvTEgwJi
         UT+WjdmnSDBiGYlBvo8Fqx+84H/9xfgl6SK66y9qVHZRbWhju7cbHYUSUQXedmbpyrTK
         lTX7UbBpUzrw6nJifz6eEbpfGkpUAZfQGLnRxUwualNard49/hO7P6SMgCVwjMT6w7Qq
         ffscM32esnRHZbhvvuuy8VWZigLp/h/EtXan4UXYPuBzamZsN7cl+Kpja0dO9kkesqph
         jkEbhP7HgweP/CXzPxUwyWNF7wK2uItsT4e7H2E+tyczvQkHg6hIy+0gunBliPDMJHCA
         d/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGv1Y/0reu20DBr8S7i4JOZE8sfHN0Ia0VoWgcxjJq4=;
        b=o4fe9ZD2d8NnYXFeqcZuzvvc4zYTHIR7QEZfjGFcj+OSvgh+8ImYaSChsrMh3yF5EZ
         u/KGUy6O9QXgb5Ydv9GZZbVVhZe7QrroxHJpgvc4/CY/7GsmQklwBp9ZMDa7CSuBLMeZ
         uR+k1DWLjnv5JWHu+T3kH/pv31bCLHkHu3+i8tIWjYOIInP95ErdqKWFhZZM5nY6g29t
         1NAB0NpM8picydyJ0typEX2Lp49LDJgvNkFkU2yvfd2gmjrTOixgKorE8h5jZbc4Wr0q
         8SHRql+Mu9wKnWOH9eChk9vP5bqSeGL2i8GdWhrlLLuQnkjRZpV37iJMYTiGJkYE8bY9
         Vi9w==
X-Gm-Message-State: AOAM531/Nehf4xq2Qdh/PjcU71fJ0o3U0lj5sAGtVg0VRbZWsjw0PK7J
        1NBwNYeVCsiyYxlUwXRMGGVL2cUsgnBOJMJjIV222g==
X-Google-Smtp-Source: ABdhPJyTnQSKpb7ULx8ypqe5smcRjLTr9OXB2hTEElGXWXi2nGDOvd47JBO3gG3Scd0S9SvSSanP4ZAwgFMa+fh1jF4=
X-Received: by 2002:a92:c5ce:: with SMTP id s14mr3130329ilt.40.1603822344388;
 Tue, 27 Oct 2020 11:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201027135325.22235-1-vincent.whitchurch@axis.com>
In-Reply-To: <20201027135325.22235-1-vincent.whitchurch@axis.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 27 Oct 2020 19:12:13 +0100
Message-ID: <CAMRc=Mdjm8tgxF_76T3f6r3TwghLKtrFtUv7ywtX3-nEQzVGtA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mockup: Allow probing from device tree
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel@axis.com, devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 2:54 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Allow the mockup driver to be probed via the device tree without any
> module parameters, allowing it to be used to configure and test higher
> level drivers like the leds-gpio driver and corresponding userspace
> before actual hardware is available.
>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> v2: Remove most of the added code, since the latest driver doesn't need it.
>     Drop DT binding document, since Rob Herring was OK with not documenting
>     this:
>     https://lore.kernel.org/linux-devicetree/5baa1ae6.1c69fb81.847f2.3ab1@mx.google.com/
>
>  drivers/gpio/gpio-mockup.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-mockup.c b/drivers/gpio/gpio-mockup.c
> index 67ed4f238d43..c93892a6936a 100644
> --- a/drivers/gpio/gpio-mockup.c
> +++ b/drivers/gpio/gpio-mockup.c
> @@ -13,6 +13,7 @@
>  #include <linux/gpio/driver.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/of.h>

Please keep the includes ordered alphabetically.

>  #include <linux/irq_sim.h>
>  #include <linux/irqdomain.h>
>  #include <linux/module.h>
> @@ -460,9 +461,18 @@ static int gpio_mockup_probe(struct platform_device *pdev)
>         return 0;
>  }
>
> +#ifdef CONFIG_OF
> +static const struct of_device_id gpio_mockup_of_match[] = {
> +       { .compatible = "gpio-mockup", },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, gpio_mockup_of_match);
> +#endif

You don't need this ifdef - of_match_ptr() will evaluate to NULL if
CONFIG_OF is disabled and the compiler will optimize this struct out.

Bartosz

> +
>  static struct platform_driver gpio_mockup_driver = {
>         .driver = {
>                 .name = "gpio-mockup",
> +               .of_match_table = of_match_ptr(gpio_mockup_of_match),
>         },
>         .probe = gpio_mockup_probe,
>  };
> @@ -556,8 +566,7 @@ static int __init gpio_mockup_init(void)
>  {
>         int i, num_chips, err;
>
> -       if ((gpio_mockup_num_ranges < 2) ||
> -           (gpio_mockup_num_ranges % 2) ||
> +       if ((gpio_mockup_num_ranges % 2) ||
>             (gpio_mockup_num_ranges > GPIO_MOCKUP_MAX_RANGES))
>                 return -EINVAL;
>
> --
> 2.28.0
>
