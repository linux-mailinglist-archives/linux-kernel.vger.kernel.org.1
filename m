Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2F9240378
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHJIeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 04:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJIeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:34:46 -0400
Received: from localhost.localdomain (unknown [180.22.250.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D7D520709;
        Mon, 10 Aug 2020 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597048485;
        bh=nVJ1YOeSYsEtBFDu1yB6K6Mup+VVhxZPIANp/vQT/Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O02gKiYo5TXVpEVAcWF0egLqgHUbk36XfKoHPje/0IB4Xl1emuVQ+51AK7yjk9LmS
         3K423tJLIq33uVzaAFDXXm2Q13FD8RmmnA7tyIGI+Pl4mUSUkV8XucW9JsyuYen4OA
         2vq7j9o/d0P4bTU57/nTx0jPpem1XZvshQHnE8bw=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/6] tools/bootconfig: Show bootconfig compact tree from bootconfig file
Date:   Mon, 10 Aug 2020 17:34:41 +0900
Message-Id: <159704848156.175360.6621139371000789360.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159704847064.175360.3292152056631660862.stgit@devnote2>
References: <159704847064.175360.3292152056631660862.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the bootconfig compact tree from the bootconfig file
instead of an initrd if the given file has no magic number
and is smaller than 32KB.

User can use this for checking the syntax error or output
checking before applying the bootconfig to initrd.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 tools/bootconfig/main.c |   81 ++++++++++++++++++++++++++++++++++-------------
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
 

