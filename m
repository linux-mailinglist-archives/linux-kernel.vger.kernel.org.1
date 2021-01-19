Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEC52FB782
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405045AbhASLCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390964AbhASKve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:51:34 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8782C061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:50:49 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id b8so10269024plh.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MdowI1spYzSZ783aBzUoan8uq2NdmnUHuCZElfPxqfQ=;
        b=Fx/tzeqor4dkEBrQ0EyMKi5UYinFCZNM+4m2iEiHgFjtaqmVm8MaDD8C4DMfirKXyU
         H5gAlRfQHzOM/5ghPHjfII8w+BN1O7fXQkhddHMAP/wAde5v1uvn14+cD29IIL+durT4
         h5pxtZ+oPR5/0Mr2BZONiO4fZ9jVg+B0pmf5QUUeY2K/1IjvhcQ2aTOpG7VCHg4s10kG
         0f+RczmVuu9aFkP3pYQiQQwxxweG/yhG1p37p+eBX84V6KxuP/o5d6VXVhXBVzkBttTK
         ACUL6DnJc6+255oBCQNY5VExJpM25oUrD3J+aVy4LCWpjQAKIXh+ndx2OC4S+5W+6ZOr
         lsrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MdowI1spYzSZ783aBzUoan8uq2NdmnUHuCZElfPxqfQ=;
        b=lESP9jo+faAUV8qwpSum/SgCx98UFxUM4JeX2PYb30/e6PVQZ4xHJs17MN6GimVnaS
         LaHl0ow+0EEEVVSpKhGFROVGgDcb64xn9erg8x2YWfdS8OjfxG7C7zyIwE7quPNFQTpb
         eR08rLAl6ltw3W0n7hzFkvYXM9LFYHJBq8Ttsg584O0gvy8xw0ACIvds5nRcy6aMRcE4
         DdnWbXC95eywsePKDjnLxEoDeHmROQptFUMZaXfvUu3cKXbb3bIANMmlHTivkTHDaUmm
         14pKm5GCvWQ+BhE4XCbiGZu++o7fme8G11GZknNx3G4Ks+iUJisytDXkfp+wYb7hE1U+
         tzGg==
X-Gm-Message-State: AOAM533FmGJL8VkF6vKgK04GZrq7oF+XeWK5IftoVj0LkipT/9Baj70Q
        rI6ot2APefZFqLhAsSRQRFnjZUq/bUBV4w==
X-Google-Smtp-Source: ABdhPJz6EoK9JnwYL1Qcj/o7CwQgRwQsXysqajEDUuSbbCkplLL+gfnG4gJ1U1PgzoWtncHHZFMJcQ==
X-Received: by 2002:a17:90a:bf88:: with SMTP id d8mr4764171pjs.102.1611053449104;
        Tue, 19 Jan 2021 02:50:49 -0800 (PST)
Received: from localhost.localdomain ([122.181.110.213])
        by smtp.gmail.com with ESMTPSA id a136sm19619797pfd.149.2021.01.19.02.50.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 02:50:48 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     kgdb-bugreport@lists.sourceforge.net
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        dianders@chromium.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH] kdb: Simplify kdb commands registration
Date:   Tue, 19 Jan 2021 16:20:18 +0530
Message-Id: <1611053418-29283-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify kdb commands registration via using linked list instead of
static array for commands storage.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 kernel/debug/kdb/kdb_main.c    | 78 ++++++++++--------------------------------
 kernel/debug/kdb/kdb_private.h |  1 +
 2 files changed, 20 insertions(+), 59 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index 930ac1b..93ac0f5 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -33,6 +33,7 @@
 #include <linux/kallsyms.h>
 #include <linux/kgdb.h>
 #include <linux/kdb.h>
+#include <linux/list.h>
 #include <linux/notifier.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
@@ -84,15 +85,8 @@ static unsigned int kdb_continue_catastrophic =
 static unsigned int kdb_continue_catastrophic;
 #endif
 
