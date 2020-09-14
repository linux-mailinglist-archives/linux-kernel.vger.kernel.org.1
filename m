Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE02268BCA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgINNI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgINNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:02:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5AC06178A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:02:05 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so18612802wrm.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NBc+524mNMySIXGyBF0ZKFskAXcAly2eLLkxj4mn+0Q=;
        b=wW//ZSe6q99e6l33yqQ0bv9yrvassnq7qwZRgFmB3tl5KWNCuLqKteAKnwijt+a7M4
         RSOJCituZMcaXRkqRQ+SRT6J4ASyMHxdQFmS0L5pfONjKlLWGM+zXRYRhQT/7Vn9Xkxw
         1aIZa7RfhcW39YkRlDXTFvXugx0sEaAKqJGvaN+UVce/RUL+FahnGAm2Iyop8CYrrqZx
         bk8iZ5tUfH+ksOynOz+ZqTp7aa8Qm5MMTOSsq09VpPAI9wOpC0jz6sSRG45t+kGtsJCE
         mVNE6KEkrQTEeNSJRDmweR9U7pDvTGTCHcKTdrLTfkkmuyrlKyYey17h6QfKd1CDKBcW
         H4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NBc+524mNMySIXGyBF0ZKFskAXcAly2eLLkxj4mn+0Q=;
        b=eAxFyr2ZYaEXfc/ANL+4TLNEC+iOv1XpaJGZiOKDyQXpPADB73qKE4G9v4phNiPjop
         q3lqXCJTZTTYIsB3O1i2Ks9l1ULo9QAhXPm/rWjO1/L1a7jWGePAEHaiHfo1IWeM3rc5
         24FyYJ+wrSigIFI87gYASApcmkIKdjGVj76pYNxkPYCQn8diKUA4BMQsEqeKTdzxSdS9
         VPGboksscxG653RhUTDQ7vfOcq6ty2HWazcxeqIZu75AzSqHiC65FHRM3Z5dPKhagfOc
         Jk4NRFYQf4a1hZpNVOjPbS4zVW2bC9xcAGJp3IDC7MF6GConAXm8Yv7tJAU9vWW3tHV0
         7Ing==
X-Gm-Message-State: AOAM532HkcIMdMcy6NiWe1fqpwYZT5TB88BNJtEFPcb/Pap6FiyfFpEo
        esQ+w2wAURRf1J8VLHIqGmnt7A==
X-Google-Smtp-Source: ABdhPJx0l/sd/ukowq4I6JNlM0FlvEF8p/b6PwzlqUyLsn2dcKfjzKGIpoDUNVbkTK7sLhad++59xw==
X-Received: by 2002:adf:9b8b:: with SMTP id d11mr8024287wrc.71.1600088524074;
        Mon, 14 Sep 2020 06:02:04 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t6sm23420983wre.30.2020.09.14.06.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 06:02:03 -0700 (PDT)
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
Date:   Mon, 14 Sep 2020 14:01:42 +0100
Message-Id: <20200914130143.1322802-3-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200914130143.1322802-1-daniel.thompson@linaro.org>
References: <20200914130143.1322802-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
 kernel/debug/debug_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b1277728a835..9618c1e2faf6 100644
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
@@ -302,6 +304,7 @@ static void kgdb_flush_swbreak_addr(unsigned long addr)
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
+NOKPROBE_SYMBOL(kgdb_flush_swbreak_addr);
 
 /*
  * SW breakpoint management:
@@ -329,6 +332,7 @@ int dbg_activate_sw_breakpoints(void)
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(dbg_activate_sw_breakpoints);
 
 int dbg_set_sw_break(unsigned long addr)
 {
@@ -392,6 +396,7 @@ int dbg_deactivate_sw_breakpoints(void)
 	}
 	return ret;
 }
+NOKPROBE_SYMBOL(dbg_deactivate_sw_breakpoints);
 
 int dbg_remove_sw_break(unsigned long addr)
 {
@@ -560,6 +565,7 @@ static int kgdb_reenter_check(struct kgdb_state *ks)
 
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_reenter_check);
 
 static void dbg_touch_watchdogs(void)
 {
@@ -567,6 +573,7 @@ static void dbg_touch_watchdogs(void)
 	clocksource_touch_watchdog();
 	rcu_cpu_stall_reset();
 }
+NOKPROBE_SYMBOL(dbg_touch_watchdogs);
 
 static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 		int exception_state)
@@ -798,6 +805,7 @@ static int kgdb_cpu_enter(struct kgdb_state *ks, struct pt_regs *regs,
 
 	return kgdb_info[cpu].ret_state;
 }
+NOKPROBE_SYMBOL(kgdb_cpu_enter);
 
 /*
  * kgdb_handle_exception() - main entry point from a kernel exception
@@ -842,6 +850,7 @@ kgdb_handle_exception(int evector, int signo, int ecode, struct pt_regs *regs)
 		arch_kgdb_ops.enable_nmi(1);
 	return ret;
 }
+NOKPROBE_SYMBOL(kgdb_handle_exception);
 
 /*
  * GDB places a breakpoint at this function to know dynamically loaded objects.
@@ -876,6 +885,7 @@ int kgdb_nmicallback(int cpu, void *regs)
 #endif
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_nmicallback);
 
 int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 							atomic_t *send_ready)
@@ -901,6 +911,7 @@ int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 #endif
 	return 1;
 }
+NOKPROBE_SYMBOL(kgdb_nmicallin);
 
 static void kgdb_console_write(struct console *co, const char *s,
    unsigned count)
-- 
2.25.4

