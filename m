Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A982AD2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgKJJ6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:58:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:58352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJJ6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:58:14 -0500
Received: from kernel.org (unknown [77.125.7.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6414020780;
        Tue, 10 Nov 2020 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605002293;
        bh=qTvuhXI8yb9kzIsmvWorljez87NX0Y7TlxO8SGs8940=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V70csC1e3dgcXVirLFjHrv9tWI1nvZ5tApBo8lcp1y65qHAipgmBVwHGTpk43f5KD
         pJFPrvgoL8ZRRRNHgjoCsQjx375vGV36RdtwrT9Vp8VpYXTa6/kBMroduHe2dFtCDY
         Roqaz1u6T4gP52GjieCtBolTwgxo07FQUdmh81sA=
Date:   Tue, 10 Nov 2020 11:58:06 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Stefan Agner <stefan@agner.ch>
Cc:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, akpm@linux-foundation.org,
        sjenning@linux.vnet.ibm.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
Message-ID: <20201110095806.GH301837@kernel.org>
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org>
 <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 10:29:54AM +0100, Stefan Agner wrote:
> On 2020-11-08 07:46, Mike Rapoport wrote:
> > On Sat, Nov 07, 2020 at 04:22:06PM +0100, Stefan Agner wrote:
> >> Most architectures define MAX_PHYSMEM_BITS in asm/sparsemem.h and don't
> >> include it in asm/pgtable.h. Include asm/sparsemem.h directly to get
> >> the MAX_PHYSMEM_BITS define on all architectures.

...

> >> Fixes: 61989a80fb3a ("staging: zsmalloc: zsmalloc memory allocation library")
> >> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >> ---
> >>  mm/zsmalloc.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> >> index c36fdff9a371..260bd48aacd0 100644
> >> --- a/mm/zsmalloc.c
> >> +++ b/mm/zsmalloc.c
> >> @@ -40,6 +40,7 @@
> >>  #include <linux/string.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/pgtable.h>
> >> +#include <asm/sparsemem.h>
> > 
> > asm/sparsemem.h is not available on some architectures.
> > It's better to use linux/mmzone.h instead.
> > 
> 
> Hm, linux/mmzone.h only includes asm/sparsemem.h when CONFIG_SPARSEMEM
> is enabled. However, on ARM at least I can have configurations without
> CONFIG_SPARSEMEM and physical address extension on (e.g.
> multi_v7_defconfig + CONFIG_LPAE + CONFIG_ZSMALLOC).
> 
> While sparsemem seems to be a good idea with LPAE it really seems not
> required (see also https://lore.kernel.org/patchwork/patch/567589/).
> 
> There seem to be also other architectures which define MAX_PHYSMEM_BITS
> only when SPARSEMEM is enabled, e.g.
> arch/riscv/include/asm/sparsemem.h...
> 
> Not sure how to get out of this.. Maybe make ZSMALLOC dependent on
> SPARSEMEM? It feels a bit silly restricting ZSMALLOC selection only due
> to a compile time define...

I think we can define MAX_POSSIBLE_PHYSMEM_BITS in one of 
arch/arm/inclide/asm/pgtable-{2,3}level-*.h headers to values supported
by !LPAE and LPAE.

That's what x86 does: 

$ git grep -w MAX_POSSIBLE_PHYSMEM_BITS arch/
arch/x86/include/asm/pgtable-3level_types.h:#define MAX_POSSIBLE_PHYSMEM_BITS   36
arch/x86/include/asm/pgtable_64_types.h:#define MAX_POSSIBLE_PHYSMEM_BITS       52

It seems that actual numbers would be 36 for !LPAE and 40 for LPAE, but
I'm not sure about that.

> --
> Stefan
> 
> >>  #include <asm/tlbflush.h>
> >>  #include <linux/cpumask.h>
> >>  #include <linux/cpu.h>
> >> --
> >> 2.29.1
> >>
> >>

-- 
Sincerely yours,
Mike.
