Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42227EB19
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgI3Oj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:39:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:34602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728149AbgI3Ojz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:39:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DC4CDABAD;
        Wed, 30 Sep 2020 14:39:53 +0000 (UTC)
Subject: Re: [RFC-PATCH 2/4] mm: Add __rcu_alloc_page_lockless() func.
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20200918194817.48921-1-urezki@gmail.com>
 <20200918194817.48921-3-urezki@gmail.com>
 <38f42ca1-ffcd-04a6-bf11-618deffa897a@suse.cz> <20200929220742.GB8768@pc636>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <795d6aea-1846-6e08-ac1b-dbff82dd7133@suse.cz>
Date:   Wed, 30 Sep 2020 16:39:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200929220742.GB8768@pc636>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/20 12:07 AM, Uladzislau Rezki wrote:
> On Tue, Sep 29, 2020 at 12:15:34PM +0200, Vlastimil Babka wrote:
>> On 9/18/20 9:48 PM, Uladzislau Rezki (Sony) wrote:
>> 
>> After reading all the threads and mulling over this, I am going to deflect from
>> Mel and Michal and not oppose the idea of lockless allocation. I would even
>> prefer to do it via the gfp flag and not a completely separate path. Not using
>> the exact code from v1, I think it could be done in a way that we don't actually
>> look at the new flag until we find that pcplist is empty - which should not
>> introduce overhead to the fast-fast path when pcpclist is not empty. It's more
>> maintainable that adding new entry points, IMHO.
>> 
> Thanks for reading all that from the beginning! It must be tough due to the
> fact there were lot of messages in the threads, so at least i was lost.
> 
> I agree that adding a new entry or separate lock-less function can be considered
> as something that is hard to maintain. I have a question here. I mean about your
> different look at it:
> 
> <snip>
> bool is_pcp_cache_empty(gfp_t gfp)
> {
>     struct per_cpu_pages *pcp;
>     struct zoneref *ref;
>     unsigned long flags;
>     bool empty;
> 
>     ref = first_zones_zonelist(node_zonelist(
>             numa_node_id(), gfp), gfp_zone(gfp), NULL);
>     if (!ref->zone)
>             return true;
> 
>     local_irq_save(flags);
>     pcp = &this_cpu_ptr(ref->zone->pageset)->pcp;
>     empty = list_empty(&pcp->lists[gfp_migratetype(gfp)]);
>     local_irq_restore(flags);
> 
>     return empty;
> }
> 
> disable_irq();
> if (!is_pcp_cache_empty(GFP_NOWAIT))
>     __get_free_page(GFP_NOWAIT);
> enable_irq();
> <snip>
> 
> Do you mean to have something like above? I mean some extra API
> function that returns true or false if fast-fast allocation can
> either occur or not. Above code works just fine and never touches
> main zone->lock.
> 
> i.e. Instead of introducing an extra GFP_LOCKLESS flag or any new
> extra lock-less function. We could have something that checks a
> pcp page cache list, thus it can guarantee that a request would
> be accomplish using fast-fast path.

No, I meant going back to idea of new gfp flag, but adjust the implementation in
the allocator (different from what you posted in previous version) so that it
only looks at the flag after it tries to allocate from pcplist and finds out
it's empty. So, no inventing of new page allocator entry points or checks such
as the one you wrote above, but adding the new gfp flag in a way that it doesn't
affect existing fast paths.
