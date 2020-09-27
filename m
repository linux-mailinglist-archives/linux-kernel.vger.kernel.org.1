Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51E727A439
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 23:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgI0VQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 17:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgI0VQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 17:16:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC6C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:16:16 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so4595877wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 14:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dlej/lv7oVkXNfjhU3o8F709/Rsr6/sqjZB7q+Bb9kY=;
        b=jjIs/ShxEUKGd7uwSXED4AjI2tzuzQz/UDxHA4VMAJF2qD1a0V0jAAB2AWYdaDBYAC
         I2AELKianFoU4dmp7Nun+Ui2jfnrme9WZnOviAv+3g1ucd6BpKMy2L8Y8ggKrsYa3Xlp
         Am8eUlB+uiZ82P9xc9wWfb2/GxLifoUXmLzwLrzFc8ch5l5c91ZPwDLBBGD0C3oUBY/Y
         8CVEJKRaNTzHxbsA0mOSz4Mq9cMM7h9xZeMD7nxDMIaIc0D3FcNx1pi0p/xA40X8TnZN
         zQrTAH1rMR2lD9gfgU0r9I4w6Ca1CIwFgyOnB1/G8jhMrJMmRh7ptCB3PUJanTYDyQud
         D4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dlej/lv7oVkXNfjhU3o8F709/Rsr6/sqjZB7q+Bb9kY=;
        b=MFx7lmHxZ36nD8U3vU/7hBTeMxVtG/3yYDnKXph2HC0bc2Ymuo0D4jx4oYs9xfqEjB
         xUd9mG+3J72WycUXtVeoPG+ACqbpAUBCCYGsMIqMlKGFl6ihS7OEQlgL19sLNLhKkFtH
         SV+CJUaxK28PcO33hd2UNMzKNcAQ+GiqYhXc8X6m/cUztz/uU5p17E0JArPMt1GaAXhU
         JGxiCkMiOgVa0rIMZl3ZM/v4PY0kVgsyaGR/9SORLDjnwbDzdx1/0+1Qjhk/sKrBOwK8
         zYzwVt3oi0cw4e+UiezZo2uRVdfwiXmHUbxYwmqNyVa0k3rhblwgqo63w3m2kpW9xoLM
         rIQg==
X-Gm-Message-State: AOAM532k4Jyrx0Eg96Q/lmIrRzSNK4u/HVix4z4wIuQ09yv60n0bs7a3
        rGkzzHdhHqJIUs2WfhG+xQelTA==
X-Google-Smtp-Source: ABdhPJybjs2360ZXFdycpun4TnffqLBoF2b3BVpvb5RBACJB4L8AP9d14d9i8h6KCHKK5li6jLs2cA==
X-Received: by 2002:a1c:4c06:: with SMTP id z6mr8202363wmf.40.1601241375471;
        Sun, 27 Sep 2020 14:16:15 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s17sm11396676wrr.40.2020.09.27.14.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 14:16:14 -0700 (PDT)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: [PATCH v3 1/3] kgdb: Honour the kprobe blocklist when setting breakpoints
Date:   Sun, 27 Sep 2020 22:15:29 +0100
Message-Id: <20200927211531.1380577-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200927211531.1380577-1-daniel.thompson@linaro.org>
References: <20200927211531.1380577-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kgdb has absolutely no safety rails in place to discourage or
prevent a user from placing a breakpoint in dangerous places such as
the debugger's own trap entry/exit and other places where it is not safe
to take synchronous traps.

Introduce a new config symbol KGDB_HONOUR_BLOCKLIST and modify the
default implementation of kgdb_validate_break_address() so that we use
the kprobe blocklist to prohibit instrumentation of critical functions
if the config symbol is set. The config symbol dependencies are set to
ensure that the blocklist will be enabled by default if we enable KGDB
and are compiling for an architecture where we HAVE_KPROBES.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/kgdb.h      | 18 ++++++++++++++++++
 kernel/debug/debug_core.c |  4 ++++
 kernel/debug/kdb/kdb_bp.c |  9 +++++++++
 lib/Kconfig.kgdb          | 15 +++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 477b8b7c908f..0d6cf64c8bb1 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -16,6 +16,7 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <linux/atomic.h>
+#include <linux/kprobes.h>
 #ifdef CONFIG_HAVE_ARCH_KGDB
 #include <asm/kgdb.h>
 #endif
@@ -335,6 +336,23 @@ extern int kgdb_nmicallin(int cpu, int trapnr, void *regs, int err_code,
 			  atomic_t *snd_rdy);
 extern void gdbstub_exit(int status);
 
+/*
+ * kgdb and kprobes both use the same (kprobe) blocklist (which makes sense
+ * given they are both typically hooked up to the same trap meaning on most
+ * architectures one cannot be used to debug the other)
+ *
+ * However on architectures where kprobes is not (yet) implemented we permit
+ * breakpoints everywhere rather than blocking everything by default.
+ */
+static inline bool kgdb_within_blocklist(unsigned long addr)
+{
+#ifdef CONFIG_KGDB_HONOUR_BLOCKLIST
+	return within_kprobe_blacklist(addr);
+#else
+	return false;
+#endif
+}
+
 extern int			kgdb_single_step;
 extern atomic_t			kgdb_active;
 #define in_dbg_master() \
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index b16dbc1bf056..b1277728a835 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -188,6 +188,10 @@ int __weak kgdb_validate_break_address(unsigned long addr)
 {
 	struct kgdb_bkpt tmp;
 	int err;
+
+	if (kgdb_within_blocklist(addr))
+		return -EINVAL;
+
 	/* Validate setting the breakpoint and then removing it.  If the
 	 * remove fails, the kernel needs to emit a bad message because we
 	 * are deep trouble not being able to put things back the way we
diff --git a/kernel/debug/kdb/kdb_bp.c b/kernel/debug/kdb/kdb_bp.c
index d7ebb2c79cb8..ec4940146612 100644
--- a/kernel/debug/kdb/kdb_bp.c
+++ b/kernel/debug/kdb/kdb_bp.c
@@ -306,6 +306,15 @@ static int kdb_bp(int argc, const char **argv)
 	if (!template.bp_addr)
 		return KDB_BADINT;
 
+	/*
+	 * This check is redundant (since the breakpoint machinery should
+	 * be doing the same check during kdb_bp_install) but gives the
+	 * user immediate feedback.
+	 */
+	diag = kgdb_validate_break_address(template.bp_addr);
+	if (diag)
+		return diag;
+
 	/*
 	 * Find an empty bp structure to allocate
 	 */
diff --git a/lib/Kconfig.kgdb b/lib/Kconfig.kgdb
index 256f2486f9bd..05dae05b6cc9 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -24,6 +24,21 @@ menuconfig KGDB
 
 if KGDB
 
+config KGDB_HONOUR_BLOCKLIST
+	bool "KGDB: use kprobe blocklist to prohibit unsafe breakpoints"
+	depends on HAVE_KPROBES
+	depends on MODULES
+	select KPROBES
+	default y
+	help
+	  If set to Y the debug core will use the kprobe blocklist to
+	  identify symbols where it is unsafe to set breakpoints.
+	  In particular this disallows instrumentation of functions
+	  called during debug trap handling and thus makes it very
+	  difficult to inadvertently provoke recursive trap handling.
+
+	  If unsure, say Y.
+
 config KGDB_SERIAL_CONSOLE
 	tristate "KGDB: use kgdb over the serial console"
 	select CONSOLE_POLL
-- 
2.25.4

