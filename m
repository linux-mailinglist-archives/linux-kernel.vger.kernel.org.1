Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920BE274235
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 14:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgIVMjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 08:39:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20920 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbgIVMjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 08:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600778390;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=crR5PthBpxzdqlujeZdFZGroLo+fuRCA0PMiWNcld80=;
        b=JFLyOxG6eyvlXkWIFBTQHZ5nAdAMaEU9srhmjim31zvzh80c4tIr2uQHAn+4K8rT8XtCoD
        JkBo0dugr7k21VjcfIL3hYfFR2ghcYxvxLimcIt4K/wO7bAEMVKn8LVFrfIabsTb8oJa7k
        nNvnhojUXyyTW0hjbzxZyAOdMNPTuPU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-GsHIGEyCOaqd5V5f7FTIUw-1; Tue, 22 Sep 2020 08:39:48 -0400
X-MC-Unique: GsHIGEyCOaqd5V5f7FTIUw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B65D364083;
        Tue, 22 Sep 2020 12:39:46 +0000 (UTC)
Received: from [10.64.54.30] (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 360385C1A3;
        Tue, 22 Sep 2020 12:39:43 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 2/2] arm64/mm: Enable color zero pages
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, catalin.marinas@arm.com,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com,
        linux-arm-kernel@lists.infradead.org
References: <20200916032523.13011-1-gshan@redhat.com>
 <20200916032523.13011-3-gshan@redhat.com>
 <20200916082819.GB27496@willie-the-truck>
 <c1b79a8c-e5a5-f375-87e1-20bbc5cc2707@redhat.com>
 <33e9a04e-9f93-6a06-273d-284900bc1535@arm.com>
 <968a5ae7-ebed-8191-15df-6c9860dc72fe@redhat.com>
 <e6ceee8d-3e50-7abc-da3a-fe688cab46b6@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <40ef213c-d74a-6d42-7e02-ae14ad622b4e@redhat.com>
