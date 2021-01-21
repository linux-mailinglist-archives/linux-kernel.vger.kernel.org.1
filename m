Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7152FE38A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbhAUHLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:36776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbhAUG7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:59:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D589923977;
        Thu, 21 Jan 2021 06:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212258;
        bh=UQhakrY4O9KxkZ5EbI2PfDss2LPTvSAVrHSUQiAzu7U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsR0Kzg8ZgL1dw5jbDO3PvApfunnnfRngag7sPOEqDx5Ly870A9wu0BB4pQvIQpCa
         Z2QEp87CZ0pAL2Z7X9Jvxw/KGgUqlgzXpvSjlx0HYsU3dajUMwdBpYhWwcy2UOGuUH
         UN8TT7GUz2UHt698pGqnEOdSjwwcG23844AhFnDDsCvFc64xt4w+cnu7YRKV0H3/eD
         oDZCeTJZwdcjqF0SHTjP0GPchrECYGAEGOkFRAv3rAlZomA91wCi7xuSuhhnbWQyG5
         X1U5tJz5YpIxl2NyNFA/i/YzSwYTmHXI7HTWljT4T6wVeWB6PhVg84GPBdl+yh2/tm
         n1HWUKfOZrx3A==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 25/29] csky: Fixup swapon
Date:   Thu, 21 Jan 2021 14:53:45 +0800
Message-Id: <20210121065349.3188251-25-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current csky's swappon is broken by wrong swap PTE entry format.
Now redesign the new format for abiv1 & abiv2 and make swappon +
zram work properly on csky machines.

C-SKY PTE has VALID, DIRTY to emulate PRESENT, READ, WRITE, EXEC
attributes. GLOBAL bit is shared by two pages in the same tlb
entry. So we need to keep GLOBAL, VALID, PRESENT zero in swp_pte.

To distinguish PAGE_NONE and swp_pte, we need to use an additional
bit (abiv1 is _PAGE_READ, abiv2 is _PAGE_WRITE).

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/abiv1/inc/abi/pgtable-bits.h | 22 ++++++++++++++++++++++
 arch/csky/abiv2/inc/abi/pgtable-bits.h | 22 ++++++++++++++++++++++
 arch/csky/include/asm/pgtable.h        | 17 ++++++++---------
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/csky/abiv1/inc/abi/pgtable-bits.h b/arch/csky/abiv1/inc/abi/pgtable-bits.h
index 6583333b2b0c..50ebe9c28095 100644
--- a/arch/csky/abiv1/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv1/inc/abi/pgtable-bits.h
@@ -24,6 +24,28 @@
 #define _CACHE_CACHED		_PAGE_CACHE
 #define _CACHE_UNCACHED		_PAGE_UNCACHE
 
+#define _PAGE_PROT_NONE		_PAGE_READ
+
+/*
+ * Encode and decode a swap entry
+ *
+ * Format of swap PTE:
+ *     bit          0:    _PAGE_PRESENT (zero)
+ *     bit          1:    _PAGE_READ (zero)
+ *     bit      2 - 5:    swap type[0 - 3]
+ *     bit          6:    _PAGE_GLOBAL (zero)
+ *     bit          7:    _PAGE_VALID (zero)
+ *     bit          8:    swap type[4]
+ *     bit     9 - 31:    swap offset
+ */
+#define __swp_type(x)			((((x).val >> 2) & 0xf) | \
+					(((x).val >> 4) & 0x10))
+#define __swp_offset(x)			((x).val >> 9)
+#define __swp_entry(type, offset)	((swp_entry_t) { \
+					((type & 0xf) << 2) | \
+					((type & 0x10) << 4) | \
+					((offset) << 9)})
+
 #define HAVE_ARCH_UNMAPPED_AREA
 
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/abiv2/inc/abi/pgtable-bits.h b/arch/csky/abiv2/inc/abi/pgtable-bits.h
index 09303dbc89a6..5b27eaf18aa8 100644
--- a/arch/csky/abiv2/inc/abi/pgtable-bits.h
+++ b/arch/csky/abiv2/inc/abi/pgtable-bits.h
@@ -24,4 +24,26 @@
 #define _CACHE_CACHED		(_PAGE_CACHE | _PAGE_BUF)
 #define _CACHE_UNCACHED		(0)
 
+#define _PAGE_PROT_NONE		_PAGE_WRITE
+
+/*
+ * Encode and decode a swap entry
+ *
+ * Format of swap PTE:
+ *     bit          0:    _PAGE_GLOBAL (zero)
+ *     bit          1:    _PAGE_VALID (zero)
+ *     bit      2 - 6:    swap type
+ *     bit      7 - 8:    swap offset[0 - 1]
+ *     bit          9:    _PAGE_WRITE (zero)
+ *     bit         10:    _PAGE_PRESENT (zero)
+ *     bit    11 - 31:    swap offset[2 - 22]
+ */
+#define __swp_type(x)			(((x).val >> 2) & 0x1f)
+#define __swp_offset(x)			((((x).val >> 7) & 0x3) | \
+					(((x).val >> 9) & 0x7ffffc))
+#define __swp_entry(type, offset)	((swp_entry_t) { \
+					((type & 0x1f) << 2) | \
+					((offset & 0x3) << 7) | \
+					((offset & 0x7ffffc) << 9)})
+
 #endif /* __ASM_CSKY_PGTABLE_BITS_H */
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 9dfbe7c0ddca..d349335616e2 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -41,13 +41,6 @@
 #define pfn_pte(pfn, prot) __pte(((unsigned long long)(pfn) << PAGE_SHIFT) \
 				| pgprot_val(prot))
 
-#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | \
-			 _CACHE_MASK)
-
-#define __swp_type(x)			(((x).val >> 4) & 0xff)
-#define __swp_offset(x)			((x).val >> 12)
-#define __swp_entry(type, offset)	((swp_entry_t) {((type) << 4) | \
-					((offset) << 12) })
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
@@ -61,8 +54,7 @@
  */
 #define _PAGE_BASE	(_PAGE_PRESENT | _PAGE_ACCESSED)
 
-#define PAGE_NONE	__pgprot(_PAGE_BASE | \
-				_CACHE_CACHED)
+#define PAGE_NONE	__pgprot(_PAGE_PROT_NONE)
 #define PAGE_READ	__pgprot(_PAGE_BASE | _PAGE_READ | \
 				_CACHE_CACHED)
 #define PAGE_WRITE	__pgprot(_PAGE_BASE | _PAGE_READ | _PAGE_WRITE | \
@@ -78,6 +70,13 @@
 				_PAGE_GLOBAL | \
 				_CACHE_UNCACHED | _PAGE_SO)
 
+#define _PAGE_CHG_MASK	(~(unsigned long) \
+				(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
+				_CACHE_MASK | _PAGE_GLOBAL))
+
+#define MAX_SWAPFILES_CHECK() \
+		BUILD_BUG_ON(MAX_SWAPFILES_SHIFT != 5)
+
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READ
 #define __P010	PAGE_READ
-- 
2.17.1

