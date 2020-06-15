Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8491F9171
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 10:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgFOI3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 04:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728920AbgFOI3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:29:45 -0400
Received: from kernel.org (unknown [87.70.26.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A822068E;
        Mon, 15 Jun 2020 08:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592209784;
        bh=23TYPFpEKvNG+M9i5OGqsm7+0VGa7qmB7xwajbtz/wU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Flm5vp3x+Sr5xNiY+TsswHMxMMM66rFoAkf6bDLGOOmK//WbN06VBkC9RP4FMU2a5
         qJKxQkn0M5uE/Jm/NEYcJkWZMEsbC65SPM8S9WC/pF9tXYRYufOOstFYKxjjrB1AUf
         fwxcH6K7gdb2bGQcqv9kakRnWoneX0oeF6edxIqM=
Date:   Mon, 15 Jun 2020 11:29:37 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     akpm@linux-foundation.org, bhe@redhat.com, geert@linux-m68k.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, rppt@linux.ibm.com
Subject: Re: [PATCH 04/21] mm: free_area_init: use maximal zone PFNs rather
 than zone sizes
Message-ID: <20200615082937.GB7882@kernel.org>
References: <20200412194859.12663-5-rppt@kernel.org>
 <f53e68db-ed81-6ef6-5087-c7246d010ea2@linux-m68k.org>
 <20200615062234.GA7882@kernel.org>
 <24563231-ed19-6f4f-617e-4d6bfc7553e4@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24563231-ed19-6f4f-617e-4d6bfc7553e4@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(reduced the spam list)

On Mon, Jun 15, 2020 at 05:17:28PM +1000, Greg Ungerer wrote:
> Hi Mike,
> 
> On 15/6/20 4:22 pm, Mike Rapoport wrote:
> > On Mon, Jun 15, 2020 at 01:53:42PM +1000, Greg Ungerer wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > Currently, architectures that use free_area_init() to initialize memory map
> > > > and node and zone structures need to calculate zone and hole sizes. We can
> > > > use free_area_init_nodes() instead and let it detect the zone boundaries
> > > > while the architectures will only have to supply the possible limits for
> > > > the zones.
> > > > 
> > > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > This is causing some new warnings for me on boot on at least one non-MMU m68k target:
> > 
> > There were a couple of changes that cause this. The free_area_init()
> > now relies on memblock data and architectural limits for zone sizes
> > rather than on explisit pfns calculated by the arch code. I've update
> > motorola variant and missed coldfire. Angelo sent a fix for mcfmmu.c
> > [1] and I've updated it to include nommu as well
> > 
> > [1] https://lore.kernel.org/linux-m68k/20200614225119.777702-1-angelo.dureghello@timesys.com
> > 
> > > From 55b8523df2a5c4565b132c0691990f0821040fec Mon Sep 17 00:00:00 2001
> > From: Angelo Dureghello <angelo.dureghello@timesys.com>
> > Date: Mon, 15 Jun 2020 00:51:19 +0200
> > Subject: [PATCH] m68k: fix registration of memory regions with memblock
> > 
> > Commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
> > introduced assumption that UMA systems have their memory at node 0 and
> > updated most of them, but it forgot nommu and coldfire variants of m68k.
> > 
> > The later change in free area initialization in commit fa3354e4ea39 ("mm:
> > free_area_init: use maximal zone PFNs rather than zone sizes") exposed that
> > and caused a lot of "BUG: Bad page state in process swapper" reports.
> 
> Even with this patch applied I am still seeing the same messages.

Argh, it was to early in the morning...
Can you please try the one below?

It seems that coldfire didn't register all its physical memory with
memblock and the pfn list was damaged because of that.


diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index e779b19e0193..f66f4b1d062e 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -138,7 +138,8 @@ void __init setup_arch(char **cmdline_p)
 	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
 		 __bss_stop, memory_start, memory_start, memory_end);
 
-	memblock_add(memory_start, memory_end - memory_start);
+	memblock_add(_rambase, memory_end - _rambase);
+	memblock_reserve(_rambase, memory_start - _rambase);
 
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];

> Regards
> Greg
> 
> 
> 
> > Using memblock_add_node() with nid = 0 to register memory banks solves the
> > problem.
> > 
> > Fixes: 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
> > Fixes: fa3354e4ea39 ("mm: free_area_init: use maximal zone PFNs rather than zone sizes")
> > Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> > Co-developed-by: Mike Rapoport <rppt@linux.ibm.com>
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >   arch/m68k/kernel/setup_no.c | 2 +-
> >   arch/m68k/mm/mcfmmu.c       | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> > index e779b19e0193..0c4589a39ba9 100644
> > --- a/arch/m68k/kernel/setup_no.c
> > +++ b/arch/m68k/kernel/setup_no.c
> > @@ -138,7 +138,7 @@ void __init setup_arch(char **cmdline_p)
> >   	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
> >   		 __bss_stop, memory_start, memory_start, memory_end);
> > -	memblock_add(memory_start, memory_end - memory_start);
> > +	memblock_add_node(memory_start, memory_end - memory_start, 0);
> >   	/* Keep a copy of command line */
> >   	*cmdline_p = &command_line[0];
> > diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
> > index 29f47923aa46..7d04210d34f0 100644
> > --- a/arch/m68k/mm/mcfmmu.c
> > +++ b/arch/m68k/mm/mcfmmu.c
> > @@ -174,7 +174,7 @@ void __init cf_bootmem_alloc(void)
> >   	m68k_memory[0].addr = _rambase;
> >   	m68k_memory[0].size = _ramend - _rambase;
> > -	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
> > +	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
> >   	/* compute total pages in system */
> >   	num_pages = PFN_DOWN(_ramend - _rambase);
> > 

-- 
Sincerely yours,
Mike.
