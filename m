Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1F01F7E93
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 23:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgFLV4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 17:56:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbgFLV4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:56:51 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82F20206DC;
        Fri, 12 Jun 2020 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591999010;
        bh=mWMXi6xqoC2+eKZfze2WcCelGr8w6FXyOKbi5oEX2as=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A89F5YbzfyufclIGNaDWvLyh8iSo6b5hovTNFiZUqBJpsGz3YmoS7w6xOfYusMRS/
         SRYicMV62L9j+NhNJHd/4uia8P7y/oDvJTsnjuM7mRWDZtZrkEEFEhy08Hd2MjlUs1
         oSjTSce0+m45Dr/RGoffJyPyMnk2El/1r7ySNGzM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 69EBD3522658; Fri, 12 Jun 2020 14:56:50 -0700 (PDT)
Date:   Fri, 12 Jun 2020 14:56:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org,
        Andrew Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH x86/entry: Force rcu_irq_enter() when in idle task
Message-ID: <20200612215650.GN4455@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87r1ukxf1b.fsf@nanos.tec.linutronix.de>
 <87k10ccc2n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k10ccc2n.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:34:56PM +0200, Thomas Gleixner wrote:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > "Paul E. McKenney" <paulmck@kernel.org> writes:
> >> On Fri, Jun 12, 2020 at 10:49:53AM -0700, Paul E. McKenney wrote:
> >>> I will therefore address this issue in a follow-on patch.
> >>
> >> I should add that -your- patch from yesterday did -not- cause this
> >> problem, in case that is of interest.
> >
> > So I still can add it back and amend the changelog and comment:
> >
> > Change the condition from !rcu_is_watching() to is_idle_task(current) ||
> > rcu_is_watching() which enforces that interrupts in the idle task
> > unconditionally invoke rcu_irq_enter() independent of the RCU state. For
> > most scenarios is_idle_task() would be sufficient but Task RCU needs it
> > according to Paul.
> 
> After talking to Paul some more we came to the conclusion that the
> failure scenario of task rcu is not completely clear and the trigger
> scenario is obscure enough. This needs more investigation and the
> important part which we were chasing is fixed and agreed on. So I go
> with the simple version now and Paul will follow up once it can be
> properly explained.

So the whole TASKS03 failure issue turned out to be me applying the
wrong patches onto the wrong commits.  Retesting with -tip x86/entry
passes TASKS03, as in more than 100 instances of it.

I am rerunning the whole stack, but I don't see the need to wait for
that.  (I will be running increasingly long tests over Friday night,
Pacific Time.)

							Thanx, Paul
