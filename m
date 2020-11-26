Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7037A2C5561
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbgKZNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:31:50 -0500
Received: from mout01.posteo.de ([185.67.36.65]:50337 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389775AbgKZNbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:31:49 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0138E16005F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 14:31:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1606397507; bh=ngM+0rw6x2l2xrLAt+k14uW3bBh+HwtctRSqgtfOE7k=;
        h=Date:From:To:Cc:Subject:From;
        b=P2yqY/ctkbt5+O7vzW3DVobQ0dA29ObOvp/J7K6itKOJ3LaCo77SWFC9XT2wjxLYd
         Z3wpInvMRpp7jb/dd6EOqXTwYzJ9/ELeQQWi5Kawon7JEZ0p2Q+0FXVClSUZ17A3Rd
         Jj/+DHf+wnS740WEc6gM4EWSELi/13cvWILt+/PYzWqYxJyk+m+0u+SvT2LzQtJaZB
         YIDEwSs3GVeN2f7oFqfI5vtonIjZuoSTmQ7l3ywanezZ0kdUntjfCNVCFslkBl6ZSl
         amJ2vmPyxBwPBB50R2jnInj+OlJhjg4qOPdz7toVf/W+c0+c8usnDphKB2/uVOpE4P
         8tDrFKVImkUqQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Chdvj31Bmz6tmM;
        Thu, 26 Nov 2020 14:31:45 +0100 (CET)
Date:   Thu, 26 Nov 2020 14:31:43 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201126143143.06107cf4@monster.powergraphx.local>
In-Reply-To: <20201124145425.GB185852@builder.lan>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
        <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
        <20201122051900.GH807@yoga>
        <20201123191712.72484b19@monster.powergraphx.local>
        <20201124145425.GB185852@builder.lan>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 08:54:25 -0600
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:

> On Mon 23 Nov 12:17 CST 2020, Wilken Gottwalt wrote:
> 
> > On Sat, 21 Nov 2020 23:19:00 -0600
> > Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > > > +static int hwlocks_inuse_show(struct seq_file *seqf, void *unused)
> > > > +{
> > > > +	struct sunxi_hwspinlock_data *priv = seqf->private;
> > > > +	int inuse;
> > > > +
> > > > +	/* getting the status of only the main 32 spinlocks is supported */
> > > > +	inuse = hweight32(readl(priv->io_base + SPINLOCK_STATUS_REG));
> > > 
> > > So this returns how many of the locks are taken? How is that useful?
> > 
> > It is a way to see if locks were taken from linux or the arisc core without
> > touching the actual hwspinlock abi or the locks. So it is a nice way to debug
> > hwspinlocks, hence it is part of debugfs.
> > 
> 
> So in a scenario where two remote processors ping-pong the lock between
> them, this will always read 1 and you won't know why?

I know it is not perfect. I will change it to actually report which locks are
taken. And currently the crust firmware does not use the locks and on the
Linux side there are only a handful of driver/components using hwspinlocks,
and none of them are active in a kernel compiled for a H5. So it really is a
nice way to check/debug the hwspinlocks. I already have a simple test running
where crust sets a spinlock and I can see it on Linux without touching the
actuall locks thanks to this status register.

> > > > +	seq_printf(seqf, "%d\n", inuse);
> [..]
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static const struct of_device_id sunxi_hwspinlock_ids[] = {
> > > > +	{ .compatible = "allwinner,sun8i-hwspinlock", },
> > > > +	{ .compatible = "allwinner,sun50i-hwspinlock", },
> > > > +	{},
> > > > +};
> > > > +MODULE_DEVICE_TABLE(of, sunxi_hwspinlock_ids);
> > > > +
> > > > +static struct platform_driver sunxi_hwspinlock_driver = {
> > > > +	.probe	= sunxi_hwspinlock_probe,
> > > > +	.remove	= sunxi_hwspinlock_remove,
> > > > +	.driver	= {
> > > > +		.name		= DRIVER_NAME,
> > > > +		.of_match_table	= of_match_ptr(sunxi_hwspinlock_ids),
> > > 
> > > Please avoid of_match_ptr, as this will cause warnings about unused
> > > variables when COMPILE_TEST without OF.
> > 
> > So did you mean to leave it out completely?
> > 
> 
> Yes, "worst case" is that you include the reference to
> sunxi_hwspinlock_ids on a build without CONFIG_OF and wasting a little
> bit of memory.
> 
> Using of_match_ptr() with CONFIG_OF=n will result in NULL and as such
> we'll get a compile warning that nothing references sunxi_hwspinlock_ids
> - so then that will have to be marked __maybe_unused, or wrapped in an
> #if...
> 
> So better just leave it as:
> 	.of_match_table = sunxi_hwspinlock_ids,

Thank you for the explanation. I really like to know the details and reasons
behind this.

greetings,
Wilken

> Regards,
> Bjorn

