Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC5A29D765
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbgJ1WXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:23:53 -0400
Received: from mx.socionext.com ([202.248.49.38]:49958 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732749AbgJ1WXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:23:50 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 28 Oct 2020 10:56:11 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id AE547180C13;
        Wed, 28 Oct 2020 10:56:11 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Wed, 28 Oct 2020 10:56:11 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 337081A15B7;
        Wed, 28 Oct 2020 10:56:11 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] arm64: Fix build error for init_new_context()
Date:   Wed, 28 Oct 2020 10:56:07 +0900
Message-Id: <1603850167-22652-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After init_new_context() in arch/arm64/include/asm/mmu_context.h changed to
inline, asm-generic/mmu_context.h inclusion was added. This should be defined.

Fixes these build error:

../include/asm-generic/mmu_context.h:34:19: error: redefinition of 'init_new_context'
   34 | static inline int init_new_context(struct task_struct *tsk,
      |                   ^~~~~~~~~~~~~~~~

Cc: Nicholas Piggin <npiggin@gmail.com>
Fixes: 4c792ad103f3 ("arm64: use asm-generic/mmu_context.h for no-op implementations")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 arch/arm64/include/asm/mmu_context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index da5f146..cd5c33a 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -176,6 +176,7 @@ static inline void cpu_replace_ttbr1(pgd_t *pgdp)
  */
 void check_and_switch_context(struct mm_struct *mm);
 
+#define init_new_context init_new_context
 static inline int
 init_new_context(struct task_struct *tsk, struct mm_struct *mm)
 {
-- 
2.7.4

