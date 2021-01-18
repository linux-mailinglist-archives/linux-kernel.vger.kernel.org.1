Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC922FA044
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391825AbhARMpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:45:40 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2364 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391747AbhARMkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:40:23 -0500
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKB9X0kwJz67dKJ;
        Mon, 18 Jan 2021 20:36:32 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 18 Jan 2021 13:39:38 +0100
Received: from [10.47.8.82] (10.47.8.82) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 18 Jan
 2021 12:39:37 +0000
Subject: Re: [PATCH v4 3/3] iommu/iova: Flush CPU rcache for when a depot
 fills
To:     Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     <joro@8bytes.org>, <will@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <iommu@lists.linux-foundation.org>
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-4-git-send-email-john.garry@huawei.com>
 <YAHRwZXoRZFJkgE8@larix.localdomain>
 <7a4f3d74-2f0d-1ffa-95cf-cfeaa81d8c7e@arm.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <7b2b4f7c-d240-4922-4204-60cee61c8a60@huawei.com>
Date:   Mon, 18 Jan 2021 12:38:23 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <7a4f3d74-2f0d-1ffa-95cf-cfeaa81d8c7e@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.8.82]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2021 19:21, Robin Murphy wrote:
>>
>> It would be good to understand why the rcache doesn't stabilize. Could be
>> a bug, or just need some tuning
>>
>> In strict mode, if a driver does Alloc-Free-Alloc and the first alloc
>> misses the rcache, the second allocation hits it. The same sequence in
>> non-strict mode misses the cache twice, because the IOVA is added to the
>> flush queue on Free.
>>
>> So rather than AFAFAF.. we get AAA..FFF.., only once the fq_timer 
>> triggers
>> or the FQ is full.

Sounds right

>> Interestingly the FQ size is 2x IOVA_MAG_SIZE, so we
>> could allocate 2 magazines worth of fresh IOVAs before alloc starts
>> hitting the cache. If a job allocates more than that, some magazines are
>> going to the depot, and with multi-CPU jobs those will get used on other
>> CPUs during the next alloc bursts, causing the progressive increase in
>> rcache consumption. I wonder if setting IOVA_MAG_SIZE > IOVA_FQ_SIZE 
>> helps
>> reuse of IOVAs?

Looking back through the lore history, I don't know where the 
IOVA_FQ_SIZE = 256 came from. I guess it's size of 2x IOVA_MAG_SIZE (1x 
for loaded and 1x for prev) for the reason you mention.

>>
>> Then again I haven't worked out the details, might be entirely wrong. 
>> I'll
>> have another look next week.
> 

cheers

> I did start digging into the data (thanks for that!) before Christmas, 
> but between being generally frazzled and trying to remember how to write 
> Perl to massage the numbers out of the log dump I never got round to 
> responding, sorry.

As you may have seen:
https://raw.githubusercontent.com/hisilicon/kernel-dev/064c4dc8869b3f2ad07edffceafde0b129f276b0/lsi3008_dmesg

I had to change some block configs via sysfs to ever get IOVA locations 
for size > 0. And even then, I still got none bigger than 
IOVA_RANGE_CACHE_MAX_SIZE.

