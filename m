Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D352C8BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgK3RvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729267AbgK3RvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:51:21 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C234C207F7;
        Mon, 30 Nov 2020 17:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606758640;
        bh=6vR1NNeFhXTHPNhLIobNWpzBNkP4AUUXt02lMefhnm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bfOl4RNtjMe51gpgt7cAnWb750JMIIRRD4/hw1+Tj2c0awm7njjeUCX4OlfJhp3d4
         RZoHod4Hs1hhEbwPcKkXYjJkWjkXQlX5Y8o3zoRrviz8pIO45leVqWoknAhGB2q8Sw
         4bP/n4Adyj6MQuq4mW+UnHP0MQWCVzqmM9XsyJJ0=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 1/3] x86/membarrier: Get rid of a dubious optimization
Date:   Mon, 30 Nov 2020 09:50:33 -0800
Message-Id: <9b8ecd9a017960c9e56ef3f3e733f32aa1194366.1606758530.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606758530.git.luto@kernel.org>
References: <cover.1606758530.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sync_core_before_usermode() had an incorrect optimization.  If we're
in an IRQ, we can get to usermode without IRET -- we just have to
schedule to a different task in the same mm and do SYSRET.
Fortunately, there were no callers of sync_core_before_usermode()
that could have had in_irq() or in_nmi() equal to true, because it's
only ever called from the scheduler.

While we're at it, clarify a related comment.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/sync_core.h | 9 +++++----
 arch/x86/mm/tlb.c                | 6 ++++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 0fd4a9dfb29c..ab7382f92aff 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -98,12 +98,13 @@ static inline void sync_core_before_usermode(void)
 	/* With PTI, we unconditionally serialize before running user code. */
 	if (static_cpu_has(X86_FEATURE_PTI))
 		return;
+
 	/*
-	 * Return from interrupt and NMI is done through iret, which is core
-	 * serializing.
+	 * Even if we're in an interrupt, we might reschedule before returning,
+	 * in which case we could switch to a different thread in the same mm
+	 * and return using SYSRET or SYSEXIT.  Instead of trying to keep
+	 * track of our need to sync the core, just sync right away.
 	 */
-	if (in_irq() || in_nmi())
-		return;
 	sync_core();
 }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 11666ba19b62..dabe683ab076 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -474,8 +474,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 	/*
 	 * The membarrier system call requires a full memory barrier and
 	 * core serialization before returning to user-space, after
-	 * storing to rq->curr. Writing to CR3 provides that full
-	 * memory barrier and core serializing instruction.
+	 * storing to rq->curr, when changing mm.  This is because membarrier()
+	 * sends IPIs to all CPUs that are in the target mm, but another
+	 * CPU switch to the target mm in the mean time.  Writing to CR3
+	 * provides that full memory barrier and core serializing instruction.
 	 */
 	if (real_prev == next) {
 		VM_WARN_ON(this_cpu_read(cpu_tlbstate.ctxs[prev_asid].ctx_id) !=
-- 
2.28.0

