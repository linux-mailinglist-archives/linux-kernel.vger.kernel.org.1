Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093012B84FF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 20:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgKRTga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 14:36:30 -0500
Received: from mout02.posteo.de ([185.67.36.66]:35249 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgKRTga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 14:36:30 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B8BB8240100
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 20:36:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1605728187; bh=f+tdtr/iDGN69itDal1IKU9g8CV1e5mhPPTlB/qogq4=;
        h=Date:From:To:Cc:Subject:From;
        b=BSn97CZF2vPdRl3IEPckwH5fhwCyARfd/9twuVescXS+EnzxQdxmxmusJk8Mx/mdX
         Dut1waDHto1WQF9oGYLDphiUDUcrJwyB70ekewaKJwVCEQq89Xeza/z57oNV/ssa/D
         XuVZCY2i8sLQHQkQFG/NFO8KzJ/mVIjhn08iIlUlmkIHeD0UXESnxoldEfMv3IT/BF
         fWNaItwc8QwVIWn1sGy1YAnyh5NPnfz9YRUvzGd8q6N3O4o/f6xjaItl8jSRZv8Ty9
         /BCeNaz7t9a+MYscmNFlyL0Hl0nK5G4WX2CtYCqmaVUDPhqQuE30AL1SKnUU+IPAkp
         Od0hWV3NsOg9A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CbtNB0mZ0z9rxH;
        Wed, 18 Nov 2020 20:36:25 +0100 (CET)
Date:   Wed, 18 Nov 2020 20:36:24 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201118203624.7221ba8b@monster.powergraphx.local>
In-Reply-To: <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
        <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
        <20201118153733.jgiokn6jkwu6rv6c@gilmour.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On Wed, 18 Nov 2020 16:37:33 +0100
Maxime Ripard <maxime@cerno.tech> wrote:
> Hi Wilken,
> 
> On Wed, Nov 18, 2020 at 11:02:40AM +0100, Wilken Gottwalt wrote:
> > Adds the sunxi_hwspinlock driver and updates makefiles/maintainers.
> > 
> > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> 
> A more descriptive commit log would be welcome here, for example
> containing on which SoC this driver can be used, and on which it was
> tested.

can you help me here a bit? I still try to figure out how to do patch sets
properly. Some kernel submitting documentation says everything goes into the
coverletter and other documentation only tells how to split the patches. So
what would be the right way? A quick example based on my patch set would be
really helpful.

> This is the third attempt at that driver, and you can find the previous
> versions here:
> https://patchwork.kernel.org/project/linux-arm-kernel/cover/20200210170143.20007-1-nborisov@suse.com/
> https://lore.kernel.org/patchwork/patch/706512/
> 
> Most of the comments on those series still apply to yours.

Oh, I wrote my driver 2-3 years ago and just prepared it for mainline. I
wasn't aware of other attempts. I really should have checked this. Though,
I really want to get to the point where this driver is good enough for
mainline. Hmmm, it is interesting how similar these drivers are. Looks like
the other developers also got inspired by the already existing hwspinlock
drivers. :D

> Most importantly, this hwspinlock is used to synchronize the ARM cores
> and the ARISC. How did you test this driver?

Yes, you are right, I should have mentioned this. I have a simple test kernel
module for this. But I must admit, testing the ARISC is very hard and I have
no real idea how to do it. Testing the hwspinlocks in general seems to work
with my test kernel module, but I'm not sure if this is really sufficient. I
can provide the code for it if you like. What would be the best way? Github?
Just mailing a patch?

The test module produces these results:

# insmod /lib/modules/5.9.8/kernel/drivers/hwspinlock/sunxi_hwspinlock_test.ko 
[   45.395672] [init] sunxi hwspinlock test driver start
[   45.400775] [init] start test locks
[   45.404263] [run ] testing 32 locks
[   45.407804] [test] testing lock 0 -----
[   45.411652] [test] taking lock attempt #0 succeded
[   45.416438] [test] try taken lock attempt #0
[   45.420735] [test] unlock/take attempt #0
[   45.424752] [test] taking lock attempt #1 succeded
[   45.429556] [test] try taken lock attempt #1
[   45.433823] [test] unlock/take attempt #1
[   45.437862] [test] testing lock 1 -----
[   45.441699] [test] taking lock attempt #0 succeded
[   45.446484] [test] try taken lock attempt #0
[   45.450768] [test] unlock/take attempt #0
[   45.454774] [test] taking lock attempt #1 succeded
[   45.459576] [test] try taken lock attempt #1
[   45.463843] [test] unlock/take attempt #1
.
.
.
[   46.309925] [test] testing lock 30 -----
[   46.313852] [test] taking lock attempt #0 succeded
[   46.318654] [test] try taken lock attempt #0
[   46.322920] [test] unlock/take attempt #0
[   46.326944] [test] taking lock attempt #1 succeded
[   46.331729] [test] try taken lock attempt #1
[   46.335994] [test] unlock/take attempt #1
[   46.340021] [test] testing lock 31 -----
[   46.343947] [test] taking lock attempt #0 succeded
[   46.348749] [test] try taken lock attempt #0
[   46.353016] [test] unlock/take attempt #0
[   46.357040] [test] taking lock attempt #1 succeded
[   46.361825] [test] try taken lock attempt #1
[   46.366090] [test] unlock/take attempt #1
[   46.370112] [init] end test locks

Greetings,
Wilken
