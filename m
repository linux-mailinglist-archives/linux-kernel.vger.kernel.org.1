Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E3423BE7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 19:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729577AbgHDRDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 13:03:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:51346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728880AbgHDRCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 13:02:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22F21B588;
        Tue,  4 Aug 2020 17:02:30 +0000 (UTC)
Subject: Re: [RFC-PROTOTYPE 1/1] mm: Add __GFP_FAST_TRY flag
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
References: <20200803163029.1997-1-urezki@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1d50a46a-b97f-96b2-8a5c-21075f022f01@suse.cz>
Date:   Tue, 4 Aug 2020 19:02:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200803163029.1997-1-urezki@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/20 6:30 PM, Uladzislau Rezki (Sony) wrote:
> Some background and kfree_rcu()
> ===============================
> The pointers to be freed are stored in the per-cpu array to improve
> performance, to enable an easier-to-use API, to accommodate vmalloc
> memmory and to support a single argument of the kfree_rcu() when only
> a pointer is passed. More details are below.
> 
> In order to maintain such per-CPU arrays there is a need in dynamic
> allocation when a current array is fully populated and a new block is
> required. See below the example:
> 
>  0 1 2 3      0 1 2 3
> |p|p|p|p| -> |p|p|p|p| -> NULL
> 
> there are two pointer-blocks, each one can store 4 addresses
> which will be freed after a grace period is passed. In reality
> we store PAGE_SIZE / sizeof(void *).

So what do you actually have without the dynamic allocation, 8 addresses or
PAGE_SIZE / sizeof(void *) addresses? And how many dynamically allocated pages
did you observe you might need in practice? Can it be somehow quantified the
benefit that you are able to allocate up to X pages dynamically from the
pcplists, vs a fixed number of pages held just for that purpose + fallback?

...

> A number of pre-fetched elements seems does not depend on amount of the
> physical memory in a system. In my case it is 63 pages. This step is not

It may depend, if you tune vm.percpu_pagelist_fraction sysctl. But I wouldn't
know the exact formulas immediately. See pageset_set_high_and_batch(). In any
case for your purpose the 'high' value (in e.g. /proc/zoneinfo) is more relevant
(it means the maximum pages you might find cached) for you than the 'batch' (how
much is cached in one refill).

> lock-less. It uses spinlock_t for accessing to the body's zone. This
> step is fully covered in the rmqueue_bulk() function.
> 
> Summarizing. The __GFP_FAST_TRY covers only [1] and can not do step [2],
> due to the fact that [2] acquires spinlock_t. It implies that it is super
> fast, but a higher rate of fails is also expected.
> 
> Usage: __get_free_page(__GFP_FAST_TRY);
> 
> 2) There was a proposal from Matthew Wilcox: https://lkml.org/lkml/2020/7/31/1015
> 
> <snip>
> On non-RT, we could make that lock a raw spinlock.  On RT, we could
> decline to take the lock.  We'd need to abstract the spin_lock() away
> behind zone_lock(zone), but that should be OK.
> <snip>
> 
> It would be great to use any existing flag, say GFP_NOWAIT. Suppose we
> decline to take the lock across the page allocator for RT. But there is
> at least one path that does it outside of the page allocator. GFP_NOWAIT
> can wakeup the kswapd, whereas a "wake-up path" uses sleepable lock:
> 
> wakeup_kswapd() -> wake_up_interruptible(&pgdat->kswapd_wait).
> 
> Probably it can be fixed by the excluding of waking of the kswapd process
> defining something like below:

Is something missing here?

> what is equal to zero and i am not sure if __get_free_page(0) handles
> all that correctly, though it allocates and seems working on my test
> machine! Please note it is related to "if we can reuse existing flags".
> 
> In the meantime, please see below for a patch that adds a __GFP_FAST_TRY,
> which can at least serve as a baseline against which other proposals can
> be compared. The patch is based on the 5.8.0-rc3.
> 
> Please RFC.

At first glance __GFP_FAST_TRY (more descriptive name? __GFP_NO_LOCKS?) seems
better than doing weird things with GFP_NOWAIT, but depends on the real benefits
(hence my first questions).

Thanks,
Vlastimil
