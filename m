Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3E42E7675
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgL3GXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:23:10 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:42468 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgL3GXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=vwLnnKIQ6AwNTFQq3y
        uKtvrwYwXYLUDyf68GlSk/Nfc=; b=epajJGOkZnIQ7PrYP7KS2DQ9minaKyWXIQ
        NiA1j9G6QYNkFlK0iz8416P3YWWNYWrXDKh+0s0wH9//TWFQmF5ls/Syr33535uE
        GDUKi1uZosWbFFVNe6S2r9p90/0C/TStIKDs0x2ynd5di41i11PTk+w54105a9iV
        eF6tbxUBg=
Received: from pek-pliu1-d1.wrs.com (unknown [60.247.85.82])
        by smtp2 (Coremail) with SMTP id GtxpCgD3h29pGOxf8oeWHA--.716S4;
        Wed, 30 Dec 2020 14:04:32 +0800 (CST)
From:   Liu Peibao <liupeibao@163.com>
To:     mhiramat@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] init/main.c: sink the kernel_init to the bottom
Date:   Wed, 30 Dec 2020 14:04:24 +0800
Message-Id: <20201230060424.29097-3-liupeibao@163.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201230060424.29097-1-liupeibao@163.com>
References: <20201230060424.29097-1-liupeibao@163.com>
X-CM-TRANSID: GtxpCgD3h29pGOxf8oeWHA--.716S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1UGF4DZFyfJF4DKF18AFb_yoWrCF15pr
        Wvkry3Kry8GanrtrWfArZ5WFySy3ykGa4UKrZrG34SqFn5Cr1rXr9FgrySvFykXrWFv3Wa
        qFWkAFWfur17XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j9a9-UUUUU=
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/xtbBaRALbFXltCo5wAAAsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the redundant kernel_init_freeable statement.

Signed-off-by: Liu Peibao <liupeibao@163.com>
---
 init/main.c | 132 ++++++++++++++++++++++++++--------------------------
 1 file changed, 65 insertions(+), 67 deletions(-)

diff --git a/init/main.c b/init/main.c
index 1e492de770c8..d5c2fa85ee54 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1364,8 +1364,6 @@ static int try_to_run_init_process(const char *init_filename)
 	return ret;
 }
 
-static noinline void __init kernel_init_freeable(void);
-
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
 bool rodata_enabled __ro_after_init = true;
 static int __init set_debug_rodata(char *str)
@@ -1408,71 +1406,6 @@ void __weak free_initmem(void)
 	free_initmem_default(POISON_FREE_INITMEM);
 }
 
-static int __ref kernel_init(void *unused)
-{
-	int ret;
-
-	kernel_init_freeable();
-	/* need to finish all async __init code before freeing the memory */
-	async_synchronize_full();
-	kprobe_free_init_mem();
-	ftrace_free_init_mem();
-	free_initmem();
-	mark_readonly();
-
-	/*
-	 * Kernel mappings are now finalized - update the userspace page-table
-	 * to finalize PTI.
-	 */
-	pti_finalize();
-
-	system_state = SYSTEM_RUNNING;
-	numa_default_policy();
-
-	rcu_end_inkernel_boot();
-
-	do_sysctl_args();
-
-	if (ramdisk_execute_command) {
-		ret = run_init_process(ramdisk_execute_command);
-		if (!ret)
-			return 0;
-		pr_err("Failed to execute %s (error %d)\n",
-		       ramdisk_execute_command, ret);
-	}
-
-	/*
-	 * We try each of these until one succeeds.
-	 *
-	 * The Bourne shell can be used instead of init if we are
-	 * trying to recover a really broken machine.
-	 */
-	if (execute_command) {
-		ret = run_init_process(execute_command);
-		if (!ret)
-			return 0;
-		panic("Requested init %s failed (error %d).",
-		      execute_command, ret);
-	}
-
-	if (CONFIG_DEFAULT_INIT[0] != '\0') {
-		ret = run_init_process(CONFIG_DEFAULT_INIT);
-		if (ret)
-			pr_err("Default init %s failed (error %d)\n",
-			       CONFIG_DEFAULT_INIT, ret);
-		else
-			return 0;
-	}
-
-	if (!try_to_run_init_process("/sbin/init") ||
-	    !try_to_run_init_process("/etc/init") ||
-	    !try_to_run_init_process("/bin/init") ||
-	    !try_to_run_init_process("/bin/sh"))
-		return 0;
-
-	panic("No working init found. Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.");
-}
-
 /* Open /dev/console, for stdin/stdout/stderr, this should never fail */
 void __init console_on_rootfs(void)
 {
@@ -1554,3 +1487,68 @@ static noinline void __init kernel_init_freeable(void)
 
 	integrity_load_keys();
 }
+
+static int __ref kernel_init(void *unused)
+{
+	int ret;
+
+	kernel_init_freeable();
+	/* need to finish all async __init code before freeing the memory */
+	async_synchronize_full();
+	kprobe_free_init_mem();
+	ftrace_free_init_mem();
+	free_initmem();
+	mark_readonly();
+
+	/*
+	 * Kernel mappings are now finalized - update the userspace page-table
+	 * to finalize PTI.
+	 */
+	pti_finalize();
+
+	system_state = SYSTEM_RUNNING;
+	numa_default_policy();
+
+	rcu_end_inkernel_boot();
+
+	do_sysctl_args();
+
+	if (ramdisk_execute_command) {
+		ret = run_init_process(ramdisk_execute_command);
+		if (!ret)
+			return 0;
+		pr_err("Failed to execute %s (error %d)\n",
+		       ramdisk_execute_command, ret);
+	}
+
+	/*
+	 * We try each of these until one succeeds.
+	 *
+	 * The Bourne shell can be used instead of init if we are
+	 * trying to recover a really broken machine.
+	 */
+	if (execute_command) {
+		ret = run_init_process(execute_command);
+		if (!ret)
+			return 0;
+		panic("Requested init %s failed (error %d).",
+		      execute_command, ret);
+	}
+
+	if (CONFIG_DEFAULT_INIT[0] != '\0') {
+		ret = run_init_process(CONFIG_DEFAULT_INIT);
+		if (ret)
+			pr_err("Default init %s failed (error %d)\n",
+			       CONFIG_DEFAULT_INIT, ret);
+		else
+			return 0;
+	}
+
+	if (!try_to_run_init_process("/sbin/init") ||
+	    !try_to_run_init_process("/etc/init") ||
+	    !try_to_run_init_process("/bin/init") ||
+	    !try_to_run_init_process("/bin/sh"))
+		return 0;
+
+	panic("No working init found. Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.");
+}
-- 
2.17.1

