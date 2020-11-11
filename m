Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDCA2AEF1D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 12:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKKLEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 06:04:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgKKLEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 06:04:24 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B39BE206D9;
        Wed, 11 Nov 2020 11:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605092663;
        bh=6mVJM7br/AZrziH2MmM8/kLPWqumU6zjuSl8o3JuUB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R8rhYgRjiSA1tpuYygoeNE5zZX3oFBqGlhpqbSKUl/DqSOGPWrtUi81V/c3uP5YeP
         DOm79S607XeamzxILnW2EvV/DJzA7AI5G6K8FxdVmpZXnJlY4lHqZTHKnstwWD6m27
         Et8DC9XEC/sIJGOEzRwVAnM8AhqKgIi4KXrLonjg=
Date:   Wed, 11 Nov 2020 13:04:16 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, Minchan Kim <minchan@kernel.org>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-ID: <20201111110416.GG4758@kernel.org>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org>
 <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org>
 <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org>
 <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
 <20201111102654.GF4758@kernel.org>
 <CAK8P3a0sfYWkHvNauEN8BwPCi2cMX-TVBTXUtnLJZpAzS7YNMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0sfYWkHvNauEN8BwPCi2cMX-TVBTXUtnLJZpAzS7YNMg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 11:57:02AM +0100, Arnd Bergmann wrote:
> On Wed, Nov 11, 2020 at 11:26 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Wed, Nov 11, 2020 at 10:33:29AM +0100, Arnd Bergmann wrote:
> > > On Tue, Nov 10, 2020 at 5:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> > > > On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> > > > >
> > > > > To be on the safe side, we could provoke a compile-time error
> > > > > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > > > > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
> > > >
> > > > Maybe compile time warning and a runtime error in zs_init() if 32 bit
> > > > machine has memory above 4G?
> > >
> > > If the fix is as easy as adding a single line in a header, I think a
> > > compile-time
> > > error makes it easier, no need to wait for someone to boot a broken
> > > system before fixing it.
> >
> > Not sure it would be as easy as adding a single line in a header for
> > MIPS with it's diversity.
> 
> I looked up the architecture, and found:
> 
> - The pre-MIPS32r1 cores only support 32-bit addressing
> - octeon selects PHYS_ADDR_T_64BIT but no longer
>   supports 32-bit kernels
> - Alchemy and netlogic (XLR, XLP) have 36-bit addressing
> - CONFIG_XPA implies 40-bit addressing

Fair enough. A typo below.

> We should run it by the MIPS maintainers, but I think this patch
> is sufficient:
> 
> --- a/arch/mips/include/asm/pgtable-32.h
> +++ b/arch/mips/include/asm/pgtable-32.h
> @@ -154,6 +154,7 @@ static inline void pmd_clear(pmd_t *pmdp)
> 
>  #if defined(CONFIG_XPA)
> 
> +#define MAX_POSSIBLE_PHYSMEM_BITS 40
>  #define pte_pfn(x)             (((unsigned long)((x).pte_high >>
> _PFN_SHIFT)) | (unsigned long)((x).pte_low << _PAGE_PRESENT_SHIFT))
>  static inline pte_t
>  pfn_pte(unsigned long pfn, pgprot_t prot)
> @@ -169,6 +170,7 @@ pfn_pte(unsigned long pfn, pgprot_t prot)
> 
>  #elif defined(CONFIG_PHYS_ADDR_T_64BIT) && defined(CONFIG_CPU_MIPS32)
> 
> +#define MAX_POSSIBLE_PHYSMEM_BITS 35

                                    ^ 36 ?

>  #define pte_pfn(x)             ((unsigned long)((x).pte_high >> 6))
> 
>  static inline pte_t pfn_pte(unsigned long pfn, pgprot_t prot)
> @@ -183,6 +185,7 @@ static inline pte_t pfn_pte(unsigned long pfn,
> pgprot_t prot)
> 
>  #else
> 
> +#define MAX_POSSIBLE_PHYSMEM_BITS 32
>  #ifdef CONFIG_CPU_VR41XX
>  #define pte_pfn(x)             ((unsigned long)((x).pte >> (PAGE_SHIFT + 2)))
>  #define pfn_pte(pfn, prot)     __pte(((pfn) << (PAGE_SHIFT + 2)) |
> pgprot_val(prot))
> 
>      Arnd

-- 
Sincerely yours,
Mike.
