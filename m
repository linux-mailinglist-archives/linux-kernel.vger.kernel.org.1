Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 008953025AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 14:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbhAYNrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 08:47:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:43746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729055AbhAYNoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:44:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6EA6EB99F;
        Mon, 25 Jan 2021 11:18:19 +0000 (UTC)
Date:   Mon, 25 Jan 2021 12:18:17 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        akpm@linux-foundation.org, mhocko@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        pasha.tatashin@soleen.com
Subject: Re: [PATCH 2/5] mm,memory_hotplug: Allocate memmap from the added
 memory range
Message-ID: <20210125111816.GB28363@linux>
References: <20201217130758.11565-1-osalvador@suse.de>
 <20201217130758.11565-3-osalvador@suse.de>
 <21079c2d-67d0-fc59-8d7f-0795b3f8a3e3@redhat.com>
 <20210125103951.GA27851@linux>
 <a0193441-4c79-b85e-ff38-e7ab3a462beb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0193441-4c79-b85e-ff38-e7ab3a462beb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 25, 2021 at 11:57:20AM +0100, David Hildenbrand wrote:
> I'm confused.
> 
> 1. Assume we hotplug memory, online it to ZONE_MOVABLE. The vmemmap gets
> allocated from altmap space.

The vmemmap could have never been allocated from altmap in case hpage vmemmap
feature is enabled.

Have a look at [1].
If is_hugetlb_free_vmemmap_enabled(), vmemmap_populate() ends up calling
vmemmap_populate_basepages().

And since no memory was consumed from altmap, and hence altmap_alloc_block_buf()
was never called, vmem_altmap->alloc will be 0, and memory_block->nr_vmemmap_pages
will be 0 as well.

But on a second though, true is that we will get in trouble if hpage vmemmap
feature ever gets to work with vmemmap_populate_hugepages.
I will queue that to look in a new future.

[1] https://patchwork.kernel.org/project/linux-mm/patch/20210117151053.24600-10-songmuchun@bytedance.com/


-- 
Oscar Salvador
SUSE L3
