Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1EF2D416B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbgLILvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:51:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:59152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730842AbgLILvq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:51:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 47CC4ACF1;
        Wed,  9 Dec 2020 11:51:05 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:51:02 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
Subject: Re: [RFC PATCH v3 2/4] mm,memory_hotplug: Allocate memmap from the
 added memory range
Message-ID: <20201209115033.GA31745@linux>
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-3-osalvador@suse.de>
 <0e53ae49-6b0a-0714-df0f-fd6183061752@redhat.com>
 <20201209103226.GC30892@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209103226.GC30892@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 11:32:26AM +0100, Oscar Salvador wrote:
> On Wed, Dec 02, 2020 at 11:05:53AM +0100, David Hildenbrand wrote:
> > If you take a look at generic_online_page() there are some things that
> > won't be done for our vmemmap pages
> > 
> > 1. kernel_map_pages(page, 1 << order, 1);
> > 
> > We're accessing these pages already when initializing the memmap. We
> > might have to explicitly map these vmemmap pages at some point. Might
> > require some thought. Did you test with debug pagealloc?
> 
> I always try to run with all debug stuff enabled, but I definitely
> did not enable debug_pagealloc.
> I will have a look at it.
> 
> > 2. totalram_pages_add(1UL << order);
> > 
> > We should add/remove the vmemmap pages manually from totalram I guess.
> 
> Yes, we should. That was a clear oversight.

Looking closer, I do not think we have to account those into totalram.
I might be mistaken but looking at memblock_free_all, it seems we only
account to totalram_pages those ranges laying in memblock.memory filtering
out memblock.reserved.

And it seems that the pages we use for pglist_data structs (the ones we handle
in register_page_bootmem_info_node) fall in memblock.reserved.

-- 
Oscar Salvador
SUSE L3
