Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDB72AAB58
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 15:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgKHOLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 09:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgKHOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:11:41 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0FCC0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 06:11:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id x23so3254215plr.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2aF5NaoDkK2ZcMpmMV4l4ZLBE98BuwSgPzZ5P5ulSGs=;
        b=r8a1yp/F3kNUNVyLMKlRBhl3dY/sw+BfRjs2khXncZ+IcSy3wqMSo9cn6S3lHf5gBZ
         T01P4kIkm/FzOqZ/GLdZYLufIThXzQ2XtQQ9pkXfHkJTI5Wqr7BLUp3I/khSalOR9te2
         xQY6Yz1oP8HwuujDG4w02UXhrfN9fvi5AnwOVMHt0s5I6pXwLvyjKFLqNsysYHrMuhsJ
         EAQ4QsStMsdgXGCwLnqdPaaG2/MFaYKI+p96uHMpVS20d5I2dH7HVa9iBvj5y7yvwq2n
         OzYtRpshMrK0H0RKW7mN/w6eqCR6V46/4fUz5xUKMTUpLxmwPT3PWSjl1z2voK3ZDK+g
         pH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2aF5NaoDkK2ZcMpmMV4l4ZLBE98BuwSgPzZ5P5ulSGs=;
        b=CqLWQEphP9ggj3e8a1AQ21EWTOyJsLph2Z3PqzmmVEV+1vl/QGtRTa/tTlzPBHmtHY
         6TwZHUgj/3v4oKMAUFf6FC2uFufoteeCXOHlkOGtH2bXP1OD5e0qXP1DBXEC4XhhgxfF
         c6ExQ5th1wfd2j+TxeireZwok0hxUx+6Q9XJKLVbW/tZdlComuqDhmh+GVzrQY3BzMf3
         8bw9QoiPWsfP+urT1/avZYcHuKE6Qs+VWsttSrUJQ1KRV+JRLlcLb1+LsvBn3yVGXDFh
         cLFckOwHXKechm5FJ+LscdpZmqBSuMbBLIK/Pw+6Ln8aIumWdWxuzZDRMbFHe8ZKL6QF
         SFbw==
X-Gm-Message-State: AOAM533zheRojc8FgvgU5c6atMuwGnb7ktock78kGZLeKjF7kOlWHKCs
        BYMx2y1ANcI8FyAd6UnlzX16TA==
X-Google-Smtp-Source: ABdhPJw6hMkEOMDskOGoCGVgf+fV/337gzTkrkWC7pp/WtaP4oN3OfepzT6SygsSJORM5gKr1J0UTA==
X-Received: by 2002:a17:902:684b:b029:d6:e482:9fee with SMTP id f11-20020a170902684bb02900d6e4829feemr9254378pln.10.1604844701033;
        Sun, 08 Nov 2020 06:11:41 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.11.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:11:40 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 00/21] Free some vmemmap pages of hugetlb page
Date:   Sun,  8 Nov 2020 22:10:52 +0800
Message-Id: <20201108141113.65450-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch series will free some vmemmap pages(struct page structures)
associated with each hugetlbpage when preallocated to save memory.

Nowadays we track the status of physical page frames using `struct page`
arranged in one or more arrays. And here exists one-to-one mapping between
the physical page frame and the corresponding `struct page`.

The hugetlbpage support is built on top of multiple page size support
that is provided by most modern architectures. For example, x86 CPUs
normally support 4K and 2M (1G if architecturally supported) page sizes.
Every hugetlbpage has more than one `struct page`. The 2M hugetlbpage
has 512 `struct page` and 1G hugetlbpage has 4096 `struct page`. But
in the core of hugetlbpage only uses the first 4 `struct page` to store
metadata associated with each hugetlbpage. The rest of the `struct page`
are usually read the compound_head field which are all the same value.
If we can free some struct page memory to buddy system so that we can
save a lot of memory.

