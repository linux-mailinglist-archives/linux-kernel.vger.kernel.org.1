Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED77303F39
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405084AbhAZNsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:48:20 -0500
Received: from foss.arm.com ([217.140.110.172]:40586 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405207AbhAZNrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:47:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8463511D4;
        Tue, 26 Jan 2021 05:46:22 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDCB83F68F;
        Tue, 26 Jan 2021 05:46:20 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v9 3/4] kasan: Add report for async mode
Date:   Tue, 26 Jan 2021 13:46:02 +0000
Message-Id: <20210126134603.49759-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126134603.49759-1-vincenzo.frascino@arm.com>
References: <20210126134603.49759-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN provides an asynchronous mode of execution.

Add reporting functionality for this mode.

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/kasan.h |  6 ++++++
 mm/kasan/report.c     | 13 +++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bb862d1f0e15..b6c502dad54d 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -360,6 +360,12 @@ static inline void *kasan_reset_tag(const void *addr)
 
 #endif /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS*/
 
+#ifdef CONFIG_KASAN_HW_TAGS
+
+void kasan_report_async(void);
+
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 #ifdef CONFIG_KASAN_SW_TAGS
 void __init kasan_init_sw_tags(void);
 #else
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 87b271206163..69bad9c01aed 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -360,6 +360,19 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	end_report(&flags, (unsigned long)object);
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
+void kasan_report_async(void)
+{
+	unsigned long flags;
+
+	start_report(&flags);
+	pr_err("BUG: KASAN: invalid-access\n");
+	pr_err("Asynchronous mode enabled: no access details available\n");
+	dump_stack();
+	end_report(&flags);
+}
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 				unsigned long ip)
 {
-- 
2.30.0

