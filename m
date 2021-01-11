Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC012F0F97
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbhAKJ77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:59:59 -0500
Received: from elvis.franken.de ([193.175.24.41]:42348 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbhAKJ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:59:58 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kytyc-0000DI-00; Mon, 11 Jan 2021 10:59:06 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9C599C0898; Mon, 11 Jan 2021 10:40:22 +0100 (CET)
Date:   Mon, 11 Jan 2021 10:40:22 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
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
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: Old platforms: bring out your dead
Message-ID: <20210111094022.GA5691@alpha.franken.de>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
 <CAMuHMdWiYkhN_S2t+hg0cDk84Qd950YE9-qGTgsdL_-2vPr1WQ@mail.gmail.com>
 <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3TNVj_Gw=GaEFELdF9Fo25XU_PFWS5N0+kb=R394KNVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 09:59:23AM +0100, Arnd Bergmann wrote:
> On Mon, Jan 11, 2021 at 9:19 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Jan 8, 2021 at 11:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > > * MIPS R3000/TX39xx: 32-bit MIPS-II generation, mostly superseded by
> > >   64-bit MIPS-III (R4000 and higher) starting in 1991. arch/mips still
> > >   supports these in DECstation and Toshiba Txx9, but it appears that most
> > >   of those machines are of the 64-bit kind. Later MIPS32 such as 4Kc and
> > >   later are rather different and widely used.
> >
> > I have a (32-bit) RBTX4927 development board in my board farm, boot-test
> > every bi-weekly renesas-drivers release on it, and fix kernel issues
> > when they appear.
> 
> Right, I was specifically thinking of the MIPS-II/R3000 ones here, I know
> there are users on multiple actively maintained MIPS-III platforms.

Maciej still runs R3k based machines.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
