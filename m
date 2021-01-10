Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1372F060E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 09:46:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbhAJIqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 03:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbhAJIqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 03:46:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2734523B08
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 08:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610268334;
        bh=ezKsWu6SKYCsEDVNC7gYvArnfAqz+A1VYlxI+V1ulzQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OyGTEQE7Eu7na0QE9+L5KBFQIoS9bjGOccxD6tp1TuUK3jOYxkz4O+aT3oddN9v5F
         5B2U9PwA+jqZ4Z8MmG0YC2IxxVOVqeXBeOhWsyJAM43V4SAjidmT5xM0bDx0LWjLax
         PGUeOQ13wLgdXVDjEitB8ACIEfGsYsJ4zEkDF8Kq53OHPIolA+h2EP0oZ4izo+mQd8
         GOMJyaYHkSQLK0IJbjqk4SdKEzOc0WzHL4RsltozkeYqOoLUrdA4D8wdNJKk9owe2+
         QSWA6UON7BZ2PrTI+nK56+WY51cEWAbICul7Eo07yo8tiDgZTj+DRlaHaNAHH+1f17
         rMx/7OhIwEdWQ==
Received: by mail-ot1-f44.google.com with SMTP id x13so14044035oto.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 00:45:34 -0800 (PST)
X-Gm-Message-State: AOAM533TI+ZXPGMIooT5Kn+YlUT5xMUqXwmNRwga8AQEtk4aXyvB8ioT
        pmoo0ppYZYAj2Y3bB7UrLUiIbSsBul3HZdScG9c=
X-Google-Smtp-Source: ABdhPJysJm8g3yuu2ckVz7T90Kk8ZQKr5n5eTo9f9M2KyQcpGgNX97ljZKIX/HPRJz/SLyV0n9tOB4w8HVmImRzdy2A=
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr7746394otr.210.1610268333333;
 Sun, 10 Jan 2021 00:45:33 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <X/o4VZzW4m77AYDB@lunn.ch>
In-Reply-To: <X/o4VZzW4m77AYDB@lunn.ch>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 10 Jan 2021 09:45:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3kg1u3QVj1JS92Js7ZO9HvgDfzBtEbN4HULpNfNEJfoA@mail.gmail.com>
Message-ID: <CAK8P3a3kg1u3QVj1JS92Js7ZO9HvgDfzBtEbN4HULpNfNEJfoA@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baruch Siach <baruch@tkos.co.il>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Tang <dt.tangr@gmail.com>,
        Jamie Iles <jamie@jamieiles.com>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Alex Elder <elder@linaro.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Mark Salter <msalter@redhat.com>,
        Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 12:12 AM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > Then there are ARM platforms that are old but have still seen some work
> > in the past years. If I hear nothing, these will all stay, but if maintainers
> > may want to drop them anyway, I can help with that:
>
> Hi Arnd
>
> I notice orion5x is not on this list. Is that because of Debian still
> building for it?

No, it was a mistake on my end, it should have been in the
second list of platforms that are fairly old but still updated
and possibly have users.

> I just blew the dust out of my orion5x RDK and booted 5.11-rc2 on it.
> orion5x_defconfig needs a few updates, but otherwise it seems to work
> O.K.
>
> But i have no idea if there are any real users out there running
> modern kernels.

For this platform, I'm most interested in whether there are still users
that rely on board files instead of DT. AFAIU we could just fold
the DT variant into arch-mvebu like kirkwood was, right?

        Arnd
