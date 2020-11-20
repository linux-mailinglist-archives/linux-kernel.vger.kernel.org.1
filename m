Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35CB2B9F22
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 01:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbgKTAO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 19:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgKTAO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 19:14:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89576C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 16:14:27 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605831265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdGYwHCFRpuZtqOK0tHJMAkquMVT4wsdLaTWR34iWks=;
        b=JlCV9dHHTLJyFMHm+SGXIcqybYl3jJ0hOrfMmR5gd8wlV5tAgszMU3Xy8c/Nxln3SFw+20
        aun/69qpNDTxhxb+RZtjMOiIszl9KsoGNzT1qr4Aj5TBeN8H92Q9yS3Pr4V7pf1CRJOgK1
        wq+G/6rbfKGrMEqchYb5hqFtwwNZH1qSAPGSrdR0KEpE+/PE9rcDn4GXY4rKt+p7KNVZM4
        P60WclqrJ4YxZAfVt5NIlRl662qQU1D+0fIiLvXRfmz6icifccDvfenxzsd9UYoue1CzO4
        VCGdoX+JXaAxPtyns6jXaI9+BYtXNOVVJASbdkVixUuG44BjbIKni0y0nlm24g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605831265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NdGYwHCFRpuZtqOK0tHJMAkquMVT4wsdLaTWR34iWks=;
        b=JSGY7zmhQRKoP/gPp6RhgMyuyQ3N/utAQ2sh7EQ83rd8EHweZAssUEZnPwhfCQe1qYaSir
        McrkKF9kYzB3nFBg==
To:     Carlos O'Donell <carlos@redhat.com>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr =?utf-8?B?xaBwYcSNZWs=?= <petr.spacek@nic.cz>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME support plans in Linux time namespaces
In-Reply-To: <d88ede3f-5f50-24a2-5009-6418f3cfaf4c@redhat.com>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan> <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com> <87sg9vn40t.fsf@nanos.tec.linutronix.de> <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com> <87h7qbmqc3.fsf@nanos.tec.linutronix.de> <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com> <87k0v7kwdc.fsf@nanos.tec.linutronix.de> <7a4d7b14-1f0b-4c40-2bd1-2582d8b71868@redhat.com> <87y2jej8mp.fsf@nanos.tec.linutronix.de> <d88ede3f-5f50-24a2-5009-6418f3cfaf4c@redhat.com>
Date:   Fri, 20 Nov 2020 01:14:24 +0100
Message-ID: <87wnygopen.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19 2020 at 13:37, Carlos O'Donell wrote:
> On 11/6/20 7:47 PM, Thomas Gleixner wrote:
>> Would CONFIG_DEBUG_DISTORTED_CLOCK_REALTIME be a way to go? IOW,
>> something which is clearly in the debug section of the kernel which wont
>> get turned on by distros (*cough*) and comes with a description that any
>> bug reports against it vs. time correctness are going to be ignored.
>
> Yes. I would be requiring CONFIG_DEBUG_DISTORTED_CLOCK_REALTIME.
>
> Let me be clear though, the distros have *+debug kernels for which this
> CONFIG_DEBUG_* could get turned on? In Fedora *+debug kernels we enable all
> sorts of things like CONFIG_DEBUG_OBJECTS_* and CONFIG_DEBUG_SPINLOCK etc.
> etc. etc.

That's why I wrote '(*cough*)'. It's entirely clear to me that this
would be enabled for whatever raisins.

> I would push Fedora/RHEL to ship this in the *+debug kernels. That way I can have
> this on for local test/build cycle. Would you be OK with that?

Distros ship a lot of weird things. Though that config would be probably
saner than some of the horrors shipped in enterprise production kernels.

> We could have it disabled by default but enabled via proc like
> unprivileged_userns_clone was at one point?

Yes, that'd be mandatory. But see below.

> I want to avoid accidental use in Fedora *+debug kernels unless the
> developer is actively going to run tests that require time
> manipulation e.g. thousands of DNSSEC tests with timeouts [1].

...

> In case of DNSSEC protocol conversations have real time values in them
> which cause "expiration", thus packet captures are useful only if real
> time clock reflects values during the original conversation. In our case
> packet captures come from real Internet, i.e. we do not have private
> keys used to sign the packets, so we cannot change time values.
>
> This use-case also implies support for settime(): During the course of a
> test we shorten time windows where "nothing happens" and server and
> client are waiting for an event, e.g. for cache expiration on
> client. This window can be hours long so it really _does_ make a
> difference. Oh yes, and for these time jumps we need to move monotonic
> time as well.

I hope you are aware that the time namespace offsets have to be set
_before_ the process starts and can't be changed afterwards,
i.e. settime() is not an option.

That might limit the usability for your use case and this can't be
changed at all because there might be armed timers and other time
related things which would start to go into full confusion mode.

The supported use case is container life migration and that _is_ very
careful about restoring time and armed timers and if their user space
tools screw it up then they can keep the bits and pieces.

So in order to utilize that you'd have to checkpoint the container,
manipulate the offsets and restore it.

The point is that on changing the time offset after the fact the kernel
would have to chase _all_ armed timers which belong to that namespace
and are related to the affected clock and readjust them to the new
distortion of namespace time. Otherwise they might expire way too late
(which is kinda ok from a correctness POV, but not what you expect) or
too early, which is clearly a NONO. Finding them is not trivial because
some of them are part of a syscall and on stack.

What's worse is that if the host's CLOCK_REALTIME is set, then it'd have
to go through _all_ time namespaces, adjust the offsets, find all timers
of all tasks in each namespace.

Contrary to that the real clock_settime(CLOCK_REALTIME) is not a big
problem, simply because all it takes is to change the time and then kick
all CPUs to reevaluate their first expiring timer. If the clock jumped
backward then they rearm their hardware and are done, if it jumped
forward they expire the ones which are affected and all is good.

The original posix timer implementation did not have seperate time bases
and on clock_settime() _all_ armed CLOCK_REALTIME timers in the system
had to be chased down, reevaluated and readjusted. Guess how well that
worked and what kind of limitation that implied.

Aside of this, there are other things, e.g. file times, packet
timestamps etc. which are based on CLOCK_REALTIME. What to do about
them? Translate these to/from name space time or not? There is a long
list of other horrors which are related to that.

So _you_ might say, that you don't care about file times, RTC, timers
expiring at the wrong time, packet timestamps and whatever.

But then the next test dude comes around and want's to test exactly
these interfaces and we have to slap the time namespace conversions for
REALTIME and TAI all over the place because we already support the
minimal thing.

Can you see why this is a slippery slope and why I'm extremly reluctant
to even provide the minimal 'distort realtime when the namespace starts'
support?

> Hopefully this ilustrates that real time name space is not "request for
> ponny" :-)

I can understand your pain and why you want to distort time, but please
understand that timekeeping is complex. The primary focus must be
correctness, scalability and maintainability which is already hard
enough to achieve. Just for the perspective: It took us only 8 years to
get the kernel halfways 2038 ready (filesystems still outstanding).

So from my point of view asking for distorted time still _is_ a request
for ponies.

The fixed offsets for clock MONOTONIC/BOOTTIME are straight forward,
absolutely make sense and they have a limited scope of exposure. clock
REALTIME/TAI are very different beasts which entail a slew of horrors.
Adding settime() to the mix makes it exponentially harder.

Thanks,

        tglx
