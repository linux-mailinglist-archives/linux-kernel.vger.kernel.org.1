Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45635302429
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbhAYLRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:17:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727752AbhAYLFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 06:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611572580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYrCK4S5sMWEuFTQpwhFCN56OBkg294iDAFXHwV5Xao=;
        b=bS+0dwqkR6dkSCt7tbKIAuheKcD89hLTcq6GR2gHwWO5es0HkM1fGgsfpvrYBzI/8KIZ6P
        O0+jMIw+YOP2TmdE23gEaWzDbzZj6g2ScNoOiDEQe2AMi2rQ+snYDPVr9vvKevCchjUFLk
        SXEASZg4vAMzwvnPy+D1rU3R2PmvMGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-H9fHBhPoPmeWcgTVHCKsog-1; Mon, 25 Jan 2021 06:02:58 -0500
X-MC-Unique: H9fHBhPoPmeWcgTVHCKsog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79F89801AC3;
        Mon, 25 Jan 2021 11:02:56 +0000 (UTC)
Received: from [10.36.115.13] (ovpn-115-13.ams2.redhat.com [10.36.115.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD1DF1981B;
        Mon, 25 Jan 2021 11:02:54 +0000 (UTC)
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
To:     Oscar Salvador <osalvador@suse.de>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
 <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
 <20210125103951.GA27851@linux> <20210125105557.GA28363@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <64b0dca6-4460-ec6c-66f6-88db24ec288f@redhat.com>
Date:   Mon, 25 Jan 2021 12:02:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210125105557.GA28363@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.01.21 11:56, Oscar Salvador wrote:
> On Mon, Jan 25, 2021 at 11:39:55AM +0100, Oscar Salvador wrote:
>>> Interresting, so we automatically support differeing sizeof(struct
>>> page). I guess it will be problematic in case of sizeof(struct page) !=
>>> 64, because then, we might not have multiples of 2MB for the memmap of a
>>> memory block.
>>>
>>> IIRC, it could happen that if we add two consecutive memory blocks, that
>>> the second one might reuse parts of the vmemmap residing on the first
>>> memory block. If you remove the first one, you might be in trouble.
>>>
>>> E.g., on x86-64
>>>  vmemmap_populate()->vmemmap_populate_hugepages()->vmemmap_alloc_block_buf():
>>> - Populate a huge page
>>>
>>> vmemmap_free()->remove_pagetable()...->remove_pmd_table():
>>> - memchr_inv() will leave the hugepage populated.
>>>
>>> Do we want to fence that off, maybe in mhp_supports_memmap_on_memory()?
>>> Or do we somehow want to fix that? We should never populate partial huge
>>> pages from an altmap ...
>>>
>>> But maybe I am missing something.
>>
>> No, you are not missing anything.
>>
>> I think that remove_pmd_table() should be fixed.
>> vmemmap_populate_hugepages() allocates PMD_SIZE chunk and marks the PMD as
>> PAGE_KERNEL_LARGE, so when remove_pmd_table() sees that 1) the PMD
>> is large and 2) the chunk is not aligned, the memset() should be writing
>> PAGE_INUSE for a PMD chunk.
>>
>> I do not really a see a reason why this should not happen.
>> Actually, we will be leaving pagetables behind as we never get to free
>> the PMD chunk when sizeof(struct page) is not a multiple of 2MB.
>>
>> I plan to fix remove_pmd_table(), but for now let us not allow to use this feature
>> if the size of a struct page is not 64.
>> Let us keep it simply for the time being, shall we?
> 
> My first intention was:
> 
> diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> index b5a3fa4033d3..0c9756a2eb24 100644
> --- a/arch/x86/mm/init_64.c
> +++ b/arch/x86/mm/init_64.c
> @@ -1044,32 +1044,14 @@ remove_pmd_table(pmd_t *pmd_start, unsigned long addr, unsigned long end,
>  			continue;
>  
>  		if (pmd_large(*pmd)) {
> -			if (IS_ALIGNED(addr, PMD_SIZE) &&
> -			    IS_ALIGNED(next, PMD_SIZE)) {
> -				if (!direct)
> -					free_hugepage_table(pmd_page(*pmd),
> -							    altmap);
> -
> -				spin_lock(&init_mm.page_table_lock);
> -				pmd_clear(pmd);
> -				spin_unlock(&init_mm.page_table_lock);
> -				pages++;
> -			} else {
> -				/* If here, we are freeing vmemmap pages. */
> -				memset((void *)addr, PAGE_INUSE, next - addr);
> -
> -				page_addr = page_address(pmd_page(*pmd));
> -				if (!memchr_inv(page_addr, PAGE_INUSE,
> -						PMD_SIZE)) {
> -					free_hugepage_table(pmd_page(*pmd),
> -							    altmap);
> -
> -					spin_lock(&init_mm.page_table_lock);
> -					pmd_clear(pmd);
> -					spin_unlock(&init_mm.page_table_lock);
> -				}
> -			}
> +			if (!direct)
> +				free_hugepage_table(pmd_page(*pmd),
> +						    altmap);
>  
> +			spin_lock(&init_mm.page_table_lock);
> +			pmd_clear(pmd);
> +			spin_unlock(&init_mm.page_table_lock);
> +			pages++;
>  			continue;
>  		}
> 
> I did not try it out yet and this might explode badly, but AFAICS, a PMD size
> chunk is always allocated even when the section does not spand 2MB.
> E.g: sizeof(struct page) = 56.
> 
> PAGES_PER_SECTION * 64 = 2097152
> PAGES_PER_SECTION * 56 = 1835008
> 
> Even in the latter case, vmemmap_populate_hugepages will allocate a PMD size chunk
> to satisfy the unaligned range.
> So, unless I am missing something, it should not be a problem to free that 2MB in
> remove_pmd_table when 1) the PMD is large and 2) the range is not aligned.

