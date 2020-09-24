Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7047277C31
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 01:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgIXXKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 19:10:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:42566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgIXXKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 19:10:51 -0400
Received: from localhost (lfbn-ncy-1-588-162.w81-51.abo.wanadoo.fr [81.51.203.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE83207FB;
        Thu, 24 Sep 2020 23:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600989051;
        bh=k7HlL1eolWqQK5DvcGOA0sV0tdXDjjYHruV19LRwoTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELhm/5ZCh+lPslLk//JEuimuuC3HffxRwed0XCSXaJkiUabB3urRCDJDik6e/2bgJ
         9vS2d9d/titgu6EM9c2NU7D8fWFv4WfboExBuGr/gnVGLto4FBLucnflxkPezXJ3cw
         j5SOoU/5nh1ZucUD7t2tnkZOyja1fQV+yVxUHJqg=
Date:   Fri, 25 Sep 2020 01:10:48 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        laoar.shao@gmail.com, qais.yousef@arm.com, urezki@gmail.com
Subject: Re: [PATCH V7 4/4] softirq: Allow early break the softirq processing
 loop
Message-ID: <20200924231048.GD19346@lenoir>
References: <20200915115609.85106-1-qianjun.kernel@gmail.com>
 <20200915115609.85106-5-qianjun.kernel@gmail.com>
 <878scz89tl.fsf@nanos.tec.linutronix.de>
 <20200924230811.GC19346@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924230811.GC19346@lenoir>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 01:08:11AM +0200, Frederic Weisbecker wrote:
> On Thu, Sep 24, 2020 at 05:37:42PM +0200, Thomas Gleixner wrote:
> > Subject: softirq; Prevent starvation of higher softirq vectors
> > From: Thomas Gleixner <tglx@linutronix.de>
> > Date: Thu, 24 Sep 2020 10:40:24 +0200
> > 
> > From: Thomas Gleixner <tglx@linutronix.de>
> > 
> > The early termination of the softirq processing loop can lead to starvation
> > of the higher numbered soft interrupt vectors because each run starts at
> > the lowest bit. If the loop terminates then the already processed bits can
> > be raised again before the next loop starts. If these lower bits run into
> > the termination again, then a re-raise might starve the higher bits forever.
> > 
> > To prevent this, store the leftovers of the previous run in the upper 16
> > bit of the local softirq_pending storage and ensure that these are
> > processed before any newly raised bits are handled.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/softirq.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 50 insertions(+), 8 deletions(-)
> > 
> > --- a/kernel/softirq.c
> > +++ b/kernel/softirq.c
> > @@ -259,11 +259,23 @@ static inline bool __softirq_needs_break
> >  	return need_resched() || __softirq_timeout(tbreak);
> >  }
> >  
> > +/*
> > + * local_softirq_pending() is split into two 16 bit words. The low word
> > + * contains the bits set by raise_softirq(), the high word contains pending
> > + * bits which have not been processed in an early terminated run. This is
> > + * required to prevent starvation of the higher numbered softirqs.
> > + */
> > +#define SIRQ_PREV_SHIFT		16
> 
> Note that in the case of x86, irq_start.__softirq_pending is a u16.

irq_stat even
