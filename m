Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035A22FCCBB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbhATIaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:30:20 -0500
Received: from foss.arm.com ([217.140.110.172]:49836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730313AbhATI3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:29:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE2A611B3;
        Wed, 20 Jan 2021 00:28:13 -0800 (PST)
Received: from [10.163.90.172] (unknown [10.163.90.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FC453F68F;
        Wed, 20 Jan 2021 00:28:09 -0800 (PST)
Subject: Re: [PATCH V3 3/3] s390/mm: Define arch_get_mappable_range()
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1610975582-12646-1-git-send-email-anshuman.khandual@arm.com>
 <1610975582-12646-4-git-send-email-anshuman.khandual@arm.com>
 <cbdb32af-74af-ceb2-fa68-3912ef20d784@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a58eb974-4700-d877-7033-4ad6dfd2476f@arm.com>
Date:   Wed, 20 Jan 2021 13:58:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cbdb32af-74af-ceb2-fa68-3912ef20d784@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/21 5:56 PM, David Hildenbrand wrote:
> On 18.01.21 14:13, Anshuman Khandual wrote:
>> This overrides arch_get_mappabble_range() on s390 platform which will be
>> used with recently added generic framework. It modifies the existing range
>> check in vmem_add_mapping() using arch_get_mappable_range(). It also adds a
>> VM_BUG_ON() check that would ensure that memhp_range_allowed() has already
>> been called on the hotplug path.
>>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/s390/mm/init.c |  1 +
>>  arch/s390/mm/vmem.c | 15 ++++++++++++++-
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
>> index 73a163065b95..97017a4bcc90 100644
>> --- a/arch/s390/mm/init.c
>> +++ b/arch/s390/mm/init.c
>> @@ -297,6 +297,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>>  	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>>  		return -EINVAL;
>>  
>> +	VM_BUG_ON(!memhp_range_allowed(start, size, true));
>>  	rc = vmem_add_mapping(start, size);
>>  	if (rc)
>>  		return rc;
>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>> index 01f3a5f58e64..afc39ff1cc8d 100644
>> --- a/arch/s390/mm/vmem.c
>> +++ b/arch/s390/mm/vmem.c
>> @@ -4,6 +4,7 @@
>>   *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
>>   */
>>  
>> +#include <linux/memory_hotplug.h>
>>  #include <linux/memblock.h>
>>  #include <linux/pfn.h>
>>  #include <linux/mm.h>
>> @@ -532,11 +533,23 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>  	mutex_unlock(&vmem_mutex);
>>  }
>>  
>> +struct range arch_get_mappable_range(void)
>> +{
>> +	struct range memhp_range;
> 
> You could do:
> 
> memhp_range = {
> 	.start = 0,
> 	.end =  VMEM_MAX_PHYS - 1,
> };
> 
> Similar in the arm64 patch.

There is a comment block just before this assignment on arm64. Also
it seems like code style preference and Heiko had originally agreed
on this particular patch. Could we just leave it unchanged please ?

> 
>> +
>> +	memhp_range.start = 0;
>> +	memhp_range.end =  VMEM_MAX_PHYS - 1;
>> +	return memhp_range;
>> +}
>> +
>>  int vmem_add_mapping(unsigned long start, unsigned long size)
>>  {
>> +	struct range range;
>>  	int ret;
>>  
>> -	if (start + size > VMEM_MAX_PHYS ||
>> +	range = arch_get_mappable_range();
> 
> You could do
> 
> struct range range = arch_get_mappable_range();

Sure, will change this though.

> 
>> +	if (start < range.start ||
>> +	    start + size > range.end + 1 ||
>>  	    start + size < start)
>>  		return -ERANGE;
>>  
>>
> 
> 
