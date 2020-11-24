Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A802C1FC0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgKXIUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:20:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:56898 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgKXIUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:20:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606206005; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=roLXjPdZSyjfxbswfdmyz8HZsNkniy24pO6y4bkuN5M=;
        b=hUYh/iU/cU/7AByPIn0H+ed3kCXycS7U6l5BBvy1UqzcmeahB//kcSwkqjQt4u1K1qA65A
        SgmuKgeIX/aVUUo4fF9xiushJ8vkPAp1GFvLFE9q0RPKeeyMsT5SAuDSuz7h4YKyc5N0DH
        s8c5tYTDuxkrMm3q5FGee29WHFLyZ7g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E9150AF58;
        Tue, 24 Nov 2020 08:20:04 +0000 (UTC)
Date:   Tue, 24 Nov 2020 09:20:03 +0100
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
Message-ID: <20201124081837.GS27488@dhcp22.suse.cz>
References: <CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com>
 <20201123090129.GD27488@dhcp22.suse.cz>
 <CA+CK2bCD8_x5cBUOksAzat_O4G8-PoLp378zN1mxKMcmyV8dAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bCD8_x5cBUOksAzat_O4G8-PoLp378zN1mxKMcmyV8dAw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 23-11-20 11:06:21, Pavel Tatashin wrote:
> On Mon, Nov 23, 2020 at 4:01 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 20-11-20 15:27:46, Pavel Tatashin wrote:
> > > Recently, I encountered a hang that is happening during memory hot
> > > remove operation. It turns out that the hang is caused by pinned user
> > > pages in ZONE_MOVABLE.
> > >
> > > Kernel expects that all pages in ZONE_MOVABLE can be migrated, but
> > > this is not the case if a user applications such as through dpdk
> > > libraries pinned them via vfio dma map.
> >
> > Long term or effectively time unbound pinning on zone movable is
> > fundamentaly broken. The sole reason of ZONE_MOVABLE existence is to
> > guarantee migrateability. If the cosumer of this memory cannot guarantee
> > that then it shouldn't use __GFP_MOVABLE in the first place.
> 
> Exactly, this is what I am trying to solve, and started this thread to
> figure out what is the best approach to address this problem.
> 
> >
> > > Kernel keeps trying to
> > > hot-remove them, but refcnt never gets to zero, so we are looping
> > > until the hardware watchdog kicks in.
> >
> > Yeah, the existing offlining behavior doesn't stop trying because the
> > current implementation of the migration cannot tell a diffence between
> > short and long term failures. Maybe the recent ref count for long term
> > pinning can be used to help out there.
> >
> > Anyway, I am wondering what do you mean by watchdog firing. The
> > operation should trigger neither of soft, hard or hung detectors.
> 
> You are right, the hot-remove is killable operation. In our case,
> however, systemd stops petting watchdog during kexec reboot to ensure
> that reboot finishes, however, because we hot-remove memory during
> shutdown, and kernel is unable to hot-remove memory within 60s we get
> a watchdog reset.

Well, this should be worked around quite trivially. You can kill your
attempt before the timeout fires.

[...]
> > > 2. Add an internal move_pages_zone() similar to move_pages() syscall
> > > but instead of migrating to a different NUMA node, migrate pages from
> > > ZONE_MOVABLE to another zone.
> > > Call move_pages_zone() on demand prior to pinning pages from
> > > vfio_pin_map_dma() for instance.
> >
> > Why is the existing migration API insufficient?
> 
> Here I am talking about internal implementation not user API. We do
> not have a function that migrates pages in a user address space from
> one zone to another zone. We only have a function that is exposed as a
> syscall that migrates pages from one node to another node.

We do have migrate_pages and its interface should make it trivial enough
that a new general purpose helper shouldn't be really needed.

	struct migration_target_control mtc = {
		.gfp_mask = GFP_USER | __GFP_RETRY_MAYFAIL,
	};
	migrate_pages(&list_of_pages, alloc_migration_target, NULL,
		(unsigned long)&mtc, MIGRATE_SYNC, MR_PINNING);

note that NR_PINNING would have to added.

> > > 3. Perhaps, it also makes sense to add madvise() flag, to allocate
> > > pages from non-movable zone. When a user application knows that it
> > > will do DMA mapping, and pin pages for a long time, the memory that it
> > > allocates should never be migrated or hot-removed, so make sure that
> > > it comes from the appropriate place.
> > > The benefit of adding madvise() flag is that we won't have to deal
> > > with slow page migration during pin time, but the disadvantage is that
> > > we would need to change the user interface.
> >
> > No, the MOVABLE_ZONE like other zone types are internal implementation
> > detail of the MM. I do not think we want to expose that to the userspace
> > and carve this into stone.
> 
> What I mean here is allowing users to guarantee that the page's PA is
> going to stay the same. Sort of a stronger mlock. Mlock only
> guarantees that the page is not swapped, but something like
> MADV_PINNED would guarantee that page is not going to be swapped and
> also not migrated.

There were some discussions around vmpin/unpin syscalls. This didn't
really lead anywhere. One of the roadblock was a proper accounting IIRC.
You might want to look for those discussions in email archives.

> If a user determines the PA of that page, that PA
> is going to stay the same throughout the life of the page. This is not
> exposing internal implementation in any way, this guarantee could be
> honored in various ways: i.e. pinned or allocating from ZONE_NORMAL.
> The fact that we would honor it by allocating memory from ZONE_NORMAL
> is implementation detail that would not be exposed to the user.

Jason has already replied to this and I do not have much to add.

[...]

> I just think it is inefficient to first allocate memory from
> ZONE_MOVABLE, and later migrate it to ZONE_NORMAL.

Yes it is inefficient. Is it usual that the memory is already faulted in
when it is pinned?

-- 
Michal Hocko
SUSE Labs
