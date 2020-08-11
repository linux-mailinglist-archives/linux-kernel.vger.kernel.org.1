Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD7A241820
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbgHKITU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 04:19:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:49156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgHKITT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:19:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 93D56AB8B;
        Tue, 11 Aug 2020 08:19:38 +0000 (UTC)
Date:   Tue, 11 Aug 2020 10:19:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [RFC-PATCH 1/2] mm: Add __GFP_NO_LOCKS flag
Message-ID: <20200811081917.GG4793@dhcp22.suse.cz>
References: <20200809204354.20137-1-urezki@gmail.com>
 <20200809204354.20137-2-urezki@gmail.com>
 <20200810123141.GF4773@dhcp22.suse.cz>
 <20200810160739.GA29884@pc636>
 <20200810192525.GG4773@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810192525.GG4773@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-08-20 21:25:26, Michal Hocko wrote:
> On Mon 10-08-20 18:07:39, Uladzislau Rezki wrote:
[...]
> > The problem that i see is we can not use the page allocator from atomic
> > contexts, what is our case:
> > 
> > <snip>
> >     local_irq_save(flags) or preempt_disable() or raw_spinlock();
> >     __get_free_page(GFP_ATOMIC);
> > <snip>
> > 
> > So if we can convert the page allocator to raw_* lock it will be appreciated,
> > at least from our side, IMHO, not from RT one. But as i stated above we need
> > to sort raised questions out if converting is done.
> > 
> > What is your view?
> 
> To me it would make more sense to support atomic allocations also for
> the RT tree. Having both GFP_NOWAIT and GFP_ATOMIC which do not really
> work for atomic context in RT sounds subtle and wrong.

I was thinking about this some more. I still think the above would be a
reasonable goal we should try to achieve. If for not other then for
future maintainability (especially after the RT patchset is merged).
I have tried to search for any known problems/attempts to make
zone->lock raw but couldn't find anything. Maybe somebody more involved
in RT world have something to say about that.

Anyway, if the zone->lock is not a good fit for raw_spin_lock then the
only way I can see forward is to detect real (RT) atomic contexts and
bail out early before taking the lock in the allocator for NOWAIT/ATOMIC
requests.
-- 
Michal Hocko
SUSE Labs
