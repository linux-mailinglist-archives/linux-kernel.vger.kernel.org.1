Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9232FEB97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 14:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbhAUNW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 08:22:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36380 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731795AbhAUNU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:20:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 87CD0139F;
        Thu, 21 Jan 2021 05:20:12 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E33A3F68F;
        Thu, 21 Jan 2021 05:20:11 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH v2 2/2] kasan: Add explicit preconditions to kasan_report()
Date:   Thu, 21 Jan 2021 13:19:56 +0000
Message-Id: <20210121131956.23246-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121131956.23246-1-vincenzo.frascino@arm.com>
References: <20210121131956.23246-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
the address passed as a parameter.

Add a comment to make sure that the preconditions to the function are
explicitly clarified.

Note: An invalid address (e.g. NULL) passed to the function when,
KASAN_HW_TAGS is enabled, leads to a kernel panic.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 mm/kasan/kasan.h  | 2 +-
 mm/kasan/report.c | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cc4d9e1d49b1..8c706e7652f2 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -209,7 +209,7 @@ bool check_memory_region(unsigned long addr, size_t size, bool write,
 
 static inline bool addr_has_metadata(const void *addr)
 {
-	return true;
+	return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
 }
 
 #endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c0fb21797550..8b690091cb37 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -403,6 +403,13 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	end_report(&flags);
 }
 
+/**
+ * kasan_report - report kasan fault details
+ * @addr: valid address of the allocation where the tag fault was detected
+ * @size: size of the allocation where the tag fault was detected
+ * @is_write: the instruction that caused the fault was a read or write?
+ * @ip: pointer to the instruction that cause the fault
+ */
 bool kasan_report(unsigned long addr, size_t size, bool is_write,
 			unsigned long ip)
 {
-- 
2.30.0

