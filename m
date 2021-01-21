Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509662FE382
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbhAUHKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:10:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbhAUHAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:00:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59737239ED;
        Thu, 21 Jan 2021 06:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212261;
        bh=XovlzmUsIAz9wxP3jozqCwwmw2ckkB7WIL7vTczeqFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pktTEqlF+c5hpufKGsAYQCaJxibt3sPuv+ePr3YKUy2qBQPlFj8FBy5wIOjuY7eME
         PmqNLfGSURlYmIaohZwOWst40aTUp+Yms0O6248kvwBQxq/XnhNHGozAVmW85ZXXTt
         /TXv0QN6MWmBynZXt/X/EQ8bMlfdhPCwqfvqZiGX2aRcbsoayamsMWjEbaUtlPaxFA
         sLXmU+HB02VmVJ/gYkLwavQzwiO3tUszuPbNGCNpgrTXmsY8NuITK6HbKDHrUcp3l4
         Tkhmh1kUINzgYIUJjFCw8GFHTarHRbqLR/G7xvPd+n8LA6WjxURPtOwyptiPaGEt0C
         dHdLI6/on+w5Q==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Menglong Dong <dong.menglong@zte.com.cn>
Subject: [PATCH 26/29] csky: kprobe: fix code in simulate without 'long'
Date:   Thu, 21 Jan 2021 14:53:46 +0800
Message-Id: <20210121065349.3188251-26-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The type of 'val' is 'unsigned long' in simulate_blz32, so 'val < 0'
can't be true.

Cast 'val' to 'long' here to determine branch token or not,

Fixup instructions: bnezad32, bhsz32, bhz32, blsz32, blz32

Link: https://lore.kernel.org/linux-csky/CAJF2gTQjKXR9gpo06WAWG1aquiT87mATiMGorXs6ChxOxoe90Q@mail.gmail.com/T/#t
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Menglong Dong <dong.menglong@zte.com.cn>
Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 arch/csky/kernel/probes/simulate-insn.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/csky/kernel/probes/simulate-insn.c b/arch/csky/kernel/probes/simulate-insn.c
index 4e464fed52ec..d6e8d092c9b7 100644
--- a/arch/csky/kernel/probes/simulate-insn.c
+++ b/arch/csky/kernel/probes/simulate-insn.c
@@ -274,9 +274,9 @@ void __kprobes
 simulate_bnezad32(u32 opcode, long addr, struct pt_regs *regs)
 {
 	unsigned long tmp = opcode & 0x1f;
-	unsigned long val;
+	long val;
 
-	csky_insn_reg_get_val(regs, tmp, &val);
+	csky_insn_reg_get_val(regs, tmp, (unsigned long *)&val);
 
 	val -= 1;
 
@@ -286,7 +286,7 @@ simulate_bnezad32(u32 opcode, long addr, struct pt_regs *regs)
 	} else
 		instruction_pointer_set(regs, addr + 4);
 
-	csky_insn_reg_set_val(regs, tmp, val);
+	csky_insn_reg_set_val(regs, tmp, (unsigned long)val);
 }
 
 void __kprobes
@@ -297,13 +297,11 @@ simulate_bhsz32(u32 opcode, long addr, struct pt_regs *regs)
 
 	csky_insn_reg_get_val(regs, tmp, &val);
 
-	if (val >= 0) {
+	if ((long) val >= 0) {
 		instruction_pointer_set(regs,
 			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
 	} else
 		instruction_pointer_set(regs, addr + 4);
-
-	csky_insn_reg_set_val(regs, tmp, val);
 }
 
 void __kprobes
@@ -314,13 +312,11 @@ simulate_bhz32(u32 opcode, long addr, struct pt_regs *regs)
 
 	csky_insn_reg_get_val(regs, tmp, &val);
 
-	if (val > 0) {
+	if ((long) val > 0) {
 		instruction_pointer_set(regs,
 			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
 	} else
 		instruction_pointer_set(regs, addr + 4);
-
-	csky_insn_reg_set_val(regs, tmp, val);
 }
 
 void __kprobes
@@ -331,13 +327,11 @@ simulate_blsz32(u32 opcode, long addr, struct pt_regs *regs)
 
 	csky_insn_reg_get_val(regs, tmp, &val);
 
-	if (val <= 0) {
+	if ((long) val <= 0) {
 		instruction_pointer_set(regs,
 			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
 	} else
 		instruction_pointer_set(regs, addr + 4);
-
-	csky_insn_reg_set_val(regs, tmp, val);
 }
 
 void __kprobes
@@ -348,13 +342,11 @@ simulate_blz32(u32 opcode, long addr, struct pt_regs *regs)
 
 	csky_insn_reg_get_val(regs, tmp, &val);
 
-	if (val < 0) {
+	if ((long) val < 0) {
 		instruction_pointer_set(regs,
 			addr + sign_extend32((opcode & 0xffff0000) >> 15, 15));
 	} else
 		instruction_pointer_set(regs, addr + 4);
-
-	csky_insn_reg_set_val(regs, tmp, val);
 }
 
 void __kprobes
-- 
2.17.1

