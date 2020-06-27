Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7820C144
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 14:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgF0Mbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 08:31:51 -0400
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:45010 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgF0Mbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:31:50 -0400
Received: from av3.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id 05RCUpCS027643;
        Sat, 27 Jun 2020 12:30:53 GMT
X-AuditID: 8b5b014d-241ff700000045c5-8d-5ef73bfbceb5
Received: from enigma.ics.forth.gr (enigma.ics.forth.gr [139.91.151.35])
        by av3.ics.forth.gr (Symantec Messaging Gateway) with SMTP id C9.81.17861.BFB37FE5; Sat, 27 Jun 2020 15:30:51 +0300 (EEST)
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 27 Jun 2020 15:30:50 +0300
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] riscv: Implement sv48 support
Organization: FORTH
In-Reply-To: <20200603081104.14004-6-alex@ghiti.fr>
References: <20200603081104.14004-1-alex@ghiti.fr>
 <20200603081104.14004-6-alex@ghiti.fr>
Message-ID: <74a770fcf00980281b60bb3f6274419d@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.3.9
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsXSHT1dWfe39fc4g3Nv1Cye3fnKatHy4R2r
        xcrVR5ksLu+aw2ax7XMLm8XLyz3MFm2z+C0+3J3N5sDhMfX3GRaPNy9fsnjcOzGN1WPzknqP
        3Tcb2DwuNV9n9/i8SS6APYrLJiU1J7MstUjfLoEr42LzevaCHYEVi19vZ2lgvO/QxcjBISFg
        IvH7rX0XIxeHkMBRRolnp+awdzFyAsVNJWbv7WQEsXkFBCVOznzCAmIzC1hITL2ynxHClpdo
        3jqbGcRmEVCV2NhyC6yXTUBTYv6lgywg80UElCV2HlEGmc8s0M8k0bznKViNsIClxMLf55lA
        bH4BYYlPdy+ygticAsYS71v6wGqEBKIlTsz+wwgyh1fAReJAexzEaSoSH34/ACsRBRp/8/Bz
        9gmMgrOQXDoLyaWzkFy6gJF5FaNAYpmxXmZysV5aflFJhl560SZGcCQw+u5gvL35rd4hRiYO
        xkOMEhzMSiK8n62/xQnxpiRWVqUW5ccXleakFh9ilOZgURLnzeNeHiskkJ5YkpqdmlqQWgST
        ZeLglGpgSpZk8pd4Jbdq4rv3l2doL1I+/uRu1eNrX/zKzjNs+ePJUZa97v3LEoVvkxSjDjxW
        augT0Njl2HkplOdU7OTQ6UEplmbapT1KPasfZCwqfLIjf/Xdf4mfDocueLdptejryJQTXF9a
        ojpzG0UkcmfcmWPXdsYwSfmJrsGFP4Ip96tFXV0fnDAMiz98hfG7xp2Cdf5Hr5steaLAEBLv
        yFNrqLxr8sZykxdPbnxYsTSOPezj8hOJar3SO894WLEeEBI0ttmse+u1rxOT8/q9B+P+dk/I
        5uLerf9DZUN8yt7yuf4CPc/1n+UtaWPWkd1dXFe631K7YVev+vqM3qtnHkwsS/fcJe4rs/+k
        qWUXDw+jEktxRqKhFnNRcSIAFlZWlfMCAAA=
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Sat, 27 Jun 2020 12:30:53 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av3.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Sat, 27 Jun 2020 12:30:53 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2020-06-03 11:11, Alexandre Ghiti έγραψε:
> By adding a new 4th level of page table, give the possibility to 64bit
> kernel to address 2^48 bytes of virtual address: in practice, that 
> roughly
> offers ~160TB of virtual address space to userspace and allows up to 
> 64TB
> of physical memory.
> 
> If the underlying hardware does not support sv48, we will automatically
> fallback to a standard 3-level page table by folding the new PUD level 
> into
> PGDIR level. In order to detect HW capabilities at runtime, we
> use SATP feature that ignores writes with an unsupported mode.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> ---
>  arch/riscv/Kconfig                  |   6 +-
>  arch/riscv/include/asm/csr.h        |   3 +-
>  arch/riscv/include/asm/fixmap.h     |   1 +
>  arch/riscv/include/asm/page.h       |  15 +++
>  arch/riscv/include/asm/pgalloc.h    |  36 +++++++
>  arch/riscv/include/asm/pgtable-64.h |  97 ++++++++++++++++-
>  arch/riscv/include/asm/pgtable.h    |  10 +-
>  arch/riscv/kernel/head.S            |   3 +-
>  arch/riscv/mm/context.c             |   2 +-
>  arch/riscv/mm/init.c                | 158 +++++++++++++++++++++++++---
>  10 files changed, 307 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index e167f16131f4..3f73f60e9732 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select HAVE_COPY_THREAD_TLS
>  	select HAVE_ARCH_KASAN if MMU && 64BIT
> +	select RELOCATABLE if 64BIT
> 
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
> @@ -106,7 +107,7 @@ config PAGE_OFFSET
>  	default 0xC0000000 if 32BIT && MAXPHYSMEM_2GB
>  	default 0x80000000 if 64BIT && !MMU
>  	default 0xffffffff80000000 if 64BIT && MAXPHYSMEM_2GB
> -	default 0xffffffe000000000 if 64BIT && !MAXPHYSMEM_2GB
> +	default 0xffffc00000000000 if 64BIT && !MAXPHYSMEM_2GB
> 
>  config ARCH_FLATMEM_ENABLE
>  	def_bool y
> @@ -155,8 +156,11 @@ config GENERIC_HWEIGHT
>  config FIX_EARLYCON_MEM
>  	def_bool MMU
> 
> +# On a 64BIT relocatable kernel, the 4-level page table is at runtime 
> folded
> +# on a 3-level page table when sv48 is not supported.
>  config PGTABLE_LEVELS
>  	int
> +	default 4 if 64BIT && RELOCATABLE
>  	default 3 if 64BIT
>  	default 2
> 
> diff --git a/arch/riscv/include/asm/csr.h 
> b/arch/riscv/include/asm/csr.h
> index cec462e198ce..d41536c3f8d4 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -40,11 +40,10 @@
>  #ifndef CONFIG_64BIT
>  #define SATP_PPN	_AC(0x003FFFFF, UL)
>  #define SATP_MODE_32	_AC(0x80000000, UL)
> -#define SATP_MODE	SATP_MODE_32
>  #else
>  #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UL)
>  #define SATP_MODE_39	_AC(0x8000000000000000, UL)
> -#define SATP_MODE	SATP_MODE_39
> +#define SATP_MODE_48	_AC(0x9000000000000000, UL)
>  #endif
> 
>  /* Exception cause high bit - is an interrupt if set */
> diff --git a/arch/riscv/include/asm/fixmap.h 
> b/arch/riscv/include/asm/fixmap.h
> index 2368d49eb4ef..d891cf9c73c5 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -27,6 +27,7 @@ enum fixed_addresses {
>  	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
>  	FIX_PTE,
>  	FIX_PMD,
> +	FIX_PUD,
>  	FIX_TEXT_POKE1,
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
> diff --git a/arch/riscv/include/asm/page.h 
> b/arch/riscv/include/asm/page.h
> index 48bb09b6a9b7..5e77fe7f0d6d 100644
> --- a/arch/riscv/include/asm/page.h
> +++ b/arch/riscv/include/asm/page.h
> @@ -31,7 +31,19 @@
>   * When not using MMU this corresponds to the first free page in
>   * physical memory (aligned on a page boundary).
>   */
> +#ifdef CONFIG_RELOCATABLE
> +#define PAGE_OFFSET		__page_offset
> +
> +#ifdef CONFIG_64BIT
> +/*
> + * By default, CONFIG_PAGE_OFFSET value corresponds to SV48 address 
> space so
> + * define the PAGE_OFFSET value for SV39.
> + */
> +#define PAGE_OFFSET_L3		0xffffffe000000000
> +#endif /* CONFIG_64BIT */
> +#else
>  #define PAGE_OFFSET		_AC(CONFIG_PAGE_OFFSET, UL)
> +#endif /* CONFIG_RELOCATABLE */
> 
>  #define KERN_VIRT_SIZE (-PAGE_OFFSET)
> 
> @@ -102,6 +114,9 @@ extern unsigned long pfn_base;
>  extern unsigned long max_low_pfn;
>  extern unsigned long min_low_pfn;
>  extern unsigned long kernel_virt_addr;
> +#ifdef CONFIG_RELOCATABLE
> +extern unsigned long __page_offset;
> +#endif
> 
>  #define __pa_to_va_nodebug(x)	((void *)((unsigned long) (x) + 
> va_pa_offset))
>  #define linear_mapping_va_to_pa(x)	((unsigned long)(x) - va_pa_offset)
> diff --git a/arch/riscv/include/asm/pgalloc.h 
> b/arch/riscv/include/asm/pgalloc.h
> index 3f601ee8233f..540eaa5a8658 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -36,6 +36,42 @@ static inline void pud_populate(struct mm_struct
> *mm, pud_t *pud, pmd_t *pmd)
> 
>  	set_pud(pud, __pud((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
>  }
> +
> +static inline void p4d_populate(struct mm_struct *mm, p4d_t *p4d, 
> pud_t *pud)
> +{
> +	if (pgtable_l4_enabled) {
> +		unsigned long pfn = virt_to_pfn(pud);
> +
> +		set_p4d(p4d, __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
> +	}
> +}
> +
> +static inline void p4d_populate_safe(struct mm_struct *mm, p4d_t *p4d,
> +				     pud_t *pud)
> +{
> +	if (pgtable_l4_enabled) {
> +		unsigned long pfn = virt_to_pfn(pud);
> +
> +		set_p4d_safe(p4d,
> +			     __p4d((pfn << _PAGE_PFN_SHIFT) | _PAGE_TABLE));
> +	}
> +}
> +
> +static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long 
> addr)
> +{
> +	if (pgtable_l4_enabled)
> +		return (pud_t *)__get_free_page(
> +				GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_ZERO);
> +	return NULL;
> +}
> +
> +static inline void pud_free(struct mm_struct *mm, pud_t *pud)
> +{
> +	if (pgtable_l4_enabled)
> +		free_page((unsigned long)pud);
> +}
> +
> +#define __pud_free_tlb(tlb, pud, addr)  pud_free((tlb)->mm, pud)
>  #endif /* __PAGETABLE_PMD_FOLDED */
> 
>  #define pmd_pgtable(pmd)	pmd_page(pmd)
> diff --git a/arch/riscv/include/asm/pgtable-64.h
> b/arch/riscv/include/asm/pgtable-64.h
> index b15f70a1fdfa..c84c31fbf8da 100644
> --- a/arch/riscv/include/asm/pgtable-64.h
> +++ b/arch/riscv/include/asm/pgtable-64.h
> @@ -8,16 +8,32 @@
> 
>  #include <linux/const.h>
> 
> -#define PGDIR_SHIFT     30
> +extern bool pgtable_l4_enabled;
> +
> +#define PGDIR_SHIFT     (pgtable_l4_enabled ? 39 : 30)
>  /* Size of region mapped by a page global directory */
>  #define PGDIR_SIZE      (_AC(1, UL) << PGDIR_SHIFT)
>  #define PGDIR_MASK      (~(PGDIR_SIZE - 1))
> 
> +/* pud is folded into pgd in case of 3-level page table */
> +#define PUD_SHIFT	30
> +#define PUD_SIZE	(_AC(1, UL) << PUD_SHIFT)
> +#define PUD_MASK	(~(PUD_SIZE - 1))
> +
>  #define PMD_SHIFT       21
>  /* Size of region mapped by a page middle directory */
>  #define PMD_SIZE        (_AC(1, UL) << PMD_SHIFT)
>  #define PMD_MASK        (~(PMD_SIZE - 1))
> 
> +/* Page Upper Directory entry */
> +typedef struct {
> +	unsigned long pud;
> +} pud_t;
> +
> +#define pud_val(x)      ((x).pud)
> +#define __pud(x)        ((pud_t) { (x) })
> +#define PTRS_PER_PUD    (PAGE_SIZE / sizeof(pud_t))
> +
>  /* Page Middle Directory entry */
>  typedef struct {
>  	unsigned long pmd;
> @@ -60,6 +76,16 @@ static inline void pud_clear(pud_t *pudp)
>  	set_pud(pudp, __pud(0));
>  }
> 
> +static inline pud_t pfn_pud(unsigned long pfn, pgprot_t prot)
> +{
> +	return __pud((pfn << _PAGE_PFN_SHIFT) | pgprot_val(prot));
> +}
> +
> +static inline unsigned long _pud_pfn(pud_t pud)
> +{
> +	return pud_val(pud) >> _PAGE_PFN_SHIFT;
> +}
> +
>  static inline unsigned long pud_page_vaddr(pud_t pud)
>  {
>  	return (unsigned long)pfn_to_virt(pud_val(pud) >> _PAGE_PFN_SHIFT);
> @@ -70,6 +96,15 @@ static inline struct page *pud_page(pud_t pud)
>  	return pfn_to_page(pud_val(pud) >> _PAGE_PFN_SHIFT);
>  }
> 
> +#define mm_pud_folded	mm_pud_folded
> +static inline bool mm_pud_folded(struct mm_struct *mm)
> +{
> +	if (pgtable_l4_enabled)
> +		return false;
> +
> +	return true;
> +}
> +
>  #define pmd_index(addr) (((addr) >> PMD_SHIFT) & (PTRS_PER_PMD - 1))
> 
>  static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
> @@ -90,4 +125,64 @@ static inline unsigned long _pmd_pfn(pmd_t pmd)
>  #define pmd_ERROR(e) \
>  	pr_err("%s:%d: bad pmd %016lx.\n", __FILE__, __LINE__, pmd_val(e))
> 
> +#define pud_ERROR(e)	\
> +	pr_err("%s:%d: bad pud %016lx.\n", __FILE__, __LINE__, pud_val(e))
> +
> +static inline void set_p4d(p4d_t *p4dp, p4d_t p4d)
> +{
> +	if (pgtable_l4_enabled)
> +		*p4dp = p4d;
> +	else
> +		set_pud((pud_t *)p4dp, (pud_t){ p4d_val(p4d) });
> +}
> +
> +static inline int p4d_none(p4d_t p4d)
> +{
> +	if (pgtable_l4_enabled)
> +		return (p4d_val(p4d) == 0);
> +
> +	return 0;
> +}
> +
> +static inline int p4d_present(p4d_t p4d)
> +{
> +	if (pgtable_l4_enabled)
> +		return (p4d_val(p4d) & _PAGE_PRESENT);
> +
> +	return 1;
> +}
> +
> +static inline int p4d_bad(p4d_t p4d)
> +{
> +	if (pgtable_l4_enabled)
> +		return !p4d_present(p4d);
> +
> +	return 0;
> +}
> +
> +static inline void p4d_clear(p4d_t *p4d)
> +{
> +	if (pgtable_l4_enabled)
> +		set_p4d(p4d, __p4d(0));
> +}
> +
> +static inline unsigned long p4d_page_vaddr(p4d_t p4d)
> +{
> +	if (pgtable_l4_enabled)
> +		return (unsigned long)pfn_to_virt(
> +				p4d_val(p4d) >> _PAGE_PFN_SHIFT);
> +
> +	return pud_page_vaddr((pud_t) { p4d_val(p4d) });
> +}
> +
> +#define pud_index(addr) (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
> +
> +static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
> +{
> +	if (pgtable_l4_enabled)
> +		return (pud_t *)p4d_page_vaddr(*p4d) + pud_index(address);
> +
> +	return (pud_t *)p4d;
> +}
> +

In my test I had to put
#define pud_offset pud_offset
here or else I got a compilation error due to pud_offset being redefined 
on include/linux/pgtable.h:

#ifndef pud_offset
static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
{
         return (pud_t *)p4d_page_vaddr(*p4d) + pud_index(address);
}
#define pud_offset pud_offset
#endif
