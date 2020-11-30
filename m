Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2B22C89EC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgK3Qvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:51:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgK3Qvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:51:54 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB16C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:51:14 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id d18so17037597edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VyKkRZI14CL09cIKqCrg3tRF0u0hWmZ7H+6Vrc8e5Uo=;
        b=Zye/yjDqWPYGyg/QE0koGvl0I2eHLXcxFBm4sXkIAKcAllxFfCM8VhOKsbeI3vqS5q
         WJynbjNDVCg5tCp8TZzl46m0pdFE+emZQsOSzDR3n1Z9O0Z4KzEyprZ2N56f/VKa6qr5
         FxAkySIInHUZpy3Si5S8ztkqnlIwnnl+7xiwCRvLeHgnaLPxJaYJ4vcca1DoiMXyqK/e
         qhM+eiUXY5aMq6kr4DSF2ghhgxdJzkPPQLxsiONl3BEctySuXBtUjKggjYyyOimhxKRn
         Li7SFb8adwSPzQ9upKTgl2WnnSLw93Bq7Z3az1xpjsh+zZ0Zb2d3xY18mLqPe+ZUtDFR
         SMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VyKkRZI14CL09cIKqCrg3tRF0u0hWmZ7H+6Vrc8e5Uo=;
        b=KZ0gFfJgPPZBWUZXN6jDNyZuvFdgxgOBZu+EDerNEThuylqw4kx8//BflpCatnFwR1
         ryB/geZcx7os6eUnicniIWKxBWSmC2UDMArAwKtIcQ4rxy2vlylLHG8+CQa/HX0zsXvu
         cyH32VVe/9ZiA6p2Lw8YO/3HruS8s2Iwg+1mZ/MvldXib2s14BRdgLu9MaBzNrBVtV+V
         eqR9O4fPGXSiLa7HMinKKS7rt1+THGO7lbNOIzCR74+rbMO5ayP+JDjW30MY/RnSB9OE
         wej1ND6BAD1PzBkr7Mx4DYcCM9jTJihMKFQ56+sh0Ub6CziOyVRdp/Fyei33cVuIXLnv
         BrwA==
X-Gm-Message-State: AOAM532l9oNqS2GR2QmGkrpWdsKzaSTc9AKMwlEO9V9lE5Wx+MJNxpce
        LykpMr+zuhUI41kuBqNWaEuSiq7ZSD5jpuHmwB8L2Q==
X-Google-Smtp-Source: ABdhPJyOKnMrgBQxB4k8Qm92X/QZ93uux4mg7bXxBB+nV6g8s1tY4J8qFCSFmU/yEs/ngBHyxDuQrTMnx9skThFF/XI=
X-Received: by 2002:a05:6402:16c8:: with SMTP id r8mr15528179edx.59.1606755073013;
 Mon, 30 Nov 2020 08:51:13 -0800 (PST)
MIME-Version: 1.0
References: <20201119170739.GA22665@embeddedor> <CAHp75Ve2G25FBzMKAaTw-9mFAvwU2uBG+TZ0UdLW+c8zra=Fhg@mail.gmail.com>
In-Reply-To: <CAHp75Ve2G25FBzMKAaTw-9mFAvwU2uBG+TZ0UdLW+c8zra=Fhg@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 30 Nov 2020 17:51:02 +0100
Message-ID: <CAMpxmJWq0_ZXsPsWhgWC_93egDm9y2A5P3GiCQ4YTcdGrGTSZQ@mail.gmail.com>
Subject: Re: [PATCH][next] gpiolib: acpi: Fix fall-through warnings for Clang
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 7:46 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Thu, Nov 19, 2020 at 7:08 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Link: https://github.com/KSPP/linux/issues/115
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/gpio/gpiolib-acpi.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> > index 6cc5f91bfe2e..e37a57d0a2f0 100644
> > --- a/drivers/gpio/gpiolib-acpi.c
> > +++ b/drivers/gpio/gpiolib-acpi.c
> > @@ -233,6 +233,7 @@ acpi_gpio_to_gpiod_flags(const struct acpi_resource_gpio *agpio, int polarity)
> >                 default:
> >                         break;
> >                 }
> > +               break;
> >         default:
> >                 break;
> >         }
> > --
> > 2.27.0
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko

Are you taking it through your tree?

Bartosz
