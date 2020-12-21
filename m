Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA62E02A8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 23:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgLUWwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 17:52:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:54190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgLUWwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 17:52:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5B586AC63;
        Mon, 21 Dec 2020 22:52:01 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     linux-riscv@lists.infradead.org
Subject: [PATCH] riscv: return -ENOSYS for syscall -1
CC:     linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
X-Yow:  How do I get HOME?
Date:   Mon, 21 Dec 2020 23:52:00 +0100
Message-ID: <mvma6u6vkkv.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Properly return -ENOSYS for syscall -1 instead of leaving the return value
uninitialized.  This fixes the strace teststuite.

Fixes: 5340627e3fe0 ("riscv: add support for SECCOMP and SECCOMP_FILTER")
Signed-off-by: Andreas Schwab <schwab@suse.de>
---
 arch/riscv/kernel/entry.S | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 524d918f3601..d07763001eb0 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -186,14 +186,7 @@ check_syscall_nr:
 	 * Syscall number held in a7.
 	 * If syscall number is above allowed value, redirect to ni_syscall.
 	 */
-	bge a7, t0, 1f
-	/*
-	 * Check if syscall is rejected by tracer, i.e., a7 == -1.
-	 * If yes, we pretend it was executed.
-	 */
-	li t1, -1
-	beq a7, t1, ret_from_syscall_rejected
-	blt a7, t1, 1f
+	bgeu a7, t0, 1f
 	/* Call syscall */
 	la s0, sys_call_table
 	slli t0, a7, RISCV_LGPTR
-- 
2.29.0


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
