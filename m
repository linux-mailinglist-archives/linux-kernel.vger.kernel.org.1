Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D501A2EBAF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAFIEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:04:06 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:32822 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:04:05 -0500
Received: by mail-ot1-f42.google.com with SMTP id b24so2327604otj.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j0FQT+rA9N0z070hetg6I+nVP1v1PBlnWXO/uyobi+g=;
        b=OyxysIpS8sTfz0d0ww+MJaRRg/xg3+7BJwKaLGYPBYLAOOU6cZ/OBN+jSLRyy51FSu
         WbNZ2Bs1YhCoI19qa2YqQZ6Qh8DUkEc4FEVSMf5AMXqbxA7qyEwQgg0XTlrGOhOfceVj
         N4ScbXEma1V68yVCALxv9PYUFR4BVZXxktWG3AAQmUNuYndMlVp41pclbvXWOFmIqFlt
         gViBM+HXQMyiW7IiL9sI5PXxoXnD0aMNauFwSy9bAiPduhhrQ6xDAa7wnX8RvSNVKfoE
         VQnIY4gbp3OhesyzXZjlNBNDZpGUXMYWj3aYJZZFJX10FxdqekUmebuRBQroyhVknEYq
         UhQw==
X-Gm-Message-State: AOAM5329cdfulqMsIYQIDO5HaTym54m/sXzrHSdIf4DcgEU31qRgPbPf
        XI2deb9sdx5iFSpO9JXDMBhyw26dMxgUt7edC0I=
X-Google-Smtp-Source: ABdhPJzqr3TWkaN53m+Q+y2eKwekPVYjdblSA/FiMQ3X1gRb/N8bH6sVzO9SyxtBnAOfgLqE+FynKl5DTRMVDkRIkcg=
X-Received: by 2002:a05:6830:1f5a:: with SMTP id u26mr2418691oth.250.1609920204771;
 Wed, 06 Jan 2021 00:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20210105150124.dvlochv3qrp4wpre@runtux.com> <20210105150400.j7hhxu5uextga5mz@runtux.com>
 <CANiq72mYUVvyJuv6pxeYvzQrOyRvp4Uy8AxF_WMDgQaKBndi-A@mail.gmail.com>
In-Reply-To: <CANiq72mYUVvyJuv6pxeYvzQrOyRvp4Uy8AxF_WMDgQaKBndi-A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jan 2021 09:03:13 +0100
Message-ID: <CAMuHMdXTNXmKacw47zBxG3YG_xcjMQrKS-4iy518wU+6dq9ahA@mail.gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: HD44780 connected to I2C via PCF8574
To:     Ralf Schlatterbeck <rsc@runtux.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

On Wed, Jan 6, 2021 at 3:42 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> On Tue, Jan 5, 2021 at 4:04 PM Ralf Schlatterbeck <rsc@runtux.com> wrote:
> > Add HD44780 character display connected via I2C I/O expander.
> > Re-uses the high-level interface of the existing HD44780 driver.
> >
> > Signed-off-by: Ralf Schlatterbeck <rsc@runtux.com>

Thanks for your patch!

> Also, Cc'ing others related to hd44780/charlcd that may be interested
> (there is another patch in the series, too).

Thanks for CCing me, Miguel!

> > +config HD44780_PCF8574
> > +       tristate "HD44780 Character LCD support, I2C-connection"
>
> There is no hyphen in the "parallel connection" one, perhaps remove it?
>
> > +#define DEBUG
>
> Spurious line from development?
>
> > +/*
> > + * The display uses 4-bit mode (the I/O expander has only 8 bits)
> > + * The control signals RS, R/W, E are on three bits and on many displays
> > + * the backlight is on bit 3. The upper 4 bits are data.
> > + */
> > +#define HD44780_RS_SHIFT       0
> > +#define HD44780_RW_SHIFT       1
> > +#define HD44780_E_SHIFT                2
> > +#define HD44780_BACKLIGHT_SHIFT        3

Unless I'm missing some little detail, there should be no need for this
driver: this wiring (and alternative wirings) can just be expressed in DT.
Examples (using 74HC595 SPI GPIO expanders) can be found in my
renesas-overlays branch:

  - ARM: dts: koelsch: exio-a: Add overlay for MSIOF1 and 2xHC595
    https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=98f65d8ac2ae79d63f13d3f9cc562512670297b7

  - ARM: dts: hc595s: Add overlay for 20x4 character LCD (4 bit wiring)
    https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=topic/renesas-overlays&id=181f27534a7437e73e0067062dfa5a18dccd9a74

  - ARM: dts: hc595s: Add overlay for 20x4 character LCD (8 bit wiring)
    https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/log/?h=topic/renesas-overlays

A separate driver is needed only when using a microcontroller with a
custom protocol to interface with the HD44780.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
