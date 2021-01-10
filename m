Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72E512F0839
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 16:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbhAJP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 10:57:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbhAJP5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 10:57:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF7EF2082D
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 15:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610294230;
        bh=3FDUH0OSyYgBrcIOyENo5ukLKoMIfT4kZFDXBO5Camk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TMVeKiSBpwns74kzt9Nh84lidntW3sLr1Q/n6oXG2RhlviRthpqbaxx11FF6oZwmq
         bQ1FU58xsDo5n/VvrpjQ0Y+RDYZWmmz52zgcgjRQ18SSomDzqsY04pHBlmFwW+/qJ4
         /J1jzLbEu435MXDL3yHs6II1ZNjamiR3lQZBUGQmM5Y7NhzBnkzxzjkIQzLFCzaSS0
         d+ZiJ970fKHIsqnRKfME8nd6vKcAu8C8MdW94WN0eihJc+LibFExbSIy4lDjsBQnEE
         osk7wCTIEQonRXQvOYPo6kHeIF19QF5GZTpE3Do5akBXV6ih5U1Q4JKS6kf2wkpMwA
         rBquzE8zUsDMQ==
Received: by mail-oi1-f179.google.com with SMTP id w124so17569785oia.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 07:57:10 -0800 (PST)
X-Gm-Message-State: AOAM530XliGspflo6DEaLoYB9zdoG7LruGxT8m8sxpdsYT2z8yprX4+F
        SXhC4zMVrjDtFUOVI9udYPpW8Jy+o7j0xmeHOs0=
X-Google-Smtp-Source: ABdhPJzknFEC+j7Q9V/sFP4GhccP1jg4uYM43kULqiUljW+KHB4bRWj0SAFfbKNabReOiysIIDmVTZk5oKbTksiGJfQ=
X-Received: by 2002:aca:e103:: with SMTP id y3mr7761427oig.11.1610294230145;
 Sun, 10 Jan 2021 07:57:10 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <bbeb01ba-c941-9237-0ee5-506d9c276e89@baylibre.com>
In-Reply-To: <bbeb01ba-c941-9237-0ee5-506d9c276e89@baylibre.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Sun, 10 Jan 2021 16:56:53 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0e63dW0ZCKhOjCHVbh-KsyNHbRhLbsyxtEA-yPMWGbLA@mail.gmail.com>
Message-ID: <CAK8P3a0e63dW0ZCKhOjCHVbh-KsyNHbRhLbsyxtEA-yPMWGbLA@mail.gmail.com>
Subject: Re: Old platforms: bring out your dead
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Mark Salter <msalter@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 4:51 PM Neil Armstrong <narmstrong@baylibre.com> wr=
ote:
>
> Hi Arnd,
>
> Le 08/01/2021 =C3=A0 23:55, Arnd Bergmann a =C3=A9crit :
> > After v5.10 was officially declared an LTS kernel, I had a look around
> > the Arm platforms that look like they have not seen any patches from
> > their maintainers or users that are actually running the hardware for
> > at least five years (2015 or earlier). I made some statistics and lists
> > for my lwn.net article last year [1], so I'd thought I'd share a summar=
y
> > here for discussion about what we should remove. As I found three
> > years ago when I removed several CPU architectures, it makes sense
> > to do this in bulk, to simplify a scripted search for device drivers, h=
eader
> > files and Kconfig options that become unused in the process.
>
> ...
>
> > * oxnas -- added in 2016, but already old then, few changes later
>
> There is still active users in the openwrt community, so it would be good=
s to keep it for now.
> And we have an OX820 board in KerneCI so it's still maintained & boot-tes=
ted.

Ok, taken off the list now.

Thanks for the clarification,

      Arnd
