Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E952BAC00
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgKTOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:36:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:34088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgKTOgU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:36:20 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7948B2224C;
        Fri, 20 Nov 2020 14:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605882979;
        bh=Cx43nH7+0p7dCMlh2hWC5+4DOrQsHy/9+cM/6j7sA0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afgeTZc4tCjR0MOdMgoK69uQiEsqDnC9K0pzMB5Sj80IghTT6RiSH0yixLei86pAh
         eA3sUhCiS98J5br6nm+aCIY5W8YWvOl3cFeDFnuwN33agaWXZXHtRo46DvLXqEmIYl
         oudAEy1bh7kfEsjFKdgb8jP7qkR0efezAG0Z/UKY=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Yu Zhao <yuzhao@google.com>, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6/6] mm: proc: Avoid fullmm flush for young/dirty bit toggling
Date:   Fri, 20 Nov 2020 14:35:57 +0000
Message-Id: <20201120143557.6715-7-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201120143557.6715-1-will@kernel.org>
References: <20201120143557.6715-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clear_refs_write() uses the 'fullmm' API for invalidating TLBs after
updating the page-tables for the current mm. However, since the mm is not
being freed, this can result in stale TLB entries on architectures which
elide 'fullmm' invalidation.

Ensure that TLB invalidation is performed after updating soft-dirty
entries via clear_refs_write() by using the non-fullmm API to MMU gather.

Signed-off-by: Will Deacon <will@kernel.org>
---
 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index a76d339b5754..316af047f1aa 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1238,7 +1238,7 @@ static ssize_t clear_refs_write(struct file *file, const char __user *buf,
 			count = -EINTR;
 			goto out_mm;
 		}
-		tlb_gather_mmu_fullmm(&tlb, mm);
+		tlb_gather_mmu(&tlb, mm, 0, TASK_SIZE);
 		if (type == CLEAR_REFS_SOFT_DIRTY) {
 			for (vma = mm->mmap; vma; vma = vma->vm_next) {
 				if (!(vma->vm_flags & VM_SOFTDIRTY))
-- 
2.29.2.454.gaff20da3a2-goog

