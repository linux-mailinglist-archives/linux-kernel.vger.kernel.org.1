Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7457830028D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 13:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbhAVMJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 07:09:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:49976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbhAVMEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 07:04:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24929ABDA;
        Fri, 22 Jan 2021 12:03:58 +0000 (UTC)
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
Date:   Fri, 22 Jan 2021 13:03:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 9:03 AM, Vincent Guittot wrote:
> On Thu, 21 Jan 2021 at 19:19, Vlastimil Babka <vbabka@suse.cz> wrote:
>>
>> On 1/21/21 11:01 AM, Christoph Lameter wrote:
>> > On Thu, 21 Jan 2021, Bharata B Rao wrote:
>> >
>> >> > The problem is that calculate_order() is called a number of times
>> >> > before secondaries CPUs are booted and it returns 1 instead of 224.
>> >> > This makes the use of num_online_cpus() irrelevant for those cases
>> >> >
>> >> > After adding in my command line "slub_min_objects=36" which equals to
>> >> > 4 * (fls(num_online_cpus()) + 1) with a correct num_online_cpus == 224
>> >> > , the regression diseapears:
>> >> >
>> >> > 9 iterations of hackbench -l 16000 -g 16: 3.201sec (+/- 0.90%)
>>
>> I'm surprised that hackbench is that sensitive to slab performance, anyway. It's
>> supposed to be a scheduler benchmark? What exactly is going on?
>>
> 
> From hackbench description:
> Hackbench is both a benchmark and a stress test for the Linux kernel
> scheduler. It's  main
>        job  is  to  create a specified number of pairs of schedulable
> entities (either threads or
>        traditional processes) which communicate via either sockets or
> pipes and time how long  it
>        takes for each pair to send data back and forth.

Yep, so I wonder which slab entities this is stressing that much.

>> Things would be easier if we could trust *on all arches* either
>>
>> - num_present_cpus() to count what the hardware really physically has during
>> boot, even if not yet onlined, at the time we init slab. This would still not
>> handle later hotplug (probably mostly in a VM scenario, not that somebody would
>> bring bunch of actual new cpu boards to a running bare metal system?).
>>
>> - num_possible_cpus()/nr_cpu_ids not to be excessive (broken BIOS?) on systems
>> where it's not really possible to plug more CPU's. In a VM scenario we could
>> still have an opposite problem, where theoretically "anything is possible" but
>> the virtual cpus are never added later.
> 
> On all the system that I have tested num_possible_cpus()/nr_cpu_ids
> were correctly initialized
> 
> large arm64 acpi system
> small arm64 DT based system
> VM on x86 system

So it's just powerpc that has this issue with too large nr_cpu_ids? Is it caused
by bios or the hypervisor? How does num_present_cpus() look there?

What about heuristic:
- num_online_cpus() > 1 - we trust that and use it
- otherwise nr_cpu_ids
Would that work? Too arbitrary?


>> We could also start questioning the very assumption that number of cpus should
>> affect slab page size in the first place. Should it? After all, each CPU will
>> have one or more slab pages privately cached, as we discuss in the other
>> thread... So why make the slab pages also larger?
>>
>> > Or the num_online_cpus needs to be up to date earlier. Why does this issue
>> > not occur on x86? Does x86 have an up to date num_online_cpus earlier?
>> >
>> >
>>
> 

