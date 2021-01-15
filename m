Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F552F8549
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbhAOTWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:22:19 -0500
Received: from foss.arm.com ([217.140.110.172]:52892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbhAOTWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:22:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2ED7ED1;
        Fri, 15 Jan 2021 11:21:32 -0800 (PST)
Received: from [10.57.56.43] (unknown [10.57.56.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652683F719;
        Fri, 15 Jan 2021 11:21:31 -0800 (PST)
Subject: Re: [PATCH v4 3/3] iommu/iova: Flush CPU rcache for when a depot
 fills
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        John Garry <john.garry@huawei.com>
Cc:     joro@8bytes.org, will@kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, iommu@lists.linux-foundation.org
References: <1607538189-237944-1-git-send-email-john.garry@huawei.com>
 <1607538189-237944-4-git-send-email-john.garry@huawei.com>
 <YAHRwZXoRZFJkgE8@larix.localdomain>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <7a4f3d74-2f0d-1ffa-95cf-cfeaa81d8c7e@arm.com>
Date:   Fri, 15 Jan 2021 19:21:29 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAHRwZXoRZFJkgE8@larix.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-15 17:32, Jean-Philippe Brucker wrote:
> On Thu, Dec 10, 2020 at 02:23:09AM +0800, John Garry wrote:
>> Leizhen reported some time ago that IOVA performance may degrade over time
>> [0], but unfortunately his solution to fix this problem was not given
>> attention.
>>
>> To summarize, the issue is that as time goes by, the CPU rcache and depot
>> rcache continue to grow. As such, IOVA RB tree access time also continues
>> to grow.
>>
>> At a certain point, a depot may become full, and also some CPU rcaches may
>> also be full when inserting another IOVA is attempted. For this scenario,
>> currently the "loaded" CPU rcache is freed and a new one is created. This
>> freeing means that many IOVAs in the RB tree need to be freed, which
>> makes IO throughput performance fall off a cliff in some storage scenarios:
>>
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6314MB/0KB/0KB /s] [1616K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [5669MB/0KB/0KB /s] [1451K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6673MB/0KB/0KB /s] [1708K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6031MB/0KB/0KB /s] [1544K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6761MB/0KB/0KB /s] [1731K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6705MB/0KB/0KB /s] [1717K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6685MB/0KB/0KB /s] [1711K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6178MB/0KB/0KB /s] [1582K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [6731MB/0KB/0KB /s] [1723K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2387MB/0KB/0KB /s] [611K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2689MB/0KB/0KB /s] [688K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [2278MB/0KB/0KB /s] [583K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1288MB/0KB/0KB /s] [330K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1632MB/0KB/0KB /s] [418K/0/0 iops]
>> Jobs: 12 (f=12): [RRRRRRRRRRRR] [0.0% done] [1765MB/0KB/0KB /s] [452K/0/0 iops]
>>
>> And continue in this fashion, without recovering. Note that in this
>> example it was required to wait 16 hours for this to occur. Also note that
>> IO throughput also becomes gradually becomes more unstable leading up to
>> this point.
>>
>> This problem is only seen for non-strict mode. For strict mode, the rcaches
>> stay quite compact.
> 
> It would be good to understand why the rcache doesn't stabilize. Could be
> a bug, or just need some tuning
> 
> In strict mode, if a driver does Alloc-Free-Alloc and the first alloc
> misses the rcache, the second allocation hits it. The same sequence in
> non-strict mode misses the cache twice, because the IOVA is added to the
> flush queue on Free.
> 
> So rather than AFAFAF.. we get AAA..FFF.., only once the fq_timer triggers
> or the FQ is full. Interestingly the FQ size is 2x IOVA_MAG_SIZE, so we
> could allocate 2 magazines worth of fresh IOVAs before alloc starts
> hitting the cache. If a job allocates more than that, some magazines are
> going to the depot, and with multi-CPU jobs those will get used on other
> CPUs during the next alloc bursts, causing the progressive increase in
> rcache consumption. I wonder if setting IOVA_MAG_SIZE > IOVA_FQ_SIZE helps
> reuse of IOVAs?
> 
> Then again I haven't worked out the details, might be entirely wrong. I'll
> have another look next week.

I did start digging into the data (thanks for that!) before Christmas, 
but between being generally frazzled and trying to remember how to write 
Perl to massage the numbers out of the log dump I never got round to 
responding, sorry.

The partial thoughts that I can recall right now are firstly that the 
total numbers of IOVAs are actually pretty meaningless, it really needs 
to be broken down by size (that's where my Perl-hacking stalled...); 
secondly that the pattern is far more than just a steady increase - the 
CPU rcache count looks to be heading asymptotically towards ~65K IOVAs 
all the time, representing (IIRC) two sizes being in heavy rotation, 
while the depot is happily ticking along in a steady state as expected, 
until it suddenly explodes out of nowhere; thirdly, I'd really like to 
see instrumentation of the flush queues at the same time, since I think 
they're the real culprit.

My theory so far is that everyone is calling queue_iova() frequently 
enough to keep the timer at bay and their own queues drained. Then at 
the ~16H mark, *something* happens that pauses unmaps long enough for 
the timer to fire, and at that point all hell breaks loose. The depot is 
suddenly flooded with IOVAs of *all* sizes, indicative of all the queues 
being flushed at once (note that the two most common sizes have been 
hovering perilously close to "full" the whole time), but then, 
crucially, *that keeps happening*. My guess is that the load of 
fq_flush_timeout() slows things down enough that the the timer then 
keeps getting the chance to expire and repeat the situation.

The main conclusion I draw from this is the same one that was my initial 
gut feeling; that MAX_GLOBAL_MAGS = 32 is utter bollocks. The CPU rcache 
capacity scales with the number of CPUs; the flush queue capacity scales 
with the number of CPUs; it is nonsensical that the depot size does not 
correspondingly scale with the number of CPUs (I note that the testing 
on the original patchset cites a 16-CPU system, where that depot 
capacity is conveniently equal to the total rcache capacity).

Now yes, purging the rcaches when the depot is full does indeed help 
mitigate this scenario - I assume it provides enough of a buffer where 
the regular free_iova_fast() calls don't hit queue_iova() for a while 
(and gives fq_ring_free() some reprieve on the CPU handling the 
timeout), giving enough leeway for the flood to finish before anyone 
starts hitting queues/locks/etc. and stalling again, and thus break the 
self-perpetuating timeout cycle. But that's still only a damage 
limitation exercise! It's planning for failure to just lie down and 
assume that the depot is going to be full if fq_flush_timeout() ever 
fires because it's something like an order of magnitude smaller than the 
flush queue capacity (even for a uniform distribution of IOVA sizes) on 
super-large systems.

I'm honestly tempted to move my position further towards a hard NAK on 
this approach, because all the evidence so far points to it being a 
bodge around a clear and easily-fixed scalability oversight. At the very 
least I'd now want to hear a reasoned justification for why you want to 
keep the depot at an arbitrary fixed size while the whole rest of the 
system scales (I'm assuming that since my previous suggestion to try 
changes in that area seems to have been ignored).

Cheers,
Robin.

> 
> Thanks,
> Jean
> 
>> As a solution to this issue, judge that the IOVA caches have grown too big
>> when cached magazines need to be free, and just flush all the CPUs rcaches
>> instead.
>>
>> The depot rcaches, however, are not flushed, as they can be used to
>> immediately replenish active CPUs.
>>
>> In future, some IOVA compaction could be implemented to solve the
>> instability issue, which I figure could be quite complex to implement.
>>
>> [0] https://lore.kernel.org/linux-iommu/20190815121104.29140-3-thunder.leizhen@huawei.com/
>>
>> Analyzed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> Reported-by: Xiang Chen <chenxiang66@hisilicon.com>
>> Tested-by: Xiang Chen <chenxiang66@hisilicon.com>
>> Signed-off-by: John Garry <john.garry@huawei.com>
>> Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>   drivers/iommu/iova.c | 16 ++++++----------
>>   1 file changed, 6 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
>> index 732ee687e0e2..39b7488de8bb 100644
>> --- a/drivers/iommu/iova.c
>> +++ b/drivers/iommu/iova.c
>> @@ -841,7 +841,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   				 struct iova_rcache *rcache,
>>   				 unsigned long iova_pfn)
>>   {
>> -	struct iova_magazine *mag_to_free = NULL;
>>   	struct iova_cpu_rcache *cpu_rcache;
>>   	bool can_insert = false;
>>   	unsigned long flags;
>> @@ -863,13 +862,12 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   				if (cpu_rcache->loaded)
>>   					rcache->depot[rcache->depot_size++] =
>>   							cpu_rcache->loaded;
>> -			} else {
>> -				mag_to_free = cpu_rcache->loaded;
>> +				can_insert = true;
>> +				cpu_rcache->loaded = new_mag;
>>   			}
>>   			spin_unlock(&rcache->lock);
>> -
>> -			cpu_rcache->loaded = new_mag;
>> -			can_insert = true;
>> +			if (!can_insert)
>> +				iova_magazine_free(new_mag);
>>   		}
>>   	}
>>   
>> @@ -878,10 +876,8 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>>   
>>   	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>>   
>> -	if (mag_to_free) {
>> -		iova_magazine_free_pfns(mag_to_free, iovad);
>> -		iova_magazine_free(mag_to_free);
>> -	}
>> +	if (!can_insert)
>> +		free_all_cpu_cached_iovas(iovad);
>>   
>>   	return can_insert;
>>   }
>> -- 
>> 2.26.2
>>
>> _______________________________________________
>> iommu mailing list
>> iommu@lists.linux-foundation.org
>> https://lists.linuxfoundation.org/mailman/listinfo/iommu
