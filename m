Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 479112FD8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 20:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392366AbhATTAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 14:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:37818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731705AbhATRhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:37:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3DAF20705;
        Wed, 20 Jan 2021 17:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611164193;
        bh=1NPKVlBGRw3SuPWaJXbQxTnIY7pCrHJ3wlOHyCK9jeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9ca2SegTpBhZEzpssFClY/cObJnvft5eu8HXnPUhuqoE0GL6ZLTTHCMt+pwygMGS
         GwJ97sj9K5mpO0BafY2aTyqIHxzV97j9D4ltNM6cyfE+4dftlwGNdjAknrY08pTxKV
         xhKfsblHNbZBiPjDdzW/d9doz9vT4Q9iKoAZkuqns71CBcrqzdVvpL4A78yc/jzEsb
         Xgva3GgS62+EQ1vdc7cNnVG7BhcWZP4XTo9pnPGYWqWH+n8/CZP1P0mPvFNlpjhKjX
         bZ36Xx+btBsNJHmOg7dDapu5k0tI7CvIvpQspgEeYEIjLkAbJTUnIEK6HP956Htv9n
         ldHKDhkeCS1YQ==
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
Subject: [PATCH v4 4/8] mm: Move immutable fields of 'struct vm_fault' into anonymous struct
Date:   Wed, 20 Jan 2021 17:36:08 +0000
Message-Id: <20210120173612.20913-5-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120173612.20913-1-will@kernel.org>
References: <20210120173612.20913-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct vm_fault' contains both information about the fault being
serviced alongside mutable fields contributing to the state of the
fault-handling logic. Unfortunately, the distinction between the two is
not clear-cut, and a number of callers end up manipulating the structure
temporarily before restoring it when returning.

Try to clean this up by moving the immutable fault information into an
anonymous struct, which will later be marked as 'const'. GCC will then
complain (with an error) about modification of these fields after they
have been initialised, although LLVM currently allows them without even
a warning:

https://bugs.llvm.org/show_bug.cgi?id=48755

Ideally, the 'flags' field would be part of the new structure too, but
it seems as though the ->page_mkwrite() path is not ready for this yet.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/CAHk-=whYs9XsO88iqJzN6NC=D-dp2m0oYXuOoZ=eWnvv=5OA+w@mail.gmail.com
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/mm.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 251a2339befb..b4a5cb9bff7d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -517,11 +517,14 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
  * pgoff should be used in favour of virtual_address, if possible.
  */
 struct vm_fault {
-	struct vm_area_struct *vma;	/* Target VMA */
-	unsigned int flags;		/* FAULT_FLAG_xxx flags */
-	gfp_t gfp_mask;			/* gfp mask to be used for allocations */
-	pgoff_t pgoff;			/* Logical page offset based on vma */
-	unsigned long address;		/* Faulting virtual address */
+	struct {
+		struct vm_area_struct *vma;	/* Target VMA */
+		gfp_t gfp_mask;			/* gfp mask to be used for allocations */
+		pgoff_t pgoff;			/* Logical page offset based on vma */
+		unsigned long address;		/* Faulting virtual address */
+	};
+	unsigned int flags;		/* FAULT_FLAG_xxx flags
+					 * XXX: should really be 'const' */
 	pmd_t *pmd;			/* Pointer to pmd entry matching
 					 * the 'address' */
 	pud_t *pud;			/* Pointer to pud entry matching
-- 
2.30.0.284.gd98b1dd5eaa7-goog

