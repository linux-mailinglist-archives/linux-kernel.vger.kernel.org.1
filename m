Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8382A8AB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732192AbgKEX2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:28:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:41476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbgKEX2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:28:14 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B2FD20704;
        Thu,  5 Nov 2020 23:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604618893;
        bh=uW+s9tk8sFCHpIi1ccM7lmNw5WWhWb4a2EYXNp87zEM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=rA6UeTi7wirfhxjAkj1CmQNLIOBtEWWKe2kidYVtIWNkUdVfmQzDMsM14sljW8/cz
         JvyABj0PmLNKek5rqbJRUUuIrSOFFxzYlvyn+4fb1fDLGsJJxHx5I1SqOzz7v5Bn4g
         m6RLj6ykMVGcvKrtmWUMbK0nHRZRmnInrGHF7hoY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4D0AD3522A76; Thu,  5 Nov 2020 15:28:13 -0800 (PST)
Date:   Thu, 5 Nov 2020 15:28:13 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Qian Cai <cai@redhat.com>
Cc:     Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/smp: Move rcu_cpu_starting() earlier
Message-ID: <20201105232813.GR3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201028182614.13655-1-cai@redhat.com>
 <160404559895.1777248.8248643695413627642.b4-ty@kernel.org>
 <20201105222242.GA8842@willie-the-truck>
 <3b4c324abdabd12d7bd5346c18411e667afe6a55.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b4c324abdabd12d7bd5346c18411e667afe6a55.camel@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 06:02:49PM -0500, Qian Cai wrote:
> On Thu, 2020-11-05 at 22:22 +0000, Will Deacon wrote:
> > On Fri, Oct 30, 2020 at 04:33:25PM +0000, Will Deacon wrote:
> > > On Wed, 28 Oct 2020 14:26:14 -0400, Qian Cai wrote:
> > > > The call to rcu_cpu_starting() in secondary_start_kernel() is not early
> > > > enough in the CPU-hotplug onlining process, which results in lockdep
> > > > splats as follows:
> > > > 
> > > >  WARNING: suspicious RCU usage
> > > >  -----------------------------
> > > >  kernel/locking/lockdep.c:3497 RCU-list traversed in non-reader section!!
> > > > 
> > > > [...]
> > > 
> > > Applied to arm64 (for-next/fixes), thanks!
> > > 
> > > [1/1] arm64/smp: Move rcu_cpu_starting() earlier
> > >       https://git.kernel.org/arm64/c/ce3d31ad3cac
> > 
> > Hmm, this patch has caused a regression in the case that we fail to
> > online a CPU because it has incompatible CPU features and so we park it
> > in cpu_die_early(). We now get an endless spew of RCU stalls because the
> > core will never come online, but is being tracked by RCU. So I'm tempted
> > to revert this and live with the lockdep warning while we figure out a
> > proper fix.
> > 
> > What's the correct say to undo rcu_cpu_starting(), given that we cannot
> > invoke the full hotplug machinery here? Is it correct to call
> > rcutree_dying_cpu() on the bad CPU and then rcutree_dead_cpu() from the
> > CPU doing cpu_up(), or should we do something else?
> It looks to me that rcu_report_dead() does the opposite of rcu_cpu_starting(),
> so lift rcu_report_dead() out of CONFIG_HOTPLUG_CPU and use it there to rewind,
> Paul?

Yes, rcu_report_dead() should do the trick.  Presumably the earlier
online-time CPU-hotplug notifiers are also unwound?

							Thanx, Paul
