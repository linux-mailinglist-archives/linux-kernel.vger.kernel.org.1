Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9D82A0F14
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgJ3UGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727472AbgJ3UGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:06:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77080C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 13:06:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604088365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WThTzRS5YBDgg0iNd/sKe4DTY2Nu1BYO3f6TbP5AoZI=;
        b=WKyvmn4uOyWaHUs4cXBdKq8IKoBuflJ/Jx/Nnc331bZXC4beplyVURU3+DbvbW9QiAEx1u
        fXU/+qYWFIoryZNEzU3qBUF+4qaOkiBoyLjiFH8gmDF/o5vSEXDQvUjtC4IJZyFIYVXWe7
        n1QGf5zc+0hUdLWDKZigN9JqZfJ/4q3sf4YH3LoY0+ABLNzCxnibDzCGjvy+aB1ASo2lHk
        tEl8R3xD6ZlTrCzqpmi1BjjZ4lFbM5TAhQYzWeAcbiD6Rpm70r4hwHUenUHEVmov/3B5HM
        tuXBYQKTszckLXMpSOPKbC6lPaInrcGhnleCIppErI7M5e/jFamg/arDQDVcEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604088365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WThTzRS5YBDgg0iNd/sKe4DTY2Nu1BYO3f6TbP5AoZI=;
        b=NebTZ5naH1uT2FIkj0wKMb7t8993JUDzYgpobYKoxzsumLrWAMNUNrFeOgB0uiIiIC6IzY
        y/oD5JxGxw1rX4Cw==
To:     Carlos O'Donell <carlos@redhat.com>,
        Zack Weinberg <zackw@panix.com>, Cyril Hrubis <chrubis@suse.cz>
Cc:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@gmail.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Y2038][time namespaces] Question regarding CLOCK_REALTIME support plans in Linux time namespaces
In-Reply-To: <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com>
References: <20201030110229.43f0773b@jawa> <20201030135816.GA1790@yuki.lan> <CAKCAbMgemuaG61seKMvhjOHdPCEQJRQBiQgzcf_eO=xm2t+KBw@mail.gmail.com> <87sg9vn40t.fsf@nanos.tec.linutronix.de> <72bbb207-b041-7710-98ad-b08579fe17e4@redhat.com>
Date:   Fri, 30 Oct 2020 21:06:04 +0100
Message-ID: <87h7qbmqc3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30 2020 at 12:58, Carlos O'Donell wrote:
> On 10/30/20 11:10 AM, Thomas Gleixner via Libc-alpha wrote:
>> That's what virtual machines are for.
>
> Certainly, that is always an option, just like real hardware.
>
> However, every requirement we add to testing reduces the number of
> times that developer will run the test on their system and potentially
> catch a problem during development. Yes, CI helps, but "make check"
> gives more coverage. More kernel variants tested in all downstream rpm
> %check builds or developer systems. Just like kernel self tests help
> today.
>
> glibc uses namespaces in "make check" to increase the number of userspace
> and kernel features we can test immediately and easily on developer
> *or* distribution build systems.
>
> So the natural extension is to further isolate the testing namespace
> using the time namespace to test and verify y2038. If we can't use
> namespaces then we'll have to move the tests out to the less
> frequently run scripts we use for cross-target toolchain testing,
> and so we'll see a 100x drop in coverage.

I understand that.

> I expect that more requests for further time isolation will happen
> given the utility of this in containers.

There was a lengthy discussion about this and the only "usecase" which
was brought up was having different NTP servers in name spaces, i.e. the
leap second ones and the smearing ones.

Now imagine 1000 containers each running their own NTP. Guess what the
host does in each timer interrupt? Chasing 1000 containers and update
their notion of CLOCK_REALTIME. In the remaining 5% CPU time the 1000
containers can do their computations.

But even if you restrict it to a trivial offset without NTP
capabilities, what's the semantics of that offset when the host time is
set?

 - Does the offset just stay the same and container time just jumps
   around with the host time?

 - Has it to change so that the containers notion of realtime is not
   affected? Which is pretty much equivalent to the NTP case of chasing
   a gazillion of containers, just it might give the containers a bit
   more than 5% remaining CPU time.

 - Can the offset of the container be changed at runtime,
   i.e. is clock_settime() possible from withing the container?

There are some other bits related to that as well, but the above is
already mindboggling.

> If we have to use qemu today then that's where we're at, but again
> I expect our use case is representative of more than just glibc.

For testing purposes it might be. For real world use cases not so
much. People tend to rely on the coordinated nature of CLOCK_TAI and
CLOCK_REALTIME.

> Does checkpointing work robustly when userspace APIS use 
> CLOCK_REALTIME (directly or indirectly) in the container?

AFAICT, yes. That was the conclusion over the lenghty discussion about
time name spaces and their requirements.

Here is the Linux plumber session related to that:

     https://www.youtube.com/watch?v=sjRUiqJVzOA

Thanks,

        tglx

