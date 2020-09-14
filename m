Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F11A2684AB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 08:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgINGSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 02:18:34 -0400
Received: from foss.arm.com ([217.140.110.172]:59048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgINGSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 02:18:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBEFFD6E;
        Sun, 13 Sep 2020 23:18:30 -0700 (PDT)
Received: from [10.163.73.47] (unknown [10.163.73.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95E913F73B;
        Sun, 13 Sep 2020 23:18:28 -0700 (PDT)
Subject: Re: [PATCH v2] arm64/mm: Refactor {pgd, pud, pmd, pte}_ERROR()
To:     Gavin Shan <gshan@redhat.com>, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20200913234730.23145-1-gshan@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <49a724f5-43ea-f09b-4de1-c274f4473b08@arm.com>
Date:   Mon, 14 Sep 2020 11:47:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200913234730.23145-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/14/2020 05:17 AM, Gavin Shan wrote:
> The function __{pgd, pud, pmd, pte}_error() are introduced so that
> they can be called by {pgd, pud, pmd, pte}_ERROR(). However, some
> of the functions could never be called when the corresponding page
> table level isn't enabled. For example, __{pud, pmd}_error() are
> unused when PUD and PMD are folded to PGD.
> 
> This removes __{pgd, pud, pmd, pte}_error() and call pr_err() from
> {pgd, pud, pmd, pte}_ERROR() directly, similar to what x86/powerpc
> are doing. With this, the code looks a bit simplified either.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v2: Fix build warning caused by wrong printk format
> ---
>  arch/arm64/include/asm/pgtable.h | 17 ++++++++---------
>  arch/arm64/kernel/traps.c        | 20 --------------------
>  2 files changed, 8 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index d5d3fbe73953..e0ab81923c30 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -35,11 +35,6 @@
>  
>  extern struct page *vmemmap;
>  
> -extern void __pte_error(const char *file, int line, unsigned long val);
> -extern void __pmd_error(const char *file, int line, unsigned long val);
> -extern void __pud_error(const char *file, int line, unsigned long val);
> -extern void __pgd_error(const char *file, int line, unsigned long val);
> -
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>  
> @@ -57,7 +52,8 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
>  extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>  #define ZERO_PAGE(vaddr)	phys_to_page(__pa_symbol(empty_zero_page))
>  
> -#define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
> +#define pte_ERROR(e)	\
> +	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
>  
>  /*
>   * Macros to convert between a physical address and its placement in a
> @@ -541,7 +537,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  
>  #if CONFIG_PGTABLE_LEVELS > 2
>  
> -#define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
> +#define pmd_ERROR(e)	\
> +	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
>  
>  #define pud_none(pud)		(!pud_val(pud))
>  #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
> @@ -608,7 +605,8 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
>  
>  #if CONFIG_PGTABLE_LEVELS > 3
>  
> -#define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
> +#define pud_ERROR(e)	\
> +	pr_err("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
>  
>  #define p4d_none(p4d)		(!p4d_val(p4d))
>  #define p4d_bad(p4d)		(!(p4d_val(p4d) & 2))
> @@ -667,7 +665,8 @@ static inline unsigned long p4d_page_vaddr(p4d_t p4d)
>  
>  #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
>  
> -#define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
> +#define pgd_ERROR(e)	\
> +	pr_err("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
>  
>  #define pgd_set_fixmap(addr)	((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
>  #define pgd_clear_fixmap()	clear_fixmap(FIX_PGD)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 13ebd5ca2070..12fba7136dbd 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -935,26 +935,6 @@ asmlinkage void enter_from_user_mode(void)
>  }
>  NOKPROBE_SYMBOL(enter_from_user_mode);
>  
> -void __pte_error(const char *file, int line, unsigned long val)
> -{
> -	pr_err("%s:%d: bad pte %016lx.\n", file, line, val);
> -}
> -
> -void __pmd_error(const char *file, int line, unsigned long val)
> -{
> -	pr_err("%s:%d: bad pmd %016lx.\n", file, line, val);
> -}
> -
> -void __pud_error(const char *file, int line, unsigned long val)
> -{
> -	pr_err("%s:%d: bad pud %016lx.\n", file, line, val);
> -}
> -
> -void __pgd_error(const char *file, int line, unsigned long val)
> -{
> -	pr_err("%s:%d: bad pgd %016lx.\n", file, line, val);
> -}
> -
>  /* GENERIC_BUG traps */
>  
>  int is_valid_bugaddr(unsigned long addr)
> 

Looks good to me. Seems like a sensible clean up which reduces code.
Tried booting on multiple page size configs and see no regression.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
