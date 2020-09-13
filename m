Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148712681E7
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 01:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgIMXrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 19:47:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725942AbgIMXrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 19:47:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600040869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JIx7k6ssCTRhRUe+6ChUYZSci4c4B3pK4VyMchd5nyc=;
        b=GPbPNziuu0z2r4m9j37658r563S6pcoIWqO3UAIJ76RYYFYiSRGfzY7i7XOByUP99uawef
        Bt6VXn3HREg1zXbqMSKYpROaWx4DpLImgmaUCAFz6dn7T1tGjjQegeH0z6EBY8XQCI2aET
        m8jhGs+Myf6UonyLV9FWgIeJYXkfDVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-OgCDQo9iNlaXHBuNZpChFQ-1; Sun, 13 Sep 2020 19:47:43 -0400
X-MC-Unique: OgCDQo9iNlaXHBuNZpChFQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 526F81074651;
        Sun, 13 Sep 2020 23:47:42 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-46.bne.redhat.com [10.64.54.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2D415D9E2;
        Sun, 13 Sep 2020 23:47:39 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, will@kernel.org,
        shan.gavin@gmail.com
Subject: [PATCH v2] arm64/mm: Refactor {pgd, pud, pmd, pte}_ERROR()
Date:   Mon, 14 Sep 2020 09:47:30 +1000
Message-Id: <20200913234730.23145-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __{pgd, pud, pmd, pte}_error() are introduced so that
they can be called by {pgd, pud, pmd, pte}_ERROR(). However, some
of the functions could never be called when the corresponding page
table level isn't enabled. For example, __{pud, pmd}_error() are
unused when PUD and PMD are folded to PGD.

This removes __{pgd, pud, pmd, pte}_error() and call pr_err() from
{pgd, pud, pmd, pte}_ERROR() directly, similar to what x86/powerpc
are doing. With this, the code looks a bit simplified either.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v2: Fix build warning caused by wrong printk format
---
 arch/arm64/include/asm/pgtable.h | 17 ++++++++---------
 arch/arm64/kernel/traps.c        | 20 --------------------
 2 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d5d3fbe73953..e0ab81923c30 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -35,11 +35,6 @@
 
 extern struct page *vmemmap;
 
-extern void __pte_error(const char *file, int line, unsigned long val);
-extern void __pmd_error(const char *file, int line, unsigned long val);
-extern void __pud_error(const char *file, int line, unsigned long val);
-extern void __pgd_error(const char *file, int line, unsigned long val);
-
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 
@@ -57,7 +52,8 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
 extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr)	phys_to_page(__pa_symbol(empty_zero_page))
 
-#define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
+#define pte_ERROR(e)	\
+	pr_err("%s:%d: bad pte %016llx.\n", __FILE__, __LINE__, pte_val(e))
 
 /*
  * Macros to convert between a physical address and its placement in a
@@ -541,7 +537,8 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
-#define pmd_ERROR(pmd)		__pmd_error(__FILE__, __LINE__, pmd_val(pmd))
+#define pmd_ERROR(e)	\
+	pr_err("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
 
 #define pud_none(pud)		(!pud_val(pud))
 #define pud_bad(pud)		(!(pud_val(pud) & PUD_TABLE_BIT))
@@ -608,7 +605,8 @@ static inline unsigned long pud_page_vaddr(pud_t pud)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
-#define pud_ERROR(pud)		__pud_error(__FILE__, __LINE__, pud_val(pud))
+#define pud_ERROR(e)	\
+	pr_err("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
 
 #define p4d_none(p4d)		(!p4d_val(p4d))
 #define p4d_bad(p4d)		(!(p4d_val(p4d) & 2))
@@ -667,7 +665,8 @@ static inline unsigned long p4d_page_vaddr(p4d_t p4d)
 
 #endif  /* CONFIG_PGTABLE_LEVELS > 3 */
 
-#define pgd_ERROR(pgd)		__pgd_error(__FILE__, __LINE__, pgd_val(pgd))
+#define pgd_ERROR(e)	\
+	pr_err("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
 
 #define pgd_set_fixmap(addr)	((pgd_t *)set_fixmap_offset(FIX_PGD, addr))
 #define pgd_clear_fixmap()	clear_fixmap(FIX_PGD)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 13ebd5ca2070..12fba7136dbd 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -935,26 +935,6 @@ asmlinkage void enter_from_user_mode(void)
 }
 NOKPROBE_SYMBOL(enter_from_user_mode);
 
-void __pte_error(const char *file, int line, unsigned long val)
-{
-	pr_err("%s:%d: bad pte %016lx.\n", file, line, val);
-}
-
-void __pmd_error(const char *file, int line, unsigned long val)
-{
-	pr_err("%s:%d: bad pmd %016lx.\n", file, line, val);
-}
-
-void __pud_error(const char *file, int line, unsigned long val)
-{
-	pr_err("%s:%d: bad pud %016lx.\n", file, line, val);
-}
-
-void __pgd_error(const char *file, int line, unsigned long val)
-{
-	pr_err("%s:%d: bad pgd %016lx.\n", file, line, val);
-}
-
 /* GENERIC_BUG traps */
 
 int is_valid_bugaddr(unsigned long addr)
-- 
2.23.0