When the system boot up, every 2M hugetlbpage has 512 `struct page` which
is 8 pages(sizeof(struct page) * 512 / PAGE_SIZE).

   hugetlbpage                  struct pages(8 pages)          page frame(8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     |     1     | -------------> |     1     |
  |           |                     |     2     | -------------> |     2     |
  |           |                     |     3     | -------------> |     3     |
  |           |                     |     4     | -------------> |     4     |
  |     2M    |                     |     5     | -------------> |     5     |
  |           |                     |     6     | -------------> |     6     |
  |           |                     |     7     | -------------> |     7     |
  |           |                     +-----------+                +-----------+
  |           |
  |           |
  +-----------+


When a hugetlbpage is preallocated, we can change the mapping from above to
bellow.

   hugetlbpage                  struct pages(8 pages)          page frame(8 pages)
  +-----------+ ---virt_to_page---> +-----------+   mapping to   +-----------+
  |           |                     |     0     | -------------> |     0     |
  |           |                     |     1     | -------------> |     1     |
  |           |                     |     2     | -------------> +-----------+
  |           |                     |     3     | -----------------^ ^ ^ ^ ^
  |           |                     |     4     | -------------------+ | | |
  |     2M    |                     |     5     | ---------------------+ | |
  |           |                     |     6     | -----------------------+ |
  |           |                     |     7     | -------------------------+
  |           |                     +-----------+
  |           |
  |           |
  +-----------+

For tail pages, the value of compound_head is the same. So we can reuse
first page of tail page structs. We map the virtual addresses of the
remaining 6 pages of tail page structs to the first tail page struct,
and then free these 6 pages. Therefore, we need to reserve at least 2
pages as vmemmap areas.

When a hugetlbpage is freed to the buddy system, we should allocate six
pages for vmemmap pages and restore the previous mapping relationship.

If we uses the 1G hugetlbpage, we can save 4095 pages. This is a very
substantial gain. On our server, run some SPDK/QEMU applications which
will use 1000GB hugetlbpage. With this feature enabled, we can save
~16GB(1G hugepage)/~11GB(2MB hugepage) memory.

Because there are vmemmap page tables reconstruction on the freeing/allocating
path, it increases some overhead. Here are some overhead analysis.

1) Allocating 10240 2MB hugetlb pages.

   a) With this patch series applied:
   # time echo 10240 > /proc/sys/vm/nr_hugepages

   real     0m0.166s
   user     0m0.000s
   sys      0m0.166s

   # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
   Attaching 2 probes...

   @latency:
   [8K, 16K)           8360 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
   [16K, 32K)          1868 |@@@@@@@@@@@                                         |
   [32K, 64K)            10 |                                                    |
   [64K, 128K)            2 |                                                    |

   b) Without this patch series:
   # time echo 10240 > /proc/sys/vm/nr_hugepages

   real     0m0.066s
   user     0m0.000s
   sys      0m0.066s

   # bpftrace -e 'kprobe:alloc_fresh_huge_page { @start[tid] = nsecs; } kretprobe:alloc_fresh_huge_page /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
   Attaching 2 probes...

   @latency:
   [4K, 8K)           10176 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
   [8K, 16K)             62 |                                                    |
   [16K, 32K)             2 |                                                    |

   Summarize: this feature is about ~2x slower than before.

2) Freeing 10240 @MB hugetlb pages.

   a) With this patch series applied:
   # time echo 0 > /proc/sys/vm/nr_hugepages

   real     0m0.004s
   user     0m0.000s
   sys      0m0.002s

   # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
   Attaching 2 probes...

   @latency:
   [16K, 32K)         10240 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|

   b) Without this patch series:
   # time echo 0 > /proc/sys/vm/nr_hugepages

   real     0m0.077s
   user     0m0.001s
   sys      0m0.075s

   # bpftrace -e 'kprobe:__free_hugepage { @start[tid] = nsecs; } kretprobe:__free_hugepage /@start[tid]/ { @latency = hist(nsecs - @start[tid]); delete(@start[tid]); }'
   Attaching 2 probes...

   @latency:
   [4K, 8K)            9950 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
   [8K, 16K)            287 |@                                                   |
   [16K, 32K)             3 |                                                    |

   Summarize: The overhead of __free_hugepage is about ~2-4x slower than before.
              But according to the allocation test above, I think that here is
	      also ~2x slower than before.

              But why the 'real' time of patched is smaller than before? Because
	      In this patch series, the freeing hugetlb is asynchronous(through
	      kwoker).

