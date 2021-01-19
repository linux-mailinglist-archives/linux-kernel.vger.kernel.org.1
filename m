Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E512FBD94
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbhASR2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:28:00 -0500
Received: from foss.arm.com ([217.140.110.172]:41578 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390864AbhASR1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:27:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5781396;
        Tue, 19 Jan 2021 09:26:21 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7594C3F66E;
        Tue, 19 Jan 2021 09:26:20 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] kasan: Add explicit preconditions to kasan_report()
Date:   Tue, 19 Jan 2021 17:26:07 +0000
Message-Id: <20210119172607.18400-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of KASAN_HW_TAGS, kasan_report() dereferences
the address passed as a parameter.

Add a comment to make sure that the preconditions to the function are
explicitly clarified.

Note: An invalid address (e.g. NULL pointer address) passed to the
function when, KASAN_HW_TAGS is enabled, leads to a kernel panic.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 mm/kasan/report.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index c0fb21797550..2485b585004d 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -403,6 +403,17 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 	end_report(&flags);
 }
 
+/**
+ * kasan_report - report kasan fault details
+ * @addr: valid address of the allocation where the tag fault was detected
+ * @size: size of the allocation where the tag fault was detected
+ * @is_write: the instruction that caused the fault was a read or write?
+ * @ip: pointer to the instruction that cause the fault
+ *
+ * Note: When CONFIG_KASAN_HW_TAGS is enabled kasan_report() dereferences
+ * the address to access the tags, hence it must be valid at this point in
+ * order to not cause a kernel panic.
+ */
 bool kasan_report(unsigned long addr, size_t size, bool is_write,
 			unsigned long ip)
 {
-- 
2.30.0

