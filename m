Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820172737FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbgIVBYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:24:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:56484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D3AD23A7B;
        Tue, 22 Sep 2020 01:24:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX34-001sGp-35; Mon, 21 Sep 2020 21:24:50 -0400
Message-ID: <20200922012449.957719149@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 01/26] tools/bootconfig: Show bootconfig compact tree from bootconfig file
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Show the bootconfig compact tree from the bootconfig file
instead of an initrd if the given file has no magic number
and is smaller than 32KB.

User can use this for checking the syntax error or output
checking before applying the bootconfig to initrd.

Link: https://lkml.kernel.org/r/159704848156.175360.6621139371000789360.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/bootconfig/main.c | 81 +++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index e0878f5f74b1..d165e63b5d5a 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -195,10 +195,55 @@ int load_xbc_from_initrd(int fd, char **buf)
 	return size;
 }
 
+static void show_xbc_error(const char *data, const char *msg, int pos)
+{
+	int lin = 1, col, i;
+
+	if (pos < 0) {
+		pr_err("Error: %s.\n", msg);
+		return;
+	}
+
+	/* Note that pos starts from 0 but lin and col should start from 1. */
+	col = pos + 1;
+	for (i = 0; i < pos; i++) {
+		if (data[i] == '\n') {
+			lin++;
+			col = pos - i;
+		}
+	}
+	pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
+
+}
+
+static int init_xbc_with_error(char *buf, int len)
+{
+	char *copy = strdup(buf);
+	const char *msg;
+	int ret, pos;
+
+	if (!copy)
+		return -ENOMEM;
+
+	ret = xbc_init(buf, &msg, &pos);
+	if (ret < 0)
+		show_xbc_error(copy, msg, pos);
+	free(copy);
+
+	return ret;
+}
+
 int show_xbc(const char *path)
 {
 	int ret, fd;
 	char *buf = NULL;
+	struct stat st;
+
+	ret = stat(path, &st);
+	if (ret < 0) {
+		pr_err("Failed to stat %s: %d\n", path, -errno);
+		return -errno;
+	}
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
@@ -207,14 +252,24 @@ int show_xbc(const char *path)
 	}
 
 	ret = load_xbc_from_initrd(fd, &buf);
+	close(fd);
 	if (ret < 0) {
 		pr_err("Failed to load a boot config from initrd: %d\n", ret);
 		goto out;
 	}
+	/* Assume a bootconfig file if it is enough small */
+	if (ret == 0 && st.st_size <= XBC_DATA_MAX) {
+		ret = load_xbc_file(path, &buf);
+		if (ret < 0) {
+			pr_err("Failed to load a boot config: %d\n", ret);
+			goto out;
+		}
+		if (init_xbc_with_error(buf, ret) < 0)
+			goto out;
+	}
 	xbc_show_compact_tree();
 	ret = 0;
 out:
-	close(fd);
 	free(buf);
 
 	return ret;
@@ -251,27 +306,6 @@ int delete_xbc(const char *path)
 	return ret;
 }
 
-static void show_xbc_error(const char *data, const char *msg, int pos)
-{
-	int lin = 1, col, i;
-
-	if (pos < 0) {
-		pr_err("Error: %s.\n", msg);
-		return;
-	}
-
-	/* Note that pos starts from 0 but lin and col should start from 1. */
-	col = pos + 1;
-	for (i = 0; i < pos; i++) {
-		if (data[i] == '\n') {
-			lin++;
-			col = pos - i;
-		}
-	}
-	pr_err("Parse Error: %s at %d:%d\n", msg, lin, col);
-
-}
-
 int apply_xbc(const char *path, const char *xbc_path)
 {
 	u32 size, csum;
@@ -352,11 +386,12 @@ int apply_xbc(const char *path, const char *xbc_path)
 int usage(void)
 {
 	printf("Usage: bootconfig [OPTIONS] <INITRD>\n"
+		"Or     bootconfig <CONFIG>\n"
 		" Apply, delete or show boot config to initrd.\n"
 		" Options:\n"
 		"		-a <config>: Apply boot config to initrd\n"
 		"		-d : Delete boot config file from initrd\n\n"
-		" If no option is given, show current applied boot config.\n");
+		" If no option is given, show the bootconfig in the given file.\n");
 	return -1;
 }
 
-- 
2.28.0


