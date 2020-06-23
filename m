Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60FB2059F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 19:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733269AbgFWRup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 13:50:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732549AbgFWRuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:50:44 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E066D20702;
        Tue, 23 Jun 2020 17:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592934643;
        bh=aC9nDIw7h5eOvJ/MlaX9rImXQ5Z3f0gnp4b0KHObKV8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=pAvDh8vHVKSWHd/UvEqw+tojQfTyoMmsAzIr8uDJ2qTHBeike0xoDUpGQecd7eReg
         +dJm4Vb621QKF6OtFQRExVIqrG1NxSsU30RuOPySlWgLrB335SHSPHCBzFdpvq8BZ7
         Wv4jKsUIR2tPPwZZxKvND8l5Oh+Tl3wE0i0dLuhk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C94643522657; Tue, 23 Jun 2020 10:50:43 -0700 (PDT)
Date:   Tue, 23 Jun 2020 10:50:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, rostedt@goodmis.org, dhowells@redhat.com,
        edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
        joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 16/26] rcu: Mark rcu_nmi_enter() call to
 rcu_cleanup_after_idle() noinstr
Message-ID: <20200623175043.GQ9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200623002128.GA25456@paulmck-ThinkPad-P72>
 <20200623002147.25750-16-paulmck@kernel.org>
 <20200623170425.GR4817@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623170425.GR4817@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 07:04:25PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 22, 2020 at 05:21:37PM -0700, paulmck@kernel.org wrote:
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > The objtool complains about the call to rcu_cleanup_after_idle() from
> > rcu_nmi_enter(), so this commit adds instrumentation_begin() before that
> > call and instrumentation_end() after it.
> 
> Hmm, I've not seen this one. Still,

I am still based off of v5.8-rc1, so I might be missing some commits.
Not seeing any that would affect this, but that doesn't mean that
there aren't any.  ;-)

> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I will apply this on my next rebase, thank you!

							Thanx, Paul

> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tree.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 08e3648..67912ad 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -980,8 +980,11 @@ noinstr void rcu_nmi_enter(void)
> >  		rcu_dynticks_eqs_exit();
> >  		// ... but is watching here.
> >  
> > -		if (!in_nmi())
> > +		if (!in_nmi()) {
> > +			instrumentation_begin();
> >  			rcu_cleanup_after_idle();
> > +			instrumentation_end();
> > +		}
> >  
> >  		incby = 1;
> >  	} else if (!in_nmi()) {
> > -- 
> > 2.9.5
> > 
