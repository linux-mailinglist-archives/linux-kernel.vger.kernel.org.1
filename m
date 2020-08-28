Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390FE255EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 18:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgH1QjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 12:39:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:40624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgH1QjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:39:08 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57F7520872;
        Fri, 28 Aug 2020 16:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598632748;
        bh=YVCQjg73RxPTvlTXDUxrWS87exJNOw0r+AtJ4Kjw2bM=;
        h=From:To:Cc:Subject:Date:From;
        b=OAnMIBUg/35kIR+XHFI3uW81Vhsq5RuiNO8PZO0o+7cScYYcfQFJ/tKoqYInqbOSi
         dQWnnF3AWY7qf+6NtTYAPh1hjs5+LeMHiPoLIzkFYN69Mx3EDHR9KMKJKlYqzI8jS1
         aTQbasoMLnPibL/SFcRCQ2iAC1tMlDy4bHOcscvs=
From:   Mike Rapoport <rppt@kernel.org>
To:     Vineet Gupta <vgupta@synopsys.com>
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH] arc: fix memory initialization for systems with two memory banks
Date:   Fri, 28 Aug 2020 19:39:02 +0300
Message-Id: <20200828163902.4548-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Rework if memory map initialization broke initialization of ARC systems
with two memory banks. Before these changes, memblock was not aware of
nodes configuration and the memory map was always allocated from the
"lowmem" bank. After the addition of node information to memblock, the core
mm attempts to allocate the memory map for the "highmem" bank from its
node. The access to this memory using __va() fails because it can be only
accessed using kmap.

Anther problem that was uncovered is that {min,max}_high_pfn are calculated
from u64 high_mem_start variable which prevents truncation to 32-bit
physical address and the PFN values are above the node and zone boundaries.

Use phys_addr_t type for high_mem_start and high_mem_size to ensure
correspondence between PFNs and highmem zone boundaries and reserve the
entire highmem bank until mem_init() to avoid accesses to it before highmem
is enabled.

Fixes: 51930df5801e ("mm: free_area_init: allow defining max_zone_pfn in descend ing order")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arc/mm/init.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index f886ac69d8ad..3a35b82a718e 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -26,8 +26,8 @@ static unsigned long low_mem_sz;
 
 #ifdef CONFIG_HIGHMEM
 static unsigned long min_high_pfn, max_high_pfn;
-static u64 high_mem_start;
-static u64 high_mem_sz;
+static phys_addr_t high_mem_start;
+static phys_addr_t high_mem_sz;
 #endif
 
 #ifdef CONFIG_DISCONTIGMEM
@@ -69,6 +69,7 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 		high_mem_sz = size;
 		in_use = 1;
 		memblock_add_node(base, size, 1);
+		memblock_reserve(base, size);
 #endif
 	}
 
@@ -157,7 +158,7 @@ void __init setup_arch_memory(void)
 	min_high_pfn = PFN_DOWN(high_mem_start);
 	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
 
-	max_zone_pfn[ZONE_HIGHMEM] = max_high_pfn;
+	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
 
 	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
 	kmap_init();
@@ -166,22 +167,26 @@ void __init setup_arch_memory(void)
 	free_area_init(max_zone_pfn);
 }
 
-/*
- * mem_init - initializes memory
- *
- * Frees up bootmem
- * Calculates and displays memory available/used
- */
-void __init mem_init(void)
+static void __init highmem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
 	unsigned long tmp;
 
-	reset_all_zones_managed_pages();
+	memblock_free(high_mem_start, high_mem_sz);
 	for (tmp = min_high_pfn; tmp < max_high_pfn; tmp++)
 		free_highmem_page(pfn_to_page(tmp));
 #endif
+}
 
+/*
+ * mem_init - initializes memory
+ *
+ * Frees up bootmem
+ * Calculates and displays memory available/used
+ */
+void __init mem_init(void)
+{
 	memblock_free_all();
+	highmem_init();
 	mem_init_print_info(NULL);
 }
-- 
2.26.2

