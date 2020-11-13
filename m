Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106A42B1C01
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgKMNnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:43:01 -0500
Received: from m12-17.163.com ([220.181.12.17]:57437 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMNm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=/Hkhw
        iehHWTIOvKGRFyC1GrNVM86ARLGrmZrk6V1Ags=; b=PDO/XA5Uc8d+6nWU0QAQA
        9CwaKebWN2qS4weJ3eYXYJrKOhTJ2FS9V9kgGGELXeMqLy9mP9PoX5DNtJ9Z0onM
        u/kPE5MjKxcXMPA8p+wsun6wLbbE4BPAXEdElG8kofoqJiaitTDnKJ22LjwnWXCy
        tGKC8BweTUjvZsfo8nKUPs=
Received: from localhost (unknown [101.86.208.122])
        by smtp13 (Coremail) with SMTP id EcCowABH_RGfjK5ffHWNTg--.46759S2;
        Fri, 13 Nov 2020 21:39:43 +0800 (CST)
Date:   Fri, 13 Nov 2020 21:39:43 +0800
From:   Hui Su <sh_def@163.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, 0x7f454c46@gmail.com, jroedel@suse.de,
        akpm@linux-foundation.org, pmladek@suse.com, jannh@google.com,
        mark.mossberg@gmail.com, linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] x86/dumpstack: make show_trace_log_lvl() static
Message-ID: <20201113133943.GA136221@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowABH_RGfjK5ffHWNTg--.46759S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW8Xr1fZr4rZw15ZFWfuFg_yoW8Xr4UpF
        ZxA3Z7KFs8WasY934DZr4kur9xArsYk34qkrs7Aw1YyF15tFy8JFnrJ3Wjvr15J3s7Wa43
        KFZ09rn8JFs8Xa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U3gA7UUUUU=
X-Originating-IP: [101.86.208.122]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbByx7bX1PAPqNSIAABss
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_trace_log_lvl() won't be used by other files, so
make it static and remove the declaration from the header
file.

Signed-off-by: Hui Su <sh_def@163.com>
---
 arch/x86/include/asm/stacktrace.h | 3 ---
 arch/x86/kernel/dumpstack.c       | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 49600643faba..f248eb2ac2d4 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -88,9 +88,6 @@ get_stack_pointer(struct task_struct *task, struct pt_regs *regs)
 	return (unsigned long *)task->thread.sp;
 }
 
-void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, const char *log_lvl);
-
 /* The form of the top of the frame on the stack */
 struct stack_frame {
 	struct stack_frame *next_frame;
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 25c06b67e7e0..067de0d0fa4f 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -168,7 +168,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 	}
 }
 
-void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
+static void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 			unsigned long *stack, const char *log_lvl)
 {
 	struct unwind_state state;
-- 
2.29.0


