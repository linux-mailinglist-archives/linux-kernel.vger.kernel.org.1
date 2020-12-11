Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563122D7AB6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437644AbgLKQTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:19:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394729AbgLKQTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607703478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QzPrNOP+uHos4s/i6xpAdeYTKNwMK8JYr9wqj0U2+14=;
        b=Hu1SZAflnm8fyyw4+vYGV3xM2GjXmQpCY6lO80Y1YoreCUZN1PdDknWIDqzHUrmda4+K6e
        afXmAUHV5wy5HkZjUwVMUBiJkWsbvXoPe9863GUt69R+4o7sabJXSzkgOWDFjf3w+BzfNK
        Y95QwhAjHaphteZXQOE8lCOHmmFLrIk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-prS9FTy1Nu-MFCS0KXbU4Q-1; Fri, 11 Dec 2020 11:17:45 -0500
X-MC-Unique: prS9FTy1Nu-MFCS0KXbU4Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0A69100F340;
        Fri, 11 Dec 2020 16:17:42 +0000 (UTC)
Received: from ovpn-114-43.rdu2.redhat.com (ovpn-114-43.rdu2.redhat.com [10.10.114.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CFEA810013C0;
        Fri, 11 Dec 2020 16:17:41 +0000 (UTC)
Message-ID: <d32ac03869c95eba8a9037b28a6667c77ea8e369.camel@redhat.com>
Subject: Re: [PATCH] powerpc/mm: Refactor the floor/ceiling check in hugetlb
 range freeing functions
From:   Qian Cai <qcai@redhat.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Fri, 11 Dec 2020 11:17:41 -0500
In-Reply-To: <16a571bb32eb6e8cd44bda484c8d81cd8a25e6d7.1604668827.git.christophe.leroy@csgroup.eu>
References: <16a571bb32eb6e8cd44bda484c8d81cd8a25e6d7.1604668827.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-11-06 at 13:20 +0000, Christophe Leroy wrote:
> All hugetlb range freeing functions have a verification like the following,
> which only differs by the mask used, depending on the page table level.
> 
> 	start &= MASK;
> 	if (start < floor)
> 		return;
> 	if (ceiling) {
> 		ceiling &= MASK;
> 		if (! ceiling)
> 			return;
> 		}
> 	if (end - 1 > ceiling - 1)
> 		return;
> 
> Refactor that into a helper function which takes the mask as
> an argument, returning true when [start;end[ is not fully
> contained inside [floor;ceiling[
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 56 ++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 36c3800769fb..f8d8a4988e15 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -294,6 +294,21 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
>  static inline void hugepd_free(struct mmu_gather *tlb, void *hugepte) {}
>  #endif
>  
> +/* Return true when the entry to be freed maps more than the area being freed */
> +static bool range_is_outside_limits(unsigned long start, unsigned long end,
> +				    unsigned long floor, unsigned long ceiling,
> +				    unsigned long mask)
> +{
> +	if ((start & mask) < floor)
> +		return true;
> +	if (ceiling) {
> +		ceiling &= mask;
> +		if (!ceiling)
> +			return true;
> +	}
> +	return end - 1 > ceiling - 1;
> +}
> +
>  static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshift,
>  			      unsigned long start, unsigned long end,
>  			      unsigned long floor, unsigned long ceiling)
> @@ -309,15 +324,7 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
>  	if (shift > pdshift)
>  		num_hugepd = 1 << (shift - pdshift);
>  
> -	start &= pdmask;
> -	if (start < floor)
> -		return;
> -	if (ceiling) {
> -		ceiling &= pdmask;
> -		if (! ceiling)
> -			return;
> -	}
> -	if (end - 1 > ceiling - 1)
> +	if (range_is_outside_limits(start, end, floor, ceiling, pdmask))
>  		return;
>  
>  	for (i = 0; i < num_hugepd; i++, hpdp++)
> @@ -334,18 +341,9 @@ static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
>  				   unsigned long addr, unsigned long end,
>  				   unsigned long floor, unsigned long ceiling)
>  {
> -	unsigned long start = addr;
>  	pgtable_t token = pmd_pgtable(*pmd);
>  
> -	start &= PMD_MASK;
> -	if (start < floor)
> -		return;
> -	if (ceiling) {
> -		ceiling &= PMD_MASK;
> -		if (!ceiling)
> -			return;
> -	}
> -	if (end - 1 > ceiling - 1)
> +	if (range_is_outside_limits(addr, end, floor, ceiling, PMD_MASK))
>  		return;
>  
>  	pmd_clear(pmd);
> @@ -395,15 +393,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
>  				  addr, next, floor, ceiling);
>  	} while (addr = next, addr != end);
>  
> -	start &= PUD_MASK;
> -	if (start < floor)
> -		return;
> -	if (ceiling) {
> -		ceiling &= PUD_MASK;
> -		if (!ceiling)
> -			return;
> -	}
> -	if (end - 1 > ceiling - 1)
> +	if (range_is_outside_limits(start, end, floor, ceiling, PUD_MASK))
>  		return;
>  
>  	pmd = pmd_offset(pud, start);
> @@ -446,15 +436,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
>  		}
>  	} while (addr = next, addr != end);
>  
> -	start &= PGDIR_MASK;
> -	if (start < floor)
> -		return;
> -	if (ceiling) {
> -		ceiling &= PGDIR_MASK;
> -		if (!ceiling)
> -			return;
> -	}
> -	if (end - 1 > ceiling - 1)
> +	if (range_is_outside_limits(start, end, floor, ceiling, PGDIR_MASK))
>  		return;
>  
>  	pud = pud_offset(p4d, start);

Well, "start" is still in use in hugetlb_free_pmd_range() and
hugetlb_free_pud_range() after range_is_outside_limits(), but after this patch,
"start" is not longer has the bitmask, i.e., "no &=".

Anyway, reverting this commit from today's linux-next fixed a crash on POWE9 NV.

# runltp -f hugetlb
[ 7703.114640][T58070] LTP: starting hugemmap05_1 (hugemmap05 -m)
[ 7703.157792][   C99] ------------[ cut here ]------------
[ 7703.158279][   C99] kernel BUG at arch/powerpc/mm/book3s64/pgtable.c:387!
[ 7703.158306][   C99] Oops: Exception in kernel mode, sig: 5 [#1]
[ 7703.158330][   C99] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256 NUMA PowerNV
[ 7703.158343][   C99] Modules linked in: vfio_pci vfio_virqfd vfio_iommu_spapr_tce vfio vfio_spapr_eeh loop kvm_hv kvm ip_tables x_tables sd_mod ahci libahci tg3 libata firmware_class libphy dm_mirror dm_region_hash dm_log dm_mod [last unloaded: dummy_del_mod]
[ 7703.158435][   C99] CPU: 99 PID: 308 Comm: ksoftirqd/99 Tainted: G           O      5.10.0-rc7-next-20201211 #1
[ 7703.158464][   C99] NIP:  c00000000005dbec LR: c0000000003352f4 CTR: 0000000000000000
[ 7703.158489][   C99] REGS: c00020000bb6f830 TRAP: 0700   Tainted: G           O       (5.10.0-rc7-next-20201211)
[ 7703.158528][   C99] MSR:  900000000282b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 24002284  XER: 20040000
[ 7703.158570][   C99] GPR00: c0000000003352f4 c00020000bb6fad0 c000000007f70b00 c0002000385b3ff0 
[ 7703.158570][   C99] GPR04: 0000000000000000 0000000000000003 c00020000bb6f8b4 0000000000000001 
[ 7703.158570][   C99] GPR08: 0000000000000001 0000000000000009 0000000000000008 0000000000000002 
[ 7703.158570][   C99] GPR12: 0000000024002488 c000201fff649c00 c000000007f2a20c 0000000000000000 
[ 7703.158570][   C99] GPR16: 0000000000000007 0000000000000000 c000000000194d10 c000000000194d10 
[ 7703.158570][   C99] GPR24: 0000000000000014 0000000000000015 c000201cc6e72398 c000000007fac4b4 
[ 7703.158570][   C99] GPR28: c000000007f2bf80 c000000007fac2f8 0000000000000008 c000200033870000 
[ 7703.158766][   C99] NIP [c00000000005dbec] __tlb_remove_table+0x1dc/0x1e0
pgtable_free at arch/powerpc/mm/book3s64/pgtable.c:387
(inlined by) __tlb_remove_table at arch/powerpc/mm/book3s64/pgtable.c:405
[ 7703.158805][   C99] LR [c0000000003352f4] tlb_remove_table_rcu+0x54/0xa0
[ 7703.158853][   C99] Call Trace:
[ 7703.158872][   C99] [c00020000bb6fad0] [c00000000005db4c] __tlb_remove_table+0x13c/0x1e0 (unreliable)
[ 7703.158890][   C99] [c00020000bb6fb00] [c0000000003352f4] tlb_remove_table_rcu+0x54/0xa0
__tlb_remove_table_free at mm/mmu_gather.c:101
(inlined by) tlb_remove_table_rcu at mm/mmu_gather.c:156
[ 7703.158927][   C99] [c00020000bb6fb30] [c000000000194d7c] rcu_core+0x35c/0xbb0
rcu_do_batch at kernel/rcu/tree.c:2502
(inlined by) rcu_core at kernel/rcu/tree.c:2737
[ 7703.158966][   C99] [c00020000bb6fbf0] [c00000000095a3d0] __do_softirq+0x480/0x704
[ 7703.159006][   C99] [c00020000bb6fd10] [c0000000000cc1f4] run_ksoftirqd+0x74/0xd0
run_ksoftirqd at kernel/softirq.c:651
(inlined by) run_ksoftirqd at kernel/softirq.c:642
[ 7703.159046][   C99] [c00020000bb6fd30] [c0000000001040c8] smpboot_thread_fn+0x278/0x320
[ 7703.159096][   C99] [c00020000bb6fda0] [c0000000000fc8a4] kthread+0x1c4/0x1d0
[ 7703.159145][   C99] [c00020000bb6fe10] [c00000000000d9fc] ret_from_kernel_thread+0x5c/0x80
[ 7703.159183][   C99] Instruction dump:
[ 7703.159204][   C99] 60000000 7c0802a6 3c82f8b4 7fe3fb78 38847470 f8010040 482b4fc5 60000000 
[ 7703.159248][   C99] 0fe00000 7c0802a6 fbe10028 f8010040 <0fe00000> 3c4c07f1 38422f10 7c0802a6 
[ 7703.159293][   C99] ---[ end trace 1d92a5231ba6a0d5 ]---

