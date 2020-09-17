Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF77026E323
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIQSEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:04:32 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43730 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgIQSD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:03:59 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id C36AA20B7178;
        Thu, 17 Sep 2020 11:03:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C36AA20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1600365838;
        bh=6JyPUsm4XBTi8jnz7iQrYrl0MN3/q5hOA0x3AKWKDpU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=loJ4sthnKgyPCRujnsQVSyARpiGMSyLDCbe6jYGimKcTEzI90hScxCAkSkhuJaNcS
         aBl+evvD2SgvG2pIAUPOF7xV71akF/X4wwxZu+YrqyakoyY+2nNQPWlFXPpDCXUsG8
         wvrq1ZMXA/4xMv4MOpPUgqZ3iIVJaiBvGsRpYJd8=
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allen Pais <apais@microsoft.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200914143312.GU16999@dhcp22.suse.cz>
 <c6fcc196-ce7f-1f48-e9bd-c18448272df1@linux.microsoft.com>
 <20200915081832.GA4649@dhcp22.suse.cz>
 <53dd1e2c-f07e-ee5b-51a1-0ef8adb53926@linux.microsoft.com>
 <20200916065306.GB18998@dhcp22.suse.cz>
 <32b73685-48f2-b6dd-f000-8ea52cfee70a@linux.microsoft.com>
 <20200917121213.GC29887@dhcp22.suse.cz>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <7eddcc58-f65f-0be9-60e8-2de013365909@linux.microsoft.com>
Date:   Thu, 17 Sep 2020 11:03:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200917121213.GC29887@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/2020 5:12 AM, Michal Hocko wrote:
> On Wed 16-09-20 11:28:40, Vijay Balakrishna wrote:
> [...]
>> OOM splat below.  I see we had kmem leak detection turned on here.  We
>> haven't run stress with kmem leak detection since uncovereing low
>> min_free_kbytes.  During investigation we wanted to make sure there is no
>> kmem leaks, we didn't find significant leaks detected.
>>
>> [330319.766059] systemd invoked oom-killer:
>> gfp_mask=0x40cc0(GFP_KERNEL|__GFP_COMP), order=1, oom_score_adj=0
> 
> [...]
>> [330319.861064] Mem-Info:
>> [330319.863519] active_anon:60744 inactive_anon:109226 isolated_anon:0
>>                   active_file:6418 inactive_file:3869 isolated_file:2
>>                   unevictable:0 dirty:8 writeback:1 unstable:0
>>                   slab_reclaimable:34660 slab_unreclaimable:795718
>>                   mapped:1256 shmem:165765 pagetables:689 bounce:0
>>                   free:340962 free_pcp:4672 free_cma:0
> 
> The memory consumption is predominantely in slab (unreclaimable). Only
> ~8% of the memory is on LRUs (anonymous + file). Slab (both reclaimable
> and unreclaimable) is ~40%. So there is still a lot of memory
> unaccounted (direct users of the page allocator). This would partially
> explain why the oom killer is not able to make progress and eventually
> panics because it is the kernel which is blowing the memory consumption.
> 
> There is still ~1G free memory but the problem is that this is a
> GFP_KERNEL request which is not allowed to consume Movable memory.
> Zone normal is depleted and therefore it cannot satisfy this request
> even when there are some order-1 pages available.
> 
>> [330319.928124] Node 0 Normal free:12652kB min:14344kB low:19092kB=20
>> high:23840kB active_anon:55340kB inactive_anon:60276kB active_file:60kB
>> inactive_file:128kB unevictable:0kB writepending:4kB present:6220656kB
>> managed:4750196kB mlocked:0kB kernel_stack:9568kB pagetables:2756kB
>> bounce:0kB free_pcp:10056kB local_pcp:1376kB free_cma:0kB
> [...]
>> [330319.996879] Node 0 Normal: 3138*4kB (UME) 38*8kB (UM) 0*16kB 0*32kB
>> 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 12856kB
> 
> I do not see the state of swap in the oom splat so I assume you have
> swap disabled. If that is the case then the memory reclaim cannot really
> do much for this request. There is almost no page cache to reclaim.

No swap configured in our system.
> 
> That being said I do not see how a increased min_free_kbytes could help
> for this particular OOM situation. If there is really any relation it is
> more of a unintended side effect.

I haven't had a chance to rerun stress with kmem leak detection to know 
if we still see OOM kills after min_free_kbytes restore.
> 
> [...]
>>>> Extreme values can damage your system. Setting min_free_kbytes to an
>>>> extremely low value prevents the system from reclaiming memory, which can
>>>> result in system hangs and OOM-killing processes. However, setting
>>>> min_free_kbytes too high (for example, to 5–10% of total system memory)
>>>> causes the system to enter an out-of-memory state immediately, resulting in
>>>> the system spending too much time reclaiming memory.
>>>
>>> The auto tuned value should never reach such a low value to cause
>>> problems.
>>
>> The auto tuned value is incorrect post hotplug memory operation, in our use
>> case memoy hot add occurs very early during boot.
>   
> Define incorrect. What are the actual values? Have you tried to increase
> the value manually after the hotplug?

In our case SoC with 8GB memory, system tuned min_free_kbytes
- first to 22528
- we perform memory hot add very early in boot
- now min_free_kbytes is 8703

Before looking at code, first I manually restored min_free_kbytes soon 
after boot, reran stress and didn't notice symptoms I mentioned in 
change log.

Thanks,
Vijay
