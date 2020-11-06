Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0E12A8D2A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgKFCwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:52:09 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:47018 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgKFCwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:52:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 4D86F22C30;
        Thu,  5 Nov 2020 21:52:02 -0500 (EST)
Date:   Fri, 6 Nov 2020 13:52:01 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Arnd Bergmann <arnd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC 13/13] m68k: mac: convert to generic clockevent
In-Reply-To: <CAMuHMdUyGH=ORa4yHivMeJZaGQ3kEXi1kr9=P+u1y3QQnC+-4g@mail.gmail.com>
Message-ID: <alpine.LNX.2.23.453.2011061343030.13@nippy.intranet>
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-14-arnd@arndb.de> <alpine.LNX.2.23.453.2010091900150.12@nippy.intranet> <CAK8P3a3rM7gJjdTtcKzr6yi15n6xs-yhEpmSOf3QHfahQwxqkw@mail.gmail.com> <alpine.LNX.2.23.453.2010150937430.16@nippy.intranet>
 <CAK8P3a3i6cum_9xGgsbxjXXvbRsP8Po5qLZ0Agb3c4gZTKC9GQ@mail.gmail.com> <CAMuHMdUyGH=ORa4yHivMeJZaGQ3kEXi1kr9=P+u1y3QQnC+-4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020, Geert Uytterhoeven wrote:

> > > > The arm/rpc timer seems to be roughly in the same category as most 
> > > > of the m68k ones or the i8253 counter on a PC. It's possible that 
> > > > some of them could use the same logic as 
> > > > drivers/clocksource/i8253.o as long as there is any hardware 
> > > > oneshot mode.
> > >
> > > There appear to be 15 platforms in that category. 4 have no 
> > > clocksource besides the jiffies clocksource, meaning there's no 
> > > practical alternative to using a periodic tick, like you did in your 
> > > RFC patch:
> > >
> > > arch/m68k/apollo/config.c
> > > arch/m68k/q40/q40ints.c
> > > arch/m68k/sun3/sun3ints.c
> > > arch/m68k/sun3x/time.c
> >
> > Do any of these have users? I'm fairly sure sun3x has never worked in 
> > mainline, sun3 seems to still need the same few patches it did 20 
> > years ago. I couldn't find much about Linux on Apollo or q40, the 
> > information on the web for either of them seems to all be for 
> > linux-2.4 kernels.
> 
> They probably don't have any users.

I have access to several Sun 3 machines but no time to work on that port, 
unfortunately.

Are these 4 platforms (those with no clocksource besides the "jiffies" 
clocksource) the only reason for CONFIG_TIME_LOW_RES on m68k?
