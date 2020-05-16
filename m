Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BCE1D62E4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgEPRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 May 2020 13:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:44436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgEPRMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 13:12:24 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2092065C;
        Sat, 16 May 2020 17:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589649143;
        bh=7BUjCabPx6WoCwcfAvKuiYbT/eq0evFo0tCNOJ2KFsM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JJk+NRs1XPcDLScVdcaOk7kheXGKiId/Gke6W0uGSSBCrwAHJM2Ty1N8rpgRzRUdk
         gG8Tyu0OhI5somHQWbjFl4ilsWabZ0//10pCHq3/aITEPfm67l3PkbJskG1QMXAcm6
         6vDmsyDosxt02PzG80CidglZdIUlA2myPiFUQ7os=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 37F4C3522CED; Sat, 16 May 2020 10:12:23 -0700 (PDT)
Date:   Sat, 16 May 2020 10:12:23 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>, frextrite@gmail.com,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, kernel-team@android.com,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        madhuparnabhowmik04@gmail.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        peterz@infradead.org, Petr Mladek <pmladek@suse.com>,
        rcu@vger.kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        vpillai@digitalocean.com
Subject: Re: [PATCH v3 0/5] RCU dyntick nesting counter cleanups for rcu -dev
Message-ID: <20200516171223.GC2639@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200504120505.89351-1-joel@joelfernandes.org>
 <20200504171532.GR2869@paulmck-ThinkPad-P72>
 <20200504174413.GA8883@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504174413.GA8883@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 10:44:13AM -0700, Paul E. McKenney wrote:
> On Mon, May 04, 2020 at 10:15:32AM -0700, Paul E. McKenney wrote:
> > On Mon, May 04, 2020 at 08:05:00AM -0400, Joel Fernandes (Google) wrote:
> > > These patches clean up the usage of dynticks nesting counters simplifying the
> > > code, while preserving the usecases.
> > > 
> > > It is a much needed simplification, makes the code less confusing, and prevents
> > > future bugs such as those that arise from forgetting that the
> > > dynticks_nmi_nesting counter is not a simple counter and can be "crowbarred" in
> > > common situations.
> > > 
> > > rcutorture testing with all TREE RCU configurations succeed with
> > > CONFIG_RCU_EQS_DEBUG=y and CONFIG_PROVE_LOCKING=y.
> > > 
> > > v1->v2:
> > > - Rebase on v5.6-rc6
> > > 
> > > v2->v3:
> > > - Rebase on rcu/dev with adjustments for tasks-RCU.
> > 
> > Thank you!
> > 
> > But this does not apply to any of v5.6-rc6, v5.7-rc1, or v5.7-rc2.
> > 
> > Where should I be trying to apply it?
> 
> OK, morning blindness overcome.  I new see the "rcu/dev" in v2->v3.
> 
> Please accept my apologies for the noise.

And I have allegedly resolved the conflicts with Thomas's and Peter's
series, or at least the noinstr-rcu-nmi-2020-05-15 branch of that series.
At least one conflict was completely invisible to "git rebase" (but
fortunately blindingly obvious to the compiler).  This naturally makes
me suspect that additional adjustments might be needed.  Especially
given that misplaced instrumentation_begin() and instrumentation_end()
calls are invisible not only to the compiler, but also to rcutorture in
my setup.  (For example, tracing before instrumentation_begin() or after
instrumentation_end() is a bug.)

So could you please carefully check these commits?  They are now on the
-rcu tree's "dev" branch.

							Thanx, Paul
