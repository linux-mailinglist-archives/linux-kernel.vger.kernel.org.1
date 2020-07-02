Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D32122FD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 14:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgGBMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 08:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgGBMLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:11:40 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64C2120772;
        Thu,  2 Jul 2020 12:11:38 +0000 (UTC)
Date:   Thu, 2 Jul 2020 13:11:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        will@kernel.org, mark.rutland@arm.com, ziy@nvidia.com,
        Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC V2 1/2] arm64/mm: Change THP helpers per generic memory
 semantics
Message-ID: <20200702121135.GD22241@gaia>
References: <1592226918-26378-1-git-send-email-anshuman.khandual@arm.com>
 <1592226918-26378-2-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592226918-26378-2-git-send-email-anshuman.khandual@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On Mon, Jun 15, 2020 at 06:45:17PM +0530, Anshuman Khandual wrote:
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -353,15 +353,92 @@ static inline int pmd_protnone(pmd_t pmd)
>  }
>  #endif
>  
> +#define pmd_table(pmd)	((pmd_val(pmd) & PMD_TYPE_MASK) ==  PMD_TYPE_TABLE)
> +#define pmd_sect(pmd)	((pmd_val(pmd) & PMD_TYPE_MASK) ==  PMD_TYPE_SECT)
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  /*
> - * THP definitions.
> + * PMD Level Encoding (THP Enabled)
> + *
> + * 0b00 - Not valid	Not present	NA
> + * 0b10 - Not valid	Present		Huge  (Splitting)
> + * 0b01 - Valid		Present		Huge  (Mapped)
> + * 0b11 - Valid		Present		Table (Mapped)
>   */

I wonder whether it would be easier to read if we add a dedicated
PMD_SPLITTING bit, only when bit 0 is cleared. This bit can be high (say
59), it doesn't really matter as the entry is not valid.

The only doubt I have is that pmd_mkinvalid() is used in other contexts
when it's not necessarily splitting a pmd (search for the
pmdp_invalidate() calls). So maybe a better name like PMD_PRESENT with a
comment that pmd_to_page() is valid (i.e. no migration or swap entry).
Feel free to suggest a better name.

> +static inline pmd_t pmd_mksplitting(pmd_t pmd)
> +{
> +	unsigned long val = pmd_val(pmd);
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -#define pmd_trans_huge(pmd)	(pmd_val(pmd) && !(pmd_val(pmd) & PMD_TABLE_BIT))
> +	return __pmd((val & ~PMD_TYPE_MASK) | PMD_TABLE_BIT);
> +}
> +
> +static inline pmd_t pmd_clrsplitting(pmd_t pmd)
> +{
> +	unsigned long val = pmd_val(pmd);
> +
> +	return __pmd((val & ~PMD_TYPE_MASK) | PMD_TYPE_SECT);
> +}
> +
> +static inline bool pmd_splitting(pmd_t pmd)
> +{
> +	unsigned long val = pmd_val(pmd);
> +
> +	if ((val & PMD_TYPE_MASK) == PMD_TABLE_BIT)
> +		return true;
> +	return false;
> +}
> +
> +static inline bool pmd_mapped(pmd_t pmd)
> +{
> +	return pmd_sect(pmd);
> +}
> +
> +static inline pmd_t pmd_mkinvalid(pmd_t pmd)
> +{
> +	/*
> +	 * Invalidation should not have been invoked on
> +	 * a PMD table entry. Just warn here otherwise.
> +	 */
> +	WARN_ON(pmd_table(pmd));
> +	return pmd_mksplitting(pmd);
> +}

And here we wouldn't need t worry about table checks.

> +static inline int pmd_present(pmd_t pmd);
> +
> +static inline int pmd_trans_huge(pmd_t pmd)
> +{
> +	if (!pmd_present(pmd))
> +		return 0;
> +
> +	if (!pmd_val(pmd))
> +		return 0;
> +
> +	if (pmd_mapped(pmd))
> +		return 1;
> +
> +	if (pmd_splitting(pmd))
> +		return 1;
> +	return 0;

Doesn't your new pmd_present() already check for splitting? I think
checking for bit 0 and the new PMD_PRESENT. That would be similar to
what we do with PTE_PROT_NONE. Actually, you could use the same bit for
both.

> +}
> +
> +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +		pmd_t *pmdp, pmd_t pmd);
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> -#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
> +static inline int pmd_present(pmd_t pmd)
> +{
> +	pte_t pte = pmd_pte(pmd);
> +
> +	if (pte_present(pte))
> +		return 1;
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	if (pmd_splitting(pmd))
> +		return 1;
> +#endif
> +	return 0;
> +}

[...]

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 990929c8837e..337519031115 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -22,6 +22,8 @@
>  #include <linux/io.h>
>  #include <linux/mm.h>
>  #include <linux/vmalloc.h>
> +#include <linux/swap.h>
> +#include <linux/swapops.h>
>  
>  #include <asm/barrier.h>
>  #include <asm/cputype.h>
> @@ -1483,3 +1485,21 @@ static int __init prevent_bootmem_remove_init(void)
>  }
>  device_initcall(prevent_bootmem_remove_init);
>  #endif
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +		pmd_t *pmdp, pmd_t pmd)
> +{
> +	/*
> +	 * PMD migration entries need to retain splitting PMD
> +	 * representation created with pmdp_invalidate(). But
> +	 * any non-migration entry which just might have been
> +	 * invalidated previously, still need be a normal huge
> +	 * page. Hence selectively clear splitting entries.
> +	 */
> +	if (!is_migration_entry(pmd_to_swp_entry(pmd)))
> +		pmd = pmd_clrsplitting(pmd);
> +
> +	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
> +}
> +#endif

So a pmdp_invalidate() returns the old pmd. Do we ever need to rebuild a
pmd based on the actual bits in the new invalidated pmdp? Wondering how
the table bit ends up here that we need to pmd_clrsplitting().

-- 
Catalin
