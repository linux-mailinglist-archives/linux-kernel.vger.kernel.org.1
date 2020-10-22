Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1E8295F31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505493AbgJVM6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:58:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:60016 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395265AbgJVM6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:58:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E49D9ACD0;
        Thu, 22 Oct 2020 12:58:41 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 0/3] Allocate memmap from hotadded memory (per device)
Date:   Thu, 22 Oct 2020 14:58:32 +0200
Message-Id: <20201022125835.26396-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset would be the next version of [1], but a lot has changed
in the meantime, so I figured I would just make another RFC.

After some discussions with David off the list, we agreed that it would be
easier as a starter to only support memmap from hotadded memory if the hotadded range
spans a single memory device.

The reason behind is that at any given time, a memory_block is either online or 
offline, and so the pages within it.
That means that operations like pfn_to_online_page always returns always the
right thing.

But that would not be the case if we support spanning multiple devices with
the infrastructure we have at the moment.

We have two options to support spanning multiple memory devices (which is the
final goal of this work):

 1) We play with sub-section bitmap, so although a section might be offline
    a pfn_to_online_page made on a vmemmap page will give us the right value.
    I was tempted to explore this, I am leaning more towards #2.

 2) Do some work towards flexible-sized memory devices.
    The way I see it, a memory_block device would be as big as the hot-added range
    so we could have memory_blocks of 1GB, 512MB, 64GB, all depending on the size
    of the device to be added to the system.

I am addind some David's notes in here:

"  Case 1: add_memory() spans a single memory device

          The memory can be either online/offline, and thereby, all sections
          online/offline. Nobody should be touching the vmemmap (even during
          add_memory() - except when poisoning vmemmap, which should most probably
          work as well, if not we can work around that).


  Case 2: add_memory() spans multiple memory devices

          Option 1: As we discussed, only cover full sections with the vmemmap. "Bad" thing
          is that the memory devices holding the vemmap might be offline to user space,
          but still contain relevant data ... bad for kexec-tools when creating memory to
          dump via kdump. Won't properly work.

  Option 2: Later extend option 1 to use sub-section online bitmap.

  Option 3: Convert to case 1. Michal proposed allowing flexible-sized memory devices.
            Will require some work, but would be the cleanest IMHO.


          So maybe starting with case 1 is best for now, and later extending it via Case2.3 -
          which would simply be reworking memory devices."
"

" 1. It can happen that pfn_online() for a vmemmap page returns either
    true or false, depending on the state of the section. It could be that
    the memory block holding the vmemmap is offline while another memory
    block making use of it is online.

    I guess this isn't bad (I assume it is similar for the altmap), however
    it could be that makedumpfile will exclude the vmemmap from dumps (as it
    will usually only dump pages in sections marked online if I am not wrong
    - maybe it special cases vmemmaps already). Also, could be that it is
    not saved/restored during hibernation. We'll have to verify."


This does not go without saying that the patchset is not 100% complete.
It is missing:

 - a way to disable memmap_on_memory (either sysfs or boot_time cmd)
 - atm, arch_add_memory for s390 screams if an altmap is passed.
   I am still thinking of a way to nicely drop handle that.
   Maybe a function in s390 that sets memmap_on_memory false and
   stuff that check in support_memmap_on_memory function.


Original cover letter:

----
The primary goal of this patchset is to reduce memory overhead of the
hot-added memory (at least for SPARSEMEM_VMEMMAP memory model).
The current way we use to populate memmap (struct page array) has two main drawbacks:

a) it consumes an additional memory until the hotadded memory itself is
   onlined and
b) memmap might end up on a different numa node which is especially true
   for movable_node configuration.
c) due to fragmentation we might end up populating memmap with base
   pages

One way to mitigate all these issues is to simply allocate memmap array
(which is the largest memory footprint of the physical memory hotplug)
from the hot-added memory itself. SPARSEMEM_VMEMMAP memory model allows
us to map any pfn range so the memory doesn't need to be online to be
usable for the array. See patch 3 for more details.
This feature is only usable when CONFIG_SPARSEMEM_VMEMMAP is set.

[Overall design]:

Implementation wise we reuse vmem_altmap infrastructure to override
the default allocator used by vmemap_populate. Once the memmap is
allocated we need a way to mark altmap pfns used for the allocation.
If MHP_MEMMAP_ON_MEMORY flag was passed, we set up the layout of the
altmap structure in add_memory_resource), and then we call
mark_vmemmap_pages() to mark vmemmap pages.

memory_block gained a new field called nr_vmemmap_pages.
This plays well for two reasons:

 1) {offline/online}_pages know the differente between start_pfn and
    valid_start_pfn, which is start_pfn + nr_vmemmap_pages.
    In this way all isolation/migration/initialization operations are
    done to the right range of memory without vmemmap pages to get involved.
    This allows us for a much cleaner handling.

 2) In try_remove_memory, we construct a new vmemap_altmap struct with the
    right info, so we end up calling vmem_altmap_free instead of free_pagetable
    when removing the memory.

Oscar Salvador (3):
  mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY
  mm: Introduce a new Vmemmap page-type
  mm,memory_hotplug: Allocate memmap from the added memory range

 drivers/acpi/acpi_memhotplug.c |   2 +-
 drivers/base/memory.c          |  21 +++--
 include/linux/memory.h         |   3 +-
 include/linux/memory_hotplug.h |  27 ++++++-
 include/linux/memremap.h       |   2 +-
 include/linux/mm.h             |   6 ++
 include/linux/mm_types.h       |   5 ++
 include/linux/page-flags.h     |   6 ++
 mm/memory_hotplug.c            | 139 +++++++++++++++++++++++++++------
 mm/memremap.c                  |   5 +-
 mm/page_alloc.c                |   7 ++
 mm/sparse.c                    |  25 ++++++
 12 files changed, 205 insertions(+), 43 deletions(-)

-- 
2.26.2

