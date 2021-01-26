Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044DE303F2F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404797AbhAZNpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:45:54 -0500
Received: from foss.arm.com ([217.140.110.172]:40336 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392698AbhAZNpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 08:45:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFCFB113E;
        Tue, 26 Jan 2021 05:44:24 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 096E53F68F;
        Tue, 26 Jan 2021 05:44:22 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH v5 2/2] kasan: Make addr_has_metadata() return true for valid addresses
Date:   Tue, 26 Jan 2021 13:44:09 +0000
Message-Id: <20210126134409.47894-3-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210126134409.47894-1-vincenzo.frascino@arm.com>
References: <20210126134409.47894-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, addr_has_metadata() returns true for every address.
An invalid address (e.g. NULL) passed to the function when,
KASAN_HW_TAGS is enabled, leads to a kernel panic.

Make addr_has_metadata() return true for valid addresses only.

Note: KASAN_HW_TAGS support for vmalloc will be added with a future
patch.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 mm/kasan/kasan.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.30.0

