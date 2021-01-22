Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1334F30074C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbhAVP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:28:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:48988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbhAVP1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:27:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12797ACC6;
        Fri, 22 Jan 2021 15:27:13 +0000 (UTC)
To:     Jann Horn <jannh@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Michal Hocko <mhocko@kernel.org>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAG48ez0gutKNuRj4E22tkv8mQKo-6TExGMxvpHCtUz8sFonb3A@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <af30043f-d917-9c84-54e8-b36cee9cccf7@suse.cz>
Date:   Fri, 22 Jan 2021 16:27:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAG48ez0gutKNuRj4E22tkv8mQKo-6TExGMxvpHCtUz8sFonb3A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/21 2:05 PM, Jann Horn wrote:
> On Thu, Jan 21, 2021 at 7:19 PM Vlastimil Babka <vbabka@suse.cz> wrote:
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
> 
> Uuuh, I think powerpc doesn't have cmpxchg_double?

The benchmark was done by Vincent on arm64, AFAICS. PowerPC (ppc64) was what
Bharata had used to demonstrate the order calculation change in his patch.

There seems to be some implementation dependency on CONFIG_ARM64_LSE_ATOMICS but
AFAICS that doesn't determine if cmpxchg_double is provided.

> "vgrep cmpxchg_double arch/" just spits out arm64, s390 and x86? And
> <https://liblfds.org/mediawiki/index.php?title=Article:CAS_and_LL/SC_Implementation_Details_by_Processor_family>
> says under "POWERPC": "no DW LL/SC"

Interesting find in any case.

> So powerpc is probably hitting the page-bitlock-based implementation
> all the time for stuff like __slub_free()? Do you have detailed
> profiling results from "perf top" or something like that?
> 
> (I actually have some WIP patches and a design document for getting
> rid of cmpxchg_double in struct page that I hacked together in the
> last couple days; I'm currently in the process of sending them over to
> some other folks in the company who hopefully have cycles to
> review/polish/benchmark them so that they can be upstreamed, assuming
> that those folks think they're important enough. I don't have the
> cycles for it...)

I'm curious, so I hope this works out :)
