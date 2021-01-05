Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0884B2EB297
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbhAES3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729968AbhAES3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:29:23 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA31C06179E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:16 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m8so363484qvt.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fpLOhPj99FTMaF5xDNOc2fjXP3fAJlS0mlqNObUGCRg=;
        b=jO5CnAER6hx5Gf5iEHJj6/wFFGujrFpCYgFabsz/rL9ARs4bjWxzhIAmvTifRPDvPI
         9BeGX6muqqHf69UhdzLzJ5vTKsLmW1OmlbMvwB5GkUW4KdToVBiZEmF6QTpIVwCRBpkN
         QuPYjT6eKWmT7P9imHZFv5OP2BEJxO2iaSX3YiI1yJVRCKY/euY7wBF034aypUiXJfbK
         2vR6UBJsv4WGktzwYIwt9rhU5njzzFG0evZhKThtok2hpk7LmPRE1iM3m/DaFDo7dhTp
         XnA0RuidUupv1K+gG5tPgvmXaqnUYVVW3+xTMAk7dyoDchBX44IGhBqR/tuS5ILs3Pga
         ssqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fpLOhPj99FTMaF5xDNOc2fjXP3fAJlS0mlqNObUGCRg=;
        b=KtegumKR34lXIupGtZd9ca85MtTq5aHqXV8pNeBf+JbOuKdimaBGofbD6MkPFdLw6w
         QO/yAjYnC6lEadyQv9/1gNp9Dfh9Pd7NmzcS/EwdrenJ70IDITXRATYo9k1JjSI9BDyv
         3Vm0qhxex5lDVtxKclnpYFR56H+aXkP4vlk+JV1KoR9jIvF1hOfTN3J5PoEA4j/3ePGn
         iz0Aapj/efrnK0rwTodzFfY4uJX1wtRy15/hsRRRYod4YNE/yMYGNHRmBrQjkq1ummvo
         LyskAGtva5entqd2NAEuWrXB93hFvYvbjD3+pPosyIYKMzxA0epY2QizgHf1M4pZlpVy
         ZEEQ==
X-Gm-Message-State: AOAM531mIT4nVCft81u9wuhZEw7OdvZNCi6TfHnp4gsYOaX/f7Kyxh1K
        CkQ7MheDaeqsrTH5FjZqQx1Qk+V6e8/VY4xZ
X-Google-Smtp-Source: ABdhPJzJGr67n+498Z2fZ8tYGcl/ix6n2Zq4fa1orC0DjidO39QGu0gJDp4lBHTP9xXR8vPrqn4TCakRVtk0dnYs
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a0c:f54c:: with SMTP id
 p12mr805903qvm.35.1609871295458; Tue, 05 Jan 2021 10:28:15 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:49 +0100
In-Reply-To: <cover.1609871239.git.andreyknvl@google.com>
Message-Id: <dd061dfca76dbf86af13393edacd37e0c75b6f4a.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 05/11] kasan, arm64: allow using KUnit tests with HW_TAGS mode
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a high level, this patch allows running KUnit KASAN tests with the
hardware tag-based KASAN mode.

Internally, this change reenables tag checking at the end of each KASAN
test that triggers a tag fault and leads to tag checking being disabled.

With this patch KASAN tests are still failing for the hardware tag-based
mode; fixes come in the next few patches.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Id94dc9eccd33b23cda4950be408c27f879e474c8
---
 arch/arm64/include/asm/memory.h    |  1 +
 arch/arm64/include/asm/mte-kasan.h | 12 +++++++++
 arch/arm64/kernel/mte.c            | 12 +++++++++
 arch/arm64/mm/fault.c              | 16 +++++++-----
 lib/Kconfig.kasan                  |  4 +--
 lib/test_kasan.c                   | 42 +++++++++++++++++++++---------
 mm/kasan/kasan.h                   |  9 +++++++
 7 files changed, 75 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 18fce223b67b..cedfc9e97bcc 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -232,6 +232,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 
 #ifdef CONFIG_KASAN_HW_TAGS
 #define arch_enable_tagging()			mte_enable_kernel()
+#define arch_set_tagging_report_once(state)	mte_set_report_once(state)
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
 #define arch_get_mem_tag(addr)			mte_get_mem_tag(addr)
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 26349a4b5e2e..3748d5bb88c0 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -32,6 +32,9 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 void mte_enable_kernel(void);
 void mte_init_tags(u64 max_tag);
 
+void mte_set_report_once(bool state);
+bool mte_report_once(void);
+
 #else /* CONFIG_ARM64_MTE */
 
 static inline u8 mte_get_ptr_tag(void *ptr)
@@ -60,6 +63,15 @@ static inline void mte_init_tags(u64 max_tag)
 {
 }
 
+static inline void mte_set_report_once(bool state)
+{
+}
+
+static inline bool mte_report_once(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_ARM64_MTE */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index dc9ada64feed..c63b3d7a3cd9 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -25,6 +25,8 @@
 
 u64 gcr_kernel_excl __ro_after_init;
 
+static bool report_fault_once = true;
+
 static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
 	pte_t old_pte = READ_ONCE(*ptep);
@@ -158,6 +160,16 @@ void mte_enable_kernel(void)
 	isb();
 }
 
