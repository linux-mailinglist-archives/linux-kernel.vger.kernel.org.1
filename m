Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC96322A2C2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 01:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732922AbgGVXBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 19:01:04 -0400
Received: from ozlabs.org ([203.11.71.1]:49927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgGVXBD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:01:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BBrY8032Vz9sPf;
        Thu, 23 Jul 2020 09:00:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1595458860; bh=fPZL/Y4DVUb3JB9+eWSHpZsPLOAIwy85ePtm79pGmGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZaNz9mTKmXDUY5KHxeG2AWePHD5Iv5ncxKjBsKZkUsHY4UOoXKVvvBg2kx4sEQEcj
         td4PdWF4TB2qFuzTf6T+FcMqDbQHSdjtvITgC+kP066QHi6I0u0rJtb1gphnfExgAd
         pdNVxnP2BOJI9bDyNUfrpu+oxh6AZTOoIG0M59w7lrClj+mreqFfeRFooIRcSfX9Cd
         tYbB2BiNIrJKQVgoIc+Yyz9v2PDucNzIm1bu+FlFPY3dDxWu7klsBVhWsaIJlK9G3V
         fpDr57Odzf0HtofwaRvtFiCZ9nzYzz7ze5DLWvjajwdnbozKobCvZlFuJKskdUNLH9
         dunzN+f9uifxg==
Date:   Thu, 23 Jul 2020 09:00:58 +1000
From:   Anton Blanchard <anton@ozlabs.org>
To:     Scott Cheloha <cheloha@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Nathan Fontenont <ndfont@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Michal Suchanek <msuchanek@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org,
        Rick Lindley <ricklind@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/2] powerpc/drmem: accelerate
 memory_add_physaddr_to_nid() with LMB xarray
Message-ID: <20200723090058.62ab0df9@kryten.localdomain>
In-Reply-To: <20200221172901.1596249-2-cheloha@linux.ibm.com>
References: <20200128221113.17158-1-cheloha@linux.ibm.com>
        <20200221172901.1596249-2-cheloha@linux.ibm.com>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

I'm hitting this issue and Rick just pointed my at your patch. Any
chance we could get it upstream?

Thanks,
Anton

