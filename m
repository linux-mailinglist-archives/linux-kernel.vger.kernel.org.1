Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17F72E2D21
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 06:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgLZFF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 00:05:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:40414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgLZFF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 00:05:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1740221E9;
        Sat, 26 Dec 2020 05:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608959085;
        bh=GsnbYZxhqNnL9QP+G18FcYVYZO9/NbMeejiMTrvM+lQ=;
        h=From:To:Cc:Subject:Date:From;
        b=mI4BQhPzCuiHIbi5nIZQfp99za/cXiUPo8svVVIXwX0DYz6z+yB99vqZjAFs7onXz
         rrTXM7OVci9VH/BUQNaUHwEk0sFwTIG+BaVtCYVmqS94+uzcFl8q7uuP/PiQfLVBq7
         PCDkO3aW9zxj514pL9YjaoDb9T1vM3xnIxWEwY0TrPvaAZMawFh95+2oheBF2dWa6j
         m6FZdf68s6A0lbfCEZ6aCCJsMY4vcBnm7zb17rJcuvOnI8mOXg+eMZN2U8UsVv10om
         lxXhOQegCJ6la5+s/+/GMuPGSwQFuNzslBIBUh5RTnbbCPIJ4WPvvIrkkcfl/SgsDZ
         hNjTpmby3lvVw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH] mm: page-flags.h: Typo fix (It -> If)
Date:   Sat, 26 Dec 2020 05:03:56 +0000
Message-Id: <1608959036-91409-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The "If" was wrongly spelled as "It".

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Steven Price <steven.price@arm.com>

---
 include/linux/page-flags.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 4f6ba93..e7b4242 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -824,7 +824,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
 
 /*
  * Flags checked when a page is freed.  Pages being freed should not have
- * these flags set.  It they are, there is a problem.
+ * these flags set.  If they are, there is a problem.
  */
 #define PAGE_FLAGS_CHECK_AT_FREE				\
 	(1UL << PG_lru		| 1UL << PG_locked	|	\
@@ -835,7 +835,7 @@ static inline void ClearPageSlabPfmemalloc(struct page *page)
 
 /*
  * Flags checked when a page is prepped for return by the page allocator.
- * Pages being prepped should not have these flags set.  It they are set,
+ * Pages being prepped should not have these flags set.  If they are set,
  * there has been a kernel bug or struct page corruption.
  *
  * __PG_HWPOISON is exceptional because it needs to be kept beyond page's
-- 
2.7.4

