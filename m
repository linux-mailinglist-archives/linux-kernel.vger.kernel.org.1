Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38FF021E3B0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 01:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgGMXkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 19:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:51650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGMXj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:39:59 -0400
Received: from localhost.localdomain (unknown [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62D63214DB;
        Mon, 13 Jul 2020 23:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594683599;
        bh=6rrEJJgvghk15CsdApGD/JSMn7IJrqCOSnvwvAKk4cQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qf6HTW4K7qcujZ2v6bi3oLAkoq0TxMt1FVb3f7mG9FioTvcQ6X8XkEjXz7Ls9xdK/
         L5Pa1tLfB8JBCCaNgCR+PeJ1VZApS3oltMlVyX9wGKAVM/GJfstzNNtpbuTGoq0wLJ
         Klv+GnAZ1wh6fyoHrDl0oAzJn8y4EvP1MwSDFVMw=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, oleg@redhat.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, bjorn.topel@gmail.com,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v3 3/7] riscv: Fixup kprobes handler couldn't change pc
Date:   Mon, 13 Jul 2020 23:39:18 +0000
Message-Id: <1594683562-68149-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594683562-68149-1-git-send-email-guoren@kernel.org>
References: <1594683562-68149-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The "Changing Execution Path" section in the Documentation/kprobes.txt
said:

Since kprobes can probe into a running kernel code, it can change the
register set, including instruction pointer.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/mcount-dyn.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 35a6ed7..4b58b54 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -123,6 +123,7 @@ ENDPROC(ftrace_caller)
 	sd	ra, (PT_SIZE_ON_STACK+8)(sp)
 	addi	s0, sp, (PT_SIZE_ON_STACK+16)
 
+	sd ra,  PT_EPC(sp)
 	sd x1,  PT_RA(sp)
 	sd x2,  PT_SP(sp)
 	sd x3,  PT_GP(sp)
@@ -157,6 +158,7 @@ ENDPROC(ftrace_caller)
 	.endm
 
 	.macro RESTORE_ALL
+	ld ra,  PT_EPC(sp)
 	ld x1,  PT_RA(sp)
 	ld x2,  PT_SP(sp)
 	ld x3,  PT_GP(sp)
@@ -190,7 +192,6 @@ ENDPROC(ftrace_caller)
 	ld x31, PT_T6(sp)
 
 	ld	s0, (PT_SIZE_ON_STACK)(sp)
-	ld	ra, (PT_SIZE_ON_STACK+8)(sp)
 	addi	sp, sp, (PT_SIZE_ON_STACK+16)
 	.endm
 
-- 
2.7.4

