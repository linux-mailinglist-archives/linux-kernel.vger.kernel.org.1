Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81AAC29A7C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509889AbgJ0J0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:26:12 -0400
Received: from casper.infradead.org ([90.155.50.34]:35536 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408154AbgJ0J0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yDef0E0ogyumLmwur5x/EcaGFcvkhEhAdEIyOx5drxw=; b=oh+afw45nKJhGAxhCkE1Io5JaB
        bwEL31fHPHEV1IATRu9i8Brtcghq3XNFR3eGH0nlXyJeot/sQifCmu8ZOtKvNdCow9ip64Qz67PXY
        DykwhhsrEbAQ/kNbHNe2mWcORhf3NE0DTaTUkcNOvck1CcbJOP0JViHFj0+YlwVLN5FZlhCc/lt9y
        LPzi6GLoRz6eBLgCV+suyi+p8EBBTX005Ji4CL3DVsMyCepRe7xaWYRj0rdWzx8m4YV2qucPMaYyu
        8L6lZA2c0NklC3PbSeUXfAUok/j8SXVIZdqrvfw5A35UlxV7NZRpVPKVYJlx1XbO2gEG3QFVuRFl9
        0TgfBfBQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXLF0-0005eo-8Y; Tue, 27 Oct 2020 09:26:06 +0000
Date:   Tue, 27 Oct 2020 09:26:06 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Runge <dave@sleepmap.de>, linux-rt-users@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH RFC] blk-mq: Don't IPI requests on PREEMPT_RT
Message-ID: <20201027092606.GA20805@infradead.org>
References: <20201021175059.GA4989@hmbx>
 <20201023110400.bx3uzsb7xy5jtsea@linutronix.de>
 <20201023112130.GA23790@infradead.org>
 <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201023135219.mzzl76eqqy6tqwhe@linutronix.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 03:52:19PM +0200, Sebastian Andrzej Siewior wrote:
> On 2020-10-23 12:21:30 [+0100], Christoph Hellwig wrote:
> > > -	if (!IS_ENABLED(CONFIG_SMP) ||
> > > +	if (!IS_ENABLED(CONFIG_SMP) || IS_ENABLED(CONFIG_PREEMPT_RT) ||
> > >  	    !test_bit(QUEUE_FLAG_SAME_COMP, &rq->q->queue_flags))
> > 
> > This needs a big fat comment explaining your rationale.  And probably
> > a separate if statement to make it obvious as well.
> 
> Okay.
> How much difference does it make between completing in-softirq vs
> in-IPI?

For normal non-RT builds?  This introduces another context switch, which
for the latencies we are aiming for is noticable.

> I'm asking because acquiring a spinlock_t in an IPI shouldn't be
> done (as per Documentation/locking/locktypes.rst). We don't have
> anything in lockdep that will complain here on !RT and we the above we
> avoid the case on RT.

At least for NVMe we aren't taking locks, but with the number of drivers
