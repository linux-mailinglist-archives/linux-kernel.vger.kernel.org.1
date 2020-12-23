Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69EDF2E2256
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 23:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgLWWL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 17:11:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgLWWL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 17:11:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8353222202;
        Wed, 23 Dec 2020 22:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608761447;
        bh=bC4arC7kCsqpAI2Kec7Pwm949X5SiBOT2DcjnCTGTHA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WGWyz95x9D5GpEGsWUSwuSBB4YjS0CuTyDRhnhPPw6mjJL/6lXRsVZ48PQqgZY+F4
         n9rYfqc0Gn53kvczMG5ug4VJivqLGV7hxZA2CRdHMCAS/8Y2U0yFIkUgzJTXY9EvLz
         E6YirwPUdTVj/33KvFNEv03PBI3Qbjh1L4KmKvWqnXPPq2P2bqA1YVWwaBjxLdAk4n
         5XPUz+g277LddH759VU7P55Acv35YBUoHiqyKk2t4c1XwO0vvMS8ElXpuixAq3Cs+c
         uB1xkce/fhHWuqAUE8HymjrzcOsgoCiUMUG6pUbkWM/T7l+iIZAllm6UsoMj+Q7okU
         p5Xa6JxDZYTZg==
Date:   Thu, 24 Dec 2020 00:10:39 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Rik van Riel <riel@surriel.com>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] mm: cma: allocate cma areas bottom-up
Message-ID: <20201223221039.GH392325@kernel.org>
References: <20201217201214.3414100-1-guro@fb.com>
 <20201220064848.GA392325@kernel.org>
 <20201221170551.GB3428478@carbon.DHCP.thefacebook.com>
 <20201222200606.fe4444f1f0ba008ee9fda091@linux-foundation.org>
 <20201223163537.GA4011967@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201223163537.GA4011967@carbon.DHCP.thefacebook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020 at 08:35:37AM -0800, Roman Gushchin wrote:
> On Tue, Dec 22, 2020 at 08:06:06PM -0800, Andrew Morton wrote:
> > On Mon, 21 Dec 2020 09:05:51 -0800 Roman Gushchin <guro@fb.com> wrote:
> > 
> > > Subject: [PATCH v3 1/2] mm: cma: allocate cma areas bottom-up
> > 
> > i386 allmodconfig:
> > 
> > In file included from ./include/vdso/const.h:5,
> >                  from ./include/linux/const.h:4,
> >                  from ./include/linux/bits.h:5,
> >                  from ./include/linux/bitops.h:6,
> >                  from ./include/linux/kernel.h:11,
> >                  from ./include/asm-generic/bug.h:20,
> >                  from ./arch/x86/include/asm/bug.h:93,
> >                  from ./include/linux/bug.h:5,
> >                  from ./include/linux/mmdebug.h:5,
> >                  from ./include/linux/mm.h:9,
> >                  from ./include/linux/memblock.h:13,
> >                  from mm/cma.c:24:
> > mm/cma.c: In function ‘cma_declare_contiguous_nid’:
> > ./include/uapi/linux/const.h:20:19: warning: conversion from ‘long long unsigned int’ to ‘phys_addr_t’ {aka ‘unsigned int’} changes value from ‘4294967296’ to ‘0’ [-Woverflow]
> >  #define __AC(X,Y) (X##Y)
> >                    ^~~~~~
> > ./include/uapi/linux/const.h:21:18: note: in expansion of macro ‘__AC’
> >  #define _AC(X,Y) __AC(X,Y)
> >                   ^~~~
> > ./include/linux/sizes.h:46:18: note: in expansion of macro ‘_AC’
> >  #define SZ_4G    _AC(0x100000000, ULL)
> >                   ^~~
> > mm/cma.c:349:53: note: in expansion of macro ‘SZ_4G’
> >     addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
> >                                                      ^~~~~
> > 
> 
> I thought that (!memblock_bottom_up() && memblock_end >= SZ_4G + size)
> can't be true on a 32-bit platform, so the whole if clause can be compiled out.
> Maybe it's because memblock_end can be equal to SZ_4G and if the size == 0...
> 
> I have no better idea than wrapping everything into
> #if BITS_PER_LONG > 32
> #endif.

32-bit systems can have more than 32 bit in the physical address.
I think a better option would be to use CONFIG_PHYS_ADDR_T_64BIT
 
> Thanks!
> 
> --
> 
> diff --git a/mm/cma.c b/mm/cma.c
> index 4fe74c9d83b0..5d69b498603a 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -344,12 +344,14 @@ int __init cma_declare_contiguous_nid(phys_addr_t base,
>                  * Avoid using first 4GB to not interfere with constrained zones
>                  * like DMA/DMA32.
>                  */
> +#if BITS_PER_LONG > 32
>                 if (!memblock_bottom_up() && memblock_end >= SZ_4G + size) {
>                         memblock_set_bottom_up(true);
>                         addr = memblock_alloc_range_nid(size, alignment, SZ_4G,
>                                                         limit, nid, true);
>                         memblock_set_bottom_up(false);
>                 }
> +#endif
>  
>                 if (!addr) {
>                         addr = memblock_alloc_range_nid(size, alignment, base,

-- 
Sincerely yours,
Mike.
