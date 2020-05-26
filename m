Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 844561AF4C5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 22:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgDRUVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 16:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728594AbgDRUUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9A1C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id h2so6498000wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0hGtdK3JrdnMyoUvP1gC+Grwoug48ALKcbxaEUsQIE=;
        b=Pv3rC6H4x3A8q5RHtoxElTNGdC/uhCFTELsCSgGPhuXOc0l5j1BWhMNn09uNPwmbRC
         r/CsIIaXmK9oacprnfMDBuP4GRLKWj5aUdWY7TMaAU7ORTWk1LBA1PMY1g1bAkvsdSlS
         yOdKpMGKu+QT3CtHyOtkLxRugBaCAKPJ0l+mxokVBwg5hgnt6titkNtkQGiHzkzUO2Fw
         zV85N0GhP22ZGVLQwyq6XWS3PZlTEALJgVke5zQoxCS1e3fGF5FWseRzEd5SEWcdtaPq
         +ZTebMwO86kOBHEbQNgcZLR5V33f0d0SQi6HX6urd8DTQk6GJej7ZA3TJuQYiwPb3mWl
         ITAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0hGtdK3JrdnMyoUvP1gC+Grwoug48ALKcbxaEUsQIE=;
        b=X8KhEbgsFK03h7EGjuKNUYdEJquvpWNO2jqSgqRlK5VA/wiT/gTRh+LbEiTllgh9EQ
         0Id7LaSl66bDrM3X46NCAI/1SVCxiuHggWC3tnCNpS29BtxtkhBatK2MZZRwcS3ZP88Z
         +np7ogSsLVnI2CV5DuZBxIyT1OloEALmHtX2cl0wNQ+HFXtQv5WKWGuUak5hUM+Z5CDV
         rmTv+7e7fmZAVJ4wb0pUQxZI1p7yGKzQkkPhVI0f/CMfEXvQgDx5Wmdec8MV80xWyBap
         kOPQpQRQNgHKUDIDozqabwb+bDdGxV4lKSW0xzWimtIsDtB8cOLwltlLhwuLgzCql32o
         LbUA==
X-Gm-Message-State: AGi0PuYuHcHeVJfG0qcTG4WppT5PomrCp7hsaXnY5M2gYiXE9+aI7djI
        3cA3zpVcdtirxbnRnFqPU9Y1T8415y8=
X-Google-Smtp-Source: APiQypKMBwCTm+D9pmP1o8VKh4auNh59UytJtzmJcv9QjWZk2lgfCdJh7+0nmB8t7VyIqa5+dKGrog==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr9338218wmi.178.1587241241781;
        Sat, 18 Apr 2020 13:20:41 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:41 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCHv3 38/50] unicore32: Add loglvl to c_backtrace()
Date:   Sat, 18 Apr 2020 21:19:32 +0100
Message-Id: <20200418201944.482088-39-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Add log level parameter to c_backtrace() as a preparation for
introducing show_stack_loglvl()

Cc: Guan Xuetao <gxt@pku.edu.cn>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/unicore32/kernel/setup.h  |  2 +-
 arch/unicore32/kernel/traps.c  |  2 +-
 arch/unicore32/lib/backtrace.S | 24 ++++++++++++++++--------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/unicore32/kernel/setup.h b/arch/unicore32/kernel/setup.h
index 03e70e37f472..967352323185 100644
--- a/arch/unicore32/kernel/setup.h
+++ b/arch/unicore32/kernel/setup.h
@@ -29,7 +29,7 @@ extern void kernel_thread_helper(void);
 extern void __init early_signal_init(void);
 
 extern asmlinkage void __backtrace(void);
-extern asmlinkage void c_backtrace(unsigned long fp);
+extern asmlinkage void c_backtrace(unsigned long fp, const char *loglvl);
 
 extern void __show_regs(struct pt_regs *);
 
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index 3682a4c5d927..2b7d73456865 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -163,7 +163,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	printk("\n");
 
 	if (ok)
-		c_backtrace(fp);
+		c_backtrace(fp, KERN_DEFAULT);
 }
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
diff --git a/arch/unicore32/lib/backtrace.S b/arch/unicore32/lib/backtrace.S
index f303671e2a4e..6221944b81f3 100644
--- a/arch/unicore32/lib/backtrace.S
+++ b/arch/unicore32/lib/backtrace.S
@@ -16,6 +16,7 @@
 #define sv_fp	v5
 #define sv_pc	v6
 #define offset	v8
+#define loglvl	v9
 
 ENTRY(__backtrace)
 		mov	r0, fp
@@ -27,10 +28,11 @@ ENTRY(c_backtrace)
 ENDPROC(__backtrace)
 ENDPROC(c_backtrace)
 #else
-		stm.w	(v4 - v8, lr), [sp-]	@ Save an extra register
+		stm.w	(v4 - v10, lr), [sp-]	@ Save an extra register
 						@ so we have a location...
 		mov.a	frame, r0		@ if frame pointer is zero
 		beq	no_frame		@ we have no stack frames
+		mov	loglvl, r1
 
 1:		stm.w	(pc), [sp-]		@ calculate offset of PC stored
 		ldw.w	r0, [sp]+, #4		@ by stmfd for this CPU
@@ -95,9 +97,10 @@ for_each_frame:
 		bua	for_each_frame
 
 1006:		adr	r0, .Lbad
-		mov	r1, frame
+		mov	r1, loglvl
+		mov	r2, frame
 		b.l	printk
-no_frame:	ldm.w	(v4 - v8, pc), [sp]+
+no_frame:	ldm.w	(v4 - v10, pc), [sp]+
 ENDPROC(__backtrace)
 ENDPROC(c_backtrace)
 
@@ -128,8 +131,11 @@ ENDPROC(c_backtrace)
 		add	v7, v7, #1
 		cxor.a	v7, #6
 		cmoveq	v7, #1
-		cmoveq	r1, #'\n'
-		cmovne	r1, #' '
+		bne	201f
+		adr	r0, .Lcr
+		mov	r1, loglvl
+		b.l	printk
+201:
 		ldw.w	r3, [stack]+, #-4
 		mov	r2, reg
 		csub.a	r2, #8
@@ -141,18 +147,20 @@ ENDPROC(c_backtrace)
 		add	r2, r2, #0x10		@ so r2 need add 16
 201:
 		adr	r0, .Lfp
+		mov	r1, loglvl
 		b.l	printk
 2:		sub.a	reg, reg, #1
 		bns	1b
 		cxor.a	v7, #0
 		beq	201f
 		adr	r0, .Lcr
+		mov	r1, loglvl
 		b.l	printk
 201:		ldm.w	(instr, reg, stack, v7, pc), [sp]+
 
-.Lfp:		.asciz	"%cr%d:%08x"
-.Lcr:		.asciz	"\n"
-.Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
+.Lfp:		.asciz	"%sr%d:%08x "
+.Lcr:		.asciz	"%s\n"
+.Lbad:		.asciz	"%sBacktrace aborted due to bad frame pointer <%p>\n"
 		.align
 .Ldsi:		.word	0x92eec000 >> 14	@ stm.w sp, (... fp, ip, lr, pc)
 		.word	0x92e10000 >> 14	@ stm.w sp, ()
-- 
2.26.0

