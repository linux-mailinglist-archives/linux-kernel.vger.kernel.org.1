Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1932A0F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 21:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbgJ3UWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 16:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726061AbgJ3UWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 16:22:53 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B9620727;
        Fri, 30 Oct 2020 20:22:51 +0000 (UTC)
Date:   Fri, 30 Oct 2020 16:22:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jesper Dangaard Brouer <brouer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kan.liang@linux.intel.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com
Subject: Re: [PATCH 4/6] perf: Optimize get_recursion_context()
Message-ID: <20201030162248.58e388f0@oasis.local.home>
In-Reply-To: <20201030181138.215b2b6a@carbon>
References: <20201030151345.540479897@infradead.org>
        <20201030151955.187580298@infradead.org>
        <20201030181138.215b2b6a@carbon>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Oct 2020 18:11:38 +0100
Jesper Dangaard Brouer <brouer@redhat.com> wrote:

> On Fri, 30 Oct 2020 16:13:49 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> >   "Look ma, no branches!"
> > 
> > Cc: Jesper Dangaard Brouer <brouer@redhat.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---  
> 
> Cool trick! :-)
> 
> Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
> 
> >  kernel/events/internal.h |   17 ++++++++---------
> >  1 file changed, 8 insertions(+), 9 deletions(-)
> > 
> > --- a/kernel/events/internal.h
> > +++ b/kernel/events/internal.h
> > @@ -205,16 +205,15 @@ DEFINE_OUTPUT_COPY(__output_copy_user, a
> >  
> >  static inline int get_recursion_context(int *recursion)
> >  {
> > -	int rctx;
> > +	unsigned int pc = preempt_count();
> > +	unsigned int rctx = 0;
> >  
> > -	if (unlikely(in_nmi()))
> > -		rctx = 3;
> > -	else if (in_irq())
> > -		rctx = 2;
> > -	else if (in_serving_softirq())
> > -		rctx = 1;
> > -	else
> > -		rctx = 0;
> > +	if (pc & (NMI_MASK))
> > +		rctx++;
> > +	if (pc & (NMI_MASK | HARDIRQ_MASK))
> > +		rctx++;
> > +	if (pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET))
> > +		rctx++;
> >  
> >  	if (recursion[rctx])
> >  		return -1;
> > 
> > 

As this is something that ftrace recursion also does, perhaps we should
move this into interrupt.h so that anyone that needs a counter can get
it quickly, and not keep re-implementing it.

/*
 * Quickly find what context you are in.
 * 0 - normal
 * 1 - softirq
 * 2 - hard interrupt
 * 3 - NMI
 */
static inline int irq_context()
{
	unsigned int pc = preempt_count();
	int rctx = 0;

	if (pc & (NMI_MASK))
		rctx++;
	if (pc & (NMI_MASK | HARDIRQ_MASK))
		rctx++;
	if (pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET))
		rctx++;

	return rctx;
}

-- Steve
