Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2374A2226C4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGPPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728515AbgGPPUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:20:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639D0C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:20:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so11965077wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MA+kP4DlJmfdXBdpErlC9E+irTIJBNObkffFIf2y82I=;
        b=JqIq+nSSgbqT32taOoagK4GvW1IjeH/ECen5VaQpTPssRfgi2K/8DOcl6JBC0QxDeW
         L9hLCUvRYISHnV89d2sJRdD+6c5sxQkufYhP3jxVx68jsxG0TdCDZiP70lmDH+wZdRTC
         FznHjEsKE7OT6A1QXZ5HM+aeuVDeWOUeieYNavx54TIHRGrU3K6MgOS/grSopWEWTAaO
         hlCL5R4TMZFizDEe8gDbVEiz3XHHsc3Q22RNnsXKbadgu4t28iDUBY7TwTIPfdOnEURW
         2jL1tZurcc5gb75TDGPuPCEicPFYNSgzjJ08eexA4pnUfomSRpk/TrpZMqsicqzagoh1
         vmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MA+kP4DlJmfdXBdpErlC9E+irTIJBNObkffFIf2y82I=;
        b=eHh1PdFMw0kAfgnsuQKENUEE/jYkPejVVkK9al3ghOZSgEU9CITL7+i9KjZtc6Tq0O
         a0QprmbDtiaXmKM6pihhPVgDxy7Jj4NpXm/r92d8awzSmKV/MITK4cYQ7Uh+ZVOVmmH0
         DAvER/VINazioskIzs97APR8/XQwpz0wzL9yvPtX9QZBdbvwR77R2+kCYyCICdX6wCW9
         ZcpcaXJR4ZKXbsAxU6Fy+aaPLHlAWuVKQEUvDnR2n6kqlVYUdb0QoI0mB/Tl0bAgO86R
         NLQOkCHSX0YV7PYtLzDE3118Qim+dF3pmeQcKVBdM2bHyfv+eEsNtmThKuAO89RisMC0
         blJA==
X-Gm-Message-State: AOAM531Hyh19/TWmoS92puFJUBCzN8fcrhox50RjcHJ6RwBti/M4lcO6
        D71mDwYWdlbehY1zrY8U4IoBnw==
X-Google-Smtp-Source: ABdhPJwWZzro9ckYK2greM7KjTK8oMd0961HXp/aw47Rj9PySVK21oCV8YKb2OYPEOZ0KHUJkUyCTw==
X-Received: by 2002:a7b:c38c:: with SMTP id s12mr4799097wmj.136.1594912807056;
        Thu, 16 Jul 2020 08:20:07 -0700 (PDT)
Received: from wychelm.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id u17sm9877687wrp.70.2020.07.16.08.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 08:20:06 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v2 2/3] kgdb: Use the kprobe blocklist to limit single stepping
Date:   Thu, 16 Jul 2020 16:19:42 +0100
Message-Id: <20200716151943.2167652-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200716151943.2167652-1-daniel.thompson@linaro.org>
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we are running in a part of the kernel that dislikes breakpoint
debugging then it is very unlikely to be safe to single step. Add
some safety rails to prevent stepping through anything on the kprobe
blocklist.

As part of this kdb_ss() will no longer set the DOING_SS flags when it
requests a step. This is safe because this flag is already redundant,
returning KDB_CMD_SS is all that is needed to request a step (and this
saves us from having to unset the flag if the safety check fails).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/kgdb.h        |  1 +
 kernel/debug/debug_core.c   | 13 +++++++++++++
 kernel/debug/gdbstub.c      | 10 +++++++++-
 kernel/debug/kdb/kdb_bp.c   |  8 ++------
 kernel/debug/kdb/kdb_main.c | 10 ++++++++--
 5 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 7caba4604edc..aefe823998cb 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -214,6 +214,7 @@ extern void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long pc);
 
 /* Optional functions. */
 extern int kgdb_validate_break_address(unsigned long addr);
+extern int kgdb_validate_single_step_address(unsigned long addr);
 extern int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt);
 extern int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt);
 
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 133a361578dc..4b59bcc90c5d 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -208,6 +208,19 @@ int __weak kgdb_validate_break_address(unsigned long addr)
 	return err;
 }
 
+int __weak kgdb_validate_single_step_address(unsigned long addr)
+{
+	/*
+	 * Disallow stepping when we are executing code that is marked
+	 * as unsuitable for breakpointing... stepping won't be safe
+	 * either!
+	 */
+	if (kgdb_within_blocklist(addr))
+		return -EINVAL;
+
+	return 0;
+}
+
 unsigned long __weak kgdb_arch_pc(int exception, struct pt_regs *regs)
 {
 	return instruction_pointer(regs);
diff --git a/kernel/debug/gdbstub.c b/kernel/debug/gdbstub.c
index 61774aec46b4..f1c88007cc2b 100644
--- a/kernel/debug/gdbstub.c
+++ b/kernel/debug/gdbstub.c
@@ -1041,8 +1041,16 @@ int gdb_serial_stub(struct kgdb_state *ks)
 			if (tmp == 0)
 				break;
 			/* Fall through - on tmp < 0 */
-		case 'c': /* Continue packet */
 		case 's': /* Single step packet */
+			error = kgdb_validate_single_step_address(
+					kgdb_arch_pc(ks->ex_vector,
+						     ks->linux_regs));
+			if (error != 0) {
+				error_packet(remcom_out_buffer, error);
+				break;
+			}
+			fallthrough;
+		case 'c': /* Continue packet */
 			if (kgdb_contthread && kgdb_contthread != current) {
 				/* Can't switch threads in kgdb */
 				error_packet(remcom_out_buffer, -EINVAL);
diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index ec4940146612..4853c413f579 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -507,18 +507,14 @@ static int kdb_bc(int argc, const char **argv)
  *	None.
  * Remarks:
  *
- *	Set the arch specific option to trigger a debug trap after the next
- *	instruction.
+ *	KDB_CMD_SS is a command that our caller acts on to effect the step.
  */
 
 static int kdb_ss(int argc, const char **argv)
 {
 	if (argc != 0)
 		return KDB_ARGCOUNT;
-	/*
-	 * Set trace flag and go.
-	 */
-	KDB_STATE_SET(DOING_SS);
+
 	return KDB_CMD_SS;
 }
 
diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 5c7949061671..cd40bf780b93 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1189,7 +1189,7 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		     kdb_dbtrap_t db_result)
 {
 	char *cmdbuf;
-	int diag;
+	int diag, res;
 	struct task_struct *kdb_current =
 		kdb_curr_task(raw_smp_processor_id());
 
@@ -1346,10 +1346,16 @@ static int kdb_local(kdb_reason_t reason, int error, struct pt_regs *regs,
 		}
 		if (diag == KDB_CMD_GO
 		 || diag == KDB_CMD_CPU
-		 || diag == KDB_CMD_SS
 		 || diag == KDB_CMD_KGDB)
 			break;
 
+		if (diag == KDB_CMD_SS) {
+			res = kgdb_validate_single_step_address(instruction_pointer(regs));
+			if (res == 0)
+				break;
+			diag = res;
+		}
+
 		if (diag)
 			kdb_cmderror(diag);
 	}
-- 
2.25.4

