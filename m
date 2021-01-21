Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6288F2FF0AE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387813AbhAUQll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:41:41 -0500
Received: from foss.arm.com ([217.140.110.172]:41090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbhAUQko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:40:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EA141509;
        Thu, 21 Jan 2021 08:39:58 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2B203F68F;
        Thu, 21 Jan 2021 08:39:56 -0800 (PST)
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
Subject: [PATCH v5 3/6] kasan: Add report for async mode
Date:   Thu, 21 Jan 2021 16:39:40 +0000
Message-Id: <20210121163943.9889-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121163943.9889-1-vincenzo.frascino@arm.com>
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
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
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 include/linux/kasan.h |  2 ++
 mm/kasan/report.c     | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index bb862d1f0e15..b0a1d9dfa85c 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -351,6 +351,8 @@ static inline void *kasan_reset_tag(const void *addr)
 bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 
+void kasan_report_async(void);
+
 #else /* CONFIG_KASAN_SW_TAGS || CONFIG_KASAN_HW_TAGS */
 
 static inline void *kasan_reset_tag(const void *addr)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 234f35a84f19..2fd6845a95e9 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -358,6 +358,17 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	end_report(&flags);
 }
 
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
+
 static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 				unsigned long ip)
 {
-- 
2.30.0

