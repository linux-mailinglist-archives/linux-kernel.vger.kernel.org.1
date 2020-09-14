Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37C1268BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbgINNJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgINNCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:02:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57805C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:02:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so18611016wrw.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 06:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2bHvryZQLWnkv+dYNHBTXO/DsrmPeloLYjVsFFfptI=;
        b=pE2cCoB4QzQ08cjcZxpQf2kst5TzIrF2i5trDOAzUpy2s9zeuwAQ/Nx3IFBR9z/hXZ
         2kKNmcYp5d1ZihOljX+hxl3qNDCb0lc8Y8Mvobr9D5EKagkgH1aB9uVQ4CVdYdrRXoY9
         zP42ixjTX6ZAvclvIg6i9jBtf+RZtIOUlXhRiQGMhIh6IQswvzUWCBLGVz5emnKjak20
         xWGDPxKFgvhvznguBIIQHlgs/TWGbKxGF3WaYWx6vOR+btYNXEM835N65nlXsV2u7cKK
         6jmc2/2qvjDCEsfykogJZ0sLkaEOgM775yi8SXaX/hwGEy+nY/bxXpLvhpQMUaWpAXrk
         KYug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2bHvryZQLWnkv+dYNHBTXO/DsrmPeloLYjVsFFfptI=;
        b=DEr3LgtLMeBPg4ij3dtvF4ArcQAeKyVYIBImonRqqRvReSkJ+dPbg+J3vstNQS+0Qm
         EbFdMNMgcreObWGdQVzcJCLdjXOzUujr97d7rWjOrKqiQ2LaAaq5dccv5GZDqEfYl8TI
         aAPComv05SN2Ac1TRHdQfAUc425LNqZtIyv30wBGRLAhy9D6GlIsrdC0WigNIpNNCQKr
         6lywyHptr4tKTSeQ621SmxdjsfMvRzyAaYgFVmwbO2cjJMo9Zwq6OLBItyba/mP+w1Av
         22fIlf+5H0enx8cMQ2zqpvLt57LmZwbxehDMzQ02ZJY1e4yfRmzy+pMtV494dKMlL4Uv
         4vcw==
X-Gm-Message-State: AOAM532B4isTIRbfxHQblLBuHV4Vwv4rBVJqfTCGTtw/yS5ngbQbwFcQ
        2zy8B2xeiig1RIgIOA/kFkoHQQ==
X-Google-Smtp-Source: ABdhPJxZK4XsK2KPeAGMEzC3inVIZOP5soww3+m9A+K0lTdvS3ROedJ839p6WuCHWNrJ0H7MDRhGdw==
X-Received: by 2002:a05:6000:1c8:: with SMTP id t8mr15767631wrx.3.1600088522936;
        Mon, 14 Sep 2020 06:02:02 -0700 (PDT)
Received: from wychelm.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id t6sm23420983wre.30.2020.09.14.06.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 06:02:02 -0700 (PDT)
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
Date:   Mon, 14 Sep 2020 14:01:41 +0100
Message-Id: <20200914130143.1322802-2-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200914130143.1322802-1-daniel.thompson@linaro.org>
References: <20200914130143.1322802-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 include/linux/kgdb.h      | 18 ++++++++++++++++++
 kernel/debug/debug_core.c |  4 ++++
 kernel/debug/kdb/kdb_bp.c |  9 +++++++++
 lib/Kconfig.kgdb          | 14 ++++++++++++++
 4 files changed, 45 insertions(+)

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
index 256f2486f9bd..713c17fe789c 100644
--- a/lib/Kconfig.kgdb
+++ b/lib/Kconfig.kgdb
@@ -24,6 +24,20 @@ menuconfig KGDB
 
 if KGDB
 
+config KGDB_HONOUR_BLOCKLIST
+	bool "KGDB: use kprobe blocklist to prohibit unsafe breakpoints"
+	depends on HAVE_KPROBES
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

