Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191C02CA727
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391739AbgLAPe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390298AbgLAPe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:34:26 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941D8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:33:40 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id f23so4938541ejt.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HfEmRbTUVu5buzmFymRjrzPmVpKwAUdxNZbmsbAARHI=;
        b=zpM6mciORqM6FM9fWyXykgzZO3tN82WyO0CznE01WirlCqvzyB+NGE5sturlw191Qx
         Xq63A6beE6QUlpwGR8Y2YKDluTLb33Ve5fE1Uc28FMlxUg54ywnsX8QPhpf1MHECTtqZ
         ScroKkCi3TaDc25Jq20JrHOD/xCk6mneZMpeNk/pcThyqwNMh5X5EjN17rbvEZvvOhqO
         Q+GW6ry+hLHmpavB/uFRWpWIRCSqR5An+CX7Ea1DvPduQXTsImNn/KJfEoH3ZU37N+pP
         HN9G5K2EnscgljSpnGyrGFRRWTNDf5RxzEi+fuWqxcZrq2vWBCAipkpsHGklZeiyXvcF
         Qwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HfEmRbTUVu5buzmFymRjrzPmVpKwAUdxNZbmsbAARHI=;
        b=TuVW4vj8X/XWvOY2CPFz8wqs3hWLvzBLMXfvfyUqlomC3rtmMc5ICD/4P13wsfnr/t
         RWruXWiDO8yGA2+w8/yEnTL+0OJTYLV+8qhfwgfoPDXzAezOaoOCdM0gfBXEe2GJZoiL
         skhsrn1I7KatPMwm8elSIkHS+q2qhFszOMlFqiE2/xy3YoK+UuHMei5KQGs7QGj+cDP2
         qXAZM5FquQqrFHC2sXvmTtH425Ntn1a60jcu4CA0cu5LL+CUk6XCRuk/ifv35iK6rezK
         pijFUx2gkRzQw6ic2uwi8erWOFuKtku3K4kAlmWtzVQLNdBZtwzezw7iAMIjclQRXZwF
         Pu6g==
X-Gm-Message-State: AOAM533Fyv52o5nlsrvWg9Js6OLCWiRT2VVTtNQtBkTULvnOaC5Kj1h0
        q77HgzTWnTOLVVBX9wwRntS+XisNSYiOtmLgAxWDRQ==
X-Google-Smtp-Source: ABdhPJwaleYJQJJT3SsISIG12SOKNywBoidZAcD+gTb6G8zgyBFg95d1+qKFI19arkSUdTOEX+v3bvq6AXYs2hdUcY4=
X-Received: by 2002:a17:907:b09:: with SMTP id h9mr3591194ejl.155.1606836819337;
 Tue, 01 Dec 2020 07:33:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605893641.git.syednwaris@gmail.com> <c509c26eb9903414bd730bdd344b7864aedaa6f1.1605893642.git.syednwaris@gmail.com>
In-Reply-To: <c509c26eb9903414bd730bdd344b7864aedaa6f1.1605893642.git.syednwaris@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 1 Dec 2020 16:33:28 +0100
Message-ID: <CAMpxmJVNPWCUFnBXzDW3uJ_1Sv4rQ=M0WbKmoW4juYLUQP-ABA@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/4] gpio: xilinx: Modify bitmap_set_value() calls
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-arch@vger.kernel.org,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 7:46 PM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> Modify the bitmap_set_value() calls. bitmap_set_value()
> now takes an extra bitmap width as second argument and the width of
> value is now present as the fourth argument.
>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
> ---
>  drivers/gpio/gpio-xilinx.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index ad4ee4145db4..05dae086c4d0 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -151,16 +151,16 @@ static void xgpio_set_multiple(struct gpio_chip *gc, unsigned long *mask,
>         spin_lock_irqsave(&chip->gpio_lock[0], flags);
>         spin_lock(&chip->gpio_lock[1]);
>
> -       bitmap_set_value(old, state[0], 0, width[0]);
> -       bitmap_set_value(old, state[1], width[0], width[1]);
> +       bitmap_set_value(old, 64, state[0], width[0], 0);
> +       bitmap_set_value(old, 64, state[1], width[1], width[0]);
>         bitmap_replace(new, old, bits, mask, gc->ngpio);
>
> -       bitmap_set_value(old, state[0], 0, 32);
> -       bitmap_set_value(old, state[1], 32, 32);
> +       bitmap_set_value(old, 64, state[0], 32, 0);
> +       bitmap_set_value(old, 64, state[1], 32, 32);
>         state[0] = bitmap_get_value(new, 0, width[0]);
>         state[1] = bitmap_get_value(new, width[0], width[1]);
> -       bitmap_set_value(new, state[0], 0, 32);
> -       bitmap_set_value(new, state[1], 32, 32);
> +       bitmap_set_value(new, 64, state[0], 32, 0);
> +       bitmap_set_value(new, 64, state[1], 32, 32);
>         bitmap_xor(changed, old, new, 64);
>
>         if (((u32 *)changed)[0])
> --
> 2.29.0
>

This series is not bisectable because you modify the interface -
breaking existing users - and you only fix them later. Please squash
those changes into a single commit.

Bartosz
