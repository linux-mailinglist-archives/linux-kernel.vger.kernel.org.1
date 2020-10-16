Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D23F28FC76
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 04:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404245AbgJPCko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 22:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404216AbgJPCkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 22:40:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8998C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j136so1220062wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0v8cEFkv006H/orJHvg5H7puUbhcFvgGtNNhP7STOH0=;
        b=Mxy/DHXYmetsU0zQ6Xxh1pIcvrU0cHOnso1CihgTxthKlvIcT8ftKJ55SlcGGZfbDa
         jBawsSf7AUXCfRCxIluzdno+mafFszhLYoV7FahRcde1d5DCpJU7Y7hMoFrMJpVnJZNC
         ZcCiTdqLP1n1i0UI9OxPjGUBqrgy2hvq8zaNVy76gNgARBB/oJLfnNp30XaydSb3FXMx
         1cH6okiO95nwslQzplGwqKVzo8RcCWQ8PVyEkMIHW7LQI+cl88YKlbNsOva4qZ614ZS2
         hLonSIBr70WsYSgQbvuvy78FLDkrgoLgZJGlDYoVHTZzNIWv2AN49p3ZLxai7LqcJXav
         y9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0v8cEFkv006H/orJHvg5H7puUbhcFvgGtNNhP7STOH0=;
        b=hyep8tN72Br0CLuQ1LsP+VncgjcTWdgWZc84nNLmxBJm4mGfxjLRsYsT9/YHmO2KgL
         yTu2sDOgsRbQjRJbS+1VLc+5QPDeZzI9G+eYu6qPs29287T1Z2Upnhw9om9NHvVmdvhl
         bFBNzMSXP2MiY03dc+nadykb15Ia8kS77bXVqvokxNDOuSVqdgs0OGD0uqmCOCyzK2HF
         oI11ishZbZnXUblVDe+PsLG/4/dn+ulPjh+cy1Onuz4IO3v3+SPl3yeFLtaD8ZD/A5xk
         FCPEqpaC5aoQZEgerq+O6IZ0UlRRyNJ/TQt3wZJO3G37t3Y8WLXf5MigIqoYRJzIF6oc
         5SJA==
X-Gm-Message-State: AOAM5328rI+tgXzJAhZJ0hioNtmnJmwqv3Ust0zYQ6rjZ7woy4iCNS/j
        4mr1BXUKWUgCrzV80T67Ldv0FQ==
X-Google-Smtp-Source: ABdhPJxodChBJ6f8oDeAnkcjiQsUaWNS+KK9LGGhQxaK4kbSw1XKCZe42gB2XUNidA9gSk8JvJk4ZQ==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr1403751wmi.50.1602816037248;
        Thu, 15 Oct 2020 19:40:37 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id a17sm1550065wra.29.2020.10.15.19.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 19:40:36 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH 3/6] mm: Add refcount for preserving mm_struct without pgd
Date:   Fri, 16 Oct 2020 04:40:16 +0200
Message-Id: <20201016024019.1882062-4-jannh@google.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201016024019.1882062-1-jannh@google.com>
References: <20201016024019.1882062-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, mm_struct has two refcounts:

 - mm_users: preserves everything - the mm_struct, the page tables, the
   memory mappings, and so on
 - mm_count: preserves the mm_struct and pgd

However, there are three types of users of mm_struct:

1. users that want page tables, memory mappings and so on
2. users that want to preserve the pgd (for lazy TLB)
3. users that just want to keep the mm_struct itself around (e.g. for
   mmget_not_zero() or __ptrace_may_access())

Dropping mm_count references can be messy because dropping mm_count to
zero deletes the pgd, which takes the pgd_lock on x86, meaning it doesn't
work from RCU callbacks (which run in IRQ context). In those cases,
mmdrop_async() must be used to punt the invocation of __mmdrop() to
workqueue context.

That's fine when mmdrop_async() is a rare case, but the preceding patch
"ptrace: Keep mm around after exit_mm() for __ptrace_may_access()" makes it
the common case; we should probably avoid punting freeing to workqueue
context all the time if we can avoid it?

To resolve this, add a third refcount that just protects the mm_struct and
the user_ns it points to, and which can be dropped with synchronous freeing
from (almost) any context.

Signed-off-by: Jann Horn <jannh@google.com>
---
 arch/x86/kernel/tboot.c    |  2 ++
 drivers/firmware/efi/efi.c |  2 ++
 include/linux/mm_types.h   | 13 +++++++++++--
 include/linux/sched/mm.h   | 13 +++++++++++++
 kernel/fork.c              | 14 ++++++++++----
 mm/init-mm.c               |  2 ++
 6 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 992fb1415c0f..b92ea1bb3bb9 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -19,6 +19,7 @@
 #include <linux/mm.h>
 #include <linux/tboot.h>
 #include <linux/debugfs.h>
+#include <linux/refcount.h>
 
 #include <asm/realmode.h>
 #include <asm/processor.h>
