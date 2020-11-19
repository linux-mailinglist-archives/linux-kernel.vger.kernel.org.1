Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182EB2B8FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 11:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgKSKNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 05:13:55 -0500
Received: from mout01.posteo.de ([185.67.36.65]:37223 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgKSKNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 05:13:55 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 81F57160064
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 11:13:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1605780831; bh=xqiQG/dHvbiqPnLUHnrIJGw7cSZUheLL7+Mm/fo794U=;
        h=Date:From:To:Cc:Subject:From;
        b=FdxZ2mGIRPbSAq72BHewv7C0NAkAh/39HjsrRv6AYebBQ63UoaYFJkFs5emPENYJ0
         YwoJ4xuh88Wp3ThaFbqvADdXIaEn5kLsw36xEkVVRlYqyoOn8bmIvj2gDO7/FU957/
         EOtlz3ZttRFgj+0+OwzMZlkXsa/+rfVV78rBrE9a+xqaseAxYw9npguASueO3y+IKX
         oRxnMqUF67lkeuGXrdV6NkP+flSHFt7DdOyMVNPjVdcWDtD5+0kpMCpwsy3k2wuPXk
         GLUwQlcHJhOhhkYRmwrDVv3iZ78qlnJ/tTuf2jfKXgVI/srnlkXq4hvd1RjEGjOVd1
         o2Nbp1RqkIYrA==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CcFrV30xKz6tmk;
        Thu, 19 Nov 2020 11:13:46 +0100 (CET)
Date:   Thu, 19 Nov 2020 11:13:43 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201119111343.74956eae@monster.powergraphx.local>
In-Reply-To: <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
        <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
        <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
        <20201118203624.7221ba8b@monster.powergraphx.local>
        <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Nov 2020 08:15:23 +0100
Maxime Ripard <maxime@cerno.tech> wrote:
> > can you help me here a bit? I still try to figure out how to do patch sets
> > properly. Some kernel submitting documentation says everything goes into the
> > coverletter and other documentation only tells how to split the patches. So
> > what would be the right way? A quick example based on my patch set would be
> > really helpful.
> 
> I mean, the split between your patches and so on is good, you got that right
> 
> The thing I wanted better details on is the commit log itself, so the
> message attached to that patch.

Ah yes, I think I got it now. So basically add a nice summary of the coverletter
there.

> > > Most importantly, this hwspinlock is used to synchronize the ARM cores
> > > and the ARISC. How did you test this driver?
> > 
> > Yes, you are right, I should have mentioned this. I have a simple test kernel
> > module for this. But I must admit, testing the ARISC is very hard and I have
> > no real idea how to do it. Testing the hwspinlocks in general seems to work
> > with my test kernel module, but I'm not sure if this is really sufficient. I
> > can provide the code for it if you like. What would be the best way? Github?
> > Just mailing a patch?
> > 
> > The test module produces these results:
> > 
> > # insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspinlock_test.ko 
> > [   45.395672] [init] sunxi hwspinlock test driver start
> > [   45.400775] [init] start test locks
> > [   45.404263] [run ] testing 32 locks
> > [   45.407804] [test] testing lock 0 -----
> > [   45.411652] [test] taking lock attempt #0 succeded
> > [   45.416438] [test] try taken lock attempt #0
> > [   45.420735] [test] unlock/take attempt #0
> > [   45.424752] [test] taking lock attempt #1 succeded
> > [   45.429556] [test] try taken lock attempt #1
> > [   45.433823] [test] unlock/take attempt #1
> > [   45.437862] [test] testing lock 1 -----
> 
> That doesn't really test for contention though, and dealing with
> contention is mostly what this hardware is about. Could you make a small
> test with crust to see if when the arisc has taken the lock, the ARM
> cores can't take it?

So the best solution would be to write a bare metal program that runs on the
arisc and can be triggered from the linux side (the test kernel module) to take
a spinlock ... or at least take spinlocks periodically for a while and watch it
on the linux side. Okay, I think I can do this. Though, I have to dig through
all this new stuff first.

Greetings,
Wilken
