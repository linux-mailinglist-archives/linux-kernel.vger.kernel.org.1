Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F3029D97D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389821AbgJ1Wzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:55:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50342 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731789AbgJ1Wxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=f2XUd9q63Shpn8ECuQrksUMR0DROrEu1ijIel4+9FnQ=; b=seEto5hPizgDdrB9OUOxoOOLmR
        +CqxCzgTBy/UrV7q7GISf2SM8Nb60I+sULvS5RMghKDO8O5CUaqjJp4wydKPcznAzxZdAemxIzPAn
        BlcoZhFmbGkM79LkH4Ojf13Nk2wVAKycWT1AzoL/h82Fp+sxbkAQBPbZH/2xnlUA6v/Zge/RHzLgU
        31gcCK5/BZBNdG+MMy0egcGhF5pTHheV7jDND+rwN+ToMjKjUzTav/9Q1MS4m3/D2A0eehh9Fj1b/
        vnkphp2ITon/DWDT/zydoTHQrf30JU8y9Yo65kr7CgEsQqueI58/w3rTHCR7/YOyULQPwA1yeQeYZ
        4kcxpcFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXmaq-0004nh-Dc; Wed, 28 Oct 2020 14:38:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6DE2B3006D0;
        Wed, 28 Oct 2020 15:38:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21AD6203D0A43; Wed, 28 Oct 2020 15:38:26 +0100 (CET)
Date:   Wed, 28 Oct 2020 15:38:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, will@kernel.org,
        paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com, vincent.guittot@linaro.org
Subject: Re: [PATCH v3 5/6] irq_work: Provide irq_work_queue_remote()
Message-ID: <20201028143826.GB2628@hirez.programming.kicks-ass.net>
References: <20201028110707.971887448@infradead.org>
 <20201028111221.526249871@infradead.org>
 <20201028134046.GE229044@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201028134046.GE229044@lothringen>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 02:40:46PM +0100, Frederic Weisbecker wrote:
> On Wed, Oct 28, 2020 at 12:07:12PM +0100, Peter Zijlstra wrote:
> > While the traditional irq_work relies on the ability to self-IPI, it
> > makes sense to provide an unconditional irq_work_queue_remote()
> > interface.
> 
> We may need a reason as well here.

Well, it doesn't rely on arch self-IPI code. The remote irq_work bits
are generic SMP code.

> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -1308,13 +1308,14 @@ static int rcu_implicit_dynticks_qs(stru
> >  			resched_cpu(rdp->cpu);
> >  			WRITE_ONCE(rdp->last_fqs_resched, jiffies);
> >  		}
> > -		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
> > -		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> > +#ifdef CONFIG_IRQ_WORK
> > +		if (!rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
> 
> If it's unconditional on SMP, I expect it to be unconditional on rcutree.
> 
> Also this chunk seems unrelated to this patch.

This hunk is due to irq_work_queue_on() no longer existing for
CONFIG_IRQ_WORK and hence breaking the compile with that IS_ENABLED()
crud.

That is, this changes IS_ENABLED() for a proper #ifdef.

> >  		    (rnp->ffmask & rdp->grpmask)) {
> >  			rdp->rcu_iw_pending = true;
> >  			rdp->rcu_iw_gp_seq = rnp->gp_seq;
> >  			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
> >  		}
> > +#endif
> >  	}
> >  
> >  	return 0;
> > 
> > 
