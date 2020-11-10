Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B55C2ACBFB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbgKJDiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:38:19 -0500
Received: from foss.arm.com ([217.140.110.172]:49784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbgKJDiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:38:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D18A31B;
        Mon,  9 Nov 2020 19:38:18 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.79.111])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A6B3B3F6CF;
        Mon,  9 Nov 2020 19:38:16 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm/mm: Convert PUD level pgtable helper macros into functions
Date:   Tue, 10 Nov 2020 09:06:50 +0530
Message-Id: <1604979410-23997-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macros used as functions can be problematic from the compiler perspective.
There was a build failure report caused primarily because of non reference
of an argument variable. Hence convert PUD level pgtable helper macros into
functions in order to avoid such problems in the future. In the process, it
fixes the argument variables sequence in set_pud() which probably remained
hidden for being a macro.

https://lore.kernel.org/linux-mm/202011020749.5XQ3Hfzc-lkp@intel.com/
https://lore.kernel.org/linux-mm/5fa49698.Vu2O3r+dU20UoEJ+%25lkp@intel.com/

Cc: Russell King <linux@armlinux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Only build tested.

 arch/arm/include/asm/pgtable-2level.h | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
index 3502c2f..9d4f5ee 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -177,11 +177,28 @@
  * the pud: the pud entry is never bad, always exists, and can't be set or
  * cleared.
  */
-#define pud_none(pud)		(0)
-#define pud_bad(pud)		(0)
-#define pud_present(pud)	(1)
-#define pud_clear(pudp)		do { } while (0)
-#define set_pud(pud,pudp)	do { } while (0)
+static inline int pud_none(pud_t pud)
+{
+	return 0;
+}
+
+static inline int pud_bad(pud_t pud)
+{
+	return 0;
+}
+
+static inline int pud_present(pud_t pud)
+{
+	return 1;
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+}
+
+static inline void set_pud(pud_t *pudp, pud_t pud)
+{
+}
 
 static inline pmd_t *pmd_offset(pud_t *pud, unsigned long addr)
 {
-- 
2.7.4

