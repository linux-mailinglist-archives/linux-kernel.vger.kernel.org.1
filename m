Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BBD1C3232
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 07:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEDFYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 01:24:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:6020 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgEDFYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 01:24:18 -0400
IronPort-SDR: 4qkNMnD9dy5SHg+B3d164aIu6TDHWTHTe0JJdrooqSpuzLCVaxYcPda18frCSLnC+p23acmGhZ
 MEuGlIefis+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 22:24:18 -0700
IronPort-SDR: 7lsgUy6DttbyW6//xzs4Ul81yB0vy7PUZlrcy64YEyHblohykv6BjMzFudZNAKlyq4EJ7Oerx6
 IJyMm6sccb5w==
X-IronPort-AV: E=Sophos;i="5.73,350,1583222400"; 
   d="scan'208";a="250532742"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2020 22:24:17 -0700
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Subject: [PATCH 1/2] kmap: Remove kmap_atomic_to_page()
Date:   Sun,  3 May 2020 22:24:14 -0700
Message-Id: <20200504052415.984585-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200504052415.984585-1-ira.weiny@intel.com>
References: <20200504052415.984585-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

kmap_atomic_to_page() has no callers and is only defined on 1 arch and
declared on another.  Remove it.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/csky/include/asm/highmem.h  |  1 -
 arch/csky/mm/highmem.c           | 13 -------------
 arch/nds32/include/asm/highmem.h |  1 -
 3 files changed, 15 deletions(-)

diff --git a/arch/csky/include/asm/highmem.h b/arch/csky/include/asm/highmem.h
index 263fbddcd0a3..ea2f3f39174d 100644
--- a/arch/csky/include/asm/highmem.h
+++ b/arch/csky/include/asm/highmem.h
@@ -33,7 +33,6 @@ extern pte_t *pkmap_page_table;
 #define ARCH_HAS_KMAP_FLUSH_TLB
 extern void kmap_flush_tlb(unsigned long addr);
 extern void *kmap_atomic_pfn(unsigned long pfn);
-extern struct page *kmap_atomic_to_page(void *ptr);
 
 #define flush_cache_kmaps() do {} while (0)
 
diff --git a/arch/csky/mm/highmem.c b/arch/csky/mm/highmem.c
index 3ae5c8cd7619..3b3f622f5ae9 100644
--- a/arch/csky/mm/highmem.c
+++ b/arch/csky/mm/highmem.c
@@ -81,19 +81,6 @@ void *kmap_atomic_pfn(unsigned long pfn)
 	return (void *) vaddr;
 }
 
-struct page *kmap_atomic_to_page(void *ptr)
-{
-	unsigned long idx, vaddr = (unsigned long)ptr;
-	pte_t *pte;
-
-	if (vaddr < FIXADDR_START)
-		return virt_to_page(ptr);
-
-	idx = virt_to_fix(vaddr);
-	pte = kmap_pte - (idx - FIX_KMAP_BEGIN);
-	return pte_page(*pte);
-}
-
 static void __init kmap_pages_init(void)
 {
 	unsigned long vaddr;
diff --git a/arch/nds32/include/asm/highmem.h b/arch/nds32/include/asm/highmem.h
index 4d21308549c9..a48a6536d41a 100644
--- a/arch/nds32/include/asm/highmem.h
+++ b/arch/nds32/include/asm/highmem.h
@@ -52,7 +52,6 @@ extern void kmap_init(void);
  */
 #ifdef CONFIG_HIGHMEM
 extern void *kmap_atomic_pfn(unsigned long pfn);
-extern struct page *kmap_atomic_to_page(void *ptr);
 #endif
 
 #endif
-- 
2.25.1