> On PowerPC, memory_add_physaddr_to_nid() uses a linear search to find
> an LMB matching the given address.  This scales very poorly when there
> are many LMBs.  The poor scaling cripples drmem_init() during boot:
> lmb_set_nid(), which calls memory_add_physaddr_to_nid(), is called for
> each LMB.
> 
> If we index each LMB in an xarray by its base address we can achieve
> O(log n) search during memory_add_physaddr_to_nid(), which scales much
> better.
> 
> For example, in the lab we have a 64TB P9 machine with 256MB LMBs.
> So, suring drmem_init() we instantiate 249854 LMBs.  On a vanilla
> kernel it completes drmem_init() in ~35 seconds with a soft lockup
> trace.  On the patched kernel it completes drmem_init() in ~0.5
> seconds.
> 
> Before:
> [   53.721639] drmem: initializing drmem v2
> [   80.604346] watchdog: BUG: soft lockup - CPU#65 stuck for 23s!
> [swapper/0:1] [   80.604377] Modules linked in:
> [   80.604389] CPU: 65 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc2+
> #4 [   80.604397] NIP:  c0000000000a4980 LR: c0000000000a4940 CTR:
> 0000000000000000 [   80.604407] REGS: c0002dbff8493830 TRAP: 0901
> Not tainted  (5.6.0-rc2+) [   80.604412] MSR:  8000000002009033
> <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 44000248  XER: 0000000d [
> 80.604431] CFAR: c0000000000a4a38 IRQMASK: 0 [   80.604431] GPR00:
> c0000000000a4940 c0002dbff8493ac0 c000000001904400 c0003cfffffede30 [
>   80.604431] GPR04: 0000000000000000 c000000000f4095a
> 000000000000002f 0000000010000000 [   80.604431] GPR08:
> c0000bf7ecdb7fb8 c0000bf7ecc2d3c8 0000000000000008 c00c0002fdfb2001 [
>   80.604431] GPR12: 0000000000000000 c00000001e8ec200 [   80.604477]
> NIP [c0000000000a4980] hot_add_scn_to_nid+0xa0/0x3e0 [   80.604486]
> LR [c0000000000a4940] hot_add_scn_to_nid+0x60/0x3e0 [   80.604492]
> Call Trace: [   80.604498] [c0002dbff8493ac0] [c0000000000a4940]
> hot_add_scn_to_nid+0x60/0x3e0 (unreliable) [   80.604509]
> [c0002dbff8493b20] [c000000000087c10]
> memory_add_physaddr_to_nid+0x20/0x60 [   80.604521]
> [c0002dbff8493b40] [c0000000010d4880] drmem_init+0x25c/0x2f0 [
> 80.604530] [c0002dbff8493c10] [c000000000010154]
> do_one_initcall+0x64/0x2c0 [   80.604540] [c0002dbff8493ce0]
> [c0000000010c4aa0] kernel_init_freeable+0x2d8/0x3a0 [   80.604550]
> [c0002dbff8493db0] [c000000000010824] kernel_init+0x2c/0x148 [
> 80.604560] [c0002dbff8493e20] [c00000000000b648]
> ret_from_kernel_thread+0x5c/0x74 [   80.604567] Instruction dump: [
> 80.604574] 392918e8 e9490000 e90a000a e92a0000 80ea000c 1d080018
> 3908ffe8 7d094214 [   80.604586] 7fa94040 419d00dc e9490010 714a0088
> <2faa0008> 409e00ac e9490000 7fbe5040 [   89.047390] drmem: 249854
> LMB(s)
> 
> After:
> [   53.424702] drmem: initializing drmem v2
> [   53.898813] drmem: 249854 LMB(s)
> 
> lmb_set_nid() is called from dlpar_lmb_add() so this patch will also
> improve memory hot-add speeds on big machines.
> 
> Signed-off-by: Scott Cheloha <cheloha@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/drmem.h |  1 +
>  arch/powerpc/mm/drmem.c          | 24 ++++++++++++++++++++++++
>  arch/powerpc/mm/numa.c           | 29 ++++++++++-------------------
>  3 files changed, 35 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/drmem.h
> b/arch/powerpc/include/asm/drmem.h index 3d76e1c388c2..90a5a9ad872b
> 100644 --- a/arch/powerpc/include/asm/drmem.h
> +++ b/arch/powerpc/include/asm/drmem.h
> @@ -88,6 +88,7 @@ static inline bool drmem_lmb_reserved(struct
> drmem_lmb *lmb) return lmb->flags & DRMEM_LMB_RESERVED;
>  }
>  
> +struct drmem_lmb *drmem_find_lmb_by_base_addr(u64 base_addr);
>  u64 drmem_lmb_memory_max(void);
>  void __init walk_drmem_lmbs(struct device_node *dn,
>  			void (*func)(struct drmem_lmb *, const
> __be32 **)); diff --git a/arch/powerpc/mm/drmem.c
> b/arch/powerpc/mm/drmem.c index 44bfbdae920c..62cbe79e3860 100644
> --- a/arch/powerpc/mm/drmem.c
> +++ b/arch/powerpc/mm/drmem.c
> @@ -11,12 +11,31 @@
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <linux/memblock.h>
> +#include <linux/xarray.h>
>  #include <asm/prom.h>
>  #include <asm/drmem.h>
>  
> +static DEFINE_XARRAY(drmem_lmb_xa_base_addr);
>  static struct drmem_lmb_info __drmem_info;
>  struct drmem_lmb_info *drmem_info = &__drmem_info;
>  
> +static int drmem_cache_lmb_for_lookup(struct drmem_lmb *lmb)
> +{
> +	void *ret;
> +
> +	ret = xa_store(&drmem_lmb_xa_base_addr, lmb->base_addr, lmb,
> +		       GFP_KERNEL);
> +	if (xa_is_err(ret))
> +		return xa_err(ret);
> +
> +	return 0;
> +}
> +
> +struct drmem_lmb *drmem_find_lmb_by_base_addr(u64 base_addr)
> +{
> +	return xa_load(&drmem_lmb_xa_base_addr, base_addr);
> +}
> +
>  u64 drmem_lmb_memory_max(void)
>  {
>  	struct drmem_lmb *last_lmb;
> @@ -364,6 +383,8 @@ static void __init init_drmem_v1_lmbs(const
> __be32 *prop) 
>  	for_each_drmem_lmb(lmb) {
>  		read_drconf_v1_cell(lmb, &prop);
> +		if (drmem_cache_lmb_for_lookup(lmb) != 0)
> +			return;
>  		lmb_set_nid(lmb);
>  	}
>  }
> @@ -411,6 +432,9 @@ static void __init init_drmem_v2_lmbs(const
> __be32 *prop) lmb->aa_index = dr_cell.aa_index;
>  			lmb->flags = dr_cell.flags;
>  
> +			if (drmem_cache_lmb_for_lookup(lmb) != 0)
> +				return;
> +
>  			lmb_set_nid(lmb);
>  		}
>  	}
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 3c7dec70cda0..0fd7963a991e 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -958,27 +958,18 @@ early_param("topology_updates",
> early_topology_updates); static int
> hot_add_drconf_scn_to_nid(unsigned long scn_addr) {
>  	struct drmem_lmb *lmb;
> -	unsigned long lmb_size;
> -	int nid = NUMA_NO_NODE;
> -
> -	lmb_size = drmem_lmb_size();
> -
> -	for_each_drmem_lmb(lmb) {
> -		/* skip this block if it is reserved or not assigned
> to
> -		 * this partition */
> -		if ((lmb->flags & DRCONF_MEM_RESERVED)
> -		    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
> -			continue;
> -
> -		if ((scn_addr < lmb->base_addr)
> -		    || (scn_addr >= (lmb->base_addr + lmb_size)))
> -			continue;
>  
> -		nid = of_drconf_to_nid_single(lmb);
> -		break;
> -	}
> +	lmb = drmem_find_lmb_by_base_addr(scn_addr);
> +	if (lmb == NULL)
> +		return NUMA_NO_NODE;
> +	
> +	/* can't use this block if it is reserved or not assigned to
> +	 * this partition */
> +	if ((lmb->flags & DRCONF_MEM_RESERVED)
> +	    || !(lmb->flags & DRCONF_MEM_ASSIGNED))
> +		return NUMA_NO_NODE;
>  
> -	return nid;
> +	return of_drconf_to_nid_single(lmb);
>  }
>  
>  /*