+void mte_set_report_once(bool state)
+{
+	WRITE_ONCE(report_fault_once, state);
+}
+
+bool mte_report_once(void)
+{
+	return READ_ONCE(report_fault_once);
+}
+
 static void update_sctlr_el1_tcf0(u64 tcf0)
 {
 	/* ISB required for the kernel uaccess routines */
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 3c40da479899..57d3f165d907 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -302,12 +302,20 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
 static void report_tag_fault(unsigned long addr, unsigned int esr,
 			     struct pt_regs *regs)
 {
-	bool is_write  = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
+	static bool reported;
+	bool is_write;
+
+	if (READ_ONCE(reported))
+		return;
+
+	if (mte_report_once())
+		WRITE_ONCE(reported, true);
 
 	/*
 	 * SAS bits aren't set for all faults reported in EL1, so we can't
 	 * find out access size.
 	 */
+	is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
 	kasan_report(addr, 0, is_write, regs->pc);
 }
 #else
@@ -319,12 +327,8 @@ static inline void report_tag_fault(unsigned long addr, unsigned int esr,
 static void do_tag_recovery(unsigned long addr, unsigned int esr,
 			   struct pt_regs *regs)
 {
-	static bool reported;
 
-	if (!READ_ONCE(reported)) {
-		report_tag_fault(addr, esr, regs);
-		WRITE_ONCE(reported, true);
-	}
+	report_tag_fault(addr, esr, regs);
 
 	/*
 	 * Disable MTE Tag Checking on the local CPU for the current EL.
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index f5fa4ba126bf..3091432acb0a 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -190,11 +190,11 @@ config KASAN_KUNIT_TEST
 	  kernel debugging features like KASAN.
 
 	  For more information on KUnit and unit tests in general, please refer
-	  to the KUnit documentation in Documentation/dev-tools/kunit
+	  to the KUnit documentation in Documentation/dev-tools/kunit.
 
 config TEST_KASAN_MODULE
 	tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
-	depends on m && KASAN
+	depends on m && KASAN && !KASAN_HW_TAGS
 	help
 	  This is a part of the KASAN test suite that is incompatible with
 	  KUnit. Currently includes tests that do bad copy_from/to_user
diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index f1eda0bcc780..dd3d2f95c24e 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -41,16 +41,20 @@ static bool multishot;
 
 /*
  * Temporarily enable multi-shot mode. Otherwise, KASAN would only report the
- * first detected bug and panic the kernel if panic_on_warn is enabled.
+ * first detected bug and panic the kernel if panic_on_warn is enabled. For
+ * hardware tag-based KASAN also allow tag checking to be reenabled for each
+ * test, see the comment for KUNIT_EXPECT_KASAN_FAIL().
  */
 static int kasan_test_init(struct kunit *test)
 {
 	multishot = kasan_save_enable_multi_shot();
+	hw_set_tagging_report_once(false);
 	return 0;
 }
 
 static void kasan_test_exit(struct kunit *test)
 {
+	hw_set_tagging_report_once(true);
 	kasan_restore_multi_shot(multishot);
 }
 
@@ -59,19 +63,31 @@ static void kasan_test_exit(struct kunit *test)
  * KASAN report; causes a test failure otherwise. This relies on a KUnit
  * resource named "kasan_data". Do not use this name for KUnit resources
  * outside of KASAN tests.
+ *
+ * For hardware tag-based KASAN, when a tag fault happens, tag checking is
+ * normally auto-disabled. When this happens, this test handler reenables
+ * tag checking. As tag checking can be only disabled or enabled per CPU, this
+ * handler disables migration (preemption).
  */
-#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do { \
-	fail_data.report_expected = true; \
-	fail_data.report_found = false; \
-	kunit_add_named_resource(test, \
-				NULL, \
-				NULL, \
-				&resource, \
-				"kasan_data", &fail_data); \
-	expression; \
-	KUNIT_EXPECT_EQ(test, \
-			fail_data.report_expected, \
-			fail_data.report_found); \
+#define KUNIT_EXPECT_KASAN_FAIL(test, expression) do {		\
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))			\
+		migrate_disable();				\
+	fail_data.report_expected = true;			\
+	fail_data.report_found = false;				\
+	kunit_add_named_resource(test,				\
+				NULL,				\
+				NULL,				\
+				&resource,			\
+				"kasan_data", &fail_data);	\
+	expression;						\
+	KUNIT_EXPECT_EQ(test,					\
+			fail_data.report_expected,		\
+			fail_data.report_found);		\
+	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS)) {			\
+		if (fail_data.report_found)			\
+			hw_enable_tagging();			\
+		migrate_enable();				\
+	}							\
 } while (0)
 
 static void kmalloc_oob_right(struct kunit *test)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index c3fb9bf241d3..292dfbc37deb 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -280,6 +280,9 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #ifndef arch_init_tags
 #define arch_init_tags(max_tag)
 #endif
+#ifndef arch_set_tagging_report_once
+#define arch_set_tagging_report_once(state)
+#endif
 #ifndef arch_get_random_tag
 #define arch_get_random_tag()	(0xFF)
 #endif
@@ -292,10 +295,16 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #define hw_enable_tagging()			arch_enable_tagging()
 #define hw_init_tags(max_tag)			arch_init_tags(max_tag)
+#define hw_set_tagging_report_once(state)	arch_set_tagging_report_once(state)
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
 #define hw_set_mem_tag_range(addr, size, tag)	arch_set_mem_tag_range((addr), (size), (tag))
 
+#else /* CONFIG_KASAN_HW_TAGS */
+
+#define hw_enable_tagging()
+#define hw_set_tagging_report_once(state)
+
 #endif /* CONFIG_KASAN_HW_TAGS */
 
 #ifdef CONFIG_KASAN_SW_TAGS
-- 
2.29.2.729.g45daf8777d-goog

