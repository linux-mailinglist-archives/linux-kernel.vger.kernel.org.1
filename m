Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29D2CA77C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 16:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbgLAPw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 10:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389694AbgLAPw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 10:52:56 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B67C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 07:52:16 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id m62so1158222vsd.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 07:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qGZKCpVsPrH/JdijtA/n9FbjwtcLzxA3njRFW/aowtY=;
        b=FqXs+b5FvIIhLZMzf6bh3BGna1pATXQNrxqUS933uFRYhoC+q72Rco6ISUPktQGPUV
         Bv7yc61sLj+osmiirhcK1QyXpUD2bLD/QTTFotonCvByHl/B3uSQm9te9K7cB73HZcle
         Wfb1VCIAckCoJuahOSXx/8qLDWVaYB6HXqicWio8UJcpTdiv6Np0P2ZKXDzYuv5J0O8/
         ZhismHkSgtlALWf0lrl19p3EuHaGhbbn3vTrLkUm1WQ2BMl2QQ893mwgNyCivl7BLBqc
         FRIlwwWpUvZrFmqCnssI8VJTlFMYCObJ1eaM//hErgR1MAY61ZorH7KUWOVUK0Ex9pSs
         Jb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGZKCpVsPrH/JdijtA/n9FbjwtcLzxA3njRFW/aowtY=;
        b=tU7PNZgqBw3kCAMeB19hEw2GwpVPxxmXDeRxlzi033KJrs2gBrizroAIcP92cUj0Ft
         3v5l3XNUjNUmI9RKeo0Dv2PgyxwSJYDtmaHL+NMLXo2KBIQzulC+F8PmupMcPCg8aFLs
         9eSeoZv1XUChWI1bYOQONoS/JR75627ULX6BkPcSRxbCh5X9aXZ07BEqnJ2Aki6tXMCq
         0g28WwdXL/qWwhRibFebAxeBM1FA+frQgxKgz7K1fWqCVO/MapjM/kt0Awllv+R/2UoN
         Md7WUEJwtor1/OJ6HVJTq09wrukVacezptgbG9DLEen+p/R4dDUkx+FVS8vPJeMWlZQc
         X8mQ==
X-Gm-Message-State: AOAM531I1F8SUEgDQEHQGYKVj7/GGXgYDeLQn20E7WqY2vOalfj3aXwn
        r2Z60EZwqjR+EtxxB9JZAXSZ9N86L0APL5vzGtJbnUeLCfE=
X-Google-Smtp-Source: ABdhPJxXitd9iTmXfqC3+NkBXaYkcGpz9D+ddC08QXtA7S5rOuuQJxM9SeoIBw+aUWg1/42R4e4HOoNkW60jEPWfrBI=
X-Received: by 2002:a67:e43:: with SMTP id 64mr3168615vso.40.1606837935157;
 Tue, 01 Dec 2020 07:52:15 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com>
In-Reply-To: <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 1 Dec 2020 10:52:03 -0500
Message-ID: <CAGngYiVd6d2pb3eOd5ZiCvTBOzZK6+dudRUVWj8neBRK0S42Pg@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolaus,

On Tue, Dec 1, 2020 at 9:38 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Let's work on a fix for the fix now.

I tested spi-gpio on my system, by converting a built-in or hardware spi,
to a spi-gpio. Interestingly, the patch has the opposite effect on my system:
before the patch, spi-gpio did not work, but after it's applied, it does work.

Can you tell me the idle status of your chip-select gpio in debugfs?
# mount -t debugfs none /sys/kernel/debug
# cat /sys/kernel/debug/gpio
Look for something like this:
gpiochip0: GPIOs 0-31, parent: platform/209c000.gpio, 209c000.gpio:
 gpio-17  (                    |spi5 CS0            ) out hi ACTIVE LOW

Also, apply the following patch, and tell me
a) does this dev_err() get called on your system, and
b) what is the value when your chip is de-selected

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 7e8804b02be9..b2f4cf5c9ffb 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -813,11 +813,12 @@ static void spi_set_cs(struct spi_device *spi,
bool enable)

        if (spi->cs_gpiod || gpio_is_valid(spi->cs_gpio)) {
                if (!(spi->mode & SPI_NO_CS)) {
-                       if (spi->cs_gpiod)
+                       if (spi->cs_gpiod) {
+                               dev_err(&spi->dev, "gpiod %s", enable1
? "enable" : "disable");
                                /* polarity handled by gpiolib */
                                gpiod_set_value_cansleep(spi->cs_gpiod,
                                                         enable1);
-                       else
+                       } else
                                /*
                                 * invert the enable line, as active low is
                                 * default for SPI.
