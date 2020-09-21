Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23459271F21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgIUJor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:60936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgIUJoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:44:46 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D13062158C;
        Mon, 21 Sep 2020 09:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600681486;
        bh=X1/uVdXVY92wtPVB0317J9gOt/k3wF8KV8QEHbHJ2QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWMJu8SgKZmT6RBY+zNTZULfHXPuPkUgt1gJmO8MeGB7Pgz+b0cs390w33u1fejoX
         js2JPm+8XeW3MExoh3IZo0M/yDefgR9K5qFwBITjXbLXbTNvvTWp3oTcPNYu6XqJwJ
         sjbV4mKCVZ5uaukPbZxwhSaFuts8sz3YmHnmkvqs=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/4] lib/bootconfig: Fix a bug of breaking existing tree nodes
Date:   Mon, 21 Sep 2020 18:44:42 +0900
Message-Id: <160068148267.1088739.8264704338030168660.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160068147328.1088739.7282405187565509762.stgit@devnote2>
References: <160068147328.1088739.7282405187565509762.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug of breaking existing tree nodes by parsing the second
and subsequent braces. Since the bootconfig parser uses the
node.next field as a flag of current parent node, but this will
breaks the existing tree if the same key node specified again
in the bootconfig.

For example, the following bootconfig should be foo.buz and bar.

foo
bar
foo { buz }

However, when parsing the brace "{", it breaks foo->bar link
by marking open-brace node. So the bootconfig unlinks bar
from the bootconfig internal tree.

This introduces a stack outside of the tree and record the
last open-brace on the stack instead of using node.next field.

Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 0 files changed

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 2c905a91d4eb..b44bba0f1583 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -31,6 +31,8 @@ static size_t xbc_data_size __initdata;
 static struct xbc_node *last_parent __initdata;
 static const char *xbc_err_msg __initdata;
 static int xbc_err_pos __initdata;
+static int open_brace[XBC_DEPTH_MAX] __initdata;
+static int brace_index __initdata;
 
 static int __init xbc_parse_error(const char *msg, const char *p)
 {
@@ -431,27 +433,27 @@ static char *skip_spaces_until_newline(char *p)
 	return p;
 }
 
-static int __init __xbc_open_brace(void)
+static int __init __xbc_open_brace(char *p)
 {
-	/* Mark the last key as open brace */
-	last_parent->next = XBC_NODE_MAX;
+	/* Push the last key as open brace */
+	open_brace[brace_index++] = xbc_node_index(last_parent);
+	if (brace_index >= XBC_DEPTH_MAX)
+		return xbc_parse_error("Exceed max depth of braces", p);
 
 	return 0;
 }
 
 static int __init __xbc_close_brace(char *p)
 {
-	struct xbc_node *node;
-
-	if (!last_parent || last_parent->next != XBC_NODE_MAX)
+	brace_index--;
+	if (!last_parent || brace_index < 0 ||
+	    (open_brace[brace_index] != xbc_node_index(last_parent)))
 		return xbc_parse_error("Unexpected closing brace", p);
 
-	node = last_parent;
-	node->next = 0;
-	do {
-		node = xbc_node_get_parent(node);
-	} while (node && node->next != XBC_NODE_MAX);
-	last_parent = node;
+	if (brace_index == 0)
+		last_parent = NULL;
+	else
+		last_parent = &xbc_nodes[open_brace[brace_index - 1]];
 
 	return 0;
 }
@@ -661,7 +663,7 @@ static int __init xbc_open_brace(char **k, char *n)
 		return ret;
 	*k = n;
 
-	return __xbc_open_brace();
+	return __xbc_open_brace(n - 1);
 }
 
 static int __init xbc_close_brace(char **k, char *n)
@@ -681,6 +683,13 @@ static int __init xbc_verify_tree(void)
 	int i, depth, len, wlen;
 	struct xbc_node *n, *m;
 
+	/* Brace closing */
+	if (brace_index) {
+		n = &xbc_nodes[open_brace[brace_index]];
+		return xbc_parse_error("Brace is not closed",
+					xbc_node_get_data(n));
+	}
+
 	/* Empty tree */
 	if (xbc_node_num == 0) {
 		xbc_parse_error("Empty config", xbc_data);
@@ -745,6 +754,7 @@ void __init xbc_destroy_all(void)
 	xbc_node_num = 0;
 	memblock_free(__pa(xbc_nodes), sizeof(struct xbc_node) * XBC_NODE_MAX);
 	xbc_nodes = NULL;
+	brace_index = 0;
 }
 
 /**