Note: For a log like:
[13175.361915] print_iova2 iova_allocs(=5000000 ... too_big=47036

47036 is number of IOVA size > IOVA_RANGE_CACHE_MAX_SIZE, in case it was 
not clear.

And I never hit the critical point of a depot bin filling, but it may 
just take even longer.

However with IOVA size = 0 always occurring, then I noticed that the 
depot size = 0 bin fills up relatively quickly. As such, I am now 
slightly skeptical of the approach I have taken here, i.e purge the 
whole rcache.

> 
> The partial thoughts that I can recall right now are firstly that the 
> total numbers of IOVAs are actually pretty meaningless, it really needs 
> to be broken down by size (that's where my Perl-hacking stalled...); 
> secondly that the pattern is far more than just a steady increase - the 
> CPU rcache count looks to be heading asymptotically towards ~65K IOVAs 
> all the time, representing (IIRC) two sizes being in heavy rotation, 
> while the depot is happily ticking along in a steady state as expected, 
> until it suddenly explodes out of nowhere; thirdly, I'd really like to 
> see instrumentation of the flush queues at the same time, since I think 
> they're the real culprit.
> 
> My theory so far is that everyone is calling queue_iova() frequently 
> enough to keep the timer at bay and their own queues drained. Then at 
> the ~16H mark, *something* happens that pauses unmaps long enough for 
> the timer to fire, and at that point all hell breaks loose.

So do you think that the freeing the IOVA magazines when the depot fills 
is the cause of this? That was our analysis.

> The depot is 
> suddenly flooded with IOVAs of *all* sizes, indicative of all the queues 
> being flushed at once (note that the two most common sizes have been 
> hovering perilously close to "full" the whole time), but then, 
> crucially, *that keeps happening*. My guess is that the load of 
> fq_flush_timeout() slows things down enough that the the timer then 
> keeps getting the chance to expire and repeat the situation.

Not sure on that one.

> 
> The main conclusion I draw from this is the same one that was my initial 
> gut feeling; that MAX_GLOBAL_MAGS = 32 is utter bollocks.

Yeah, I tend to agree with that. Or, more specifically, how things work 
today is broken, and MAX_GLOBAL_MAGS = 32 is very much involved with that.

> The CPU rcache 
> capacity scales with the number of CPUs; the flush queue capacity scales 
> with the number of CPUs; it is nonsensical that the depot size does not 
> correspondingly scale with the number of CPUs (I note that the testing 
> on the original patchset cites a 16-CPU system, where that depot 
> capacity is conveniently equal to the total rcache capacity).
> 
> Now yes, purging the rcaches when the depot is full does indeed help 
> mitigate this scenario - I assume it provides enough of a buffer where 
> the regular free_iova_fast() calls don't hit queue_iova() for a while 
> (and gives fq_ring_free() some reprieve on the CPU handling the 
> timeout), giving enough leeway for the flood to finish before anyone 
> starts hitting queues/locks/etc. and stalling again, and thus break the 
> self-perpetuating timeout cycle. But that's still only a damage 
> limitation exercise! It's planning for failure to just lie down and 
> assume that the depot is going to be full if fq_flush_timeout() ever 
> fires because it's something like an order of magnitude smaller than the 
> flush queue capacity (even for a uniform distribution of IOVA sizes) on 
> super-large systems.
> 
> I'm honestly tempted to move my position further towards a hard NAK on 
> this approach, because all the evidence so far points to it being a 
> bodge around a clear and easily-fixed scalability oversight. At the very 
> least I'd now want to hear a reasoned justification for why you want to 
> keep the depot at an arbitrary fixed size while the whole rest of the 
> system scales 


>(I'm assuming that since my previous suggestion to try 
> changes in that area seems to have been ignored).
> 

So I said that it should fix the problem of the throughput going through 
the floor at this 16h mark.

But we see 2x tightly coupled problems:
a. leading up to the ~16H critical point, throughput is slowly degrading 
and becomes quite unstable (not shown in the log)
For the LSI3008 card, we don't see that. But then no IOVA size > 
IOVA_RANGE_CACHE_MAX_SIZE occur there.

b. at the critical point, throughput goes through the floor

So b. should be fixed with the suggestion to have unlimited/higher depot 
max bin size, but I reckon that we would still see a. And I put that 
down to the fact that we have IOVA sizes > IOVA_RANGE_CACHE_MAX_SIZE at 
a certain rate always. As the rb tree grows over time, they become 
slower and slower to alloc+free - that's our theory. Allowing the depot 
to grow further isn’t going to help that.

Maybe Leizhen's idea to trim the rcache periodically is overall better, 
but I am concerned on implementation.

If not, then if we allow depot bin size to scale/grow, I would like to 
see more efficient handling for IOVA size > IOVA_RANGE_CACHE_MAX_SIZE.

Thanks,
John
