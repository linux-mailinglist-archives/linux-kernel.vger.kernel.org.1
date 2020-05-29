Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463461E8B6A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 May 2020 00:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgE2Wg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 18:36:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59096 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgE2WgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 18:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uLG47Mpo1MtU06H8naVZ7P5E2DCID3fGpuS5yrZPyog=; b=iyGPDrgp0t+Y2yH2ZgyuLSziPN
        Rj1T8Aoa5vutvrpUHB/WxFFEA4CYuQynOSlY/sNIT9sgNJP0VQxsh0/N5kAILovVR5XAfw3CggK4w
        dbNDBLl/mzEr7hWR4sjg8uEBsz3VL7DbTlRRdX0hISeWhn419pwNB68Uk2P9jaWqSJcVy1fI92kg7
        MyfcrNDkV5yzfOtMisXJPEQFrRNPko1RGMT6KMFulugjCaarnizqVxBH1+V6YShBVq6KTMAibaa7a
        djenN2MCEP37wJAqbN1Z5ppUpCa1Wyy/uYbegeig8Ex9LQ1ykbKEFWOjtgH3WZeL7mziYYiY5ZiwV
        7enRKlvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jenZc-0008M8-OD; Fri, 29 May 2020 22:33:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 354BF9834CF; Sat, 30 May 2020 00:33:54 +0200 (CEST)
Date:   Sat, 30 May 2020 00:33:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, luto@amacapital.net,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        sean.j.christopherson@intel.com, andrew.cooper3@citrix.com,
        daniel.thompson@linaro.org, a.darwish@linutronix.de,
        bigeasy@linutronix.de
Subject: Re: [PATCH 13/14] lockdep: Prepare for NMI IRQ state tracking
Message-ID: <20200529223354.GX2483@worktop.programming.kicks-ass.net>
References: <20200529212728.795169701@infradead.org>
 <20200529213321.471984676@infradead.org>
 <20200529181401.1f01bdc5@oasis.local.home>
 <20200529222505.GW2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529222505.GW2483@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 12:25:05AM +0200, Peter Zijlstra wrote:
> On Fri, May 29, 2020 at 06:14:01PM -0400, Steven Rostedt wrote:
> > On Fri, 29 May 2020 23:27:41 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > There is no reason not to always, accurately, track IRQ state.
> > > 
> > > This change also makes IRQ state tracking ignore lockdep_off().
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/locking/lockdep.c |   33 ++++++++++++++++++++++++++++++---
> > >  1 file changed, 30 insertions(+), 3 deletions(-)
> > > 
> > > --- a/kernel/locking/lockdep.c
> > > +++ b/kernel/locking/lockdep.c
> > > @@ -3646,7 +3646,13 @@ static void __trace_hardirqs_on_caller(v
> > >   */
> > >  void lockdep_hardirqs_on_prepare(unsigned long ip)
> > >  {
> > > -	if (unlikely(!debug_locks || current->lockdep_recursion))
> > 
> > Why remove the check for debug_locks? Isn't that there to disable
> > everything at once to prevent more warnings to be printed?
> 
> Yeah, maybe. I was thinking we could keep IRQ state running. But you're
> right, if we mess up the IRQ state itself this might generate a wee
> mess.

That is, mostly the IRQ state recovers when we mess up. It's only when
we then trigger more fail that we crash and burn, and that will likely
already give more warnings.

But I can put the debug_locks check back.
