Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B64C2FC311
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbhASWLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729778AbhASWIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:08:54 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95D3C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:08:13 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id s15so11337958plr.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtvWiGPK2eweAPRjtJhZb7309sm3REWVBB+tfD69F30=;
        b=UUp1Z0eBKhUHBfdI83AvJ0436gY4K8mRwO4+iCyC1cdjEpBkDz0fEtQqNWLOo1RLyJ
         edyTCAwWw1jmaG8rElV8Jo6kHnmFMkjpiXb+Hy4vZDXwlm9AruyVqDrLFb0fP8m/5noE
         rnyw0qvkd9sRrRwzR3Xl6IMRkMfCqyK8PR+K8rnQ560jK0NU8P3pTkzqluJpu88YVx3d
         7uIts3SNc/HOqQRQlIYYWnVAvdfgM7lrI+LLjj/k9CKE8kUMX6wvO/LTS1NSqaFGCI2B
         iDEZWwZmRPt541vMUH7DyH5z+MWOJwQBIxaiwrBHvzJf/9Tyie4AOlRKGYobM6PBZAXz
         3+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtvWiGPK2eweAPRjtJhZb7309sm3REWVBB+tfD69F30=;
        b=dFz2elcOpfTwzmnWp60AnbB28X9Y+yDt7zY2AfBg8iK32Nfa/2LFMKEo00sDHdYzl2
         MAT5Vo3NIOsbuIFMqYr7Ag/gph+C/A0z0GvQBZS1SD9dimiYAMHgw8ZG2NzgHHAViDyQ
         Octl3F+SQPOW2uAby0VDxy0x98ZYXGC0iYIgJIWz3KO8mwNdDH6fw3dZCvlbmatS117O
         KBcZTSv5aYGzFowicbkQzQ+mdTleW0P9JMX5meVwHc4YLJsXITIE49rfE8y/S5m8zpFK
         M3dKfgCPV0ucDv49Sz2cO84JP+H23Il8JRK/KWMpMAHKK2ms5POvPJNsIN6LjFOt8vTV
         iCfA==
X-Gm-Message-State: AOAM530xPcMm3es+JknyRZCJJwIzaASr70We8UEnQaF02aIvngqqH0vA
        wotH9jMW/22H6AynpXu/2PHgENE7HWOpKQ==
X-Google-Smtp-Source: ABdhPJwVEJjtlAzTiLDNsWz7WVQ+ZoNp8rnM4n36DrBPJbku6zgklznseRI6dyryA7b5X3MK2hJnZg==
X-Received: by 2002:a17:902:d48a:b029:de:ae4d:2c7b with SMTP id c10-20020a170902d48ab02900deae4d2c7bmr6838343plg.62.1611094093364;
        Tue, 19 Jan 2021 14:08:13 -0800 (PST)
Received: from laptop.hsd1.wa.comcast.net ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id 72sm95196pfw.170.2021.01.19.14.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 14:08:12 -0800 (PST)
From:   Andrei Vagin <avagin@gmail.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 1/3] arm64/ptrace: don't clobber task registers on syscall entry/exit traps
Date:   Tue, 19 Jan 2021 14:06:35 -0800
Message-Id: <20210119220637.494476-2-avagin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119220637.494476-1-avagin@gmail.com>
References: <20210119220637.494476-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ip/r12 for AArch32 and x7 for AArch64 is used to indicate whether or not
the stop has been signalled from syscall entry or syscall exit. This
means that:

- Any writes by the tracer to this register during the stop are
  ignored/discarded.

- The actual value of the register is not available during the stop,
  so the tracer cannot save it and restore it later.

Right now, these registers are clobbered in tracehook_report_syscall.
This change moves this logic to gpr_get and compat_gpr_get where
registers are copied into a user-space buffer.

This will allow to change these registers and to introduce a new
NT_ARM_PRSTATUS command to get the full set of registers.

Signed-off-by: Andrei Vagin <avagin@gmail.com>
---
 arch/arm64/include/asm/ptrace.h |   5 ++
 arch/arm64/kernel/ptrace.c      | 104 +++++++++++++++++++-------------
 2 files changed, 67 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index e58bca832dff..0a9552b4f61e 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -170,6 +170,11 @@ static inline unsigned long pstate_to_compat_psr(const unsigned long pstate)
 	return psr;
 }
 
