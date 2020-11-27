Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F7A2C60C7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 09:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgK0IWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 03:22:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:42979 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbgK0IWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 03:22:31 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Cj70L68dcz9tyqT;
        Fri, 27 Nov 2020 09:22:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NtGH_xBF8Vrp; Fri, 27 Nov 2020 09:22:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Cj70L5DgCz9tyqS;
        Fri, 27 Nov 2020 09:22:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B48428B811;
        Fri, 27 Nov 2020 09:22:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id oukQXGOE9kwa; Fri, 27 Nov 2020 09:22:26 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B1CD28B80F;
        Fri, 27 Nov 2020 09:22:25 +0100 (CET)
Subject: Re: [PATCH 1/2] mm/debug_vm_pgtable/basic: Add validation for
 dirtiness after write protect
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        steven.price@arm.com, gerald.schaefer@linux.ibm.com,
        vgupta@synopsys.com, paul.walmsley@sifive.com
References: <1606453584-15399-1-git-send-email-anshuman.khandual@arm.com>
 <1606453584-15399-2-git-send-email-anshuman.khandual@arm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a6f79aba-9f9f-326f-5d73-6e0175f554ab@csgroup.eu>
Date:   Fri, 27 Nov 2020 09:22:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606453584-15399-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 27/11/2020 à 06:06, Anshuman Khandual a écrit :
> This adds validation tests for dirtiness after write protect conversion for
> each page table level. This is important for platforms such as arm64 that
> removes the hardware dirty bit while making it an write protected one. This
> also fixes pxx_wrprotect() related typos in the documentation file.
> 


> diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> index c05d9dcf7891..a5be11210597 100644
> --- a/mm/debug_vm_pgtable.c
> +++ b/mm/debug_vm_pgtable.c
> @@ -70,6 +70,7 @@ static void __init pte_basic_tests(unsigned long pfn, pgprot_t prot)
>   	WARN_ON(pte_young(pte_mkold(pte_mkyoung(pte))));
>   	WARN_ON(pte_dirty(pte_mkclean(pte_mkdirty(pte))));
>   	WARN_ON(pte_write(pte_wrprotect(pte_mkwrite(pte))));
> +	WARN_ON(pte_dirty(pte_wrprotect(pte)));

Wondering what you are testing here exactly.

Do you expect that if PTE has the dirty bit, it gets cleared by pte_wrprotect() ?

Powerpc doesn't do that, it only clears the RW bit but the dirty bit remains if it is set, until you 
call pte_mkclean() explicitely.

>   }
>   
>   static void __init pte_advanced_tests(struct mm_struct *mm,
> @@ -144,6 +145,7 @@ static void __init pmd_basic_tests(unsigned long pfn, pgprot_t prot)
>   	WARN_ON(pmd_young(pmd_mkold(pmd_mkyoung(pmd))));
>   	WARN_ON(pmd_dirty(pmd_mkclean(pmd_mkdirty(pmd))));
>   	WARN_ON(pmd_write(pmd_wrprotect(pmd_mkwrite(pmd))));
> +	WARN_ON(pmd_dirty(pmd_wrprotect(pmd)));
>   	/*
>   	 * A huge page does not point to next level page table
>   	 * entry. Hence this must qualify as pmd_bad().
> @@ -262,6 +264,7 @@ static void __init pud_basic_tests(unsigned long pfn, pgprot_t prot)
>   	WARN_ON(!pud_write(pud_mkwrite(pud_wrprotect(pud))));
>   	WARN_ON(pud_write(pud_wrprotect(pud_mkwrite(pud))));
>   	WARN_ON(pud_young(pud_mkold(pud_mkyoung(pud))));
> +	WARN_ON(pud_dirty(pud_wrprotect(pud)));
>   
>   	if (mm_pmd_folded(mm))
>   		return;
> 

Christophe
