Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2929D2FD758
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbhATRlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:41:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:38050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387402AbhATRiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:38:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 116FC23122;
        Wed, 20 Jan 2021 17:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611164204;
        bh=DEWJsXFSV81jlOBYgr3LEPW3UawvblxwfW/J9Ed78ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VpQVclVXlxSy0Xj5C7hS2E1F4PoDjtit84Uz02J2rq+/QVqCfZtq7tyCx5+xqaGkx
         Q4U5Xz2/Dqs206JdOTX6hIowJzsptc1Xi564azFWvGsbVVlQf/Gst6qKY6OkzZL9Zq
         P9eqggQdSqPisehrzCZmupr2rY1pJqtK67kijhnTmBNcBtdEhPi2fScZPX3PYbh6PQ
         lVep4qzAp7FiRs+7aTJXmmsQgW4+sIwBsP0HqAlpYGaup7TYLg8knbq4/FZqtTb7ac
         qwfZ/sTOEaBhym7q5/L4qu0dcevjkjJUmH0BA1fURJRgVg8zoAhF4S23jkfLndhPiK
         HvHfwILoYBO4w==
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
Subject: [PATCH v4 8/8] mm: Mark anonymous struct field of 'struct vm_fault' as 'const'
Date:   Wed, 20 Jan 2021 17:36:12 +0000
Message-Id: <20210120173612.20913-9-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120173612.20913-1-will@kernel.org>
References: <20210120173612.20913-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields of this struct are only ever read after being initialised, so
mark it 'const' before somebody tries to modify it again.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e0f056753bef..7ff3d9817d38 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -514,7 +514,7 @@ static inline bool fault_flag_allow_retry_first(unsigned int flags)
  * pgoff should be used in favour of virtual_address, if possible.
  */
 struct vm_fault {
-	struct {
+	const struct {
 		struct vm_area_struct *vma;	/* Target VMA */
 		gfp_t gfp_mask;			/* gfp mask to be used for allocations */
 		pgoff_t pgoff;			/* Logical page offset based on vma */
-- 
2.30.0.284.gd98b1dd5eaa7-goog

