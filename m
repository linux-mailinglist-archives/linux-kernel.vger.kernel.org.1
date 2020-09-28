Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F99C27B3F0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgI1SCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:02:14 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:42421 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726808AbgI1SBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:01:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 5F59EC18;
        Mon, 28 Sep 2020 13:55:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 28 Sep 2020 13:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=from
        :to:cc:subject:date:message-id:reply-to:mime-version
        :content-type:content-transfer-encoding; s=fm1; bh=fmncist0AzJYx
        p6GLtq+mhjYGrSXjZlMGdyR6GzoHFE=; b=JePfCtZZ3VjR0kUkXWq2LPpwtPIYW
        lNEE93ErV2Ufd1HrdZAgMOGtN6KDRmwBKj9kSHkPFambHhGYjEwHjNAI4RAdPJLM
        tTz2xmZ6LbJ1GULmgkF04E28WDiLsSP0lYJW2qgzy2gM/6/ZGA9UgWdnlei+2IVJ
        ihJ8nLtcFcvW/WdEDnwBZ2EF3SH3vRKYKX09r/fX5T6xh8gwIy+aRqkneaTPyvED
        Kr3jJ659x4KM8+QoIFvZF8RC7HBb5A+yY73OZd+uJkANQHiRyKuHoPry9uqJdY6N
        ixktF7cj+NrD2WO6yq2v450r9ezE5SRZjRzjwfdrAI/1BRc8O1EHrTviw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:reply-to:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=fmncist0AzJYxp6GLtq+mhjYGrSXjZlMGdyR6GzoHFE=; b=RowmZrDE
        Jx8V8BtJ7p+fDPPRmcIVRA78cLpzbqcNHERRl3ZvWa/A8CSXiOmz/l5MTfciQEey
        v7Hekt8Exw0J0oQlwsT4rlyzHB+Nc3Xv31sfJhaXrAAbLUCPfDUB9nrjiSuSp63c
        GhV9DsApldHK8o4TNch8Q/4f5SxUAsucdHAMq05cBthI099jAvUojqzGY53isDFh
        XG78QVeWjrQfdb3KxLQxBrhKhp1/2MwK9BxwfyD9W/t77UsRuc9EhBsR9/CXgUlH
        it7SKFHQLpDuIVnQ3uxs2uVsuuJPSjSpu4+ZwXw8bYIdWEfF8Dm4y7DSrAt7rQ9l
        z6z7m1fRenUcpg==
X-ME-Sender: <xms:hiNyX_UUWpo2T_awWKlpkD4nPXWTFLaoq2ODbD3y0DaGXEwHsz5Ppg>
    <xme:hiNyX3kmAbckZmFSgMfjopoSv2VDiG9cvWhOrIJkmeC96YQ6nC-_GxZcextFr0rcL
    U6CLB0hrWlUXaVr3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofhrgggtgfesthekredtredtjeenucfhrhhomhepkghiucgjrghn
    uceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepkeehvdevje
    elvdffueevtddviedvgeevveelhfffjeeitedtkeeikeffveffgeetnecuffhomhgrihhn
    peelqdhrtgehqdhmmhhothhsqddvtddvtddqtdelqddukedqvdduqddvfedrihhtpdhgih
    hthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecukfhppeduvddrgeeirddutdeirddu
    ieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepii
    hirdihrghnsehsvghnthdrtghomh
X-ME-Proxy: <xmx:hiNyX7Zv-lDxw2uvy4yFTNQEU_6Cpy0-z-9D6Lq3PkLieAokk2gMwQ>
    <xmx:hiNyX6WAqo8hiqIw-GJpAhP9e7hpwY8Lg_P4yjFSjJB_5OPIEekjLw>
    <xmx:hiNyX5nIjEXoYEYvCtiCQipxxRo0tTXCxuJjpKYtf1Mh22TrAzGALQ>
    <xmx:iCNyX-8BGNfLEZyCbgKDww-ZDYDgi78OXQpF3eRV8wxHtfEhOIhBTSsic3w>
