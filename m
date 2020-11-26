Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667222C550E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390110AbgKZNKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:10:47 -0500
Received: from mout02.posteo.de ([185.67.36.66]:35967 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389879AbgKZNKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:10:46 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 453872400FF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:10:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1606396243; bh=JBKgdlVv9ZLDBtqhmp72rJGZIYphVWv0LA7AuWZp+9M=;
        h=Date:From:To:Cc:Subject:From;
        b=ryFEfqP9D4ZkZQPjiULvd4/Iq8lLUWpGuWAQpNGe0GH1B5PxbQY0Ob1Yv/4gfxkrA
         FpBE1aaa8BPsBuy3wUjL//lezrU9X/lavV0JxshgmqCfx2r3Ol4pq6Ig2zrRBWaCs8
         u+82pRAMs0vHgmeeq8eoCzJgJ3Gsm8oxAgPM4hN/BshvXzYt/8dAwr1o3LPZzAqki2
         QM5jaspRrinoTUhuriK4UqXY9RaTPRQeeGIq49RBDJ0BOBkrWhY4ZW+j8Z5jnUzhnL
         0lTYcwh7KWWR3cOupOYAZnBeDev6Q4TBYCCjLvK2c8+ywlSzqmo9z6/hVp9BMzyjEZ
         NynUI7yBLX/+Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4ChdRP5XG3z9rxG;
        Thu, 26 Nov 2020 14:10:41 +0100 (CET)
Date:   Thu, 26 Nov 2020 14:10:39 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201126141039.45d56786@monster.powergraphx.local>
In-Reply-To: <39136764-2b58-f66d-68ea-e1c6b4d74edf@sholland.org>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
        <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
        <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
        <20201118203624.7221ba8b@monster.powergraphx.local>
        <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
        <20201119111343.74956eae@monster.powergraphx.local>
        <20201120164231.nmzxe5scwnfoyy3o@gilmour>
        <20201121122255.GB22987@debian>
        <20201121164418.hxrxzgob7whgzkpj@gilmour>
        <20201123193206.0b2d1b6d@monster.powergraphx.local>
        <39136764-2b58-f66d-68ea-e1c6b4d74edf@sholland.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Nov 2020 21:35:52 -0600
Samuel Holland <samuel@sholland.org> wrote:

> On 11/23/20 12:32 PM, Wilken Gottwalt wrote:
> > On Sat, 21 Nov 2020 17:44:18 +0100
> > Maxime Ripard <maxime@cerno.tech> wrote:
> > 
> >> On Sat, Nov 21, 2020 at 08:22:55PM +0800, fuyao wrote:
> >>> On Fri, Nov 20, 2020 at 05:42:31PM +0100, Maxime Ripard wrote:
> >>>> Hi,
> >>>>
> >>>> On Thu, Nov 19, 2020 at 11:13:43AM +0100, Wilken Gottwalt wrote:
> >>>>> On Thu, 19 Nov 2020 08:15:23 +0100
> >>>>> Maxime Ripard <maxime@cerno.tech> wrote:
> >>>>>>> can you help me here a bit? I still try to figure out how to do patch sets
> >>>>>>> properly. Some kernel submitting documentation says everything goes into the
> >>>>>>> coverletter and other documentation only tells how to split the patches. So
> >>>>>>> what would be the right way? A quick example based on my patch set would be
> >>>>>>> really helpful.
> >>>>>>
> >>>>>> I mean, the split between your patches and so on is good, you got that right
> >>>>>>
> >>>>>> The thing I wanted better details on is the commit log itself, so the
> >>>>>> message attached to that patch.
> >>>>>
> >>>>> Ah yes, I think I got it now. So basically add a nice summary of the coverletter
> >>>>> there.
> >>>>
> >>>> Yes, a bit more context as well. Eventually, this should be the
> >>>> motivation on why this patch is useful. So what it can be used for, what
> >>>> are the challenges, how it was tested, etc.
> >>>>
> >>>> The cover letter is usually here more to provide some meta-context: what
> >>>> you expect from the maintainers / reviewers if it's an RFC, if there's
> >>>> any feature missing or that could be added later on, etc.
> >>>>
> >>>>>>>> Most importantly, this hwspinlock is used to synchronize the ARM cores
> >>>>>>>> and the ARISC. How did you test this driver?
> >>>>>>>
> >>>>>>> Yes, you are right, I should have mentioned this. I have a simple test kernel
> >>>>>>> module for this. But I must admit, testing the ARISC is very hard and I have
> >>>>>>> no real idea how to do it. Testing the hwspinlocks in general seems to work
> >>>>>>> with my test kernel module, but I'm not sure if this is really sufficient. I
> >>>>>>> can provide the code for it if you like. What would be the best way? Github?
> >>>>>>> Just mailing a patch?
> >>>>>>>
> >>>>>>> The test module produces these results:
> >>>>>>>
> >>>>>>> # insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspinlock_test.ko 
> >>>>>>> [   45.395672] [init] sunxi hwspinlock test driver start
> >>>>>>> [   45.400775] [init] start test locks
> >>>>>>> [   45.404263] [run ] testing 32 locks
> >>>>>>> [   45.407804] [test] testing lock 0 -----
> >>>>>>> [   45.411652] [test] taking lock attempt #0 succeded
> >>>>>>> [   45.416438] [test] try taken lock attempt #0
> >>>>>>> [   45.420735] [test] unlock/take attempt #0
> >>>>>>> [   45.424752] [test] taking lock attempt #1 succeded
> >>>>>>> [   45.429556] [test] try taken lock attempt #1
> >>>>>>> [   45.433823] [test] unlock/take attempt #1
> >>>>>>> [   45.437862] [test] testing lock 1 -----
> >>>>>>
> >>>>>> That doesn't really test for contention though, and dealing with
> >>>>>> contention is mostly what this hardware is about. Could you make a small
> >>>>>> test with crust to see if when the arisc has taken the lock, the ARM
> >>>>>> cores can't take it?
> >>>>>
> >>>>> So the best solution would be to write a bare metal program that runs on the
> >>>>> arisc and can be triggered from the linux side (the test kernel module) to take
> >>>>> a spinlock ... or at least take spinlocks periodically for a while and watch it
> >>>>> on the linux side. Okay, I think I can do this. Though, I have to dig through
> >>>>> all this new stuff first.
> >>>>
> >>>> It doesn't have to be super complicated, just a loop that takes a lock,
> >>>> sleeps for some time, and releases the lock should be enough to at least
> >>>> validate that the lock is actually working
> >>>>
> >>>
> >>> I think the difficulty is the bare metal program in arsic has little
> >>> documentation.
> >>
> >> crust has mostly figured it out:
> >> https://github.com/crust-firmware/crust
> > 
> > I actually have serious trouble to get crust running. It compiles for H2+/H3, but
> > I can't figure out if it runs at all. I will switch to a H5 based device which is
> 
> Crust does not yet support the H2+/H3 (it is active WIP). H5 should work
> well.
> 
> > confirmed to work. If I see this correctly crust is doing nothing with spinlocks
> > yet, so I may end up also working on crust, adding the spinlocks there too. Don't> know yet how
> > long I will take to understand every detail, but I will
> report
> > progress.
> 
> Correct. There is currently no hwspinlock driver in crust. For testing,
> you can poke MMIO from the main loop, near the call to scpi_poll() in
> common/system.c. You can use the timeout.h functions for timing.

Thank you very much for the hint. I already have a very simple test running
were crust changes the state of the first spinlock every 250ms (with the high
timeout it is much easier to catch).
 
> If you want to write a full driver, I would like to know how you expect
> to use the hwspinlocks. Allocating the locks has to be coordinated among
> all of the users: Linux, U-Boot, crust, any other ARISC firmware, etc.

I will think about this if the Linux hwspinlock driver is in an acceptable
state and I can easily show, that it works. I want to create more complex
tests first.

Can I actualy print messages from crust to the debug uart while linux runs?
It doesn't matter if the messages get scrambled while both write to the uart.
It would be just nice to see this playing out in "realtime".

> > Greetings,
> > Wilken
> 
> Cheers,
> Samuel

