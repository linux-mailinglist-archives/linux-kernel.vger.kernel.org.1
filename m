Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2602B5591
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 01:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgKQALB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 19:11:01 -0500
Received: from anhedonia.sammy.net ([67.23.44.4]:54043 "EHLO sammy.net"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKQALA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:11:00 -0500
X-Greylist: delayed 2620 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Nov 2020 19:11:00 EST
Received: from sammy by sammy.net with local (Exim 4.63)
        (envelope-from <sammy@sammy.net>)
        id 1kentn-00010k-IZ; Mon, 16 Nov 2020 18:27:03 -0500
Date:   Mon, 16 Nov 2020 18:27:03 -0500
From:   Sam Creasey <sammy@sammy.net>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
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
Message-ID: <20201116232703.GV14088@anhedonia-3>
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-14-arnd@arndb.de> <alpine.LNX.2.23.453.2010091900150.12@nippy.intranet> <CAK8P3a3rM7gJjdTtcKzr6yi15n6xs-yhEpmSOf3QHfahQwxqkw@mail.gmail.com> <alpine.LNX.2.23.453.2010150937430.16@nippy.intranet> <CAK8P3a3i6cum_9xGgsbxjXXvbRsP8Po5qLZ0Agb3c4gZTKC9GQ@mail.gmail.com> <CAMuHMdUyGH=ORa4yHivMeJZaGQ3kEXi1kr9=P+u1y3QQnC+-4g@mail.gmail.com> <alpine.LNX.2.23.453.2011061343030.13@nippy.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.23.453.2011061343030.13@nippy.intranet>
User-Agent: Mutt/1.4.2.2i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 01:52:01PM +1100, Finn Thain wrote:
> On Fri, 23 Oct 2020, Geert Uytterhoeven wrote:
> 
> > > > > The arm/rpc timer seems to be roughly in the same category as most 
> > > > > of the m68k ones or the i8253 counter on a PC. It's possible that 
> > > > > some of them could use the same logic as 
> > > > > drivers/clocksource/i8253.o as long as there is any hardware 
> > > > > oneshot mode.
> > > >
> > > > There appear to be 15 platforms in that category. 4 have no 
> > > > clocksource besides the jiffies clocksource, meaning there's no 
> > > > practical alternative to using a periodic tick, like you did in your 
> > > > RFC patch:
> > > >
> > > > arch/m68k/apollo/config.c
> > > > arch/m68k/q40/q40ints.c
> > > > arch/m68k/sun3/sun3ints.c
> > > > arch/m68k/sun3x/time.c
> > >
> > > Do any of these have users? I'm fairly sure sun3x has never worked in 
> > > mainline, sun3 seems to still need the same few patches it did 20 
> > > years ago. I couldn't find much about Linux on Apollo or q40, the 
> > > information on the web for either of them seems to all be for 
> > > linux-2.4 kernels.
> > 
> > They probably don't have any users.
> 
> I have access to several Sun 3 machines but no time to work on that port, 
> unfortunately.
> 
> Are these 4 platforms (those with no clocksource besides the "jiffies" 
> clocksource) the only reason for CONFIG_TIME_LOW_RES on m68k?

Sun3x was probably at least as close (if not closer) than Sun3 to
working in mainline back in the day, but unfortunately I'm in the same
place as Finn...  I've got the hardware, but time is harder to come
by.

-- Sam