Received: from nvrsysarch6.NVidia.COM (unknown [12.46.106.164])
        by mail.messagingengine.com (Postfix) with ESMTPA id DBA873064610;
        Mon, 28 Sep 2020 13:55:17 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     linux-mm@kvack.org
Cc:     "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>
Subject: [RFC PATCH v2 00/30] 1GB PUD THP support on x86_64
Date:   Mon, 28 Sep 2020 13:53:58 -0400
Message-Id: <20200928175428.4110504-1-zi.yan@sent.com>
X-Mailer: git-send-email 2.28.0
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

Hi all,

This patchset adds support for 1GB PUD THP on x86_64. It is on top of
v5.9-rc5-mmots-2020-09-18-21-23. It is also available at:
https://github.com/x-y-z/linux-1gb-thp/tree/1gb_thp_v5.9-rc5-mmots-2020-09-18-21-23

Other than PUD THP, we had some discussion on generating THPs and contiguous
physical memory via a synchronous system call [0]. I am planning to send out a
separate patchset on it later, since I feel that it can be done independently of
PUD THP support.

Any comment or suggestion is welcome. Thanks.

Motiation
====
The patchset is trying to provide a more transparent way of boosting virtual
memory performance by leveraging gigantic TLB entries compared to hugetlbfs
pages [1,2]. Roman also said he would provide performance numbers of using 1GB
PUD THP once the patchset is a relatively good shape [1].


Patchset organization:
====

1. Patch 1 and 2: Jason's PUD entry READ_ONCE patch to walk_page_range to give
   a consistent read of PUD entries during lockless page table walks.
   I also add PMD entry READ_ONCE patch, since PMD level walk_page_range has
   the same lockless behavior as PUD level.

2. Patch 3: THP page table deposit now use single linked list to enable
   hierarchical page table deposit, i.e., deposit a PMD page where 512 PTE pages
   are deposited to.  Every page table page has a deposit_head and a deposit_node.
   For example, when storing 512 PTE pages to a PMD page, PMD page's deposit_head
   links to a PTE page's deposit_node, which links to another PTE page's
   deposit_node.

3. Patch 4,5,6: helper functions for allocating page table pages for PUD THPs
   and change thp_order and thp_nr.

4. Patch 7 to 23: PUD THP implementation. It is broken into small patches for
   easy review.

5. Patch 24, 25: new page size encoding for MADV_HUGEPAGE and MADV_NOHUGEPAGE in
   madvise. User can specify THP size. Only MADV_HUGEPAGE_1GB is used accepted.
   VM_HUGEPAGE_PUD is added to vm_flags to store the information at big 37.
   You are welcome to suggest any other approach.

6. Patch 26, 27: enable_pud_thp and hpage_pud_size are added to
   /sys/kernel/mm/transparent_hugepage/. enable_pud_thp is set to never by
   default.

7. Patch 28, 29: PUD THPs are allocated only from boot-time reserved CMA regions.
   The CMA regions can be used for other moveable page allocations.


Design for PUD-, PMD-, and PTE-mapped PUD THP
====

One additional design compared to PMD THP is the support for PMD-mapped PUD THP,
since original THP design supports PUD-mapped and PTE-mapped PUD THP
automatically.

PMD mapcounts are stored at (512*N + 3) subpages (N = 0 to 511) and 512*N
subpages are called PMDPageInPUD. A PUDDoubleMap bit is stored at third
subpage of a PUD THP, using the same page flag position as DoubleMap (stored
at second subpage of a PMD THP), to indicate a PUD THP with both PUD and
PMD mappings.


A PUD THP looks like:

┌───┬───┬───┬───┬─────┬───┬───┬───┬───┬────────┬──────┐
│ H │ T │ T │ T │ ... │ T │ T │ T │ T │  ...   │  T   │
│ 0 │ 1 │ 2 │ 3 │     │512│513│514│515│        │262143│
└───┴───┴───┴───┴─────┴───┴───┴───┴───┴────────┴──────┘

