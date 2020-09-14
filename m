Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B02268430
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 07:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgINFnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 01:43:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33969 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgINFnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 01:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600062201;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ml+M7Pfjeeb8Ld7vgQDD1AicYUBveLhDNpcZWgWrxQM=;
        b=Fg9pjoMMPYIQmKbabF9P50BRN84tgFpqYgbW3l2/OKZGuM9ap6pERGJ0jMmd7d+Hz36ssL
        /7hoKzsLwnhS3q8laJkAJdMEF6O+2IFdRtzpCMLGb2kiLxklS9p50RV65awMUhzOcwbrqJ
        4CeqVu3WNSqTgsAnHSLJcVaVpLNfZRo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-8uUj53KoNNmAQtFmQML2SA-1; Mon, 14 Sep 2020 01:43:17 -0400
X-MC-Unique: 8uUj53KoNNmAQtFmQML2SA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6CA431007465;
        Mon, 14 Sep 2020 05:43:16 +0000 (UTC)
Received: from [10.64.54.46] (vpn2-54-46.bne.redhat.com [10.64.54.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3078C5D98C;
        Mon, 14 Sep 2020 05:43:13 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] arm64/mm: Refactor {pgd, pud, pmd, pte}_ERROR()
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20200913234730.23145-1-gshan@redhat.com>
 <fe0747b3-fca9-12e0-37ae-cf3cb9efbe9e@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <6fa71854-b124-6366-f6da-599ea946c5bc@redhat.com>
Date:   Mon, 14 Sep 2020 15:43:12 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <fe0747b3-fca9-12e0-37ae-cf3cb9efbe9e@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 9/14/20 3:31 PM, Anshuman Khandual wrote:
> On 09/14/2020 05:17 AM, Gavin Shan wrote:
>> The function __{pgd, pud, pmd, pte}_error() are introduced so that
>> they can be called by {pgd, pud, pmd, pte}_ERROR(). However, some
>> of the functions could never be called when the corresponding page
>> table level isn't enabled. For example, __{pud, pmd}_error() are
>> unused when PUD and PMD are folded to PGD.
> 
> Right, it makes sense not to have these helpers generally available.
> Given pxx_ERROR() is enabled only when required page table level is
> available, with a CONFIG_PGTABLE_LEVEL check.
> 

Yep.

>>
>> This removes __{pgd, pud, pmd, pte}_error() and call pr_err() from
>> {pgd, pud, pmd, pte}_ERROR() directly, similar to what x86/powerpc
>> are doing. With this, the code looks a bit simplified either.
> 
> Do we need p4d_ERROR() here as well !
> 

p4d_ERROR() is defined in include/asm-generic/pgtable-nop4d.h, which
is always included because we have 4 levels of page tables to the
maximum.

>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v2: Fix build warning caused by wrong printk format
>> ---
>>   arch/arm64/include/asm/pgtable.h | 17 ++++++++---------
>>   arch/arm64/kernel/traps.c        | 20 --------------------
>>   2 files changed, 8 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index d5d3fbe73953..e0ab81923c30 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -35,11 +35,6 @@
>>   
>>   extern struct page *vmemmap;
>>   
>> -extern void __pte_error(const char *file, int line, unsigned long val);
>> -extern void __pmd_error(const char *file, int line, unsigned long val);
>> -extern void __pud_error(const char *file, int line, unsigned long val);
>> -extern void __pgd_error(const char *file, int line, unsigned long val);
>> -
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>>   
>> @@ -57,7 +52,8 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>>   extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>>   #define ZERO_PAGE(vaddr)	phys_to_page(__pa_symbol(empty_zero_page))
>>   
>> -#define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
>> +#define pte_ERROR(e)	\
>> +	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
>>   
>>   /*
>>    * Macros to convert between a physical address and its placement in a
>> @@ -541,7 +537,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>>   
>>   #if CONFIG_PGTABLE_LEVELS > 2
>>   
>> -#define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
>> +#define pmd_ERROR(e)	\
>> +	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
>>   
>>   #define pud_none(pud)		(!pud_val(pud))
>>   #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
>> @@ -608,7 +605,8 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
>>   
>>   #if CONFIG_PGTABLE_LEVELS > 3
>>   
>> -#define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
>> +#define pud_ERROR(e)	\
>> +	pr_err("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
>>   
>>   #define p4d_none(p4d)		(!p4d_val(p4d))
>>   #define p4d_bad(p4d)		(!(p4d_val(p4d) & 2))
>> @@ -667,7 +665,8 @@ static inline unsigned long p4d_page_vaddr(p4d_t p4d)
>>   
>>   #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
>>   
>> -#define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
>> +#define pgd_ERROR(e)	\
>> +	pr_err("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
> 
> A line break in these macros might not be required any more, as checkpatch.pl
> now accepts bit longer lines.
> 

Correct, but I guess it's nice to limit the width to 80 characters :)

>>   
>>   #define pgd_set_fixmap(addr)	((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
>>   #define pgd_clear_fixmap()	clear_fixmap(FIX_PGD)
>> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
>> index 13ebd5ca2070..12fba7136dbd 100644
>> --- a/arch/arm64/kernel/traps.c
>> +++ b/arch/arm64/kernel/traps.c
>> @@ -935,26 +935,6 @@ asmlinkage void enter_from_user_mode(void)
>>   }
>>   NOKPROBE_SYMBOL(enter_from_user_mode);
>>   
>> -void __pte_error(const char *file, int line, unsigned long val)
>> -{
>> -	pr_err("%s:%d: bad pte %016lx.\n", file, line, val);
>> -}
>> -
>> -void __pmd_error(const char *file, int line, unsigned long val)
>> -{
>> -	pr_err("%s:%d: bad pmd %016lx.\n", file, line, val);
>> -}
>> -
>> -void __pud_error(const char *file, int line, unsigned long val)
>> -{
>> -	pr_err("%s:%d: bad pud %016lx.\n", file, line, val);
>> -}
>> -
>> -void __pgd_error(const char *file, int line, unsigned long val)
>> -{
>> -	pr_err("%s:%d: bad pgd %016lx.\n", file, line, val);
>> -}
> 
> While moving %016lx now becomes %016llx. I guess this should be okay.
> Looks much cleaner to have removed these helpers from trap.c
> 

Yep.

>> -
>>   /* GENERIC_BUG traps */
>>   
>>   int is_valid_bugaddr(unsigned long addr)
>>
> 

Thanks,
Gavin

