Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4B62D5A14
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732048AbgLJML6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:11:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:56774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727004AbgLJML5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:11:57 -0500
From:   Will Deacon <will@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mohamed Alzayat <alzayat@mpi-sws.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-mm@kvack.org
Subject: [PATCH v2 0/6] tlb: Fix (soft-)dirty bit management clean up API
Date:   Thu, 10 Dec 2020 12:11:04 +0000
Message-Id: <20201210121110.10094-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version two of the patches I previously posted here:

  https://lore.kernel.org/r/20201120143557.6715-1-will@kernel.org

Since then, the arm64 fixes have been merged upstream, so this series
is now mainly just cleanup, with the exception of the first patch which
no longer appears to be theoretical after a bug report came up
independently:

  https://lore.kernel.org/linux-mm/CA+32v5zzFYJQ7eHfJP-2OHeR+6p5PZsX=RDJNU6vGF3hLO+j-g@mail.gmail.com/

(albeit in a test case, but I think we should restore the old behaviour)

Changes since v1 include:

  * Remove the MMU gather code from the soft-dirty path altogether,
    making it consistent with the mprotect() path in terms of handling
    the TLB invalidation explicitly.

  * Remove start/end arguments from tlb_gather_mmu()

  * Improve commit messages and fix typos

Cheers,

Will

Cc: Yu Zhao <yuzhao@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Mohamed Alzayat <alzayat@mpi-sws.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: linux-mm@kvack.org

--->8

Will Deacon (6):
  mm: proc: Invalidate TLB after clearing soft-dirty page state
  tlb: mmu_gather: Remove unused start/end arguments from
    tlb_finish_mmu()
  tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
  tlb: mmu_gather: Remove start/end arguments from tlb_gather_mmu()
  tlb: arch: Remove empty __tlb_remove_tlb_entry() stubs
  x86/ldt: Use tlb_gather_mmu_fullmm() when freeing LDT page-tables

 arch/ia64/include/asm/tlb.h     |  4 ++--
 arch/sparc/include/asm/tlb_64.h |  1 -
 arch/x86/include/asm/tlb.h      |  1 -
 arch/x86/kernel/ldt.c           | 10 ++++++++--
 fs/exec.c                       |  4 ++--
 fs/proc/task_mmu.c              |  9 +++++----
 include/asm-generic/tlb.h       |  6 ++++--
 include/linux/mm_types.h        |  7 +++----
 mm/hugetlb.c                    | 18 ++----------------
 mm/madvise.c                    | 12 ++++++------
 mm/memory.c                     |  8 ++++----
 mm/mmap.c                       |  8 ++++----
 mm/mmu_gather.c                 | 31 +++++++++++++++++--------------
 mm/oom_kill.c                   |  6 +++---
 14 files changed, 60 insertions(+), 65 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog

