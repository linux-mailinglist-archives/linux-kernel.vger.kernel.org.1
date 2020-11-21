Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00DB2BBEE5
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbgKUMXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:23:06 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:52866 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727191AbgKUMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:23:04 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07462001|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.410477-0.000193703-0.589329;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.IzZCTo2_1605961376;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.IzZCTo2_1605961376)
          by smtp.aliyun-inc.com(10.147.42.198);
          Sat, 21 Nov 2020 20:22:56 +0800
Date:   Sat, 21 Nov 2020 20:22:55 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201121122255.GB22987@debian>
Mail-Followup-To: Maxime Ripard <maxime@cerno.tech>,
        Wilken Gottwalt <wilken.gottwalt@posteo.net>,
        linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
 <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
 <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
 <20201118203624.7221ba8b@monster.powergraphx.local>
 <20201119071523.5cbpgy2cpo5cmuev@gilmour.lan>
 <20201119111343.74956eae@monster.powergraphx.local>
 <20201120164231.nmzxe5scwnfoyy3o@gilmour>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120164231.nmzxe5scwnfoyy3o@gilmour>
Organization: fuyao_love_xxt.Allwinnertech.Technology
User-Agent: Mutt/1.12.1+6 (4c2f7c70) (2019-08-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 05:42:31PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Nov 19, 2020 at 11:13:43AM +0100, Wilken Gottwalt wrote:
> > On Thu, 19 Nov 2020 08:15:23 +0100
> > Maxime Ripard <maxime@cerno.tech> wrote:
> > > > can you help me here a bit? I still try to figure out how to do patch sets
> > > > properly. Some kernel submitting documentation says everything goes into the
> > > > coverletter and other documentation only tells how to split the patches. So
> > > > what would be the right way? A quick example based on my patch set would be
> > > > really helpful.
> > > 
> > > I mean, the split between your patches and so on is good, you got that right
> > > 
> > > The thing I wanted better details on is the commit log itself, so the
> > > message attached to that patch.
> > 
> > Ah yes, I think I got it now. So basically add a nice summary of the coverletter
> > there.
> 
> Yes, a bit more context as well. Eventually, this should be the
> motivation on why this patch is useful. So what it can be used for, what
> are the challenges, how it was tested, etc.
> 
> The cover letter is usually here more to provide some meta-context: what
> you expect from the maintainers / reviewers if it's an RFC, if there's
> any feature missing or that could be added later on, etc.
> 
> > > > > Most importantly, this hwspinlock is used to synchronize the ARM cores
> > > > > and the ARISC. How did you test this driver?
> > > > 
> > > > Yes, you are right, I should have mentioned this. I have a simple test kernel
> > > > module for this. But I must admit, testing the ARISC is very hard and I have
> > > > no real idea how to do it. Testing the hwspinlocks in general seems to work
> > > > with my test kernel module, but I'm not sure if this is really sufficient. I
> > > > can provide the code for it if you like. What would be the best way? Github?
> > > > Just mailing a patch?
> > > > 
> > > > The test module produces these results:
> > > > 
> > > > # insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspinlock_test.ko 
> > > > [   45.395672] [init] sunxi hwspinlock test driver start
> > > > [   45.400775] [init] start test locks
> > > > [   45.404263] [run ] testing 32 locks
> > > > [   45.407804] [test] testing lock 0 -----
> > > > [   45.411652] [test] taking lock attempt #0 succeded
> > > > [   45.416438] [test] try taken lock attempt #0
> > > > [   45.420735] [test] unlock/take attempt #0
> > > > [   45.424752] [test] taking lock attempt #1 succeded
> > > > [   45.429556] [test] try taken lock attempt #1
> > > > [   45.433823] [test] unlock/take attempt #1
> > > > [   45.437862] [test] testing lock 1 -----
> > > 
> > > That doesn't really test for contention though, and dealing with
> > > contention is mostly what this hardware is about. Could you make a small
> > > test with crust to see if when the arisc has taken the lock, the ARM
> > > cores can't take it?
> > 
> > So the best solution would be to write a bare metal program that runs on the
> > arisc and can be triggered from the linux side (the test kernel module) to take
> > a spinlock ... or at least take spinlocks periodically for a while and watch it
> > on the linux side. Okay, I think I can do this. Though, I have to dig through
> > all this new stuff first.
> 
> It doesn't have to be super complicated, just a loop that takes a lock,
> sleeps for some time, and releases the lock should be enough to at least
> validate that the lock is actually working
> 
I think the difficulty is the bare metal program in arsic has little
documentation.

the arisc is usually used for standby, so don't provide detailed, and
start it with boot0 or uboot.

maybe we can run it use remoteproc to start it.



