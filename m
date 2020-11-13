Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4272B1EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKMPog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:44:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgKMPog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:44:36 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C938208D5;
        Fri, 13 Nov 2020 15:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605282275;
        bh=YAtBc4MUlT4iGCD181Uk2lkllpywEN1Hvihtl42VM1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bQ9L4Mk32dLgKwQAiBqqqlfdnU/rK82ar1rbPrAh/FNQoXtsoSAs+SVOoIAKIqYrO
         ogH+0IYUAZ1O7W/oyKQbReOkP1uez2pCh8v4ZC1TRS4S5BH2UnbemDvWIPzgz3K1Qv
         kyoFnv2jb7rYhMXkLNoY3n/Nem0RBQpBmJwCUv9E=
Date:   Fri, 13 Nov 2020 16:45:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: [PATCH v13 3/3] binder: add transaction latency tracer
Message-ID: <X66qHEUxUTcaqLkz@kroah.com>
References: <X6quBb28IVvyRhox@kroah.com>
 <1605063764-12930-1-git-send-email-Frankie.Chang@mediatek.com>
 <1605063764-12930-4-git-send-email-Frankie.Chang@mediatek.com>
 <X6uT941IJ3uf/7aE@kroah.com>
 <1605106986.11768.14.camel@mtkswgap22>
 <X6v/VAffVOOy56bG@kroah.com>
 <1605110345.11768.39.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605110345.11768.39.camel@mtkswgap22>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:59:05PM +0800, Frankie Chang wrote:
> On Wed, 2020-11-11 at 16:12 +0100, Greg Kroah-Hartman wrote:
> > On Wed, Nov 11, 2020 at 11:03:06PM +0800, Frankie Chang wrote:
> > > On Wed, 2020-11-11 at 08:34 +0100, Greg Kroah-Hartman wrote:
> > > > > - The reason why printing the related information to
> > > > >   kernel information log but not trace buffer is that
> > > > >   some abnormal transactions may be pending for a long
> > > > >   time ago, they could not be recorded due to buffer
> > > > >   limited.
> > > > 
> > > > Don't abuse the kernel information log for stuff that is just normal
> > > > operations.  What is wrong with using the trace buffers here?  That's
> > > > what they are designed for from what I can tell.
> > > > 
> > > As mentioned before, time limitation of recording is the reason why we
> > > don't just use trace here.
> > 
> > What limitation?
> > 
> > > In some long time stability test, such as MTBF,
> > 
> > What is "MTBF"?
> > 
> Mean time between failures (MTBF) is the predicted elapsed time between
> inherent failures of a mechanical or electronic system, during normal
> system operation. 
> 
> And we use MTBF script to run long time stress test to
> make sure our product stability is no problem.

Ok, great.

> > > the exception is caused by a series of transactions interaction.
> > > Some abnormal transactions may be pending for a long time ago, they 
> > > could not be recorded due to buffer limited.
> > 
> > How long of a time is this?  If they are pending, only when the timeout
> > happens is the trace logged, right?
> > 
> > Again, please do not abuse the kernel log for this, that is not what it
> > is for.
> > 
> Hmm..Do you mean that make timeout log print to trace buffer but not
> kernel log? 

Yes.

> The reason We don't do this is that we need to enable these trace events
> and enable trace everytimes before testing. But our testing script could
> lead to device reboot, and then it continue testing after reboot. The
> reboot would make these trace events disable, and we cannot get the
> timeout log which happen after reboot.

When you reboot you enable tracing, that's not an issue, and then you
will see the messages.  Nothing is going to work across reboots.

> > > > > +config BINDER_TRANSACTION_LATENCY_TRACKING
> > > > > +	tristate "Android Binder transaction tracking"
> > > > > +	help
> > > > > +	  Used for track abnormal binder transaction which is over threshold,
> > > > > +	  when the transaction is done or be free, this transaction would be
> > > > > +	  checked whether it executed overtime.
> > > > > +	  If yes, printing out the detailed info.
> > > > 
> > > > Why is this a separate module?  Who will ever want this split out?
> > > > 
> > > The reason we split out a separate module is that we adopted the
> > > previously discussed recommendations in PATCH v1.
> > > 
> > > This way all of this tracing code is in-kernel but outside of binder.c.
> > 
> > Putting it in a single file is fine, but what does this benifit doing it
> > in a separate file?  Doesn't it waste more codespace this way?
> > 
> Yeah, but I think separate file may be more manageable.

Sorry, I mean, "why put this in a separate kernel module", not file.
File is fine.

> > > > > +/*
> > > > > + * The reason setting the binder_txn_latency_threshold to 2 sec
> > > > > + * is that most of timeout abort is greater or equal to 2 sec.
> > > > > + * Making it configurable to let all users determine which
> > > > > + * threshold is more suitable.
> > > > > + */
> > > > > +static uint32_t binder_txn_latency_threshold = 2;
> > > > > +module_param_named(threshold, binder_txn_latency_threshold,
> > > > > +			uint, 0644);
> > > > 
> > > > Again, this isn't the 1990's, please do not add module parameters if at
> > > > all possible.
> > > > 
> > > 
> > > Is any recommended method here?
> > > Because we refer to the method in binder.c, we don't know if this method
> > > is not suitable.
> > 
> > Look at the individual binder instances.  That is what trace should be
> > on/off for, not for all binder instances in the system at the same time.
> > 
> But our testing script is not for specific binder instances, it includes
> several testing and tests for several processes.

Then turn it on for all binder instances.

> So the reason we trace for all binder instances is that we cannot
> predict which process would happen timeout transaction.

That's fine, but provide the ability to do this on a per-instance, as
that is what binder now supports.  To make it "global" is a big
regression from the way it was changed recently to support different
instances.

thanks,

greg k-h
