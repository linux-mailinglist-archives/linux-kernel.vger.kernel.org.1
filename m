Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC99C21599A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729379AbgGFOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 10:35:28 -0400
Received: from foss.arm.com ([217.140.110.172]:45600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729227AbgGFOf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:35:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7A7630E;
        Mon,  6 Jul 2020 07:35:27 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 709E53F71E;
        Mon,  6 Jul 2020 07:35:26 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     vincenzo.frascino@arm.com, mark.rutland@arm.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] kasan: Remove kasan_unpoison_stack_above_sp_to()
Date:   Mon,  6 Jul 2020 15:35:05 +0100
Message-Id: <20200706143505.23299-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function kasan_unpoison_stack_above_sp_to() is defined in kasan code
but never used. The function was introduced as part of the commit:

   commit 9f7d416c36124667 ("kprobes: Unpoison stack in jprobe_return() for KASAN")

... where it was necessary because x86's jprobe_return() would leave
stale shadow on the stack, and was an oddity in that regard.

Since then, jprobes were removed entirely, and as of commit:

  commit 80006dbee674f9fa ("kprobes/x86: Remove jprobe implementation")

... there have been no callers of this function.

Remove the declaration and the implementation.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/kasan.h |  2 --
 mm/kasan/common.c     | 15 ---------------
 2 files changed, 17 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 82522e996c76..0ebf2fab8567 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -38,7 +38,6 @@ extern void kasan_disable_current(void);
 void kasan_unpoison_shadow(const void *address, size_t size);
 
 void kasan_unpoison_task_stack(struct task_struct *task);
-void kasan_unpoison_stack_above_sp_to(const void *watermark);
 
 void kasan_alloc_pages(struct page *page, unsigned int order);
 void kasan_free_pages(struct page *page, unsigned int order);
@@ -101,7 +100,6 @@ void kasan_restore_multi_shot(bool enabled);
 static inline void kasan_unpoison_shadow(const void *address, size_t size) {}
 
 static inline void kasan_unpoison_task_stack(struct task_struct *task) {}
-static inline void kasan_unpoison_stack_above_sp_to(const void *watermark) {}
 
 static inline void kasan_enable_current(void) {}
 static inline void kasan_disable_current(void) {}
diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index 757d4074fe28..6339179badb2 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -180,21 +180,6 @@ asmlinkage void kasan_unpoison_task_stack_below(const void *watermark)
 	kasan_unpoison_shadow(base, watermark - base);
 }
 
-/*
- * Clear all poison for the region between the current SP and a provided
- * watermark value, as is sometimes required prior to hand-crafted asm function
- * returns in the middle of functions.
- */
-void kasan_unpoison_stack_above_sp_to(const void *watermark)
-{
-	const void *sp = __builtin_frame_address(0);
-	size_t size = watermark - sp;
-
-	if (WARN_ON(sp > watermark))
-		return;
-	kasan_unpoison_shadow(sp, size);
-}
-
 void kasan_alloc_pages(struct page *page, unsigned int order)
 {
 	u8 tag;
-- 
2.27.0

