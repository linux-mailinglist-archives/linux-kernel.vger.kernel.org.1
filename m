Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198D01C318F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 06:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgEDEB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 00:01:57 -0400
Received: from foss.arm.com ([217.140.110.172]:36848 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgEDEBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 00:01:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 675F11045;
        Sun,  3 May 2020 21:01:55 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.71.79])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0B563F71F;
        Sun,  3 May 2020 21:01:52 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH V18 1/2] x86/mm: Define mm_p4d_folded()
Date:   Mon,  4 May 2020 09:31:04 +0530
Message-Id: <1588564865-31160-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588564865-31160-1-git-send-email-anshuman.khandual@arm.com>
References: <1588564865-31160-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just defines mm_p4d_folded() to check whether P4D page table level is
folded at runtime.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/x86/include/asm/pgtable_64.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index df1373415f11..8d03ffd43794 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -53,6 +53,12 @@ static inline void sync_initial_page_table(void) { }
 
 struct mm_struct;
 
+#define mm_p4d_folded mm_p4d_folded
+static inline bool mm_p4d_folded(struct mm_struct *mm)
+{
+	return !pgtable_l5_enabled();
+}
+
 void set_pte_vaddr_p4d(p4d_t *p4d_page, unsigned long vaddr, pte_t new_pte);
 void set_pte_vaddr_pud(pud_t *pud_page, unsigned long vaddr, pte_t new_pte);
 
-- 
2.20.1

