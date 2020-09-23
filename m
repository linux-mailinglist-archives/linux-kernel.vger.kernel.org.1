Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E59BC275F35
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWRyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 13:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbgIWRyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:54:51 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5996C21BE5;
        Wed, 23 Sep 2020 17:54:50 +0000 (UTC)
Date:   Wed, 23 Sep 2020 13:54:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] bootconfig: A couple of bug fixes
Message-ID: <20200923135448.5d8d9cb9@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

A couple of fixes for bootconfig

Masami discovered two bugs which this fixes and he added tests to
cover these issues.

- Fix a bug that breaks bootconfig tree nodes

- Fix a bug that does not truncate whitespace properly

- Add tests to cover the above two cases


Please pull the latest trace-v5.9-rc5-2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.9-rc5-2

Tag SHA1: 755b6a3dd7b63b609f82a45e3c8934c12a52a55d
Head SHA1: 2f5fb555637eff4a3e5579f2323cd358c77efdc8


Masami Hiramatsu (4):
      lib/bootconfig: Fix a bug of breaking existing tree nodes
      lib/bootconfig: Fix to remove tailing spaces after value
      tools/bootconfig: Add testcases for repeated key with brace
      tools/bootconfig: Add testcase for tailing space

----
 lib/bootconfig.c                    | 38 +++++++++++++++++++++++--------------
 tools/bootconfig/test-bootconfig.sh | 25 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 14 deletions(-)
---------------------------
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 2c905a91d4eb..649ed44f199c 100644
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
@@ -492,8 +494,8 @@ static int __init __xbc_parse_value(char **__v, char **__n)
 			break;
 		}
 		if (strchr(",;\n#}", c)) {
-			v = strim(v);
 			*p++ = '\0';
+			v = strim(v);
 			break;
 		}
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
diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
index 56284b98d8f0..d295e406a756 100755
--- a/tools/bootconfig/test-bootconfig.sh
+++ b/tools/bootconfig/test-bootconfig.sh
@@ -137,6 +137,31 @@ $BOOTCONF $INITRD > $TEMPCONF
 cat $TEMPCONF
 xpass grep \'\"string\"\' $TEMPCONF
 
+echo "Repeat same-key tree"
+cat > $TEMPCONF << EOF
+foo
+bar
+foo { buz }
+EOF
+echo > $INITRD
+
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xpass grep -q "bar" $OUTFILE
+
+
+echo "Remove/keep tailing spaces"
+cat > $TEMPCONF << EOF
+foo = val     # comment
+bar = "val2 " # comment
+EOF
+echo > $INITRD
+
+xpass $BOOTCONF -a $TEMPCONF $INITRD
+$BOOTCONF $INITRD > $OUTFILE
+xfail grep -q val[[:space:]] $OUTFILE
+xpass grep -q val2[[:space:]] $OUTFILE
+
 echo "=== expected failure cases ==="
 for i in samples/bad-* ; do
   xfail $BOOTCONF -a $i $INITRD
