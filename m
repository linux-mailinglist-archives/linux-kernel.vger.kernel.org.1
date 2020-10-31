Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A44B2A12B7
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 02:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgJaBim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 21:38:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46204 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJaBim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 21:38:42 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604108320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rK3wJZEkOYtqx1WNclxjRSaHEF5pC1iuxF01eE8PLJI=;
        b=MF+QugM0OXKaXUm0NaPM1fgaa95T1YyIHk2elJ41F2aqZNuSd/OqIvRCjeMWDHMGzj1ysN
        YXqXyJT0IExWeb004wamnHBYu+AjFSuEDE/RDdVZa6if4tTcOZAB95TtxdO8pzR0EKOEJo
        4mlpJialGF5QOvIADs0QPPvKrWv9E4+gvii3CqmLTr76u2k7tgbP+1V19twiAckEWB2A2d
        vrApEB5qLR8vXTleB8zBgDPFciVShfMhE/6xSzsAwDcNYjUOz1WWtFLYKIocgOrWN5xI43
        Z39XKflqmldwqAtLKKdWMbM2ECAT/qD8Kj3Upf5kQqfFiSJewFutUZucy7ZFdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604108320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rK3wJZEkOYtqx1WNclxjRSaHEF5pC1iuxF01eE8PLJI=;
        b=5FHXfA/3RkszI0McedZ6f4Qx+KorARUo32F9tcfVFHlQqo0be+rdum/GXCHRHFid0tlc+c
        dSe18/ZW0uaGWsAA==
To:     Carlos O'Donell <carlos@redhat.com>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME support plans in Linux time namespaces
In-Reply-To: <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan> <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com> <87sg9vn40t.fsf@nanos.tec.linutronix.de> <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com> <87h7qbmqc3.fsf@nanos.tec.linutronix.de> <7bb5837f-1ff6-2b2c-089e-e2441d31ddb2@redhat.com>
Date:   Sat, 31 Oct 2020 02:38:39 +0100
Message-ID: <87k0v7kwdc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos,

On Fri, Oct 30 2020 at 18:19, Carlos O'Donell wrote:
> On 10/30/20 4:06 PM, Thomas Gleixner wrote:
>> On Fri, Oct 30 2020 at 12:58, Carlos O'Donell wrote:
>>> I expect that more requests for further time isolation will happen
>>> given the utility of this in containers.
>> 
>> There was a lengthy discussion about this and the only "usecase" which
>> was brought up was having different NTP servers in name spaces, i.e. the
>> leap second ones and the smearing ones.
>
> In the non-"request for ponies" category:
>
> * Running legacy 32-bit applications in containers with CLOCK_REALTIME set
>   to some value below y2038.

That's broken to begin with. That has been tried with Y2K and failed
miserably.

Any real application which needs access to CLOCK_REALTIME requires to
have access to something which is at least close to the real time.

> * Testing kernel and userspace clock handling code without needing to
>   run on bare-metal, VM, or other.

I grant you that, but it comes with a large can of worms as it opens the
door for 'request for ponies' all over the place.

>> Now imagine 1000 containers each running their own NTP. Guess what the
>> host does in each timer interrupt? Chasing 1000 containers and update
>> their notion of CLOCK_REALTIME. In the remaining 5% CPU time the 1000
>> containers can do their computations.
>
> How is this different than balancing any other resource that you give
> to a container/vm on a host?
>
> Can you enable 1000 containers running smbd/nmbd and expect to get
> great IO performance?

That's bogus. The kernel can control whether these daemons run or not
and how much CPU time they get, as it can control whether any container
application runs or not.

But when it comes down to time correctness that's a different story. At
the moment it allows to have a gazillion of notions of CLOCK_REALTIME
then it has to guarantee the correctness for all of them no matter what.

>> But even if you restrict it to a trivial offset without NTP
>> capabilities, what's the semantics of that offset when the host time is
>> set?
>
> Now you're talking about an implementation. This thread is simply
> "Would we implement CLOCK_REALTIME?" Is the answer "Maybe, if we solve
> all these other problems?"

Maybe, if you solved all these problems which is going to be finished at
the theoretical level in about 20 years from now. As I'm planning to be
retired and Y2038 has passed by then, feel free to pursue that route.

>>> If we have to use qemu today then that's where we're at, but again
>>> I expect our use case is representative of more than just glibc.
>> 
>> For testing purposes it might be. For real world use cases not so
>> much. People tend to rely on the coordinated nature of CLOCK_TAI and
>> CLOCK_REALTIME.
>
> Except we have two real world use cases, at the top of this email, 
> that could extend to a lot of software. We know legacy 32-bit 
> applications exist that will break with CLOCK_REALTIME past
> y2038. Software exists that manipulates time and needs testing
> with specific time values e.g. month crossings, day crossings,
> leap year crossings, etc.

Again. I agree with the testing part, but the legacy application part is
wishful thinking at least. IMO it's utter nonsense.

Coming back to your test coverage argument. I really don't see a problem
with the requirement of having qemu installed in order to run 'make
check'.

If you can't ask that from your contributors, then asking me to provide
you a namespace magic is just hillarious. The contributor who refuses to
install qemu will also insist to run on some last century kernel which
does not even know about name spaces at all.

Instead of asking for ponies your time might be better spent with
providing tools which just make it easy to run 'make check' with all
bells and whistels.

Virtualization is the right answer to the testing problem and if people
really insist on running their broken legacy apps past 2038, then stick
them into a VM and charge boatloads of money for that service. 
 
>>> Does checkpointing work robustly when userspace APIS use 
>>> CLOCK_REALTIME (directly or indirectly) in the container?
>> 
>> AFAICT, yes. That was the conclusion over the lenghty discussion about
>> time name spaces and their requirements.
>
> If this is the case then have we established behaviours that
> happen when such processes are migrated to other systems with
> different CLOCK_REALTIME clocks? Would these behaviours serve
> as the basis of how CLOCK_REALTIME in a namespace would behave?
>
> That is to say that migrating a container to a system with a
> different CLOCK_REALTIME should behave similarly to what happens
> when CLOCK_REALTIME is changed locally and you have a container
> with a unique CLOCK_REALTIME?

Any application has to be able to deal with CLOCK_REALTIME changing
under their feet no matter what. So why would migrating a container from
host A to host B which have a different notion of CLOCK_REALTIME make
any difference?

Please stop to abuse container migration which works perfectly fine with
the real problems vs. timekeeping solved (CLOCK_MONOTONIC and
CLOCK_BOOTTIME going backwards) as an argument for something which can
and should be solved entirely in user space.

  1) Testing

     Virtualization solves that problem. Creating tools to handle that
     conveniantly for your users/contributors is not rocket science.

  2) Legacy applications

     It does matter at all if you stick the application into a container
     which tells the kernel that it runs in some different time universe
     or if you start the very same application with a libc variant which
     uses the Y2038 aware interfaces of the kernel and pretends to be in
     the pre Y2038 time universe when handing time down to the
     application.
     
     If you have a bunch of applications which all suffer from the same
     problem and are completely disconnected from the real world notion
     of CLOCK_REALTIME then stick them into a VM and be done with it.

Just because something could be solved at the kernel level does not mean
that it is the right thing to do.

Thanks,

        tglx