Date:   Tue, 22 Sep 2020 22:39:40 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <e6ceee8d-3e50-7abc-da3a-fe688cab46b6@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 9/21/20 10:40 PM, Anshuman Khandual wrote:
> On 09/21/2020 08:26 AM, Gavin Shan wrote:
>> On 9/17/20 8:22 PM, Robin Murphy wrote:
>>> On 2020-09-17 04:35, Gavin Shan wrote:
>>>> On 9/16/20 6:28 PM, Will Deacon wrote:
>>>>> On Wed, Sep 16, 2020 at 01:25:23PM +1000, Gavin Shan wrote:
>>>>>> This enables color zero pages by allocating contigous page frames
>>>>>> for it. The number of pages for this is determined by L1 dCache
>>>>>> (or iCache) size, which is probbed from the hardware.
>>>>>>
>>>>>>      * Add cache_total_size() to return L1 dCache (or iCache) size
>>>>>>
>>>>>>      * Implement setup_zero_pages(), which is called after the page
>>>>>>        allocator begins to work, to allocate the contigous pages
>>>>>>        needed by color zero page.
>>>>>>
>>>>>>      * Reworked ZERO_PAGE() and define __HAVE_COLOR_ZERO_PAGE.
>>>>>>
>>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>>> ---
>>>>>>    arch/arm64/include/asm/cache.h   | 22 ++++++++++++++++++++
>>>>>>    arch/arm64/include/asm/pgtable.h |  9 ++++++--
>>>>>>    arch/arm64/kernel/cacheinfo.c    | 34 +++++++++++++++++++++++++++++++
>>>>>>    arch/arm64/mm/init.c             | 35 ++++++++++++++++++++++++++++++++
>>>>>>    arch/arm64/mm/mmu.c              |  7 -------
>>>>>>    5 files changed, 98 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
>>>>>> index a4d1b5f771f6..420e9dde2c51 100644
>>>>>> --- a/arch/arm64/include/asm/cache.h
>>>>>> +++ b/arch/arm64/include/asm/cache.h
>>>>>> @@ -39,6 +39,27 @@
>>>>>>    #define CLIDR_LOC(clidr)    (((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
>>>>>>    #define CLIDR_LOUIS(clidr)    (((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
>>>>>> +#define CSSELR_TND_SHIFT    4
>>>>>> +#define CSSELR_TND_MASK        (UL(1) << CSSELR_TND_SHIFT)
>>>>>> +#define CSSELR_LEVEL_SHIFT    1
>>>>>> +#define CSSELR_LEVEL_MASK    (UL(7) << CSSELR_LEVEL_SHIFT)
>>>>>> +#define CSSELR_IND_SHIFT    0
>>>>>> +#define CSSERL_IND_MASK        (UL(1) << CSSELR_IND_SHIFT)
>>>>>> +
>>>>>> +#define CCSIDR_64_LS_SHIFT    0
>>>>>> +#define CCSIDR_64_LS_MASK    (UL(7) << CCSIDR_64_LS_SHIFT)
>>>>>> +#define CCSIDR_64_ASSOC_SHIFT    3
>>>>>> +#define CCSIDR_64_ASSOC_MASK    (UL(0x1FFFFF) << CCSIDR_64_ASSOC_SHIFT)
>>>>>> +#define CCSIDR_64_SET_SHIFT    32
>>>>>> +#define CCSIDR_64_SET_MASK    (UL(0xFFFFFF) << CCSIDR_64_SET_SHIFT)
>>>>>> +
>>>>>> +#define CCSIDR_32_LS_SHIFT    0
>>>>>> +#define CCSIDR_32_LS_MASK    (UL(7) << CCSIDR_32_LS_SHIFT)
>>>>>> +#define CCSIDR_32_ASSOC_SHIFT    3
>>>>>> +#define CCSIDR_32_ASSOC_MASK    (UL(0x3FF) << CCSIDR_32_ASSOC_SHIFT)
>>>>>> +#define CCSIDR_32_SET_SHIFT    13
>>>>>> +#define CCSIDR_32_SET_MASK    (UL(0x7FFF) << CCSIDR_32_SET_SHIFT)
>>>>>

[...]

>> Ok. If this was proposed before, I'm not sure if the link to that
>> patchset is still available? :)
>>
>> When I was searching "my_zero_pfn" in upstream kernel, DAX uses the
>> zero pages to fill the holes in one particular file in dax_load_hole().
>> mmap() on /proc/kcore could use zero page either.
> 
> But how often those mapped areas will be used afterwards either in DAX
> or /proc/kcore ? It seems like the minimal adaption for this feature so
> far on platforms (i.e s390 and mips) might have to do with real world
> workload's frequency of such read accesses on mapped areas using zero
> pages.
> 

I don't think /proc/kcore is used frequently in real world, still depending
on the workload. DAX has been supported by multiple filesystems (ext2/ext4/
xfs). Taking ext4 as an example, all allocated extents (blocks), which isn't
be written with the data. The data is retrieved from the zero page. I guess
this intends to avoid exposing data, which was written by previous user for
safety reason. This would be common case and heavily depend on read performance
on zero page. Besides, holes (blocks) in ext4 are also backed by zero pages
and it would happen frequently.

However, I'm not a filesystem guy. I checked the code and understood the code
as above, but I might be wrong completely here.

Yeah, I failed to understand why this feature was enabled on s390/mips from
the corresponding commit logs. Nothing helpful is provided there. I guess
some specific S390/MIPS CPUs have large L1 cache capacity, multiple page
sizes in one set. In this case, multiple (color) zero pages can avoid
the cache line collisions on reading these pages. However, I'm not sure
about arm64. On the CPU where I had my experiment, there is 8-ways/64-sets
and 32KB L1 dCache and iCache, meaning 4KB L1 cache in one particular set.

This feature has low cost to be enabled as several extra pages are needed
and not harmful at least as I can see.

[...]

Thanks,
Gavin

