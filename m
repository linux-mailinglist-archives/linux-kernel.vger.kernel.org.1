Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F712D3D9D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgLIIjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgLIIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:39:19 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE4AC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 00:38:39 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id w13so1988176lfd.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 00:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m/1rj/wXg9oCi+YfUXe8gHvq4SdGjy/asRCiGbz5eYE=;
        b=PD4HG672/N5NMIJ8j9tpQhQA4BdG6Cb8uQhXvZQtNznh2P984CpMjc9rMkiVD7YWtb
         pdNiXfpyGdA2RBcv3Y2y6AZm8zJAA6Cls9R/ed4vspwFJgZJwEEJu2CjrCpu8Ly1coX0
         62ptj3YVQ/oAD+aebYOKd0ZoFetjwPMDQBmOuYkdyCcqN6/oTeMnQiRRRGkl7TU9G4Tn
         Ht0e7Vs/NKedWi5nYBVS9sjFLTU68O9DIH4LSwZjwn20VgLiAtag0dsWT7OQprnvD32h
         V6BTBB6dNEqK2LGQyAu95rtMmxfEsajc5JRZUk2IZFMcvU2ooTxdWf0KmWvskjuP2ht3
         4dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m/1rj/wXg9oCi+YfUXe8gHvq4SdGjy/asRCiGbz5eYE=;
        b=NPAyi0lg//kTFFtxdOjZxdhvEEwa+r78YDYBqnf7swo2t0arNlD6bGmqeOOMV4QiNU
         tzQyOEACQr5EExFNkl8CSeo2s/PJm8MyzzMGn0mywwt6UcG5nhKnOptBcQG4VXK0qkw4
         oMOPQZQ6MMs8ScrTxvTkxrMgggawURyPqA4OPAuVi0fU77BQQUSMmpTORfS10w7Wonfz
         pufP6mixw/uq64ErwUjsxFcdaD+FZOFScdTdBxiFoN+6e2m5VwxFeZxyNMYQpUQtSeQZ
         n4UYGApErQLMX/GqPlyl6K0TT6jF6zcWZD0AuoylR8rS1cC0jDUAQNBrnLpOcbDCyTkE
         lYlw==
X-Gm-Message-State: AOAM532J3RDO//9ggkI9QFDY7khc2UirskhiS4JyZZswXPJsEkORINzx
        7J08ea3dRWO/dWHyl15IeYeuDd4+jk7pPuXOi0fP0A==
X-Google-Smtp-Source: ABdhPJxLQ18SKij9xDzkpwGsoE6abk9C4B246bgaSE56cmuc2Xi0W2PPgg/U9tIm8q1R9aAe8By4wVq8J8FM000qusc=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr670420lfe.29.1607503117685;
 Wed, 09 Dec 2020 00:38:37 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
 <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
 <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com> <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com>
 <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com> <CACRpkdYgu+fyYm8aSCRuPeVe0EieyboZsWC=XsrRs5Tubog6nA@mail.gmail.com>
 <ED67B0A3-1098-4B4C-A4F4-EE52B0E5F1E3@goldelico.com>
In-Reply-To: <ED67B0A3-1098-4B4C-A4F4-EE52B0E5F1E3@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Dec 2020 09:38:26 +0100
Message-ID: <CACRpkdYbGBT1gYZ06W7G-tjx9J4YG1bi1g2GOAUAH0tzH8YbNw@mail.gmail.com>
Subject: Re: [BUG] SPI broken for SPI based panel drivers
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mark Brown <broonie@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 5, 2020 at 8:07 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> I find it interesting that so far nobody wants to take responsibility
> for a decision
(...)

What causes some consternation in this discussion is the appeal
to higher authority. The kernel community in general does not like
authority/responsibility by way of formal hierarchy.

Have you read this document? Especially point 1) Decisions:
https://www.kernel.org/doc/html/latest/process/management-style.html

(We can have a meta-discussion about this but it is not really your
point I believe.)

> > What I can do is to provide just a skeleton for the table that you or Linus
> > can fix/fill in and make a patch out of it. Is attached and the ??? is
> > something you should discuss and define.
>
> Please take the attached diff, comment it here and define the question marks
> according to your intention and then make a patch for the YAML bindings out
> of it. (I can't do because I don't know your intentions and what to write into
> the commit message).

I'll comment what I know, then you can send a proper patch to
Mark. But you really need more people than me to look at this.

> +      device node     | cs-gpio       | CS pin state active | Note
> +      ================+===============+=====================+=====
> +      spi-cs-high     | -             | H                   |
> +      -               | -             | L                   |
> +      spi-cs-high     | ACTIVE_HIGH   | H                   |
> +      -               | ACTIVE_HIGH   | L (or H ???)        | 1

When using GPIO descriptors it will be enforced to ACTIVE_LOW (L) with an
explicit warning in dmesg, see drivers/gpio/gpiolib-of.c

When using legacy GPIOs, will be enforced ACTIVE_LOW by the SPI
core.

> +      spi-cs-high     | ACTIVE_LOW    | H (or L ???)        | 2

When using GPIO descriptors it will be enforced to ACTIVE_HIGH (H) with an
explicit warning in dmesg, see drivers/gpio/gpiolib-of.c

> +      3) Effectively this rule defines that the ACTIVE level of the
> +         gpio has to be ignored

Nr 3 isn't tagged in the table.

Yours,
Linus Walleij
