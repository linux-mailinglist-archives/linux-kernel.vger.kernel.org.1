Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F081FE5DA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 04:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387607AbgFRC3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 22:29:05 -0400
Received: from foss.arm.com ([217.140.110.172]:38588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729562AbgFRBQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:16:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BB6C31B;
        Wed, 17 Jun 2020 18:16:13 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.80.176])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3351C3F6CF;
        Wed, 17 Jun 2020 18:16:02 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 (RESEND) 0/3] arm64: Enable vmemmap mapping from device memory
Date:   Thu, 18 Jun 2020 06:45:27 +0530
Message-Id: <1592442930-9380-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables vmemmap backing memory allocation from device memory
ranges on arm64. But before that, it enables vmemmap_populate_basepages()
and vmemmap_alloc_block_buf() to accommodate struct vmem_altmap based
alocation requests.

This series applies on 5.8-rc1.

Pending Question:

altmap_alloc_block_buf() does not have any other remaining users in the
tree after this change. Should it be converted into a static function and
it's declaration be dropped from the header (include/linux/mm.h). Avoided
doing so because I was not sure if there are any off-tree users or not.

Changes in V3:

- Dropped comment from free_hotplug_page_range() per Robin
- Modified comment in unmap_hotplug_range() per Robin
- Enabled altmap support in vmemmap_alloc_block_buf() per Robin

Changes in V2: (https://lkml.org/lkml/2020/3/4/475)

- Rebased on latest hot-remove series (v14) adding P4D page table support

Changes in V1: (https://lkml.org/lkml/2020/1/23/12)

- Added an WARN_ON() in unmap_hotplug_range() when altmap is
  provided without the page table backing memory being freed

Changes in RFC V2: (https://lkml.org/lkml/2019/10/21/11)

- Changed the commit message on 1/2 patch per Will
- Changed the commit message on 2/2 patch as well
- Rebased on arm64 memory hot remove series (v10)

RFC V1: (https://lkml.org/lkml/2019/6/28/32)

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-ia64@vger.kernel.org
Cc: linux-riscv@lists.infradead.org
Cc: x86@kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org

Anshuman Khandual (3):
  mm/sparsemem: Enable vmem_altmap support in vmemmap_populate_basepages()
  mm/sparsemem: Enable vmem_altmap support in vmemmap_alloc_block_buf()
  arm64/mm: Enable vmem_altmap support for vmemmap mappings

 arch/arm64/mm/mmu.c       | 59 ++++++++++++++++++++++++++-------------
 arch/ia64/mm/discontig.c  |  2 +-
 arch/powerpc/mm/init_64.c | 10 +++----
 arch/riscv/mm/init.c      |  2 +-
 arch/x86/mm/init_64.c     | 12 ++++----
 include/linux/mm.h        |  8 ++++--
 mm/sparse-vmemmap.c       | 38 ++++++++++++++++++++-----
 7 files changed, 87 insertions(+), 44 deletions(-)

-- 
2.20.1

