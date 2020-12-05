Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30E2CF7F6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730431AbgLEA00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgLEA0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:26:25 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA97C0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:25:39 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id v14so10097162lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 16:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpKhF/B/BPq1dxiZb4/12rK1wNVAfMfgAoUYhBJf7es=;
        b=DJwvtskAHpYq8BkNX/dXRtXU9/JY3NLPn2mzw8ywE7q0gWx0jsQj1H6lCvTitpDWnz
         RoRDDhxN0fP8LFfYbwFbPdaSEhtcINPjzfFkO9GBjNLtgLn4pQglZxJydZbWFMWy3gsA
         kOq6fDoqw/7FGDKKgO2ATnPowjbWOEz2Fw3N2r+FDT9X0CMPpwOEEqq9FSpx4W1YwFEm
         Sd6cUkjoMZE2Dd0+j9SyF/tLMtcg+ds5lekq0xPYxW0Y/uckrk4OXhR7K68n+cMbk2be
         N9IBLU4tX6GpcIMsiBAdLswqpkyMY/9/8nocFrsAw2prHWNXoFAGXpvvjHF5SIZY01Yk
         S0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpKhF/B/BPq1dxiZb4/12rK1wNVAfMfgAoUYhBJf7es=;
        b=Utw/O0ODIU1E+3ke9q9sahL7ZXPnimREceHCUD6CN5qKRFV/q8kkVrCGcFNBFxE9V1
         MrHa2yr2q4sUE8E2ZO/k6L1gp21CN1inq2bGg7oNtC/dLWt08phzWJpkgBhNfkWOIN9c
         xlFKDaMuAUAXpFzJQzpZafgAAQDYet61Sbs4DRotFq4hLG7g9D6RwzbUC3zU/rNKUGg7
         rmaev0rMANIK44jxh69AsMwNKz+g49dkMKk3Y30K8P/ODF7jtDDNCZILzdItFTko1a1v
         hJXkD95LoxrlNmWDsR6KmuVpcusIZCUG0xIRROyOtg884c+197FNPflVxNE0jOfEXbw2
         c/7w==
X-Gm-Message-State: AOAM530Myrvz5/BnmSMmUPPqFZHyAuI1PWudr9Y2m+w9M4pwQHAZrjK4
        /OX1zFXbNm3zfxGWVaQHt4EHJRz3lU2h0cAlRNOyoA==
X-Google-Smtp-Source: ABdhPJwEO/5uWqabw0J5JY9g9Q2kNVcCxHowh6jE0hWqr7Tpbmik0ZJSrNtRSWbtJaS8g6tvlYpEtP7Bfw7kB1c8urc=
X-Received: by 2002:a19:ad41:: with SMTP id s1mr4514717lfd.571.1607127936636;
 Fri, 04 Dec 2020 16:25:36 -0800 (PST)
MIME-Version: 1.0
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com>
 <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com>
 <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk>
 <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
 <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com> <CAGngYiUG76Q-cb_HdDKMia5yXzv_mS+5NPeaBquK3_4b3tr-4Q@mail.gmail.com>
 <9380CE00-9CE6-4E0B-B2E1-1B534F85E47D@goldelico.com> <CAGngYiVF5yMAGPJ8xZgt=BfJ3JfBMABVC0t+dQ2oOq986T9iKg@mail.gmail.com>
 <BD3995F3-F4E6-4DC9-B0B9-5DCD6655F049@goldelico.com> <CAGngYiXWo4QEDF73wa7RDah1yUUOO1URoD_k5Fd5JMqSL2JXGg@mail.gmail.com>
 <A88317FA-52CC-41D3-B11A-BFAD36C35AE4@goldelico.com> <CAGngYiUPaR=_1NKZSjUQRK9+zUw3ztUpro7NV-O=sGAC2eOzUw@mail.gmail.com>
 <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com>
In-Reply-To: <7702A943-FCC5-416B-B53A-3B0427458915@goldelico.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 5 Dec 2020 01:25:25 +0100
Message-ID: <CACRpkdYgu+fyYm8aSCRuPeVe0EieyboZsWC=XsrRs5Tubog6nA@mail.gmail.com>
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

On Fri, Dec 4, 2020 at 5:52 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:

> It could have been described by ACTIVE_LOW without spi-cs-high but that did
> emit a nasty and not helpful warning on each boot.
>
> Well, there are of course better and worse definitions and I agree that
> spi-cs-high to define an active-low chip select sounds strange. Still it
> is just a definition.

This has an historical background which is why we have the
problem in the first place. We ended up with two different
ways of doing polarity inversion in some subsystems because
polarity flags *and* local polarity flags such as this existed.
So the semantics became ambiguous.

commit f618ebfcbf9616a0fa9a78f5ecb69762f0fa3c59
"of/spi: Support specifying chip select as active high via device tree"
created spi-cs-high
October 2008

commit b908b53d580c3e9aba81ebe3339c5b7b4fa8031d
"of/gpio: Implement of_get_gpio_flags()"
Created of_get_gpio_flags() and OF_GPIO_ACTIVE_LOW
as an optional but strongly encouraged cell.
December 2008

What we are seeing
is the consequence of a formal language with ambiguous
semantics. It's no-ones fault other than the human error of
allowing both to exist simultaneously in the first place.

Both ways of doing things existed before I took over as GPIO
maintainer and before Mark took over as SPI maintainer.
What we try to do is contain the situation. My attempt was
to hide it inside the GPIO descriptor, which we still do,
if and only if GPIO descriptors are used.

> But what I don't know is if I can omit spi-cs-high and have to keep
> ACTIVE_HIGH (my revert patch) or also change to ACTIVE_LOW (my additional
> patch). This is arbitrary and someone has to decide what it should be.
(...)
> I'd prefer if you or maybe Linus could submit such a patch and I am happy to review it.

It seems really ill-advised to have me do that since I have not
managed very well to deal with this. Clearly better developers
are needed. But I can review a patch and see if it makes me
smarter :)

> > The reason for that is described in the commit message of
> > 766c6b63aa04 ("spi: fix client driver breakages when using GPIO descriptors")
>
> IMHO it could have been fixed in the gpiolib alone. In my assumption, gpiolib
> would know (or be informed) that the gpio is used by spi and could invert gpio_set_value()
> if needed. Then any SPI code would simply use gpio_set_value(true) if spi-cs-high
> is defined and gpio_set_value(false) if not to enable the chip.

That was the intention behind my code in
of_gpio_flags_quirks().

And I suppose how it finally works after the recent patches
as well, since we now pass enable1 (the non-inverted
assertion parameter) to gpiod_set_value_cansleep()
if and only if you are using GPIO descriptors.

The reason it didn't work and a lot of ill-advised patches
(mostly mine) has a lot to do with native chip selects
which both listened to the same flag "spi-cs-high"
and expected specific semantics from the spi core.

For native chip selects there is no ambiguity: they can
only be made active high using "spi-cs-high".

> The alternative would be that it is only done centrally in one place in the
> spi subsystem.

FWIW I think GPIO CS is fine to handle in the gpiolib
but then spi-cs-high also applies to native chip selects
and that makes it necessary for the SPI core to also parse
for spi-cs-high sometimes, for something that is not
a GPIO, setting SPI_CS_HIGH and calling
spi->controller->set_cs() on the controller with 0 for
active low and 1 for active high.

I think we are there now?

Yours,
Linus Walleij
