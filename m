Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04448289BB3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391091AbgJIWVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:21:42 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:39342 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732320AbgJIWVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:21:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 522E829EC7;
        Fri,  9 Oct 2020 18:21:36 -0400 (EDT)
Date:   Sat, 10 Oct 2020 09:21:38 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Sam Creasey <sammy@sammy.net>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC 13/13] m68k: mac: convert to generic clockevent
In-Reply-To: <20201008154651.1901126-14-arnd@arndb.de>
Message-ID: <alpine.LNX.2.23.453.2010091900150.12@nippy.intranet>
References: <20201008154651.1901126-1-arnd@arndb.de> <20201008154651.1901126-14-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Perhaps patch 13 does not belong in this series (?).

All m68k platforms will need conversion before the TODO can be removed 
from Documentation/features/time/clockevents/arch-support.txt.

On m68k, HZ is fixed at 100. Without addressing that, would there be any 
benefit from adopting GENERIC_CLOCKEVENTS as per this RFC patch?

On Thu, 8 Oct 2020, Arnd Bergmann wrote:

> Now that the infrastructure allows kernels to have both legacy timer 
> ticks and clockevent drivers in the same image, start by moving one 
> platform to generic clockevents.
> 
> As qemu only supports the q800 platform among the classic m68k, use that 
> as an example.
> 

Correct VIA emulation is suprisingly difficult, so this kind of work 
should be tested on real hardware.

I say that because when I did the clocksource conversion for m68k I ran 
into a bug in QEMU (since fixed) and also because I once worked on some of 
the bugs in the emulated VIA device used in MAME/MESS.

> I also tried adding oneshot mode, which was successful but broke the 
> clocksource. It's probably not hard to make it work properly, but this 
> is where I've stopped.
> 

I'm not so sure that one timer is able to support both a clocksource 
driver and a clockevent driver. In some cases we may have to drop the 
clocksource driver (i.e. fall back on the jiffies clocksource).

Anyway, even on Macs with only one VIA chip we still have two timers. So I 
think we should try to use Timer 1 as a freerunning clocksource and Timer 
2 as a oneshot clock event. This may result in better accuracy and simpler 
code. This may require some experimentation though.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I have never tried implementing a clockevent or clocksource
> driver in the past, so this is really just an experiment and
> I expect I got something wrong.
> 

Writing clockevent drivers is new to me too. I'm still trying to discover 
what the implications might be if the only available clockevent device 
offers oneshot mode or periodic mode but not both.
