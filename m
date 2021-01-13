Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442C92F4577
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbhAMHpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:45:22 -0500
Received: from bin-mail-out-06.binero.net ([195.74.38.229]:37993 "EHLO
        bin-mail-out-06.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbhAMHpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:45:22 -0500
X-Halon-ID: 27ebd293-5573-11eb-a076-005056917f90
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-02.atm.binero.net (Halon) with ESMTPA
        id 27ebd293-5573-11eb-a076-005056917f90;
        Wed, 13 Jan 2021 08:44:33 +0100 (CET)
Subject: Re: [patch 1/4] sparc/mm/highmem: Flush cache and TLB
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
References: <20210112170136.078559026@linutronix.de>
 <20210112170410.905976187@linutronix.de>
From:   Andreas Larsson <andreas@gaisler.com>
Message-ID: <8a55c407-4fad-1a2f-5540-152e28b71617@gaisler.com>
Date:   Wed, 13 Jan 2021 08:44:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210112170410.905976187@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021-01-12 18:01, Thomas Gleixner wrote:
> The recent conversion to the generic kmap_local infrastructure failed to
> assign the proper pre/post map/unmap flush operations for sparc.
> 
> Sparc requires cache flush before map/unmap and tlb flush afterwards.
> 
> Fixes: 3293efa97807 ("sparc/mm/highmem: Switch to generic kmap atomic")
> Reported-by: Andreas Larsson <andreas@gaisler.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> ---
>   arch/sparc/include/asm/highmem.h |    9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/arch/sparc/include/asm/highmem.h
> +++ b/arch/sparc/include/asm/highmem.h
> @@ -50,10 +50,11 @@ extern pte_t *pkmap_page_table;
>   
>   #define flush_cache_kmaps()	flush_cache_all()
>   
> -/* FIXME: Use __flush_tlb_one(vaddr) instead of flush_cache_all() -- Anton */
> -#define arch_kmap_local_post_map(vaddr, pteval)	flush_cache_all()
> -#define arch_kmap_local_post_unmap(vaddr)	flush_cache_all()
> -
> +/* FIXME: Use __flush_*_one(vaddr) instead of flush_*_all() -- Anton */
> +#define arch_kmap_local_pre_map(vaddr, pteval)	flush_cache_all()
> +#define arch_kmap_local_pre_unmap(vaddr)	flush_cache_all()
> +#define arch_kmap_local_post_map(vaddr, pteval)	flush_tlb_all()
> +#define arch_kmap_local_post_unmap(vaddr)	flush_tlb_all()
>   
>   #endif /* __KERNEL__ */

Yes! I found, just an hour before your patched was posted, that an
equivalent fix helped back where the switch-to-generic patch first
occurred. This patch was successfully tested on master.

Tested-by: Andreas Larsson <andreas@gaisler.com>

-- 
Andreas Larsson
Cobham Gaisler
