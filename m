Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E80A2FE363
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbhAUHFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:05:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:37000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbhAUHAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:00:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 550A523877;
        Thu, 21 Jan 2021 06:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212256;
        bh=+tUkx74LutmiYshTXP2UNLNRvJxfD9OOJ9CecaxvSZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kU/5MgWPbElj4Ff2V9n5BUExo3HoHaAiicPoxwh9V15Y2YTzhm1OlsWDeYzJAU7FM
         8hYqwcg9YNpdi+BFgutM79j3qtjGViS1vLEB/Q2CsmKM054uOH2V5djfQ8vZQogNR6
         E6mOwqN/G4bOtkQkPW0tTZ1dlthyCzEj5VjP02ED//cx1ACECDKCJXGwk5JOorc2Mh
         DJEEyRNDpKXs2Z852F6kSqHluFHksjLrBZc5qZeakfsVL+r2x2lz0z7bIxZwI0w/S9
         8nIQua0wSTT+FSnNa8ZAjOW8UXesv7gswO64X74+1+MvTPYxPgnIwr+oGtxdRhVHmd
         ErXc1posTuY4Q==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 24/29] csky: Coding convention del unnecessary definition
Date:   Thu, 21 Jan 2021 14:53:44 +0800
Message-Id: <20210121065349.3188251-24-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Remove _PAGE_IOREMAP, __READABLE, __WRITEABLE, abi/pgtable-bits.h
definition, they are no use at all.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/inc/abi/pgtable-bits.h | 17 ++------
 arch/csky/abiv2/inc/abi/pgtable-bits.h | 14 +-----
 arch/csky/include/asm/pgtable.h        | 59 +++++++++++++-------------
 3 files changed, 35 insertions(+), 55 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
index d605445aad9a..6583333b2b0c 100644
--- a/arch/csky/abiv1/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -5,33 +5,24 @@
 #define __ASM_CSKY_PGTABLE_BITS_H
 
 /* implemented in software */
-#define _PAGE_ACCESSED		(1<<3)
-#define PAGE_ACCESSED_BIT	(3)
-
+#define _PAGE_PRESENT		(1<<0)
 #define _PAGE_READ		(1<<1)
 #define _PAGE_WRITE		(1<<2)
-#define _PAGE_PRESENT		(1<<0)
-
+#define _PAGE_ACCESSED		(1<<3)
 #define _PAGE_MODIFIED		(1<<4)
-#define PAGE_MODIFIED_BIT	(4)
 
 /* implemented in hardware */
 #define _PAGE_GLOBAL		(1<<6)
-
 #define _PAGE_VALID		(1<<7)
-#define PAGE_VALID_BIT		(7)
-
 #define _PAGE_DIRTY		(1<<8)
-#define PAGE_DIRTY_BIT		(8)
 
 #define _PAGE_CACHE		(3<<9)
 #define _PAGE_UNCACHE		(2<<9)
 #define _PAGE_SO		_PAGE_UNCACHE
-
 #define _CACHE_MASK		(7<<9)
 
-#define _CACHE_CACHED		(_PAGE_VALID | _PAGE_CACHE)
-#define _CACHE_UNCACHED		(_PAGE_VALID | _PAGE_UNCACHE)
+#define _CACHE_CACHED		_PAGE_CACHE
+#define _CACHE_UNCACHED		_PAGE_UNCACHE
 
 #define HAVE_ARCH_UNMAPPED_AREA
 
diff --git a/arch/csky/abiv2/inc/abi/pgtable-bits.h b/arch/csky/abiv2/inc/abi/pgtable-bits.h
index 137f7932c83b..09303dbc89a6 100644
--- a/arch/csky/abiv2/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv2/inc/abi/pgtable-bits.h
@@ -6,32 +6,22 @@
 
 /* implemented in software */
 #define _PAGE_ACCESSED		(1<<7)
-#define PAGE_ACCESSED_BIT	(7)
-
 #define _PAGE_READ		(1<<8)
 #define _PAGE_WRITE		(1<<9)
 #define _PAGE_PRESENT		(1<<10)
-
 #define _PAGE_MODIFIED		(1<<11)
-#define PAGE_MODIFIED_BIT	(11)
 
 /* implemented in hardware */
 #define _PAGE_GLOBAL		(1<<0)
-
 #define _PAGE_VALID		(1<<1)
-#define PAGE_VALID_BIT		(1)
-
 #define _PAGE_DIRTY		(1<<2)
