Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874122FD8F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392449AbhATTBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:01:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729736AbhATRhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:37:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2365233ED;
        Wed, 20 Jan 2021 17:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611164182;
        bh=fsx985f1cF1hEHYZaVWNKqVRb18Pc9UFt6saI96uias=;
        h=From:To:Cc:Subject:Date:From;
        b=DVUl+Max0jMmGMvXzEUIQcLVFWxcdykdPnqhw3tSjJWuPNP6+yLq5ZNhba6P0Bz7J
         M1j/Ht6EVoWncHRlcuTGxP6rdSsOBDFAbLfXbRSfXbb1naFji20egWauJE1r/YliEq
         dRzkLRkK0hGfHpS9gf0DJzaaale4w5jcprkHkKTMRR+QD/jY0VVfWq995pzMCCTGUP
         qZckjFa4k4jgFWF3tPFPiMjLb9Q2bqTTqSOiEZF81t83y6rQ/rsB72EBm/UVWOmihJ
         6aXG5TTaV+mPmVuneIwZcWANOl08n+uZ82diqbwOPp4ZC55Cyk3Qmu4w2TbByj0BAj
         8twZRX2B5Ynhw==
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel-team@android.com
Subject: [PATCH v4 0/8] Create 'old' ptes for faultaround mappings on arm64 with hardware access flag
Date:   Wed, 20 Jan 2021 17:36:04 +0000
Message-Id: <20210120173612.20913-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version four of the patches I previously posted here:

  v1: https://lore.kernel.org/r/20201209163950.8494-1-will@kernel.org
  v2: https://lore.kernel.org/r/20210108171517.5290-1-will@kernel.org
  v3: https://lore.kernel.org/r/20210114175934.13070-1-will@kernel.org

The patches allow architectures to opt-in at runtime for faultaround
mappings to be created as 'old' instead of 'young'. Although there have
been previous attempts at this, they failed either because the decision
was deferred to userspace [1] or because it was done unconditionally and
shown to regress benchmarks for particular architectures [2].

The big change since v3 is that the immutable fields of 'struct vm_fault'
now live in a 'const' anonymous struct. Although Clang will silently
accept modifications to these fields [3], GCC emits an error. The
resulting diffstat is _considerably_ more manageable with this approach.

As before, I've also updated this branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=faultaround

Cheers,

Will

[1] https://www.spinics.net/lists/linux-mm/msg143831.html
[2] 315d09bf30c2 ("Revert "mm: make faultaround produce old ptes"")
[3] https://bugs.llvm.org/show_bug.cgi?id=48755

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vinayak Menon <vinmenon@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: <kernel-team@android.com>

--->8

Kirill A. Shutemov (1):
  mm: Cleanup faultaround and finish_fault() codepaths

Will Deacon (7):
  mm: Allow architectures to request 'old' entries when prefaulting
  arm64: mm: Implement arch_wants_old_prefaulted_pte()
  mm: Move immutable fields of 'struct vm_fault' into anonymous struct
  mm: Pass 'address' to map to do_set_pte() and drop FAULT_FLAG_PREFAULT
  mm: Avoid modifying vmf.address in __collapse_huge_page_swapin()
  mm: Use static initialisers for immutable fields of 'struct vm_fault'
  mm: Mark anonymous struct field of 'struct vm_fault' as 'const'

 arch/arm64/include/asm/pgtable.h |  12 +-
 fs/xfs/xfs_file.c                |   6 +-
 include/linux/mm.h               |  25 ++--
 include/linux/pgtable.h          |  11 ++
 mm/filemap.c                     | 178 ++++++++++++++++++------
 mm/khugepaged.c                  |  37 +++--
 mm/memory.c                      | 223 +++++++++++--------------------
 mm/shmem.c                       |   6 +-
 mm/swapfile.c                    |  11 +-
 9 files changed, 280 insertions(+), 229 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