+enum ptrace_syscall_dir {
+	PTRACE_SYSCALL_ENTER = 0,
+	PTRACE_SYSCALL_EXIT,
+};
+
 /*
  * This struct defines the way the registers are stored on the stack during an
  * exception. Note that sizeof(struct pt_regs) has to be a multiple of 16 (for
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 8ac487c84e37..1863f080cb07 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -40,6 +40,7 @@
 #include <asm/syscall.h>
 #include <asm/traps.h>
 #include <asm/system_misc.h>
+#include <asm/ptrace.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -561,7 +562,33 @@ static int gpr_get(struct task_struct *target,
 		   struct membuf to)
 {
 	struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
-	return membuf_write(&to, uregs, sizeof(*uregs));
+	unsigned long saved_reg;
+	int ret;
+
+	/*
+	 * We have some ABI weirdness here in the way that we handle syscall
+	 * exit stops because we indicate whether or not the stop has been
+	 * signalled from syscall entry or syscall exit by clobbering the general
+	 * purpose register x7.
+	 */
+	switch (target->ptrace_message) {
+	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+		saved_reg = uregs->regs[7];
+		uregs->regs[7] = PTRACE_SYSCALL_ENTER;
+		break;
+	case PTRACE_EVENTMSG_SYSCALL_EXIT:
+		saved_reg = uregs->regs[7];
+		uregs->regs[7] = PTRACE_SYSCALL_EXIT;
+		break;
+	}
+
+	ret =  membuf_write(&to, uregs, sizeof(*uregs));
+
+	if (target->ptrace_message == PTRACE_EVENTMSG_SYSCALL_ENTRY ||
+	    target->ptrace_message == PTRACE_EVENTMSG_SYSCALL_EXIT)
+		uregs->regs[7] = saved_reg;
+
+	return ret;
 }
 
 static int gpr_set(struct task_struct *target, const struct user_regset *regset,
@@ -1221,10 +1248,40 @@ static int compat_gpr_get(struct task_struct *target,
 			  const struct user_regset *regset,
 			  struct membuf to)
 {
+	compat_ulong_t r12;
+	bool overwrite_r12;
 	int i = 0;
 
-	while (to.left)
-		membuf_store(&to, compat_get_user_reg(target, i++));
+	/*
+	 * We have some ABI weirdness here in the way that we handle syscall
+	 * exit stops because we indicate whether or not the stop has been
+	 * signalled from syscall entry or syscall exit by clobbering the
+	 * general purpose register r12.
+	 */
+	switch (target->ptrace_message) {
+	case PTRACE_EVENTMSG_SYSCALL_ENTRY:
+		r12 = PTRACE_SYSCALL_ENTER;
+		overwrite_r12 = true;
+		break;
+	case PTRACE_EVENTMSG_SYSCALL_EXIT:
+		r12 = PTRACE_SYSCALL_EXIT;
+		overwrite_r12 = true;
+		break;
+	default:
+		overwrite_r12 = false;
+		break;
+	}
+
+	while (to.left) {
+		compat_ulong_t val;
+
+		if (!overwrite_r12 || i != 12)
+			val = compat_get_user_reg(target, i++);
+		else
+			val = r12;
+		membuf_store(&to, val);
+	}
+
 	return 0;
 }
 
@@ -1740,53 +1797,16 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ptrace_request(child, request, addr, data);
 }
 
-enum ptrace_syscall_dir {
-	PTRACE_SYSCALL_ENTER = 0,
-	PTRACE_SYSCALL_EXIT,
-};
-
 static void tracehook_report_syscall(struct pt_regs *regs,
 				     enum ptrace_syscall_dir dir)
 {
-	int regno;
-	unsigned long saved_reg;
-
-	/*
-	 * We have some ABI weirdness here in the way that we handle syscall
-	 * exit stops because we indicate whether or not the stop has been
-	 * signalled from syscall entry or syscall exit by clobbering a general
-	 * purpose register (ip/r12 for AArch32, x7 for AArch64) in the tracee
-	 * and restoring its old value after the stop. This means that:
-	 *
-	 * - Any writes by the tracer to this register during the stop are
-	 *   ignored/discarded.
-	 *
-	 * - The actual value of the register is not available during the stop,
-	 *   so the tracer cannot save it and restore it later.
-	 *
-	 * - Syscall stops behave differently to seccomp and pseudo-step traps
-	 *   (the latter do not nobble any registers).
-	 */
-	regno = (is_compat_task() ? 12 : 7);
-	saved_reg = regs->regs[regno];
-	regs->regs[regno] = dir;
-
 	if (dir == PTRACE_SYSCALL_ENTER) {
 		if (tracehook_report_syscall_entry(regs))
 			forget_syscall(regs);
-		regs->regs[regno] = saved_reg;
-	} else if (!test_thread_flag(TIF_SINGLESTEP)) {
-		tracehook_report_syscall_exit(regs, 0);
-		regs->regs[regno] = saved_reg;
 	} else {
-		regs->regs[regno] = saved_reg;
+		int singlestep = test_thread_flag(TIF_SINGLESTEP);
 
-		/*
-		 * Signal a pseudo-step exception since we are stepping but
-		 * tracer modifications to the registers may have rewound the
-		 * state machine.
-		 */
-		tracehook_report_syscall_exit(regs, 1);
+		tracehook_report_syscall_exit(regs, singlestep);
 	}
 }
 
-- 
2.29.2