-#define PAGE_DIRTY_BIT		(2)
 
 #define _PAGE_SO		(1<<5)
 #define _PAGE_BUF		(1<<6)
-
 #define _PAGE_CACHE		(1<<3)
-
 #define _CACHE_MASK		_PAGE_CACHE
 
-#define _CACHE_CACHED		(_PAGE_VALID | _PAGE_CACHE | _PAGE_BUF)
-#define _CACHE_UNCACHED		(_PAGE_VALID)
+#define _CACHE_CACHED		(_PAGE_CACHE | _PAGE_BUF)
+#define _CACHE_UNCACHED		(0)
 
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 429d96f66620..9dfbe7c0ddca 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -41,9 +41,6 @@
 #define pfn_pte(pfn, prot) __pte(((unsigned long long)(pfn) << PAGE_SHIFT) \
 				| pgprot_val(prot))
 
-#define __READABLE	(_PAGE_READ | _PAGE_VALID | _PAGE_ACCESSED)
-#define __WRITEABLE	(_PAGE_WRITE | _PAGE_DIRTY | _PAGE_MODIFIED)
-
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | \
 			 _CACHE_MASK)
 
@@ -59,43 +56,45 @@
 					pgprot_val(pgprot))
 
 /*
- * CSKY can't do page protection for execute, and considers that the same like
- * read. Also, write permissions imply read permissions. This is the closest
- * we can get by reasonable means..
+ * C-SKY only has VALID and DIRTY bit in hardware. So we need to use the
+ * two bits emulate PRESENT, READ, WRITE, EXEC, MODIFIED, ACCESSED.
  */
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
 
-#define PAGE_NONE	__pgprot(_PAGE_BASE | _CACHE_CACHED)
-#define PAGE_SHARED	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE | \
+#define PAGE_NONE	__pgprot(_PAGE_BASE | \
+				_CACHE_CACHED)
+#define PAGE_READ	__pgprot(_PAGE_BASE | _PAGE_READ | \
 				_CACHE_CACHED)
-#define PAGE_COPY	__pgprot(_PAGE_BASE | _PAGE_READ | _CACHE_CACHED)
-#define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_READ | _CACHE_CACHED)
-#define PAGE_KERNEL	__pgprot(_PAGE_BASE | __READABLE | __WRITEABLE | \
-				_PAGE_GLOBAL | _CACHE_CACHED)
-#define PAGE_USERIO	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE | \
+#define PAGE_WRITE	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE | \
+				_CACHE_CACHED)
+
+#define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_VALID | \
+				_PAGE_WRITE | _PAGE_DIRTY | _PAGE_MODIFIED | \
+				_PAGE_GLOBAL | \
 				_CACHE_CACHED)
 
-#define _PAGE_IOREMAP \
-	(_PAGE_BASE | __READABLE | __WRITEABLE | _PAGE_GLOBAL | \
-	 _CACHE_UNCACHED | _PAGE_SO)
+#define _PAGE_IOREMAP		(_PAGE_BASE | _PAGE_READ | _PAGE_VALID | \
+				_PAGE_WRITE | _PAGE_DIRTY | _PAGE_MODIFIED | \
+				_PAGE_GLOBAL | \
+				_CACHE_UNCACHED | _PAGE_SO)
 
 #define __P000	PAGE_NONE
-#define __P001	PAGE_READONLY
-#define __P010	PAGE_COPY
-#define __P011	PAGE_COPY
-#define __P100	PAGE_READONLY
-#define __P101	PAGE_READONLY
-#define __P110	PAGE_COPY
-#define __P111	PAGE_COPY
+#define __P001	PAGE_READ
+#define __P010	PAGE_READ
+#define __P011	PAGE_READ
+#define __P100	PAGE_READ
+#define __P101	PAGE_READ
+#define __P110	PAGE_READ
+#define __P111	PAGE_READ
 
 #define __S000	PAGE_NONE
-#define __S001	PAGE_READONLY
-#define __S010	PAGE_SHARED
-#define __S011	PAGE_SHARED
-#define __S100	PAGE_READONLY
-#define __S101	PAGE_READONLY
-#define __S110	PAGE_SHARED
-#define __S111	PAGE_SHARED
+#define __S001	PAGE_READ
+#define __S010	PAGE_WRITE
+#define __S011	PAGE_WRITE
+#define __S100	PAGE_READ
+#define __S101	PAGE_READ
+#define __S110	PAGE_WRITE
+#define __S111	PAGE_WRITE
 
 extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
-- 
2.17.1

