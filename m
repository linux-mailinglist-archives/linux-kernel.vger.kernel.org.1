Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AB5288FAC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390008AbgJIRNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:13:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732753AbgJIRNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:13:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F1922258;
        Fri,  9 Oct 2020 17:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602263593;
        bh=4a881GWhYctg74klNYFEJzfqbs/OhN00Lm0M2bpy6EQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YMpN38EUy6mSNQb69vl8dNKOYvWEFhm4BaLKLNtpPfus9yhWxFB+mu0MHRQzkrDlo
         gyexH1xAPWwLq5q7nO8UZoqoEKMq3iRo3SNMtyHOzbUqCX95GZ1RgGO7NvECM0boZs
         EkiqIOfFBzvIyBwhWXVEwd07WOAvZMvNglTXX9Pw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 8BCFE35227D5; Fri,  9 Oct 2020 10:13:13 -0700 (PDT)
Date:   Fri, 9 Oct 2020 10:13:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, urezki@gmail.com, lkp@intel.com,
        julia.lawall@inria.fr, mhocko@kernel.org,
        mgorman@techsingularity.net, vbabka@suse.cz, peterz@infradead.org,
        torvalds@linux-foundation.org
Subject: Re: [GIT PULL tip/core/rcu+preempt] Fix RT raw/non-raw lock ordering
Message-ID: <20201009171313.GI29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201001210750.GA25287@paulmck-ThinkPad-P72>
 <20201009165500.GA2904859@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009165500.GA2904859@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 06:55:00PM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > Hello!
> > 
> > This pull request contains Thomas Gleixner's "Make preempt count
> > unconditional" series [1], but with the addition of a kvfree_rcu() bug-fix
> > commit making use of this PREEMPT_COUNT addition.  This series reduces
> > the size of the kernel by almost 100 lines of code and is intended for
> > the upcoming v5.10 merge window.
> 
> > Thomas Gleixner (13):
> >       lib/debug: Remove pointless ARCH_NO_PREEMPT dependencies
> >       preempt: Make preempt count unconditional
> >       preempt: Cleanup PREEMPT_COUNT leftovers
> >       lockdep: Cleanup PREEMPT_COUNT leftovers
> >       mm/pagemap: Cleanup PREEMPT_COUNT leftovers
> >       locking/bitspinlock: Cleanup PREEMPT_COUNT leftovers
> >       uaccess: Cleanup PREEMPT_COUNT leftovers
> >       sched: Cleanup PREEMPT_COUNT leftovers
> >       ARM: Cleanup PREEMPT_COUNT leftovers
> >       xtensa: Cleanup PREEMPT_COUNT leftovers
> >       drm/i915: Cleanup PREEMPT_COUNT leftovers
> >       rcutorture: Cleanup PREEMPT_COUNT leftovers
> >       preempt: Remove PREEMPT_COUNT from Kconfig
> > 
> > Uladzislau Rezki (Sony) (1):
> >       rcu/tree: Allocate a page when caller is preemptible
> > 
> > kernel test robot (1):
> >       kvfree_rcu(): Fix ifnullfree.cocci warnings
> 
> >  21 files changed, 44 insertions(+), 136 deletions(-)
> 
> Pulled into tip:core/rcu, thanks a lot guys!

Thank you, Ingo!!!

							Thanx, Paul
