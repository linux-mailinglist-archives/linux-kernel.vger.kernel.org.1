Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5781A79DB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439538AbgDNLpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 07:45:11 -0400
Received: from foss.arm.com ([217.140.110.172]:53710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439513AbgDNLo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:44:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8282431B;
        Tue, 14 Apr 2020 04:44:55 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.1.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F5443F6C4;
        Tue, 14 Apr 2020 04:44:53 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64/mm: Drop __HAVE_ARCH_HUGE_PTEP_GET
Date:   Tue, 14 Apr 2020 17:14:28 +0530
Message-Id: <1586864670-21799-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586864670-21799-1-git-send-email-anshuman.khandual@arm.com>
References: <1586864670-21799-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Platform specific huge_ptep_get() is required only when fetching the huge
PTE involves more than just dereferencing the page table pointer. This is
not the case on arm64 platform. Hence huge_ptep_pte() can be dropped along
with it's __HAVE_ARCH_HUGE_PTEP_GET subscription.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/hugetlb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 2eb6c234d594..b88878ddc88b 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -17,12 +17,6 @@
 extern bool arch_hugetlb_migration_supported(struct hstate *h);
 #endif
 
-#define __HAVE_ARCH_HUGE_PTEP_GET
-static inline pte_t huge_ptep_get(pte_t *ptep)
-{
-	return READ_ONCE(*ptep);
-}
-
 static inline int is_hugepage_only_range(struct mm_struct *mm,
 					 unsigned long addr, unsigned long len)
 {
-- 
2.20.1