PMDPageInPUD pages in a PUD THP (only show first two PMDPageInPUD pages below).
Note that PMDPageInPUD pages are identified by their relative position to the
head page of the PUD THP and are still tail pages except the first one,
so H_0, T_512, T_1024, ... T_512x511 are all PMDPageInPUD pages:

 ┌────────────┬──────────────┬────────────┬──────────────┬───────────────────┐
 │PMDPageInPUD│     ...      │PMDPageInPUD│     ...      │  the remaining    │
 │    page    │ 511 subpages │    page    │ 511 subpages │ 510x512 subpages  │
 └────────────┴──────────────┴────────────┴──────────────┴───────────────────┘


Mapcount positions:

* For each subpage, its PTE mapcount is _mapcount, the same as PMD THP.
* For PUD THP, its PUD-mapping uses compound_mapcount at T_1 the same as PMD THP.
* For PMD-mapped PUD THP, its PMD-mapping uses compound_mapcount at T_3, T_515,
  ..., T_512x511+3. It is called sub_compound_mapcount.

PUDDoubleMap and DoubleMap in PUD THP:

* PUDDoubleMap is stored at the page flag of T_2 (third subpage), reusing the
  DoubleMap's position.
* DoubleMap is stored at the page flags of T_1 (second subpage), T_513, ...,
  T_512x511+1.

[0] https://lore.kernel.org/linux-mm/20200907072014.GD30144@dhcp22.suse.cz/
[1] https://lore.kernel.org/linux-mm/20200903162527.GF60440@carbon.dhcp.thefacebook.com/
[2] https://lore.kernel.org/linux-mm/20200903165051.GN24045@ziepe.ca/


Changelog from RFC v1
====
1. Add Jason's PUD entry READ_ONCE patch and my PMD entry READ_ONCE patch to
   get consistent page table entry reading in lockless page table walks.
2. Use single linked list for page table page deposit instead of pagechain
   data structure from RFC v1.
3. Address Kirill's comments.
4. Remove PUD page allocation via alloc_contig_pages(), using cma_alloc only.
5. Add madvise flag MADV_HUGEPAGE_1GB to explicitly enable PUD THP on specific
   VMAs instead of reusing MADV_HUGEPAGE. A new vm_flags VM_HUGEPAGE_PUD is
   added to achieve this.
6. Break large patches in v1 into small ones for easy review.

Jason Gunthorpe (1):
  mm/pagewalk: use READ_ONCE when reading the PUD entry unlocked