Although the overhead has increased. But the overhead is not on the
allocating/freeing of each hugetlb page, it is only once when we reserve
some hugetlb pages through /proc/sys/vm/nr_hugepages. Once the reservation
is successful, the subsequent allocating, freeing and using are the same
as before (not patched). So I think that the overhead is acceptable.

  changelog in v3:
  1. Rename some helps function name. Thanks Mike.
  2. Rework some code. Thanks Mike and Oscar.
  3. Remap the tail vmemmap page with PAGE_KERNEL_RO instead of
     PAGE_KERNEL. Thanks Matthew.
  4. Add some overhead analysis in the cover letter.
  5. Use vmemap pmd table lock instead of a hugetlb specific global lock.

  changelog in v2:
  1. Fix do not call dissolve_compound_page in alloc_huge_page_vmemmap().
  2. Fix some typo and code style problems.
  3. Remove unused handle_vmemmap_fault().
  4. Merge some commits to one commit suggested by Mike.

Muchun Song (21):
  mm/memory_hotplug: Move bootmem info registration API to
    bootmem_info.c
  mm/memory_hotplug: Move {get,put}_page_bootmem() to bootmem_info.c
  mm/hugetlb: Introduce a new config HUGETLB_PAGE_FREE_VMEMMAP
  mm/hugetlb: Introduce nr_free_vmemmap_pages in the struct hstate
  mm/hugetlb: Introduce pgtable allocation/freeing helpers
  mm/bootmem_info: Introduce {free,prepare}_vmemmap_page()
  mm/bootmem_info: Combine bootmem info and type into page->freelist
  mm/vmemmap: Initialize page table lock for vmemmap
  mm/hugetlb: Free the vmemmap pages associated with each hugetlb page
  mm/hugetlb: Defer freeing of hugetlb pages
  mm/hugetlb: Allocate the vmemmap pages associated with each hugetlb
    page
  mm/hugetlb: Introduce remap_huge_page_pmd_vmemmap helper
  mm/hugetlb: Use PG_slab to indicate split pmd
  mm/hugetlb: Support freeing vmemmap pages of gigantic page
  mm/hugetlb: Add a BUILD_BUG_ON to check if struct page size is a power
    of two
  mm/hugetlb: Set the PageHWPoison to the raw error page
  mm/hugetlb: Flush work when dissolving hugetlb page
  mm/hugetlb: Add a kernel parameter hugetlb_free_vmemmap
  mm/hugetlb: Merge pte to huge pmd only for gigantic page
  mm/hugetlb: Gather discrete indexes of tail page
  mm/hugetlb: Add BUILD_BUG_ON to catch invalid usage of tail struct
    page

 Documentation/admin-guide/kernel-parameters.txt |   9 +
 Documentation/admin-guide/mm/hugetlbpage.rst    |   3 +
 arch/x86/include/asm/hugetlb.h                  |  17 +
 arch/x86/include/asm/pgtable_64_types.h         |   8 +
 arch/x86/mm/init_64.c                           |   7 +-
 fs/Kconfig                                      |  16 +
 include/linux/bootmem_info.h                    |  79 +++
 include/linux/hugetlb.h                         |  45 ++
 include/linux/hugetlb_cgroup.h                  |  15 +-
 include/linux/memory_hotplug.h                  |  27 -
 include/linux/mm.h                              |  49 ++
 mm/Makefile                                     |   1 +
 mm/bootmem_info.c                               | 124 ++++
 mm/hugetlb.c                                    | 806 +++++++++++++++++++++++-
 mm/memory_hotplug.c                             | 116 ----
 mm/sparse-vmemmap.c                             |  31 +
 mm/sparse.c                                     |   5 +-
 17 files changed, 1181 insertions(+), 177 deletions(-)
 create mode 100644 include/linux/bootmem_info.h
 create mode 100644 mm/bootmem_info.c

-- 
2.11.0

