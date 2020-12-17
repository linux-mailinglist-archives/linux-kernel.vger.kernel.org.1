Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F12DD1E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 14:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgLQNIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 08:08:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:47118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgLQNIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 08:08:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C96B6AC7F;
        Thu, 17 Dec 2020 13:08:07 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     david@redhat.com, mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/5] Allocate memmap from hotadded memory (per device)
Date:   Thu, 17 Dec 2020 14:07:53 +0100
Message-Id: <20201217130758.11565-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I figured I would send a new version before going on vacation, so I can
work on it when I am back.

Changes from RFCv3 to Patchv1:
 - Addressed feedback from David
 - Re-order patches

Changes from v2 -> v3:
 - Re-order patches (Michal)
 - Fold "mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY" in patch#1
 - Add kernel boot option to enable this feature (Michal)

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
the default allocator used by vmemap_populate.
memory_block structure gained a new field called nr_vmemmap_pages.
This plays well for two reasons:

 1) {offline/online}_pages know the difference between start_pfn and
    buddy_start_pfn, which is start_pfn + nr_vmemmap_pages.
    In this way all isolation/migration operations are
    done to within the right range of memory without vmemmap pages.
    This allows us for a much cleaner handling.

 2) In try_remove_memory, we construct a new vmemap_altmap struct with the
    right information based on memory_block->nr_vmemap_pages, so we end up
    calling vmem_altmap_free instead of free_pagetable when removing the memory.

Oscar Salvador (5):
  mm: Introduce ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
  mm,memory_hotplug: Allocate memmap from the added memory range
  acpi,memhotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
  powerpc/memhotplug: Enable MHP_MEMMAP_ON_MEMORY when supported
  mm,memory_hotplug: Add kernel boot option to enable memmap_on_memory

 .../admin-guide/kernel-parameters.txt         |  14 ++
 arch/arm64/Kconfig                            |   4 +
 arch/powerpc/Kconfig                          |   4 +
 .../platforms/pseries/hotplug-memory.c        |   5 +-
 arch/x86/Kconfig                              |   4 +
 drivers/acpi/acpi_memhotplug.c                |   5 +-
 drivers/base/memory.c                         |  20 ++-
 include/linux/memory.h                        |   8 +-
 include/linux/memory_hotplug.h                |  21 ++-
 include/linux/memremap.h                      |   2 +-
 include/linux/mmzone.h                        |   5 +
 mm/Kconfig                                    |   3 +
 mm/Makefile                                   |   5 +-
 mm/memory_hotplug.c                           | 158 +++++++++++++++---
 mm/page_alloc.c                               |   4 +-
 15 files changed, 224 insertions(+), 38 deletions(-)

-- 
2.26.2

