Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55392C01DD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgKWJBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:01:32 -0500
Received: from mx2.suse.de ([195.135.220.15]:41878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgKWJBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:01:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606122090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjl5UMVuuyoQfqRCTSDt5soHTVWO5X8L91E971LLf0Y=;
        b=lCOXuryyJ+Vg74cLIHGG5VUmLp6mJJX5LYrnHYpwgsbBw/rJKy838IqLG35tdwexQ3e7EA
        0HhQXbrNl3gjoNFoRXqZzMo2rgb5XEtz2PyEyjvxP01tiyquIxDq/X2zAfRwxpfD2xWFuT
        0du1567VfjVs+Qux8IeR0lVdoEMNLo8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 485BFAD57;
        Mon, 23 Nov 2020 09:01:30 +0000 (UTC)
Date:   Mon, 23 Nov 2020 10:01:29 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, sthemmin@microsoft.com
Subject: Re: Pinning ZONE_MOVABLE pages
Message-ID: <20201123090129.GD27488@dhcp22.suse.cz>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 20-11-20 15:27:46, Pavel Tatashin wrote:
> Recently, I encountered a hang that is happening during memory hot
> remove operation. It turns out that the hang is caused by pinned user
> pages in ZONE_MOVABLE.
> 
> Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> this is not the case if a user applications such as through dpdk
> libraries pinned them via vfio dma map.

Long term or effectively time unbound pinning on zone movable is
fundamentaly broken. The sole reason of ZONE_MOVABLE existence is to
guarantee migrateability. If the cosumer of this memory cannot guarantee
that then it shouldn't use __GFP_MOVABLE in the first place.

> Kernel keeps trying to
> hot-remove them, but refcnt never gets to zero, so we are looping
> until the hardware watchdog kicks in.

Yeah, the existing offlining behavior doesn't stop trying because the
current implementation of the migration cannot tell a diffence between
short and long term failures. Maybe the recent ref count for long term
pinning can be used to help out there.

Anyway, I am wondering what do you mean by watchdog firing. The
operation should trigger neither of soft, hard or hung detectors.

> We cannot do dma unmaps before hot-remove, because hot-remove is a
> slow operation, and we have thousands for network flows handled by
> dpdk that we just cannot suspend for the duration of hot-remove
> operation.
> 
> The solution is for dpdk to allocate pages from a zone below
> ZONE_MOVAVLE, i.e. ZONE_NORMAL/ZONE_HIGHMEM, but this is not possible.
> There is no user interface that we have that allows applications to
> select what zone the memory should come from.

Our existing interface is __GFP_MOVABLE. It is a responsibility of the
driver to know whether the resulting memory is migratable. Users
shouldn't even have to think about that.

> I've spoken with Stephen Hemminger, and he said that DPDK is moving in
> the direction of using transparent huge pages instead of HugeTLBs,
> which means that we need to allow at least anonymous, and anonymous
> transparent huge pages to come from non-movable zones on demand.

You can migrate before pinning.

> Here is what I am proposing:
> 1. Add a new flag that is passed through pin_user_pages_* down to
> fault handlers, and allow the fault handler to allocate from a
> non-movable zone.

gup already tries to deal with long term pins on CMA regions and migrate
to a non CMA region. Have a look at __gup_longterm_locked. Migrating of
the movable zone sounds like a reasonable solution to me.

> 2. Add an internal move_pages_zone() similar to move_pages() syscall
> but instead of migrating to a different NUMA node, migrate pages from
> ZONE_MOVABLE to another zone.
> Call move_pages_zone() on demand prior to pinning pages from
> vfio_pin_map_dma() for instance.

Why is the existing migration API insufficient?

> 3. Perhaps, it also makes sense to add madvise() flag, to allocate
> pages from non-movable zone. When a user application knows that it
> will do DMA mapping, and pin pages for a long time, the memory that it
> allocates should never be migrated or hot-removed, so make sure that
> it comes from the appropriate place.
> The benefit of adding madvise() flag is that we won't have to deal
> with slow page migration during pin time, but the disadvantage is that
> we would need to change the user interface.

No, the MOVABLE_ZONE like other zone types are internal implementation
detail of the MM. I do not think we want to expose that to the userspace
and carve this into stone.

-- 
Michal Hocko
SUSE Labs
