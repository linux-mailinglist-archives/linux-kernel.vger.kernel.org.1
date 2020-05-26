Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F451DB8FB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgETQIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 12:08:12 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:59596 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgETQIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 12:08:12 -0400
Date:   Wed, 20 May 2020 12:08:10 -0400
From:   Rich Felker <dalias@libc.org>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Jack Schmidt <jack.schmidt@uky.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, nd@arm.com
Subject: Re: clock_gettime64 vdso bug on 32-bit arm, rpi-4
Message-ID: <20200520160810.GM1079@brightrain.aerifal.cx>
References: <CAK8P3a2Tw2w73ZkK-W6AA9veMK4-miLUx-TL1EuOdP7EdW-AmQ@mail.gmail.com>
 <0c2abcd1-7da8-2559-1e93-4c3bdd38dec1@linaro.org>
 <CAK8P3a3fxs+14ZdCRmt_GwJGv3Aipm1r9sAHH6aVj2UrWBNuQQ@mail.gmail.com>
 <20200520154128.GA24483@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520154128.GA24483@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 04:41:29PM +0100, Szabolcs Nagy wrote:
> The 05/19/2020 22:31, Arnd Bergmann wrote:
> > On Tue, May 19, 2020 at 10:24 PM Adhemerval Zanella
> > <adhemerval.zanella@linaro.org> wrote:
> > > On 19/05/2020 16:54, Arnd Bergmann wrote:
> > > > Jack Schmidt reported a bug for the arm32 clock_gettimeofday64 vdso call last
> > > > month: https://github.com/richfelker/musl-cross-make/issues/96 and
> > > > https://github.com/raspberrypi/linux/issues/3579
> > > >
> > > > As Will Deacon pointed out, this was never reported on the mailing list,
> > > > so I'll try to summarize what we know, so this can hopefully be resolved soon.
> > > >
> > > > - This happened reproducibly on Linux-5.6 on a 32-bit Raspberry Pi patched
> > > >    kernel running on a 64-bit Raspberry Pi 4b (bcm2711) when calling
> > > >    clock_gettime64(CLOCK_REALTIME)
> > >
> > > Does it happen with other clocks as well?
> > 
> > Unclear.
> > 
> > > > - The kernel tree is at https://github.com/raspberrypi/linux/, but I could
> > > >   see no relevant changes compared to a mainline kernel.
> > >
> > > Is this bug reproducible with mainline kernel or mainline kernel can't be
> > > booted on bcm2711?
> > 
> > Mainline linux-5.6 should boot on that machine but might not have
> > all the other features, so I think users tend to use the raspberry pi
> > kernel sources for now.
> > 
> > > > - From the report, I see that the returned time value is larger than the
> > > >   expected time, by 3.4 to 14.5 million seconds in four samples, my
> > > >   guess is that a random number gets added in at some point.
> > >
> > > What kind code are you using to reproduce it? It is threaded or issue
> > > clock_gettime from signal handlers?
> > 
> > The reproducer is very simple without threads or signals,
> > see the start of https://github.com/richfelker/musl-cross-make/issues/96
> > 
> > It does rely on calling into the musl wrapper, not the direct vdso
> > call.
> > 
> > > > - From other sources, I found that the Raspberry Pi clocksource runs
> > > >   at 54 MHz, with a mask value of 0xffffffffffffff. From these numbers
> > > >   I would expect that reading a completely random hardware register
> > > >   value would result in an offset up to 1.33 billion seconds, which is
> > > >   around factor 100 more than the error we see, though similar.
> > > >
> > > > - The test case calls the musl clock_gettime() function, which falls back to
> > > >   the clock_gettime64() syscall on kernels prior to 5.5, or to the 32-bit
> > > >   clock_gettime() prior to Linux-5.1. As reported in the bug, Linux-4.19 does
> > > >   not show the bug.
> > > >
> > > > - The behavior was not reproduced on the same user space in qemu,
> > > >   though I cannot tell whether the exact same kernel binary was used.
> > > >
> > > > - glibc-2.31 calls the same clock_gettime64() vdso function on arm to
> > > >   implement clock_gettime(), but earlier versions did not. I have not
> > > >   seen any reports of this bug, which could be explained by users
> > > >   generally being on older versions.
> > > >
> > > > - As far as I can tell, there are no reports of this bug from other users,
> > > >   and so far nobody could reproduce it.
> 
> note: i could not reproduce it in qemu-system with these configs:
> 
> qemu-system-aarch64 + arm64 kernel + compat vdso
> qemu-system-aarch64 + kvm accel (on cortex-a72) + 32bit arm kernel
> qemu-system-arm + cpu max + 32bit arm kernel
> 
> so i think it's something specific to that user's setup
> (maybe rpi hw bug or gcc miscompiled the vdso or something
> with that particular linux, i built my own linux 5.6 because
> i did not know the exact kernel version where the bug was seen)
> 
> i don't have access to rpi (or other cortex-a53 where i
> can install my own kernel) so this is as far as i got.

If we have a binary of the kernel that's known to be failing on the
hardware, it would be useful to dump its vdso and examine the
disassembly to see if it was miscompiled.

Rich
