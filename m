Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C092E7A02
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 15:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgL3Ok5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 09:40:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:38338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgL3Ok5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 09:40:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D7C3B2220B;
        Wed, 30 Dec 2020 14:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609339216;
        bh=e0+df3C86TgDkLKPUHT/YZ/mJxTl5DbhpY6cE04RF04=;
        h=From:To:Cc:Subject:Date:From;
        b=MjzBvm0aDu1O3mQ7/rE4v7q9zm6Cdcten+cJx8w8Me0821ofQItlRD1X8N7UTla+j
         2lbLJg5h2Pc2ff9ssg6PmQkUzGRbqzlSfLxT/rpCrtaiJ3ivDFDTIrmd76fjxXAWjA
         s4UdM116Lmdl2nPnOWpoy2vYbw5nHj8vvqVrfGmuSwafGojy0rpA+5O8ZqPfSx8WXf
         uk3+boqvlabVdDgb4YprdsJ8ylq/CYUpSF+cHMSt8WAq1qXH2bdC2/SNfiRwJoW6q2
         GXg6RKlzSD3tZ0Q8E3i464fNwQBHxXdLomGQz1EYiGmfJCjLp77s9e+PTzENC6UC6r
         xLN78Svzb15kg==
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] riscv: mm: abort uaccess retries upon fatal signal
Date:   Wed, 30 Dec 2020 14:39:16 +0000
Message-Id: <1609339156-61806-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Pick up the patch from the 'Link' made by Mark Rutland. Keep the
same with x86, arm, arm64, arc, sh, power.

Link: https://lore.kernel.org/linux-arm-kernel/1499782763-31418-1-git-send-email-mark.rutland@arm.com/
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
---
 arch/riscv/mm/fault.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 3c8b9e4..7f5f45b 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -280,8 +280,11 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 	 * signal first. We do not need to release the mmap_lock because it
 	 * would already be released in __lock_page_or_retry in mm/filemap.c.
 	 */
-	if (fault_signal_pending(fault, regs))
+	if (fault_signal_pending(fault, regs)) {
+		if (!user_mode(regs))
+			no_context(regs, addr);
 		return;
+	}
 
 	if (unlikely((fault & VM_FAULT_RETRY) && (flags & FAULT_FLAG_ALLOW_RETRY))) {
 		flags |= FAULT_FLAG_TRIED;
-- 
2.7.4

