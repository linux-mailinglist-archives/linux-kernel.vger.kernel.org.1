Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293B22FF0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 17:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388147AbhAUQnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 11:43:18 -0500
Received: from foss.arm.com ([217.140.110.172]:41158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387897AbhAUQlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 11:41:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F8111596;
        Thu, 21 Jan 2021 08:40:04 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D3BC3F68F;
        Thu, 21 Jan 2021 08:40:02 -0800 (PST)
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
Subject: [PATCH v5 6/6] kasan: Forbid kunit tests when async mode is enabled
Date:   Thu, 21 Jan 2021 16:39:43 +0000
Message-Id: <20210121163943.9889-7-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121163943.9889-1-vincenzo.frascino@arm.com>
References: <20210121163943.9889-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Architectures supported by KASAN_HW_TAGS can provide a sync or async
mode of execution. KASAN KUNIT tests can be executed only when sync
mode is enabled.

Forbid the execution of the KASAN KUNIT tests when async mode is
enabled.

Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 lib/test_kasan.c | 5 +++++
 mm/kasan/kasan.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 7285dcf9fcc1..1306f707b4fe 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -52,6 +52,11 @@ static int kasan_test_init(struct kunit *test)
 		return -1;
 	}
 
+	if (!hw_is_mode_sync()) {
+		kunit_err(test, "can't run KASAN tests in async mode");
+		return -1;
+	}
+
 	multishot = kasan_save_enable_multi_shot();
 	hw_set_tagging_report_once(false);
 	return 0;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 3923d9744105..3464113042ab 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -296,6 +296,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #define hw_enable_tagging_sync()		arch_enable_tagging_sync()
 #define hw_enable_tagging_async()		arch_enable_tagging_async()
+#define hw_is_mode_sync()			arch_is_mode_sync()
 #define hw_init_tags(max_tag)			arch_init_tags(max_tag)
 #define hw_set_tagging_report_once(state)	arch_set_tagging_report_once(state)
 #define hw_get_random_tag()			arch_get_random_tag()
@@ -306,6 +307,7 @@ static inline const void *arch_kasan_set_tag(const void *addr, u8 tag)
 
 #define hw_enable_tagging_sync()
 #define hw_enable_tagging_async()
+#define hw_is_mode_sync()
 #define hw_set_tagging_report_once(state)
 
 #endif /* CONFIG_KASAN_HW_TAGS */
-- 
2.30.0

