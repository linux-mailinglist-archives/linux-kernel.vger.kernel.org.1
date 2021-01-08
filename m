Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394D42EF656
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbhAHRQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:16:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727471AbhAHRQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:16:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 126172396F;
        Fri,  8 Jan 2021 17:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610126129;
        bh=YhR6DyJ6oSXaH8kGg7Rrar6eHVmLXFUyvbhiZEytVM0=;
        h=From:To:Cc:Subject:Date:From;
        b=ro6hxY1P1RL8dsSv1xyCOQy+ixIxUkdshRdTRxE/tyhfzxg3hlA1fAKjJ+oZLrnQ1
         pfk375zMP1ER8q4+pElBswPKJ4R9KZFL9/F5MFDmPl6yTNO+2WdvnOf3PqRDVV8rB9
         7XqMotEh4KRpLyIRVlElPUlTSenZu4pThQwvVUgwpG2JsVlnhyQnIA58C9DiPDAOe5
         01I8XmWPPlWFl1buFeG/SFJxE+pFV0US0cs6rqpaZZP826GMgS0HTnng6nWl7dJV3b
         kFbyCPF9W2NSvUNmdHnKwY+ZLiXMyg02Uo0FKHgOQ5eIkWs4n69esukrAawUMmxZ+I
         nBPHc7c2MqfWQ==
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
        Hugh Dickins <hughd@google.com>, kernel-team@android.com
Subject: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on arm64 with hardware access flag
Date:   Fri,  8 Jan 2021 17:15:14 +0000
Message-Id: <20210108171517.5290-1-will@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is version two of the series I originally posted here:

  https://lore.kernel.org/r/20201209163950.8494-1-will@kernel.org

The patches allow architectures to opt-in at runtime for faultaround
mappings to be created as 'old' instead of 'young'. Although there have
been previous attempts at this, they failed either because the decision
was deferred to userspace [1] or because it was done unconditionally and
shown to regress benchmarks for particular architectures [2].

The big difference in this version is that I have reworked it based on
Kirill's patch which he posted as a follow-up to the original. However,
I can't tell where we've landed on that -- Linus seemed to like it, but
Hugh was less enthusiastic. I think that my subsequent patches are an
awful lot cleaner after the rework, but I don't think I necessarily
depend on everything in there so if that patch is likely to be a
sticking point then I can try to extract the parts I need.

Feedback welcome.

Cheers,

Will

[1] https://www.spinics.net/lists/linux-mm/msg143831.html
[2] 315d09bf30c2 ("Revert "mm: make faultaround produce old ptes"")

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Vinayak Menon <vinmenon@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: <kernel-team@android.com>

--->8

Kirill A. Shutemov (1):
  mm: Cleanup faultaround and finish_fault() codepaths

Will Deacon (2):
  mm: Allow architectures to request 'old' entries when prefaulting
  arm64: mm: Implement arch_wants_old_prefaulted_pte()

 arch/arm64/include/asm/pgtable.h |  12 +-
 fs/xfs/xfs_file.c                |   6 +-
 include/linux/mm.h               |  17 ++-
 include/linux/pgtable.h          |  11 ++
 mm/filemap.c                     | 181 +++++++++++++++++++------
 mm/memory.c                      | 219 +++++++++++--------------------
 6 files changed, 251 insertions(+), 195 deletions(-)

-- 
2.29.2.729.g45daf8777d-goog

