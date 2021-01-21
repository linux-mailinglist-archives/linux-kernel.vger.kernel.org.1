Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529932FF313
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbhAUSWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:22:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:48774 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388643AbhAUSUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 13:20:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17DF9B947;
        Thu, 21 Jan 2021 18:19:22 +0000 (UTC)
To:     Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        shakeelb@google.com, Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
Date:   Thu, 21 Jan 2021 19:19:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/21 11:01 AM, Christoph Lameter wrote:
> On Thu, 21 Jan 2021, Bharata B Rao wrote:
> 
>> > The problem is that calculate_order() is called a number of times
>> > before secondaries CPUs are booted and it returns 1 instead of 224.
>> > This makes the use of num_online_cpus() irrelevant for those cases
>> >
>> > After adding in my command line "slub_min_objects=36" which equals to
>> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
>> > , the regression diseapears:
>> >
>> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)

I'm surprised that hackbench is that sensitive to slab performance, anyway. It's
supposed to be a scheduler benchmark? What exactly is going on?

>> Should we have switched to num_present_cpus() rather than
>> num_online_cpus()? If so, the below patch should address the
>> above problem.
> 
> There is certainly an initcall after secondaries are booted where we could
> redo the calculate_order?

We could do it even in hotplug handler. But in practice that means making sure
it's safe, i.e. all users of oo_order/oo_objects must handle the value changing.

Consider e.g. init_cache_random_seq() which uses oo_objects(s->oo) to allocate
s->random_seq when cache s is created. Then shuffle_freelist() will use the
current value of oo_objects(s->oo) to index s->random_seq, for a newly allocated
slab - what if the page order has increased meanwhile due to secondary booting
or hotplug? Array overflow. That's why I just made the former sysfs handler for
changing order read-only.

Things would be easier if we could trust *on all arches* either

- num_present_cpus() to count what the hardware really physically has during
boot, even if not yet onlined, at the time we init slab. This would still not
handle later hotplug (probably mostly in a VM scenario, not that somebody would
bring bunch of actual new cpu boards to a running bare metal system?).

- num_possible_cpus()/nr_cpu_ids not to be excessive (broken BIOS?) on systems
where it's not really possible to plug more CPU's. In a VM scenario we could
still have an opposite problem, where theoretically "anything is possible" but
the virtual cpus are never added later.

We could also start questioning the very assumption that number of cpus should
affect slab page size in the first place. Should it? After all, each CPU will
have one or more slab pages privately cached, as we discuss in the other
thread... So why make the slab pages also larger?

> Or the num_online_cpus needs to be up to date earlier. Why does this issue
> not occur on x86? Does x86 have an up to date num_online_cpus earlier?
> 
> 

