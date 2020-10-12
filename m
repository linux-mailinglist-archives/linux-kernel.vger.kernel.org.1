Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848D928AC4E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 04:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgJLCy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 22:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27024 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725917AbgJLCy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 22:54:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602471295;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyBvKJlwEt88IRf9EfgPjGolLJMwPUsWY1lJjJpIoqg=;
        b=h/5YTOebSmv3JAugn9+5jTpB8ParvWPqJGMuIahepfFatyBFP07yQ5uH41eiOYkr5fHWsb
        RnLo2Q5wC1nUZzJNO5JXEK+jRAJ4QT1wZ2eMbzruhajJPtPPFnBD77Un2KYzxZJTWMkZ48
        dyyAj7Jz8I2ODX2c96s9rXWVTciyJaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-IsD0W383MImwHkY_DoC6cA-1; Sun, 11 Oct 2020 22:54:51 -0400
X-MC-Unique: IsD0W383MImwHkY_DoC6cA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6612185A0C0;
        Mon, 12 Oct 2020 02:54:48 +0000 (UTC)
Received: from [10.64.54.32] (vpn2-54-32.bne.redhat.com [10.64.54.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C50345C225;
        Mon, 12 Oct 2020 02:54:42 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v3] arm64/mm: add fallback option to allocate virtually
 contiguous memory
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Sudarshan Rajagopalan <sudaraja@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>
References: <cover.1601582954.git.sudaraja@codeaurora.org>
 <9e6178d2828e9c36275487263c5842c688e5b731.1601582954.git.sudaraja@codeaurora.org>
 <49dd60a7-25f4-8dc1-b905-088dff2a84fb@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <c61139c9-0949-e602-f880-9731eafc7a67@redhat.com>
Date:   Mon, 12 Oct 2020 13:54:40 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <49dd60a7-25f4-8dc1-b905-088dff2a84fb@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/20 2:36 PM, Anshuman Khandual wrote:
> On 10/02/2020 01:46 AM, Sudarshan Rajagopalan wrote:
>> When section mappings are enabled, we allocate vmemmap pages from physically
>> continuous memory of size PMD_SIZE using vmemmap_alloc_block_buf(). Section
>> mappings are good to reduce TLB pressure. But when system is highly fragmented
>> and memory blocks are being hot-added at runtime, its possible that such
>> physically continuous memory allocations can fail. Rather than failing the
>> memory hot-add procedure, add a fallback option to allocate vmemmap pages from
>> discontinuous pages using vmemmap_populate_basepages().
>>
>> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> Cc: Logan Gunthorpe <logang@deltatee.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Steven Price <steven.price@arm.com>
>> ---
>>   arch/arm64/mm/mmu.c | 11 +++++++++--
>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>

It looks good to me with Anshuman's comments fixed:

Reviewed-by: Gavin Shan <gshan@redhat.com>

>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 75df62f..11f8639 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -1121,8 +1121,15 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
>>   			void *p = NULL;
>>   
>>   			p = vmemmap_alloc_block_buf(PMD_SIZE, node, altmap);
>> -			if (!p)
>> -				return -ENOMEM;
>> +			if (!p) {
>> +				/*
>> +				 * fallback allocating with virtually
>> +				 * contiguous memory for this section
>> +				 */
> 
> Mapping is always virtually contiguous with or without huge pages.
> Please drop this comment here, as it's obvious.
> 
>> +				if (vmemmap_populate_basepages(addr, next, node, NULL))
>> +					return -ENOMEM;
> 
> Please send in the 'altmap' instead of NULL for allocation from
> device memory if and when requested.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

