Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430402AD8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:24:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbgKJOYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730059AbgKJOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:24:16 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F992C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:24:14 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id dk16so17779967ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u6GB7ypk83KMaLnug0kEhxxuhg0irI7q+WnuAwKUDz4=;
        b=z6lVbF7hbH9X2l93H3Ds7VcmaP1i40C685zORXYPM+UvzOmOd/uv5rOpNySsFWY6Td
         M5RNFY9fjeUW+oluZfzRSnHIfxf8Y6/fDjzy3WOQnEfBXb/jSjh1R8iAc3vl4zkQSgY1
         Np5QndhNUKpNZKb3obtpsedD0LLbao0Fx+EY9IJc8UW52Tuotb4cnULPkeOoSlzjnp2k
         BX6TiJ+1CXf1fLpG4IYBgdyqso1xQ8i7viqm8NY1XtfL2ot1tMjNF3YFXMxlJoKQXYxU
         u+wFNOMyQIOvB2t/n9Knfs8akKf3F0iLwR+gbffDnSC2UN6PUEpFCS499P98tuSciXHw
         zFoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6GB7ypk83KMaLnug0kEhxxuhg0irI7q+WnuAwKUDz4=;
        b=WBlj5SQEejxzepHA6cbcIgzn4jUi5D2QUk7MrsDKVHWrD9/RUtRVZyN5YbbZG0ngqK
         nfm296NH6z5TDTRfP90sM7eXzCQ9Cl64rDuhJKSlf5WsUbaEPgg/FIoL/OJB/tZP3R1D
         PUUNcuRF6+MZdkJdOwKxo6VBCiNLOmM2vjqH+cySPc8fT1KTFRYWyHlkytNbvkSwzwDl
         1oON9OYa0SE9SI1eKAR0rf60VMswkfTACGYpDXmkxpljy4Dj3UUUR4h4Zx390Juqz5or
         AN6OSZKcyL7iTP/NN2w0/PXt48I4hDv4tlxEcDiu8+s/RdFhcpOq4+Qy6mznGnXtQ1k7
         3ZHA==
X-Gm-Message-State: AOAM53023K2cambR7ozH7amEikXSKxYqsDfVBVV3qBHmMvE5YPaHB47B
        JZ6tcRabH/1X4I6zSuqyjtJHbWFT9gHoGSlIBx/exQ==
X-Google-Smtp-Source: ABdhPJx30Zk9w+Bs/0VfrWJHfOBCeMB9VX9ifkstoX3lH+ntpsdokpy96vRRKYCOAcZ1VsUjRmNOLK680JnfY1jggZ0=
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr21453325ejh.155.1605018252919;
 Tue, 10 Nov 2020 06:24:12 -0800 (PST)
MIME-Version: 1.0
References: <20201110123406.3261-1-brgl@bgdev.pl> <20201110123406.3261-7-brgl@bgdev.pl>
 <CAHp75VekgB1ch4QjHkvvgbE2_KRWG-AynBMP=aLmoM8jBGRmTQ@mail.gmail.com>
In-Reply-To: <CAHp75VekgB1ch4QjHkvvgbE2_KRWG-AynBMP=aLmoM8jBGRmTQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 10 Nov 2020 15:24:02 +0100
Message-ID: <CAMpxmJUfRi8g1B7ufya4py+ta-jnCWew+QR94O-HCDuuWyiLdA@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] gpio: exar: switch to using regmap
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:11 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, Nov 10, 2020 at 2:35 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> ...
>
> >  struct exar_gpio_chip {
> >         struct gpio_chip gpio_chip;
> > -       struct mutex lock;
>
> > +       struct regmap *regs;
>
> Leaving the same name is a call for potential troubles.
>
> >         int index;
> > -       void __iomem *regs;
> >         char name[20];
> >         unsigned int first_pin;
> >  };
>
> ...
>
> > +static const struct regmap_config exar_regmap_config = {
> > +       .name           = "exar-gpio",
> > +       .reg_bits       = 8,
> > +       .val_bits       = 8,
> > +};
>
> Looking at the crash, are you sure this is a comprehensive description?
> Maybe it requires something like stride or so?
>

This is what I'm looking at ATM. Looking at the datasheet[1], there
are no breaks in the registers so the default stride of 1 should be
fine as is the value bits width of 8. I think that I got the address
width wrong though. Should be 16 bits probably.

Jan: could you change reg_bits to 16 and try again?

Bartosz

[1] https://www.maxlinear.com/ds/xr17v352.pdf