Zi Yan (29):
  mm: pagewalk: use READ_ONCE when reading the PMD entry unlocked
  mm: thp: use single linked list for THP page table page deposit.
  mm: add new helper functions to allocate one PMD page with 512 PTE
    pages.
  mm: thp: add page table deposit/withdraw functions for PUD THP.
  mm: change thp_order and thp_nr as we will have not just PMD THPs.
  mm: thp: add anonymous PUD THP page fault support without enabling it.
  mm: thp: add PUD THP support for copy_huge_pud.
  mm: thp: add PUD THP support to zap_huge_pud.
  fs: proc: add PUD THP kpageflag.
  mm: thp: handling PUD THP reference bit.
  mm: rmap: add mappped/unmapped page order to anonymous page rmap
    functions.
  mm: rmap: add map_order to page_remove_anon_compound_rmap.
  mm: thp: add PUD THP split_huge_pud_page() function.
  mm: thp: add PUD THP to deferred split list when PUD mapping is gone.
  mm: debug: adapt dump_page to PUD THP.
  mm: thp: PUD THP COW splits PUD page and falls back to PMD page.
  mm: thp: PUD THP follow_p*d_page() support.
  mm: stats: make smap stats understand PUD THPs.
  mm: page_vma_walk: teach it about PMD-mapped PUD THP.
  mm: thp: PUD THP support in try_to_unmap().
  mm: thp: split PUD THPs at page reclaim.
  mm: support PUD THP pagemap support.
  mm: madvise: add page size options to MADV_HUGEPAGE and
    MADV_NOHUGEPAGE.
  mm: vma: add VM_HUGEPAGE_PUD to vm_flags at bit 37.
  mm: thp: add a global knob to enable/disable PUD THPs.
  mm: thp: make PUD THP size public.
  hugetlb: cma: move cma reserve function to cma.c.
  mm: thp: use cma reservation for pud thp allocation.
  mm: thp: enable anonymous PUD THP at page fault path.

 .../admin-guide/kernel-parameters.txt         |   2 +-
 Documentation/admin-guide/mm/transhuge.rst    |   1 +
 arch/arm64/mm/hugetlbpage.c                   |   2 +-
 arch/powerpc/mm/hugetlbpage.c                 |   2 +-
 arch/x86/include/asm/pgalloc.h                |  69 ++
 arch/x86/include/asm/pgtable.h                |  26 +
 arch/x86/kernel/setup.c                       |   8 +-
 arch/x86/mm/pgtable.c                         |  38 +
 drivers/base/node.c                           |   3 +
 fs/proc/meminfo.c                             |   2 +
 fs/proc/page.c                                |   2 +
 fs/proc/task_mmu.c                            | 200 +++-
 include/linux/cma.h                           |  18 +
 include/linux/huge_mm.h                       |  84 +-
 include/linux/hugetlb.h                       |  12 -
 include/linux/memcontrol.h                    |   5 +
 include/linux/mm.h                            |  42 +-
 include/linux/mm_types.h                      |  11 +-
 include/linux/mmu_notifier.h                  |  13 +
 include/linux/mmzone.h                        |   1 +
 include/linux/page-flags.h                    |  48 +
 include/linux/pagewalk.h                      |   4 +-
 include/linux/pgtable.h                       |  34 +
 include/linux/rmap.h                          |  10 +-
 include/linux/swap.h                          |   2 +
 include/linux/vm_event_item.h                 |   7 +
 include/uapi/asm-generic/mman-common.h        |  23 +
 include/uapi/linux/kernel-page-flags.h        |   1 +
 kernel/events/uprobes.c                       |   4 +-
 kernel/fork.c                                 |  10 +-
 mm/cma.c                                      | 119 +++
 mm/debug.c                                    |   6 +-
 mm/gup.c                                      |  60 +-
 mm/hmm.c                                      |  16 +-
 mm/huge_memory.c                              | 899 +++++++++++++++++-
 mm/hugetlb.c                                  | 117 +--
 mm/khugepaged.c                               |  16 +-
 mm/ksm.c                                      |   4 +-
 mm/madvise.c                                  |  76 +-
 mm/mapping_dirty_helpers.c                    |   6 +-
 mm/memcontrol.c                               |  43 +-
 mm/memory.c                                   |  28 +-
 mm/mempolicy.c                                |  29 +-
 mm/migrate.c                                  |  12 +-
 mm/mincore.c                                  |  10 +-
 mm/page_alloc.c                               |  53 +-
 mm/page_vma_mapped.c                          | 171 +++-
 mm/pagewalk.c                                 |  47 +-
 mm/pgtable-generic.c                          |  49 +-
 mm/ptdump.c                                   |   3 +-
 mm/rmap.c                                     | 300 ++++--
 mm/swap.c                                     |  30 +
 mm/swap_slots.c                               |   2 +
 mm/swapfile.c                                 |  11 +-
 mm/userfaultfd.c                              |   2 +-
 mm/util.c                                     |  22 +-
 mm/vmscan.c                                   |  33 +-
 mm/vmstat.c                                   |   8 +
 58 files changed, 2396 insertions(+), 460 deletions(-)

--
2.28.0

