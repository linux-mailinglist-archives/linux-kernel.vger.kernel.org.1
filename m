Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B039B2FF0B8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbhAUQmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:42:55 -0500
Received: from foss.arm.com ([217.140.110.172]:41156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387854AbhAUQlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:41:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37E9F1595;
        Thu, 21 Jan 2021 08:40:02 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C92A3F68F;
        Thu, 21 Jan 2021 08:40:00 -0800 (PST)
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
Subject: [PATCH v5 5/6] arm64: mte: Expose execution mode
Date:   Thu, 21 Jan 2021 16:39:42 +0000
Message-Id: <20210121163943.9889-6-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121163943.9889-1-vincenzo.frascino@arm.com>
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MTE enabled arm64 HW can be configured in synchronous or asynchronous
tagging mode of execution.
In synchronous mode, an exception is triggered if a tag check fault
occurs.
In asynchronous mode, if a tag check fault occurs, the TFSR_EL1 register
is updated asynchronously. The kernel checks the corresponding bits
periodically.

Introduce an API that exposes the mode of execution to the kernel.

Note: This API will be used by KASAN KUNIT tests to forbid the execution
when async mode is enable.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/include/asm/memory.h    | 1 +
 arch/arm64/include/asm/mte-kasan.h | 6 ++++++
 arch/arm64/kernel/mte.c            | 8 ++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index df96b9c10b81..1d4eef519fa6 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -233,6 +233,7 @@ static inline const void *__tag_set(const void *addr, u8 tag)
 #ifdef CONFIG_KASAN_HW_TAGS
 #define arch_enable_tagging_sync()		mte_enable_kernel_sync()
 #define arch_enable_tagging_async()		mte_enable_kernel_async()
+#define arch_is_mode_sync()			mte_is_mode_sync()
 #define arch_set_tagging_report_once(state)	mte_set_report_once(state)
 #define arch_init_tags(max_tag)			mte_init_tags(max_tag)
 #define arch_get_random_tag()			mte_get_random_tag()
diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
index 76b6a5988ce5..c216160e805c 100644
--- a/arch/arm64/include/asm/mte-kasan.h
+++ b/arch/arm64/include/asm/mte-kasan.h
@@ -31,6 +31,7 @@ void *mte_set_mem_tag_range(void *addr, size_t size, u8 tag);
 
 void mte_enable_kernel_sync(void);
 void mte_enable_kernel_async(void);
+bool mte_is_mode_sync(void);
 void mte_init_tags(u64 max_tag);
 
 void mte_set_report_once(bool state);
@@ -64,6 +65,11 @@ static inline void mte_enable_kernel_sync(void)
 {
 }
 
+static inline bool mte_is_mode_sync(void)
+{
+	return false;
+}
+
 static inline void mte_init_tags(u64 max_tag)
 {
 }
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index 7763ac1f2917..1cc3fc173b97 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -26,6 +26,7 @@
 u64 gcr_kernel_excl __ro_after_init;
 
 static bool report_fault_once = true;
+static bool __mte_mode_sync = true;
 
 static void mte_sync_page_tags(struct page *page, pte_t *ptep, bool check_swap)
 {
@@ -169,9 +170,16 @@ void mte_enable_kernel_sync(void)
 
 void mte_enable_kernel_async(void)
 {
+	__mte_mode_sync = false;
+
 	__mte_enable_kernel("asynchronous", SCTLR_ELx_TCF_ASYNC);
 }
 
+bool mte_is_mode_sync(void)
+{
+	return __mte_mode_sync;
+}
+
 void mte_set_report_once(bool state)
 {
 	WRITE_ONCE(report_fault_once, state);
-- 
2.30.0

