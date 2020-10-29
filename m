Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B335D29EDEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgJ2OJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:09:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgJ2OJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:09:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF82F2076B;
        Thu, 29 Oct 2020 14:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603980585;
        bh=TtwUVFFMG65oBFG7U1vALVcKONIwt0CrlaLqNEzbKoE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=iJ1u9s0abfgaRCyv9SyeMUvmqdIxY7ECdRh5+mF8LW2zNX5SL5jW3tM2tUBrvU01M
         lIQNNCDAjm1o/WVXseCu+QwqP3AaGdcN1oi5K7dyUjmO/9oy9VQoIqk/yRBM9zwwYs
         axPwxcQ6hh2h9qvnX7jtSfFXMJcPqGHt969QyoxU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5ADA23522778; Thu, 29 Oct 2020 07:09:45 -0700 (PDT)
Date:   Thu, 29 Oct 2020 07:09:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Qian Cai <cai@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201029140945.GK3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028182614.13655-1-cai@redhat.com>
 <20201029091045.GA29890@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029091045.GA29890@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 09:10:45AM +0000, Will Deacon wrote:
> On Wed, Oct 28, 2020 at 02:26:14PM -0400, Qian Cai wrote:
> > The call to rcu_cpu_starting() in secondary_start_kernel() is not early
> > enough in the CPU-hotplug onlining process, which results in lockdep
> > splats as follows:
> > 
> >  WARNING: suspicious RCU usage
> >  -----------------------------
> >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> > 
> >  other info that might help us debug this:
> > 
> >  RCU used illegally from offline CPU!
> >  rcu_scheduler_active = 1, debug_locks = 1
> >  no locks held by swapper/1/0.
> > 
> >  Call trace:
> >   dump_backtrace+0x0/0x3c8
> >   show_stack+0x14/0x60
> >   dump_stack+0x14c/0x1c4
> >   lockdep_rcu_suspicious+0x134/0x14c
> >   __lock_acquire+0x1c30/0x2600
> >   lock_acquire+0x274/0xc48
> >   _raw_spin_lock+0xc8/0x140
> >   vprintk_emit+0x90/0x3d0
> >   vprintk_default+0x34/0x40
> >   vprintk_func+0x378/0x590
> >   printk+0xa8/0xd4
> >   __cpuinfo_store_cpu+0x71c/0x868
> >   cpuinfo_store_cpu+0x2c/0xc8
> >   secondary_start_kernel+0x244/0x318
> > 
> > This is avoided by moving the call to rcu_cpu_starting up near the
> > beginning of the secondary_start_kernel() function.
> 
> Hmm, it's not really a move though -- we'll end up calling this thing twice
> afaict. It would be better to make sure we've called notify_cpu_starting()
> early enough. Can we do that instead?

It uses a per-CPU variable so that RCU pays attention only to the first
call to rcu_cpu_starting() if there is more than one of them.  This is
even intentional, due to there being a generic arch-independent call to
rcu_cpu_starting() in notify_cpu_starting().

So multiple calls to rcu_cpu_starting() are fine by design.

							Thanx, Paul
