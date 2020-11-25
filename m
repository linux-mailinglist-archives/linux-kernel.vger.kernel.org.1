Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF252C3EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgKYLUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:20:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:39960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgKYLUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:20:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCDFFAC48;
        Wed, 25 Nov 2020 11:20:53 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v2 0/4] Allocate memmap from hotadded memory (per device)
Date:   Wed, 25 Nov 2020 12:20:44 +0100
Message-Id: <20201125112048.8211-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of [1]:

Changes from v1 -> v2:
 - Addressed feedback provided by David
 - Add a arch_support_memmap_on_memory to be called
   from mhp_supports_memmap_on_memory, as atm,
   only ARM, powerpc and x86_64 have altmat support.


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

[1] https://patchwork.kernel.org/project/linux-mm/cover/20201022125835.26396-1-osalvador@suse.de/

Oscar Salvador (4):
  mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY
  mm,memory_hotplug: Allocate memmap from the added memory range
  mm,memory_hotplug: Add mhp_supports_memmap_on_memory
  mm,memory_hotplug: Enable MHP_MEMMAP_ON_MEMORY when supported

 arch/arm64/mm/mmu.c                       |   5 +
 arch/powerpc/mm/mem.c                     |   5 +
 arch/powerpc/platforms/powernv/memtrace.c |   2 +-
 arch/x86/mm/init_64.c                     |   5 +
 drivers/acpi/acpi_memhotplug.c            |   5 +-
 drivers/base/memory.c                     |  21 ++--
 include/linux/memory.h                    |   7 +-
 include/linux/memory_hotplug.h            |  21 +++-
 include/linux/memremap.h                  |   2 +-
 mm/memory_hotplug.c                       | 119 ++++++++++++++++++----
 mm/page_alloc.c                           |   4 +-
 11 files changed, 158 insertions(+), 38 deletions(-)

-- 
2.26.2

