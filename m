Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69A4277C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 01:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgIXXmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 19:42:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgIXXmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 19:42:13 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19498221E2;
        Thu, 24 Sep 2020 23:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600990933;
        bh=nVwlUINslmbvoUxZeVlG6ZOgSAlwrMDJvgGSwWJ8/eA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BO8hRjQiuqzo++6iXUy3KqHgYvCW/Noj0T+rgLomBrRExK78IwT/thRRPsoF4xjT6
         rAn/gGvSk/KrEJWZcLtfIRuymASYhbxYWvxw9ng6igMenj6svdksx62v+zjEbhKk4o
         Y3iA3QC8Y2zUI48cxeUTnrqtyqUcNzqFpYvvHUb0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D9A4435230AC; Thu, 24 Sep 2020 16:42:12 -0700 (PDT)
Date:   Thu, 24 Sep 2020 16:42:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH v6 0/4] Add support for length of each segment in the
 segcblist
Message-ID: <20200924234212.GZ29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200923152211.2403352-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923152211.2403352-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 11:22:07AM -0400, Joel Fernandes (Google) wrote:
> 
> This is required for several usecases identified. One of them being tracing how
> the segmented callback list changes. Tracing this has identified issues in RCU
> code in the past.
> 
> >From Paul:
> Another use case is of course more accurately determining whether a given CPU's
> large pile of callbacks can be best served by making grace periods go faster,
> invoking callbacks more vigorously, or both.  It should also be possible to
> simplify some of the callback handling a bit, given that some of the unnatural
> acts are due to there having been no per-batch counts.
> 
> Revision history:
> v6: Fixed TREE04, and restored older logic to ensure rcu_barrier works.
> 
> v5: Various changes, bug fixes. Discovery of rcu_barrier issue.
> 
> v4: Restructured rcu_do_batch() and segcblist merging to avoid issues.
>     Fixed minor nit from Davidlohr.
> v1->v3: minor nits.
> (https://lore.kernel.org/lkml/20200719034210.2382053-1-joel@joelfernandes.org/)

Looking much improved, thank you!

I have placed these on branch rcu/test in -rcu for testing and inspection.
I had to apply them at b94e6291a208 ("torture: Force weak-hashed pointers
on console log") and cherry-pick them onto the "dev" branch, but it looks
like things worked nicely.

							Thanx, Paul

> Joel Fernandes (Google) (4):
> rcu/tree: Make rcu_do_batch count how many callbacks were executed
> rcu/segcblist: Add counters to segcblist datastructure
> rcu/trace: Add tracing for how segcb list changes
> rcu/segcblist: Remove useless rcupdate.h include
> 
> include/linux/rcu_segcblist.h |   2 +
> include/trace/events/rcu.h    |  25 ++++++
> kernel/rcu/rcu_segcblist.c    | 161 +++++++++++++++++++++++++---------
> kernel/rcu/rcu_segcblist.h    |   8 +-
> kernel/rcu/tree.c             |  18 ++--
> 5 files changed, 165 insertions(+), 49 deletions(-)
> 
> --
> 2.28.0.681.g6f77f65b4e-goog
> 
