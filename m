Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D322AF416
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgKKOxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgKKOxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:53:17 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890D0C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:53:17 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id z21so3462555lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZVLlXwDe5fMTOgU+8fzchgHyqxUszJ9a/tL8hlboio=;
        b=xc8wsRKk6zyyqqhu0VJTkcJlwAnC4Q79uq/8+TbZoSG/ykQgRiT+HKe87VLF9uZstn
         MgDS1NM8zimQQMC8/jfVnY3MqxXXdM5x3Go4u5KHIXLd1aqt2yY1r2ZgEbjQHbAI8EEe
         mXDqQFmCTy5ppXABOYt0Ldwz2KroXRF/g9/1g2Ehd4CNOy3d5yi+KW7k/3JETlKs7m/I
         THLvuNGyXT7xze+fjDBzpwof0BmsU2XUkLYRlml7ln4KFzfjnw+1JsXVQ0maDaGSCn7k
         YCp2QSskXDmS8xZlClwEhlofC9h+pJWAjuwStDWEHTNWh6MPQ7+0rsn3TSErW8mSIEyb
         Ikvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZVLlXwDe5fMTOgU+8fzchgHyqxUszJ9a/tL8hlboio=;
        b=tBpVgPGqI9UVqV3vMxCvJBFG4AAaF/roecgDbw3pvgd0B3MT9xqUzOUZMjVMabYlkx
         wQUDYxcgMjEyypjyO02wY1hiu9FCRWf8Qe4XFWulQ0s85SkJyHXIVun9QOA4KIiTWsk7
         9s8cp+4l1v3dv0WltHJd4PzxenlhUxCK29caUe0HnI5QQkZNa/etELJwgXyoJ1V9q6nE
         T8d+JvwZBau8fP4hGdXb31UdIK1uHLdA9YdBywJyIPYlpooFHcvi5mRhSyYOLhIZKy5J
         nStzCGsKexlOzjdS66mjkjDCGd+FtikDXOeqKPpNZJdwt6Uyxiczm0Q4LAn6IZieMXwn
         CXuw==
X-Gm-Message-State: AOAM533CJVdvkC/fXiZU96gwbP9KxFDO5+SMZj58wa3a/B4sYErVkQYB
        dRaRYmkfolddOAm5tvh7yRTulE/GJS2lCyBVnkUHjA==
X-Google-Smtp-Source: ABdhPJzSEoIuAvWpeEhGWcyet/dlWnEpWoX24604qd6BmgRHaExWp2au6Wt3tP7E8zvOBiKSncIlPnSi6HXI9tld7Ws=
X-Received: by 2002:a19:ca05:: with SMTP id a5mr6514401lfg.571.1605106395648;
 Wed, 11 Nov 2020 06:53:15 -0800 (PST)
MIME-Version: 1.0
References: <20201108180144.28594-1-martin@kaiser.cx> <CAHp75VeVPUJ_a4L+Lj-zR6Wm3Woq6F0uHzmtx3NCRO=TVopvrw@mail.gmail.com>
 <fc6a99af-7cee-b0ae-c4b1-cc7249e22b6c@microchip.com>
In-Reply-To: <fc6a99af-7cee-b0ae-c4b1-cc7249e22b6c@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 15:53:04 +0100
Message-ID: <CACRpkdYyAvDzZ5fqtcYWxhdLU+JS00iKbo3pogG0AnvWv4-ucQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: pinctrl-at91-pio4: Set irq handler and data in
 one go
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:08 AM Nicolas Ferre
<nicolas.ferre@microchip.com> wrote:
> On 09/11/2020 at 12:26, Andy Shevchenko wrote:
> > On Sun, Nov 8, 2020 at 8:05 PM Martin Kaiser <martin@kaiser.cx> wrote:
> >>
> >> Replace the two separate calls for setting the irq handler and data with a
> >> single irq_set_chained_handler_and_data() call.
> >
> > Can it be rewritten to use the GPIO core facility of instantiating IRQ chip?
>
> I have the feeling it's out of scope for this (tiny) patch.

True, but a good suggestion anyways.

If you have a TODO for the AT91 pin controllers I think both using
the GPIOLIB_IRQCHIP can cut down
the code in these files quite a bit, and probably fix some unknown bugs.

Yours,
Linus Walleij
