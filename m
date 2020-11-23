Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9A22BFF09
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 05:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgKWEjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 23:39:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40672 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKWEjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 23:39:23 -0500
Received: by mail-lf1-f65.google.com with SMTP id u19so21950481lfr.7;
        Sun, 22 Nov 2020 20:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41P9nu435fMmUKCXQ+eupnyQPmIuwwlpwwo3wAWO9KQ=;
        b=Z12NpJ0sHpw9u6ZFAEZEflOMGb7BOlvSmyTZsls2FFR5rJje6hcQeEccCD1WcyYWtj
         2NqobeSlXg4Vm99Ck4nE2XSLtWTUDaeJUjq3zYRXDKx3qBjGrxRbFFZivScJIAvBzmBN
         sQrI+h/5g1ONz07ZLFz7zjlt4JI+Hhd7UT10Rdo2mwt5tY4I389vqcqvRfSVvTyRubOe
         WMpO2fgtg5/Fkgbiqmu0gaxqblTBG/P1dmeu2t+X5EIVpPz8lXiH2MJE636XjR8zGTYa
         68rnKbJ6lIMRIol34wvo3EektLZBkdRhZW/a7xhyfnSI0TAj2ZKocUDxZDyvowT+ZOUS
         RR8g==
X-Gm-Message-State: AOAM530aCxpZhn1iGSj/ZLyp4W452lVBoKKpJUPZAZ6itaeqXz5+fmkl
        8SopJ4kck5EuecbW3fC8U7wEG4ap23dnsw==
X-Google-Smtp-Source: ABdhPJzaZPEFsOJdTP5Pi9RycKCSABdEyrABdxr3sjxRAGovxOtEP1wEQnOQ11pwIZYjylWFvgCAdw==
X-Received: by 2002:a19:c8ca:: with SMTP id y193mr11419087lff.150.1606106359429;
        Sun, 22 Nov 2020 20:39:19 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id q21sm1164857ljm.52.2020.11.22.20.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 20:39:19 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id t22so4180770ljk.0;
        Sun, 22 Nov 2020 20:39:18 -0800 (PST)
X-Received: by 2002:a2e:3c1a:: with SMTP id j26mr12828664lja.294.1606106358783;
 Sun, 22 Nov 2020 20:39:18 -0800 (PST)
MIME-Version: 1.0
References: <20201115222425.2885427-1-michael@fossekall.de>
 <20201120155252.kfkavrn4wpqzmbyc@gilmour> <20201120182739.GA3734181@a98shuttle.de>
In-Reply-To: <20201120182739.GA3734181@a98shuttle.de>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 23 Nov 2020 12:39:07 +0800
X-Gmail-Original-Message-ID: <CAGb2v645Hq_C6fntM8CFnBiHBTFM-6zyZUXLKWPccmb3eOZBKQ@mail.gmail.com>
Message-ID: <CAGb2v645Hq_C6fntM8CFnBiHBTFM-6zyZUXLKWPccmb3eOZBKQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add gpio-line-names
To:     Michael Klein <michael@fossekall.de>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 2:28 AM Michael Klein <michael@fossekall.de> wrote:
>
> Thank you for having a look at the patch!
>
> On Fri, Nov 20, 2020 at 04:52:52PM +0100, Maxime Ripard wrote:
> >On Sun, Nov 15, 2020 at 11:24:25PM +0100, Michael Klein wrote:
> >> Add gpio-line-names as documented in the Banana Pi wiki [1] and in the
> >> schematics [2].
> >>
> >> [1]: http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO#GPIO_PIN_define
> >> [2]: https://drive.google.com/file/d/0B4PAo2nW2KfnMW5sVkxWSW9qa28/view
> >>
> >> Signed-off-by: Michael Klein <michael@fossekall.de>
> >> ---
> >>  .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 64 +++++++++++++++++++
> >>  1 file changed, 64 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> index 4c6704e4c57e..b4ddfaf01b45 100644
> >> --- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> +++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
> >> @@ -136,6 +136,70 @@ bluetooth {
> >>
> >>  };
> >>
> >> +&pio {
> >> +    gpio-line-names =
> >> +            /* PA */
> >> +            "UART2-TX", "UART2-RX", "UART2-RTS", "UART2-CTS",
> >> +                    "UART0-TXD", "UART0-RXD", "PWM1", "PA7-EINT7",
> >> +            "PA8-EINT8", "PA9-EINT9", "PA10-EINT10", "TWI0-SCK",
> >> +                    "TWI0-SDA", "UART3-TX", "UART3-RX", "UART3-RTS",
> >> +            "UART3-CTS", "PA17-EINT17", "TWI1-SCK", "TWI1-SDA",
> >> +                    "PA20-EINT20", "PA21-EINT21", "", "",
> >> +            "", "", "", "", "", "", "", "",
> >
> >IIRC, the point is to have the pin names that the vendor publishes.
> >
> >Looking at Documentation/devicetree/bindings/gpio/gpio.txt, it says:
> >
> >"""
> >Optionally, a GPIO controller may have a "gpio-line-names" property. This is
> >an array of strings defining the names of the GPIO lines going out of the
> >GPIO controller. This name should be the most meaningful producer name
> >for the system, such as a rail name indicating the usage. Package names
> >such as pin name are discouraged: such lines have opaque names (since they
> >are by definition generic purpose) and such names are usually not very
> >helpful.
> >"""
> >
> >In this case, from the link you gave above, I think having the CON*-P*
> >names make more sense.
>
> Hm, but these are the pin names (of the connector) and should thus not
> be used, right?
>
> For e.g. the PA0 pin, the wiki link gives three candidates:
>
> - CON2-P13 (GPIO Pin Name -> pin 13 of the 40 pin GPIO header)
> - UART2-TX (Default Function)
> - PA0-EINT0 (Function2 : GPIO)
>
> IMHO, the CON*-P* name is the least helpful of the above, as it tells
> nothing about the usage. I'm not sure about the other two names, though.

I believe the function names are pretty useless in this case, as you
cannot use the GPIO subsystem to mux functions. That is what pinctrl
does. And in our case, the pinctrl drivers already know all the
available functions each pin has.

Using the pin count and connector name provides the user direct mapping
of the software representation of the pin against the actual pin on the
hardware. The user can then proceed to request and use that pin.

Again, you can not request "functions" from userspace, only GPIO usage.

Also using "one" function name creates confusion if the same function
is available on multiple pins.

ChenYu


> Michael
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
