Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA952C5F20
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 04:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392390AbgK0D7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 22:59:02 -0500
Received: from mail.loongson.cn ([114.242.206.163]:52520 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389089AbgK0D7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 22:59:02 -0500
Received: from bogon.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxatB6ecBfElAXAA--.37838S2;
        Fri, 27 Nov 2020 11:58:51 +0800 (CST)
From:   Youling Tang <tangyouling@loongson.cn>
To:     Oleg Nesterov <oleg@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: Removes code duplication between arch_ptrace and compat_arch_ptrace
Date:   Fri, 27 Nov 2020 11:58:50 +0800
Message-Id: <1606449530-14319-1-git-send-email-tangyouling@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9AxatB6ecBfElAXAA--.37838S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFy7KFWkWF4UGFy3tF1xAFb_yoWrCF47p3
        yfA39rKF47tr12kF4xZayrZF95ur1xWF9Fy3s5JFnYkr1vgrWFkFnFq3s2qFyakrWkW3s7
        Cr4qk3Z09FsFgrUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8GwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIHGQDUUUU
X-CM-SenderInfo: 5wdqw5prxox03j6o00pqjv00gofq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch removes code duplication between arch_ptrace and
compat_arch_ptrace, in large part by having the former call
into the later for all requests that don't need any special
"compat" treatment.

Signed-off-by: Youling Tang <tangyouling@loongson.cn>
---
 arch/sparc/kernel/ptrace_64.c | 71 +++++++++++--------------------------------
 1 file changed, 17 insertions(+), 54 deletions(-)

diff --git a/arch/sparc/kernel/ptrace_64.c b/arch/sparc/kernel/ptrace_64.c
index 2b92155d..4fd8c33 100644
--- a/arch/sparc/kernel/ptrace_64.c
+++ b/arch/sparc/kernel/ptrace_64.c
@@ -929,78 +929,51 @@ struct compat_fps {
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
-	compat_ulong_t caddr2 = task_pt_regs(current)->u_regs[UREG_I4];
 	struct pt_regs32 __user *pregs;
 	struct compat_fps __user *fps;
-	unsigned long addr2 = caddr2;
 	unsigned long addr = caddr;
 	unsigned long data = cdata;
-	int ret;
 
 	pregs = (struct pt_regs32 __user *) addr;
 	fps = (struct compat_fps __user *) addr;
 
 	switch (request) {
-	case PTRACE_PEEKUSR:
-		ret = (addr != 0) ? -EIO : 0;
-		break;
-
 	case PTRACE_GETREGS:
-		ret = copy_regset_to_user(child, &ptrace32_view,
+		return copy_regset_to_user(child, &ptrace32_view,
 					  REGSET_GENERAL, 0,
 					  19 * sizeof(u32),
 					  pregs);
-		break;
 
 	case PTRACE_SETREGS:
-		ret = copy_regset_from_user(child, &ptrace32_view,
+		return copy_regset_from_user(child, &ptrace32_view,
 					  REGSET_GENERAL, 0,
 					  19 * sizeof(u32),
 					  pregs);
-		break;
 
 	case PTRACE_GETFPREGS:
-		ret = copy_regset_to_user(child, &ptrace32_view,
+		return copy_regset_to_user(child, &ptrace32_view,
 					  REGSET_FP, 0,
 					  68 * sizeof(u32),
 					  fps);
-		break;
 
 	case PTRACE_SETFPREGS:
-		ret = copy_regset_from_user(child, &ptrace32_view,
+		return copy_regset_from_user(child, &ptrace32_view,
 					  REGSET_FP, 0,
 					  33 * sizeof(u32),
 					  fps);
-		break;
 
+	case PTRACE_PEEKUSR:
 	case PTRACE_READTEXT:
 	case PTRACE_READDATA:
-		ret = ptrace_readdata(child, addr,
-				      (char __user *)addr2, data);
-		if (ret == data)
-			ret = 0;
-		else if (ret >= 0)
-			ret = -EIO;
-		break;
-
 	case PTRACE_WRITETEXT:
 	case PTRACE_WRITEDATA:
-		ret = ptrace_writedata(child, (char __user *) addr2,
-				       addr, data);
-		if (ret == data)
-			ret = 0;
-		else if (ret >= 0)
-			ret = -EIO;
-		break;
+		return arch_ptrace(child, request, addr, data);
 
 	default:
 		if (request == PTRACE_SPARC_DETACH)
 			request = PTRACE_DETACH;
-		ret = compat_ptrace_request(child, request, addr, data);
-		break;
+		return compat_ptrace_request(child, request, addr, data);
 	}
-
-	return ret;
 }
 #endif /* CONFIG_COMPAT */
 
@@ -1025,63 +998,53 @@ long arch_ptrace(struct task_struct *child, long request,
 
 	switch (request) {
 	case PTRACE_PEEKUSR:
-		ret = (addr != 0) ? -EIO : 0;
-		break;
+		return ((addr != 0) ? -EIO : 0);
 
 	case PTRACE_GETREGS64:
-		ret = copy_regset_to_user(child, &ptrace64_view,
+		return copy_regset_to_user(child, &ptrace64_view,
 					  REGSET_GENERAL, 0,
 					  19 * sizeof(u64),
 					  pregs);
-		break;
 
 	case PTRACE_SETREGS64:
-		ret = copy_regset_from_user(child, &ptrace64_view,
+		return copy_regset_from_user(child, &ptrace64_view,
 					  REGSET_GENERAL, 0,
 					  19 * sizeof(u64),
 					  pregs);
-		break;
 
 	case PTRACE_GETFPREGS64:
-		ret = copy_regset_to_user(child, view, REGSET_FP,
+		return copy_regset_to_user(child, view, REGSET_FP,
 					  0 * sizeof(u64),
 					  33 * sizeof(u64),
 					  fps);
-		break;
 
 	case PTRACE_SETFPREGS64:
-		ret = copy_regset_from_user(child, view, REGSET_FP,
+		return copy_regset_from_user(child, view, REGSET_FP,
 					  0 * sizeof(u64),
 					  33 * sizeof(u64),
 					  fps);
-		break;
 
 	case PTRACE_READTEXT:
 	case PTRACE_READDATA:
 		ret = ptrace_readdata(child, addr, addr2p, data);
 		if (ret == data)
-			ret = 0;
+			return 0;
 		else if (ret >= 0)
-			ret = -EIO;
-		break;
+			return -EIO;
 
 	case PTRACE_WRITETEXT:
 	case PTRACE_WRITEDATA:
 		ret = ptrace_writedata(child, addr2p, addr, data);
 		if (ret == data)
-			ret = 0;
+			return 0;
 		else if (ret >= 0)
-			ret = -EIO;
-		break;
+			return -EIO;
 
 	default:
 		if (request == PTRACE_SPARC_DETACH)
 			request = PTRACE_DETACH;
-		ret = ptrace_request(child, request, addr, data);
-		break;
+		return ptrace_request(child, request, addr, data);
 	}
-
-	return ret;
 }
 
 asmlinkage int syscall_trace_enter(struct pt_regs *regs)
-- 
2.1.0

