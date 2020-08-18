Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988DC247FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 09:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRHnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 03:43:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:56726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgHRHnv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:43:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24540ABCC;
        Tue, 18 Aug 2020 07:44:15 +0000 (UTC)
Date:   Tue, 18 Aug 2020 09:43:44 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200818074344.GL28270@dhcp22.suse.cz>
References: <20200814141425.GM4295@paulmck-ThinkPad-P72>
 <20200814161106.GA13853@paulmck-ThinkPad-P72>
 <20200814174924.GI3982@worktop.programming.kicks-ass.net>
 <20200814180224.GQ4295@paulmck-ThinkPad-P72>
 <875z9lkoo4.fsf@nanos.tec.linutronix.de>
 <20200814204140.GT4295@paulmck-ThinkPad-P72>
 <20200814215206.GL3982@worktop.programming.kicks-ass.net>
 <20200816225655.GA17869@pc636>
 <20200817082849.GA28270@dhcp22.suse.cz>
 <20200817222803.GE23602@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817222803.GE23602@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 17-08-20 15:28:03, Paul E. McKenney wrote:
> On Mon, Aug 17, 2020 at 10:28:49AM +0200, Michal Hocko wrote:
> > On Mon 17-08-20 00:56:55, Uladzislau Rezki wrote:
> 
> [ . . . ]
> 
> > > wget ftp://vps418301.ovh.net/incoming/1000000_kmalloc_kfree_rcu_proc_percpu_pagelist_fractio_is_8.png
> > 
> > 1/8 of the memory in pcp lists is quite large and likely not something
> > used very often.
> > 
> > Both these numbers just make me think that a dedicated pool of page
> > pre-allocated for RCU specifically might be a better solution. I still
> > haven't read through that branch of the email thread though so there
> > might be some pretty convincing argments to not do that.
> 
> To avoid the problematic corner cases, we would need way more dedicated
> memory than is reasonable, as in well over one hundred pages per CPU.
> Sure, we could choose a smaller number, but then we are failing to defend
> against flooding, even on systems that have more than enough free memory
> to be able to do so.  It would be better to live within what is available,
> taking the performance/robustness hit only if there isn't enough.

Thomas had a good point that it doesn't really make much sense to
optimize for flooders because that just makes them more effective.

> My current belief is that we need a combination of (1) either the
> GFP_NOLOCK flag or Peter Zijlstra's patch and

I must have missed the patch?
-- 
Michal Hocko
SUSE Labs
