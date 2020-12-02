Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84ABC2CCAB3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgLBXsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:48:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgLBXsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:48:18 -0500
Date:   Wed, 2 Dec 2020 15:47:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1606952857;
        bh=9u2sLsqA/pgqgw1aASdJJWXFrLINqvAmzHh0/6/9ogo=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=KGKt739KlwoUynzZmZtSCcV9nJh3WdbCt28K/PjS2aATmTdqX4KrUcbs+Ues9BUGG
         s5j32+z0hgdCndbzXWGbdl7kFu5dhH03Pg2eIwM3ogjo75yCEFJ1rvJUflEFLN8+3n
         9BeEpoh99RcfbSeyj2j+y357sAqBk5OxNHV+zhU0=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: refactor initialization of stuct page for holes in
 memory layout
Message-Id: <20201202154736.5799e01b4c27a75b98e863fc@linux-foundation.org>
In-Reply-To: <20201201181502.2340-1-rppt@kernel.org>
References: <20201201181502.2340-1-rppt@kernel.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Dec 2020 20:15:02 +0200 Mike Rapoport <rppt@kernel.org> wrote:

> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> There could be struct pages that are not backed by actual physical memory.
> This can happen when the actual memory bank is not a multiple of
> SECTION_SIZE or when an architecture does not register memory holes
> reserved by the firmware as memblock.memory.
> 
> Such pages are currently initialized using init_unavailable_mem() function
> that iterated through PFNs in holes in memblock.memory and if there is a
> struct page corresponding to a PFN, the fields if this page are set to
> default values and it is marked as Reserved.
> 
> init_unavailable_mem() does not take into account zone and node the page
> belongs to and sets both zone and node links in struct page to zero.
> 
> On a system that has firmware reserved holes in a zone above ZONE_DMA, for
> instance in a configuration below:
> 
> 	# grep -A1 E820 /proc/iomem
> 	7a17b000-7a216fff : Unknown E820 type
> 	7a217000-7bffffff : System RAM
> 
> unset zone link in struct page will trigger
> 
> 	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);

That sounds pretty serious.

> because there are pages in both ZONE_DMA32 and ZONE_DMA (unset zone link in
> struct page) in the same pageblock.
> 
> Interleave initialization of pages that correspond to holes with the
> initialization of memory map, so that zone and node information will be
> properly set on such pages.
> 

Should this be backported to -stable?  If so, do we have a suitable Fixes:?
