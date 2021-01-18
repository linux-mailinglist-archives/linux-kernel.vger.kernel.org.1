Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00082FA8E6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407630AbhARScA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:32:00 -0500
Received: from foss.arm.com ([217.140.110.172]:41910 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393684AbhARSbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:31:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3F77ED1;
        Mon, 18 Jan 2021 10:30:51 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3555E3F719;
        Mon, 18 Jan 2021 10:30:50 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 2/5] kasan: Add KASAN mode kernel parameter
Date:   Mon, 18 Jan 2021 18:30:30 +0000
Message-Id: <20210118183033.41764-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210118183033.41764-1-vincenzo.frascino@arm.com>
References: <20210118183033.41764-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures supported by KASAN HW can provide a sync or async mode of
execution. On an MTE enabled arm64 hw for example this can be identified
with the synchronous or asynchronous tagging mode of execution.
In synchronous mode, an exception is triggered if a tag check fault occurs.
In asynchronous mode, if a tag check fault occurs, the TFSR_EL1 register is
updated asynchronously. The kernel checks the corresponding bits
periodically.

KASAN requires a specific kernel command line parameter to make use of this
hw features.

Add KASAN HW execution mode kernel command line parameter.

Note: This patch adds the kasan.mode kernel parameter and the
sync/async kernel command line options to enable the described features.

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 Documentation/dev-tools/kasan.rst |  3 +++
 mm/kasan/hw_tags.c                | 31 ++++++++++++++++++++++++++++++-
 mm/kasan/kasan.h                  |  3 ++-
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 1651d961f06a..60ad73c2a33c 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -162,6 +162,9 @@ particular KASAN features.
 
 - ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
+- ``kasan.mode=sync`` or ``=async`` controls whether KASAN is configured in
+  synchronous or asynchronous mode of execution (default: ``sync``).
+
 - ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
   traces collection (default: ``on`` for ``CONFIG_DEBUG_KERNEL=y``, otherwise
   ``off``).
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index e529428e7a11..344aeec05d43 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -25,6 +25,11 @@ enum kasan_arg {
 	KASAN_ARG_ON,
 };
 
+enum kasan_arg_mode {
+	KASAN_ARG_MODE_SYNC,
+	KASAN_ARG_MODE_ASYNC,
+};
+
 enum kasan_arg_stacktrace {
 	KASAN_ARG_STACKTRACE_DEFAULT,
 	KASAN_ARG_STACKTRACE_OFF,
@@ -38,6 +43,7 @@ enum kasan_arg_fault {
 };
 
 static enum kasan_arg kasan_arg __ro_after_init;
+static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
 static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
 static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
 
@@ -68,6 +74,21 @@ static int __init early_kasan_flag(char *arg)
 }
 early_param("kasan", early_kasan_flag);
 
+/* kasan.mode=sync/async */
+static int __init early_kasan_mode(char *arg)
+{
+	/* If arg is not set the default mode is sync */
+	if ((!arg) || !strcmp(arg, "sync"))
+		kasan_arg_mode = KASAN_ARG_MODE_SYNC;
+	else if (!strcmp(arg, "async"))
+		kasan_arg_mode = KASAN_ARG_MODE_ASYNC;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+early_param("kasan.mode", early_kasan_mode);
+
 /* kasan.stacktrace=off/on */
 static int __init early_kasan_flag_stacktrace(char *arg)
 {
@@ -102,6 +123,14 @@ static int __init early_kasan_fault(char *arg)
 }
 early_param("kasan.fault", early_kasan_fault);
 
+static inline void hw_enable_tagging_mode(void)
+{
+	if (kasan_arg_mode == KASAN_ARG_MODE_ASYNC)
+		hw_enable_tagging_async();
+	else
+		hw_enable_tagging_sync();
+}
+
 /* kasan_init_hw_tags_cpu() is called for each CPU. */
 void kasan_init_hw_tags_cpu(void)
 {
@@ -115,7 +144,7 @@ void kasan_init_hw_tags_cpu(void)
 		return;
 
 	hw_init_tags(KASAN_TAG_MAX);
-	hw_enable_tagging();
+	hw_enable_tagging_mode();
 }
 
 /* kasan_init_hw_tags() is called once on boot CPU. */
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cc4d9e1d49b1..7db7bd42fe97 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -284,7 +284,8 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 #define arch_set_mem_tag_range(addr, size, tag) ((void *)(addr))
 #endif
 
-#define hw_enable_tagging()			arch_enable_tagging()
+#define hw_enable_tagging_sync()		arch_enable_tagging_sync()
+#define hw_enable_tagging_async()		arch_enable_tagging_async()
 #define hw_init_tags(max_tag)			arch_init_tags(max_tag)
 #define hw_get_random_tag()			arch_get_random_tag()
 #define hw_get_mem_tag(addr)			arch_get_mem_tag(addr)
-- 
2.30.0

