Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC66F2C4A24
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgKYVi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:38:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26131 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731952AbgKYVi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606340305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8cd2jOc4EY0Hm/DYXh8AybG7dAGI+7EMMq4q48oG85k=;
        b=dURP6vZ0rC/sfTbZUixN3ivy33v8xnrmmMLlf8pLrTROJlnVxGDC8BNiYqsxp+reuvDQX3
        +m6axnNxwGW052p6S2o8a0jRdmA7IfUGq8GrMeTtc7MI/vtS4GYc/3ORgkzgsE7FbzBqCv
        jVZ2Yu9AsN+Vomsj93NO/IPdNM5H6u8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-oJi7CX4JPTuRCdqkq_z3Mw-1; Wed, 25 Nov 2020 16:38:20 -0500
X-MC-Unique: oJi7CX4JPTuRCdqkq_z3Mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12B9D10866A2;
        Wed, 25 Nov 2020 21:38:17 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E41345C1B4;
        Wed, 25 Nov 2020 21:38:16 +0000 (UTC)
Date:   Wed, 25 Nov 2020 16:38:16 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X77OyM8utmWcq1Di@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125210414.GO123287@linux.ibm.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 11:04:14PM +0200, Mike Rapoport wrote:
> I think the very root cause is how e820__memblock_setup() registers
> memory with memblock:
> 
> 		if (entry->type == E820_TYPE_SOFT_RESERVED)
> 			memblock_reserve(entry->addr, entry->size);
> 
> 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> 			continue;
> 
> 		memblock_add(entry->addr, entry->size);
> 
> From that point the system has inconsistent view of RAM in both
> memblock.memory and memblock.reserved and, which is then translated to
> memmap etc.
> 
> Unfortunately, simply adding all RAM to memblock is not possible as
> there are systems that for them "the addresses listed in the reserved
> range must never be accessed, or (as we discovered) even be reachable by
> an active page table entry" [1].
> 
> [1] https://lore.kernel.org/lkml/20200528151510.GA6154@raspberrypi/

It looks like what's missing is a blockmem_reserve which I don't think
would interfere at all with the issue above since it won't create
direct mapping and it'll simply invoke the second stage that wasn't
invoked here.

I guess this would have a better chance to have the second
initialization stage run in reserve_bootmem_region and it would likely
solve the problem without breaking E820_TYPE_RESERVED which is known
by the kernel:

> 		if (entry->type == E820_TYPE_SOFT_RESERVED)
> 			memblock_reserve(entry->addr, entry->size);
> 

+		if (entry->type == 20)
+			memblock_reserve(entry->addr, entry->size);

> 		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
> 			continue;
> 

This is however just to show the problem, I didn't check what type 20
is.

To me it doesn't look the root cause though, the root cause is that if
you don't call memblock_reserve the page->flags remains uninitialized.

I think the page_alloc.c need to be more robust and detect at least if
if holes within zones (but ideally all pfn_valid of all struct pages
in system even if beyond the end of the zone) aren't being initialized
in the second stage without relying on the arch code to remember to
call memblock_reserve.

In fact it's not clear why memblock_reserve even exists, that
information can be calculated reliably by page_alloc in function of
memblock.memory alone by walking all nodes and all zones. It doesn't
even seem to help in destroying the direct mapping,
reserve_bootmem_region just initializes the struct pages so it doesn't
need a special memeblock_reserved to find those ranges.

In fact it's scary that codes then does stuff like this trusting the
memblock_reserve is nearly complete information (which obviously isn't
given type 20 doesn't get queued and I got that type 20 in all my systems):

	for_each_reserved_mem_region(i, &start, &end) {
		if (addr >= start && addr_end <= end)
			return true;
	}

That code in irq-gic-v3-its.c should stop using
for_each_reserved_mem_region and start doing
pfn_valid(addr>>PAGE_SHIFT) if
PageReserved(pfn_to_page(addr>>PAGE_SHIFT)) instead.

At best memory.reserved should be calculated automatically by the
page_alloc.c based on the zone_start_pfn/zone_end_pfn and not passed
by the e820 caller, instead of adding the memory_reserve call for type
20 we should delete the memory_reserve function.

Thanks,
Andrea

