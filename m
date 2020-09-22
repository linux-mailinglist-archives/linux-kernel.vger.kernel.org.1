Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC4F42737FC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbgIVBYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729528AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54C4423A84;
        Tue, 22 Sep 2020 01:24:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX34-001sHL-Ag; Mon, 21 Sep 2020 21:24:50 -0400
Message-ID: <20200922012450.115825248@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 02/26] tools/bootconfig: Add list option
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Add list option (-l) to show the bootconfig in the list style.
This is same output of /proc/bootconfig. So users can check
how their bootconfig will be shown in procfs. This will help
them to write a user-space script to parse the /proc/bootconfig.

Link: https://lkml.kernel.org/r/159704849087.175360.8761890802048625207.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 52 +++++++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index d165e63b5d5a..78025267df20 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -14,18 +14,19 @@
 #include <linux/kernel.h>
 #include <linux/bootconfig.h>
 
-static int xbc_show_value(struct xbc_node *node)
+static int xbc_show_value(struct xbc_node *node, bool semicolon)
 {
-	const char *val;
+	const char *val, *eol;
 	char q;
 	int i = 0;
 
+	eol = semicolon ? ";\n" : "\n";
 	xbc_array_for_each_value(node, val) {
 		if (strchr(val, '"'))
 			q = '\'';
 		else
 			q = '"';
-		printf("%c%s%c%s", q, val, q, node->next ? ", " : ";\n");
+		printf("%c%s%c%s", q, val, q, node->next ? ", " : eol);
 		i++;
 	}
 	return i;
@@ -53,7 +54,7 @@ static void xbc_show_compact_tree(void)
 			continue;
 		} else if (cnode && xbc_node_is_value(cnode)) {
 			printf("%s = ", xbc_node_get_data(node));
-			xbc_show_value(cnode);
+			xbc_show_value(cnode, true);
 		} else {
 			printf("%s;\n", xbc_node_get_data(node));
 		}
@@ -77,6 +78,26 @@ static void xbc_show_compact_tree(void)
 	}
 }
 
+static void xbc_show_list(void)
+{
+	char key[XBC_KEYLEN_MAX];
+	struct xbc_node *leaf;
+	const char *val;
+	int ret = 0;
+
+	xbc_for_each_key_value(leaf, val) {
+		ret = xbc_node_compose_key(leaf, key, XBC_KEYLEN_MAX);
+		if (ret < 0)
+			break;
+		printf("%s = ", key);
+		if (!val || val[0] == '\0') {
+			printf("\"\"\n");
+			continue;
+		}
+		xbc_show_value(xbc_node_get_child(leaf), false);
+	}
+}
+
 /* Simple real checksum */
 int checksum(unsigned char *buf, int len)
 {
@@ -233,7 +254,7 @@ static int init_xbc_with_error(char *buf, int len)
 	return ret;
 }
 
-int show_xbc(const char *path)
+int show_xbc(const char *path, bool list)
 {
 	int ret, fd;
 	char *buf = NULL;
@@ -267,7 +288,10 @@ int show_xbc(const char *path)
 		if (init_xbc_with_error(buf, ret) < 0)
 			goto out;
 	}
-	xbc_show_compact_tree();
+	if (list)
+		xbc_show_list();
+	else
+		xbc_show_compact_tree();
 	ret = 0;
 out:
 	free(buf);
@@ -390,7 +414,8 @@ int usage(void)
 		" Apply, delete or show boot config to initrd.\n"
 		" Options:\n"
 		"		-a <config>: Apply boot config to initrd\n"
-		"		-d : Delete boot config file from initrd\n\n"
+		"		-d : Delete boot config file from initrd\n"
+		"		-l : list boot config in initrd or file\n\n"
 		" If no option is given, show the bootconfig in the given file.\n");
 	return -1;
 }
@@ -399,10 +424,10 @@ int main(int argc, char **argv)
 {
 	char *path = NULL;
 	char *apply = NULL;
-	bool delete = false;
+	bool delete = false, list = false;
 	int opt;
 
-	while ((opt = getopt(argc, argv, "hda:")) != -1) {
+	while ((opt = getopt(argc, argv, "hda:l")) != -1) {
 		switch (opt) {
 		case 'd':
 			delete = true;
@@ -410,14 +435,17 @@ int main(int argc, char **argv)
 		case 'a':
 			apply = optarg;
 			break;
+		case 'l':
+			list = true;
+			break;
 		case 'h':
 		default:
 			return usage();
 		}
 	}
 
-	if (apply && delete) {
-		pr_err("Error: You can not specify both -a and -d at once.\n");
+	if ((apply && delete) || (delete && list) || (apply && list)) {
+		pr_err("Error: You can give one of -a, -d or -l at once.\n");
 		return usage();
 	}
 
@@ -433,5 +461,5 @@ int main(int argc, char **argv)
 	else if (delete)
 		return delete_xbc(path);
 
-	return show_xbc(path);
+	return show_xbc(path, list);
 }
-- 
2.28.0


