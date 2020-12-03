Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B7F2CCB06
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 01:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgLCAdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 19:33:55 -0500
Received: from foss.arm.com ([217.140.110.172]:54716 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728455AbgLCAdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 19:33:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 767BA113E;
        Wed,  2 Dec 2020 16:33:08 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29EA03F575;
        Wed,  2 Dec 2020 16:33:05 -0800 (PST)
Subject: Re: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
 <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
 <20201202203233.GB11274@osiris>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <24905c32-f6c1-97a0-000f-f822b9870ea5@arm.com>
Date:   Thu, 3 Dec 2020 06:03:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202203233.GB11274@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/20 2:02 AM, Heiko Carstens wrote:
> On Mon, Nov 30, 2020 at 08:59:52AM +0530, Anshuman Khandual wrote:
>> This overrides arch_get_mappabble_range() on s390 platform and drops now
>> redundant similar check in vmem_add_mapping(). This compensates by adding
>> a new check __segment_load() to preserve the existing functionality.
>>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/s390/mm/extmem.c |  5 +++++
>>  arch/s390/mm/vmem.c   | 13 +++++++++----
>>  2 files changed, 14 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
>> index 5060956b8e7d..cc055a78f7b6 100644
>> --- a/arch/s390/mm/extmem.c
>> +++ b/arch/s390/mm/extmem.c
>> @@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
>>  		goto out_free_resource;
>>  	}
>>  
>> +	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
>> +		rc = -ERANGE;
>> +		goto out_resource;
>> +	}
>> +
>>  	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
>>  	if (rc)
>>  		goto out_resource;
>> diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
>> index b239f2ba93b0..06dddcc0ce06 100644
>> --- a/arch/s390/mm/vmem.c
>> +++ b/arch/s390/mm/vmem.c
>> @@ -532,14 +532,19 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
>>  	mutex_unlock(&vmem_mutex);
>>  }
>>  
>> +struct range arch_get_mappable_range(void)
>> +{
>> +	struct range memhp_range;
>> +
>> +	memhp_range.start = 0;
>> +	memhp_range.end =  VMEM_MAX_PHYS;
>> +	return memhp_range;
>> +}
>> +
>>  int vmem_add_mapping(unsigned long start, unsigned long size)
>>  {
>>  	int ret;
>>  
>> -	if (start + size > VMEM_MAX_PHYS ||
>> -	    start + size < start)
>> -		return -ERANGE;
>> -
> 
> I really fail to see how this could be considered an improvement for
> s390. Especially I do not like that the (central) range check is now
> moved to the caller (__segment_load). Which would mean potential
> additional future callers would have to duplicate that code as well.

The physical range check is being moved to the generic hotplug code
via arch_get_mappable_range() instead, making the existing check in
vmem_add_mapping() redundant. Dropping the check there necessitates
adding back a similar check in __segment_load(). Otherwise there
will be a loss of functionality in terms of range check.

May be we could just keep this existing check in vmem_add_mapping()
as well in order avoid this movement but then it would be redundant
check in every hotplug path.

So I guess the choice is to either have redundant range checks in
all hotplug paths or future internal callers of vmem_add_mapping()
take care of the range check.
