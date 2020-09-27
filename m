Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6AB27A43D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgI0VQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgI0VQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:16:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100B1C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:16:18 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v12so4938391wmh.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+Ii1nMTxqQ3KB5diZSPJLBE7AzX1vOzJWQZljPq00k=;
        b=IzRe0iLcxGVxSWG941aMsPrFaGDAlhFd/0DWKmNS7I3+k9Rs8UszLqf+776SaffdkQ
         iw8OT30UVGAn4LNed6pEQ18id6nyCzVVhe0MGBnPpbUFH5LyDb6nZi6qX0Zp+XTFBv3k
         pTlcZFBfouoLSmyfldSWnGJIXWszAxX3W9VxhfdjwHqAiPX/NOBwgOE0ZiOBaRfRK31v
         JSHtqJ0NsNUS4GOCiXkcOOLuDUGEe1DSRdbhjxsD6FqoqhOHqYaX94MepxMpRD32J8Hc
         sew+85FHUwqbGlAnZLy59HlBvg1ci53RzlzkZvuBhtyomo+bu9hOmtIblasPwvfuMnDG
         r3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+Ii1nMTxqQ3KB5diZSPJLBE7AzX1vOzJWQZljPq00k=;
        b=ajdjvUg7G3fs8kMkstScALwv40RhjCYDEmBMiYUpsjNhfCVcRFRYnv2gb/4dclAPpE
         DgY8MjWunyaTE2UeZBUGCHbC5en0BcyqJ8+df0qjxFKOmWhxV+bMFWT7/PQ8PMpj24/Z
         rHXeGlYB2cpdgICOWxzrcuZBS5iWu86EtS9gLpPjB4rNuAXXej+23z4aenTKS0YRcNVm
         7Bvy/gAcBy94dKsRfdoEw66+p+eBHGos9jAzLyZQzFXAVbxoXy/5ue2k7cJtd13UXwte
         cxly8n3WakrUq8N31uaYafKoicXof2agn3Ioangsaz43VIgSDPeaT3ZnLzn1Ei1tBIgd
         uLzw==
X-Gm-Message-State: AOAM532qCvQd7rSMxW23XMi3CXodVfdJbdjEw8rg5J97zD+rJd3SO193
        wXnO+LQNNA0+rqq5sEYVnV8HSw==
X-Google-Smtp-Source: ABdhPJwi5Uve1dX5mSII74NP7BohO0vivBIUiywg2rM9zTvrjEX3Q5fG1U53TK3YqXK9dTZdIaQk+A==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr8161345wmk.167.1601241376739;
        Sun, 27 Sep 2020 14:16:16 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s17sm11396676wrr.40.2020.09.27.14.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 14:16:16 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 2/3] kgdb: Add NOKPROBE labels on the trap handler functions
Date:   Sun, 27 Sep 2020 22:15:30 +0100
Message-Id: <20200927211531.1380577-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200927211531.1380577-1-daniel.thompson@linaro.org>
References: <20200927211531.1380577-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kgdb honours the kprobe blocklist but doesn't place its own
trap handling code on the list. Add labels to discourage attempting to
use kgdb to debug itself.

Not every functions that executes from the trap handler needs to be
marked up: relatively early in the trap handler execution (just after
we bring the other CPUs to a halt) all breakpoints are replaced with
the original opcodes. This patch marks up code in the debug_core that
executes between trap entry and the breakpoints being deactivated
and, also, code that executes between breakpoint activation and trap
exit.

To be clear these changes are not sufficient to make recursive trapping
impossible since cover all the library calls made during kgdb's
entry/exit logic. However going much further whilst we are sharing the
kprobe blocklist risks reducing the capabilities of kprobe and this
would be a bad trade off (especially so given kgdb's users are currently
conditioned to avoid recursive traps).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/debug_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b1277728a835..faa1f99ce65a 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -177,12 +177,14 @@ int __weak kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 				 arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE);
 	return err;
 }
+NOKPROBE_SYMBOL(kgdb_arch_set_breakpoint);
 
 int __weak kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 {
 	return copy_to_kernel_nofault((char *)bpt->bpt_addr,
 				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
 }
+NOKPROBE_SYMBOL(kgdb_arch_remove_breakpoint);
 
 int __weak kgdb_validate_break_address(unsigned long addr)
 {
@@ -212,6 +214,7 @@ unsigned long __weak kgdb_arch_pc(int exception, struct pt_regs *regs)
 {
 	return instruction_pointer(regs);
 }
+NOKPROBE_SYMBOL(kgdb_arch_pc);
 
 int __weak kgdb_arch_init(void)
 {
@@ -222,6 +225,7 @@ int __weak kgdb_skipexception(int exception, struct pt_regs *regs)
 {
 	return 0;
 }
+NOKPROBE_SYMBOL(kgdb_skipexception);
 
 #ifdef CONFIG_SMP
 
@@ -243,6 +247,7 @@ void __weak kgdb_call_nmi_hook(void *ignored)
 	 */
 	kgdb_nmicallback(raw_smp_processor_id(), get_irq_regs());
 }
+NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
 
 void __weak kgdb_roundup_cpus(void)
 {
@@ -276,6 +281,7 @@ void __weak kgdb_roundup_cpus(void)
 			kgdb_info[cpu].rounding_up = false;
 	}
 }
+NOKPROBE_SYMBOL(kgdb_roundup_cpus);
 
 #endif
 
@@ -302,6 +308,7 @@ static void kgdb_flush_swbreak_addr(unsigned long addr)
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
+NOKPROBE_SYMBOL(kgdb_flush_swbreak_addr);
 
 /*
  * SW breakpoint management:
@@ -329,6 +336,7 @@ int dbg_activate_sw_breakpoints(void)
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(dbg_activate_sw_breakpoints);
 
 int dbg_set_sw_break(unsigned long addr)
 {
@@ -392,6 +400,7 @@ int dbg_deactivate_sw_breakpoints(void)
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(dbg_deactivate_sw_breakpoints);
 
 int dbg_remove_sw_break(unsigned long addr)
 {
@@ -513,6 +522,7 @@ static int kgdb_io_ready(int print_wait)
 	}
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_io_ready);
 
 static int kgdb_reenter_check(struct kgdb_state *ks)
 {
@@ -560,6 +570,7 @@ static int kgdb_reenter_check(struct kgdb_state *ks)
 
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_reenter_check);
 
 static void dbg_touch_watchdogs(void)
 {
@@ -567,6 +578,7 @@ static void dbg_touch_watchdogs(void)
 	clocksource_touch_watchdog();
 	rcu_cpu_stall_reset();
 }
+NOKPROBE_SYMBOL(dbg_touch_watchdogs);
 
 static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 		int exception_state)
@@ -798,6 +810,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 
 	return kgdb_info[cpu].ret_state;
 }
+NOKPROBE_SYMBOL(kgdb_cpu_enter);
 
 /*
  * kgdb_handle_exception() - main entry point from a kernel exception
@@ -842,6 +855,7 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 		arch_kgdb_ops.enable_nmi(1);
 	return ret;
 }
+NOKPROBE_SYMBOL(kgdb_handle_exception);
 
 /*
  * GDB places a breakpoint at this function to know dynamically loaded objects.
@@ -876,6 +890,7 @@ int kgdb_nmicallback(int cpu, void *regs)
 #endif
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_nmicallback);
 
 int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 							atomic_t *send_ready)
@@ -901,6 +916,7 @@ int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 #endif
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_nmicallin);
 
 static void kgdb_console_write(struct console *co, const char *s,
    unsigned count)
-- 
2.25.4