-/* kdb_commands describes the available commands. */
-static kdbtab_t *kdb_commands;
-#define KDB_BASE_CMD_MAX 50
-static int kdb_max_commands = KDB_BASE_CMD_MAX;
-static kdbtab_t kdb_base_commands[KDB_BASE_CMD_MAX];
-#define for_each_kdbcmd(cmd, num)					\
-	for ((cmd) = kdb_base_commands, (num) = 0;			\
-	     num < kdb_max_commands;					\
-	     num++, num == KDB_BASE_CMD_MAX ? cmd = kdb_commands : cmd++)
+/* kdb_cmds_head describes the available commands. */
+static LIST_HEAD(kdb_cmds_head);
 
 typedef struct _kdbmsg {
 	int	km_diag;	/* kdb diagnostic */
@@ -921,7 +915,7 @@ int kdb_parse(const char *cmdstr)
 	char *cp;
 	char *cpp, quoted;
 	kdbtab_t *tp;
-	int i, escaped, ignore_errors = 0, check_grep = 0;
+	int escaped, ignore_errors = 0, check_grep = 0;
 
 	/*
 	 * First tokenize the command string.
@@ -1011,7 +1005,7 @@ int kdb_parse(const char *cmdstr)
 		++argv[0];
 	}
 
-	for_each_kdbcmd(tp, i) {
+	list_for_each_entry(tp, &kdb_cmds_head, list_node) {
 		if (tp->cmd_name) {
 			/*
 			 * If this command is allowed to be abbreviated,
@@ -1037,8 +1031,8 @@ int kdb_parse(const char *cmdstr)
 	 * few characters of this match any of the known commands.
 	 * e.g., md1c20 should match md.
 	 */
-	if (i == kdb_max_commands) {
-		for_each_kdbcmd(tp, i) {
+	if (list_entry_is_head(tp, &kdb_cmds_head, list_node)) {
+		list_for_each_entry(tp, &kdb_cmds_head, list_node) {
 			if (tp->cmd_name) {
 				if (strncmp(argv[0],
 					    tp->cmd_name,
@@ -1049,7 +1043,7 @@ int kdb_parse(const char *cmdstr)
 		}
 	}
 
-	if (i < kdb_max_commands) {
+	if (!list_entry_is_head(tp, &kdb_cmds_head, list_node)) {
 		int result;
 
 		if (!kdb_check_flags(tp->cmd_flags, kdb_cmd_enabled, argc <= 1))
@@ -2428,12 +2422,11 @@ static int kdb_kgdb(int argc, const char **argv)
 static int kdb_help(int argc, const char **argv)
 {
 	kdbtab_t *kt;
-	int i;
 
 	kdb_printf("%-15.15s %-20.20s %s\n", "Command", "Usage", "Description");
 	kdb_printf("-----------------------------"
 		   "-----------------------------\n");
-	for_each_kdbcmd(kt, i) {
+	list_for_each_entry(kt, &kdb_cmds_head, list_node) {
 		char *space = "";
 		if (KDB_FLAG(CMD_INTERRUPT))
 			return 0;
@@ -2667,13 +2660,9 @@ int kdb_register_flags(char *cmd,
 		       short minlen,
 		       kdb_cmdflags_t flags)
 {
-	int i;
 	kdbtab_t *kp;
 
-	/*
-	 *  Brute force method to determine duplicates
-	 */
-	for_each_kdbcmd(kp, i) {
+	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
 		if (kp->cmd_name && (strcmp(kp->cmd_name, cmd) == 0)) {
 			kdb_printf("Duplicate kdb command registered: "
 				"%s, func %px help %s\n", cmd, func, help);
@@ -2681,35 +2670,10 @@ int kdb_register_flags(char *cmd,
 		}
 	}
 
-	/*
-	 * Insert command into first available location in table
-	 */
-	for_each_kdbcmd(kp, i) {
-		if (kp->cmd_name == NULL)
-			break;
-	}
-
-	if (i >= kdb_max_commands) {
-		kdbtab_t *new = kmalloc_array(kdb_max_commands -
-						KDB_BASE_CMD_MAX +
-						kdb_command_extend,
-					      sizeof(*new),
-					      GFP_KDB);
-		if (!new) {
-			kdb_printf("Could not allocate new kdb_command "
-				   "table\n");
-			return 1;
-		}
-		if (kdb_commands) {
-			memcpy(new, kdb_commands,
-			  (kdb_max_commands - KDB_BASE_CMD_MAX) * sizeof(*new));
-			kfree(kdb_commands);
-		}
-		memset(new + kdb_max_commands - KDB_BASE_CMD_MAX, 0,
-		       kdb_command_extend * sizeof(*new));
-		kdb_commands = new;
-		kp = kdb_commands + kdb_max_commands - KDB_BASE_CMD_MAX;
-		kdb_max_commands += kdb_command_extend;
+	kp = kmalloc(sizeof(*kp), GFP_KDB);
+	if (!kp) {
+		kdb_printf("Could not allocate new kdb_command table\n");
+		return 1;
 	}
 
 	kp->cmd_name   = cmd;
@@ -2719,6 +2683,8 @@ int kdb_register_flags(char *cmd,
 	kp->cmd_minlen = minlen;
 	kp->cmd_flags  = flags;
 
+	list_add_tail(&kp->list_node, &kdb_cmds_head);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kdb_register_flags);
@@ -2757,15 +2723,15 @@ EXPORT_SYMBOL_GPL(kdb_register);
  */
 int kdb_unregister(char *cmd)
 {
-	int i;
 	kdbtab_t *kp;
 
 	/*
 	 *  find the command.
 	 */
-	for_each_kdbcmd(kp, i) {
+	list_for_each_entry(kp, &kdb_cmds_head, list_node) {
 		if (kp->cmd_name && (strcmp(kp->cmd_name, cmd) == 0)) {
-			kp->cmd_name = NULL;
+			list_del(&kp->list_node);
+			kfree(kp);
 			return 0;
 		}
 	}
@@ -2778,12 +2744,6 @@ EXPORT_SYMBOL_GPL(kdb_unregister);
 /* Initialize the kdb command table. */
 static void __init kdb_inittab(void)
 {
-	int i;
-	kdbtab_t *kp;
-
-	for_each_kdbcmd(kp, i)
-		kp->cmd_name = NULL;
-
 	kdb_register_flags("md", kdb_md, "<vaddr>",
 	  "Display Memory Contents, also mdWcN, e.g. md8c1", 1,
 	  KDB_ENABLE_MEM_READ | KDB_REPEAT_NO_ARGS);
diff --git a/kernel/debug/kdb/kdb_private.h b/kernel/debug/kdb/kdb_private.h
index a4281fb..7a4a181 100644
--- a/kernel/debug/kdb/kdb_private.h
+++ b/kernel/debug/kdb/kdb_private.h
@@ -174,6 +174,7 @@ typedef struct _kdbtab {
 	short    cmd_minlen;		/* Minimum legal # command
 					 * chars required */
 	kdb_cmdflags_t cmd_flags;	/* Command behaviour flags */
+	struct list_head list_node;
 } kdbtab_t;
 
 extern int kdb_bt(int, const char **);	/* KDB display back trace */
-- 
2.7.4