@@ -93,6 +94,7 @@ static struct mm_struct tboot_mm = {
 	.pgd            = swapper_pg_dir,
 	.mm_users       = ATOMIC_INIT(2),
 	.mm_count       = ATOMIC_INIT(1),
+	.mm_bare_refs   = REFCOUNT_INIT(1),
 	MMAP_LOCK_INITIALIZER(init_mm)
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.mmlist         = LIST_HEAD_INIT(init_mm.mmlist),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 3aa07c3b5136..3b73a0717c6e 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/random.h>
 #include <linux/reboot.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/ucs2_string.h>
@@ -54,6 +55,7 @@ struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
 	.mm_count		= ATOMIC_INIT(1),
+	.mm_bare_refs		= REFCOUNT_INIT(1),
 	MMAP_LOCK_INITIALIZER(efi_mm)
 	.page_table_lock	= __SPIN_LOCK_UNLOCKED(efi_mm.page_table_lock),
 	.mmlist			= LIST_HEAD_INIT(efi_mm.mmlist),
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index ed028af3cb19..764d251966c7 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -429,13 +429,22 @@ struct mm_struct {
 
 		/**
 		 * @mm_count: The number of references to &struct mm_struct
-		 * (@mm_users count as 1).
+		 * including its pgd (@mm_users count as 1).
 		 *
 		 * Use mmgrab()/mmdrop() to modify. When this drops to 0, the
-		 * &struct mm_struct is freed.
+		 * pgd is freed.
 		 */
 		atomic_t mm_count;
 
+		/**
+		 * @mm_bare_refs: The number of references to &struct mm_struct
+		 * that preserve no page table state whatsoever (@mm_count
+		 * counts as 1).
+		 *
+		 * When this drops to 0, the &struct mm_struct is freed.
+		 */
+		refcount_t mm_bare_refs;
+
 		/**
 		 * @has_pinned: Whether this mm has pinned any pages.  This can
 		 * be either replaced in the future by @pinned_vm when it
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index f889e332912f..e5b236e15757 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -109,6 +109,19 @@ extern void mmput(struct mm_struct *);
 void mmput_async(struct mm_struct *);
 #endif
 
+static inline void mm_ref(struct mm_struct *mm)
+{
+	refcount_inc(&mm->mm_bare_refs);
+}
+
+void __mm_unref(struct mm_struct *mm);
+
+static inline void mm_unref(struct mm_struct *mm)
+{
+	if (refcount_dec_and_test(&mm->mm_bare_refs))
+		__mm_unref(mm);
+}
+
 /* Grab a reference to a task's mm, if it is not already going away */
 extern struct mm_struct *get_task_mm(struct task_struct *task);
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index 4942428a217c..fcdd1ace79e4 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -642,10 +642,16 @@ static void check_mm(struct mm_struct *mm)
 #define allocate_mm()	(kmem_cache_alloc(mm_cachep, GFP_KERNEL))
 #define free_mm(mm)	(kmem_cache_free(mm_cachep, (mm)))
 
+void __mm_unref(struct mm_struct *mm)
+{
+	put_user_ns(mm->user_ns);
+	free_mm(mm);
+}
+
 /*
- * Called when the last reference to the mm
+ * Called when the last PGD-preserving reference to the mm
  * is dropped: either by a lazy thread or by
- * mmput. Free the page directory and the mm.
+ * mmput. Free the page directory.
  */
 void __mmdrop(struct mm_struct *mm)
 {
@@ -656,8 +662,7 @@ void __mmdrop(struct mm_struct *mm)
 	destroy_context(mm);
 	mmu_notifier_subscriptions_destroy(mm);
 	check_mm(mm);
-	put_user_ns(mm->user_ns);
-	free_mm(mm);
+	mm_unref(mm);
 }
 EXPORT_SYMBOL_GPL(__mmdrop);
 
@@ -1007,6 +1012,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm->vmacache_seqnum = 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
+	refcount_set(&mm->mm_bare_refs, 1);
 	mmap_init_lock(mm);
 	INIT_LIST_HEAD(&mm->mmlist);
 	mm->core_state = NULL;
diff --git a/mm/init-mm.c b/mm/init-mm.c
index 3a613c85f9ed..3c3cd35236fd 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -7,6 +7,7 @@
 #include <linux/cpumask.h>
 #include <linux/mman.h>
 #include <linux/pgtable.h>
+#include <linux/refcount.h>
 
 #include <linux/atomic.h>
 #include <linux/user_namespace.h>
@@ -31,6 +32,7 @@ struct mm_struct init_mm = {
 	.pgd		= swapper_pg_dir,
 	.mm_users	= ATOMIC_INIT(2),
 	.mm_count	= ATOMIC_INIT(1),
+	.mm_bare_refs	= REFCOUNT_INIT(1),
 	MMAP_LOCK_INITIALIZER(init_mm)
 	.page_table_lock =  __SPIN_LOCK_UNLOCKED(init_mm.page_table_lock),
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
-- 
2.29.0.rc1.297.gfa9743e501-goog

