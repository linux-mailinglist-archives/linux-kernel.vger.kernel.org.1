Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2AE2BABF8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgKTOgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:36:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:33666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgKTOgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:36:04 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE6532224C;
        Fri, 20 Nov 2020 14:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605882963;
        bh=B2tsz1eLDySQbKv3rPA/SjqjJvraB6qR6zYVvcCJO3U=;
        h=From:To:Cc:Subject:Date:From;
        b=pfnWM6mpPr4mUovHZOqS0m5JTkFwwrPNej8iWne6LVWh44CuojQDQ2e8GbrwhJgPw
         E51LRycawzpz8/vnMjAOh4WPU0NY32mcbFTDSF8NEx1XjZfJ/R/DKKZcwRS6Y95e91
         ZyahIyR6nxGDdWxMPTqLMh6D0ytvmdQc3mPINgrQ=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/6] tlb: Fix access and (soft-)dirty bit management
Date:   Fri, 20 Nov 2020 14:35:51 +0000
Message-Id: <20201120143557.6715-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series attempts to fix some issues relating to our access and
(soft-)dirty bit management relating to TLB invalidation. It's a bit all
over the place because I kept running into new issues as I was trying to
figure it out.

The first patch fixes a crash we've seen in practice. The other patches
are all addressing things that I found by code inspection and I would
_really_ appreciate others having a look. In particular, what can go
wrong in practice if a CPU has a stale, writable entry in the TLB for a
pte which is !pte_write()? It feels intuitively bad, but I couldn't find
anywhere that would explode (the CoW path looks alright, for example).

Cheers,

Will

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org
Cc: linux-arm-kernel@lists.infradead.org

--->8

Will Deacon (6):
  arm64: pgtable: Fix pte_accessible()
  arm64: pgtable: Ensure dirty bit is preserved across pte_wrprotect()
  tlb: mmu_gather: Remove unused start/end arguments from
    tlb_finish_mmu()
  mm: proc: Invalidate TLB after clearing soft-dirty page state
  tlb: mmu_gather: Introduce tlb_gather_mmu_fullmm()
  mm: proc: Avoid fullmm flush for young/dirty bit toggling

 arch/arm64/include/asm/pgtable.h | 31 +++++++++++++++----------------
 arch/ia64/include/asm/tlb.h      |  2 +-
 arch/x86/kernel/ldt.c            |  2 +-
 fs/exec.c                        |  2 +-
 fs/proc/task_mmu.c               | 22 +++++++++++++---------
 include/asm-generic/tlb.h        |  6 ++++--
 include/linux/mm_types.h         |  4 ++--
 mm/hugetlb.c                     |  2 +-
 mm/madvise.c                     |  6 +++---
 mm/memory.c                      |  4 ++--
 mm/mmap.c                        |  6 +++---
 mm/mmu_gather.c                  | 21 +++++++++++++++------
 mm/oom_kill.c                    |  4 ++--
 13 files changed, 63 insertions(+), 49 deletions(-)

-- 
2.29.2.454.gaff20da3a2-goog