Assume you have two consecutive memory blocks with 56 sizeof(struct page).
The first one allocates a PMD (2097152) but only consumes 1835008, the second
one reuses the remaining part and allocates another PMD (1835008),
only using parts of it.

Ripping out a memory block, along with the PMD in the vmemmap would
remove parts of the vmemmap of another memory block.

You might want to take a look at:

commit 2c114df071935762ffa88144cdab03d84beaa702
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Jul 22 11:45:58 2020 +0200

    s390/vmemmap: avoid memset(PAGE_UNUSED) when adding consecutive sections
    
    Let's avoid memset(PAGE_UNUSED) when adding consecutive sections,
    whereby the vmemmap of a single section does not span full PMDs.
    
    Cc: Vasily Gorbik <gor@linux.ibm.com>
    Cc: Christian Borntraeger <borntraeger@de.ibm.com>
    Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
    Signed-off-by: David Hildenbrand <david@redhat.com>
    Message-Id: <20200722094558.9828-10-david@redhat.com>
    Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

commit cd5781d63eaf6dbf89532d8c7c214786b767ee16
Author: David Hildenbrand <david@redhat.com>
Date:   Wed Jul 22 11:45:57 2020 +0200

    s390/vmemmap: remember unused sub-pmd ranges
    
    With a memmap size of 56 bytes or 72 bytes per page, the memmap for a
    256 MB section won't span full PMDs. As we populate single sections and
    depopulate single sections, the depopulation step would not be able to
    free all vmemmap pmds anymore.
    
    Do it similarly to x86, marking the unused memmap ranges in a special way
    (pad it with 0xFD).
    
    This allows us to add/remove sections, cleaning up all allocated
    vmemmap pages even if the memmap size is not multiple of 16 bytes per page.
    
    A 56 byte memmap can, for example, be created with !CONFIG_MEMCG and
    !CONFIG_SLUB.
    
    Cc: Vasily Gorbik <gor@linux.ibm.com>
    Cc: Christian Borntraeger <borntraeger@de.ibm.com>
    Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
    Signed-off-by: David Hildenbrand <david@redhat.com>
    Message-Id: <20200722094558.9828-9-david@redhat.com>
    Signed-off-by: Heiko Carstens <hca@linux.ibm.com>


But again, the root issue I see is that we can play such games with anonymous pages, but not with
memory residing in the altmap space.

-- 
Thanks,

David / dhildenb

