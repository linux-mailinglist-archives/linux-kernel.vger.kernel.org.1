Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC04223B2DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 04:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgHDCwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Aug 2020 22:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbgHDCwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:52:16 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533C02075D;
        Tue,  4 Aug 2020 02:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596509536;
        bh=omu5bgYLt7XzcbFBfJMzrYKS2aJGyBRDwaAWcy8Cj58=;
        h=From:To:Cc:Subject:Date:From;
        b=fIYRagPZ6zqYAR6X8Hhk/2TsWe8esSONonwQuToaTjoMLyUr19zC4H+ZEXiTIGP23
         QfqNiObYUOI0RYUt9K/GuBG6di6WiQ6BibzH611GXYiMVgLBqEOzT28IYMHFLV6DSn
         Arr0eQaXlxxTzn1RDWSJ5X9YUGTUNHm9b3+Cm3mk=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] bootconfig: Fix to find the initargs correctly
Date:   Tue,  4 Aug 2020 11:52:13 +0900
Message-Id: <159650953285.270383.14822353843556363851.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the parse_args() stops parsing at '--', bootconfig_params()
will never get the '--' as param and initargs_found never be true.
In the result, if we pass some init arguments via the bootconfig,
those are always appended to the kernel command line with '--'
even if the kernel command line already has '--'.

To fix this correctly, check the return value of parse_args()
and set initargs_found true if the return value is not an error
but a valid address.

Fixes: f61872bb58a1 ("bootconfig: Use parse_args() to find bootconfig and '--'")
Cc: stable@vger.kernel.org
Reported-by: Arvind Sankar <nivedita@alum.mit.edu>
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Changes in v2:
  - Remvoe unneede !IS_ERR().
---
 init/main.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/init/main.c b/init/main.c
index 0ead83e86b5a..883ded3638e5 100644
--- a/init/main.c
+++ b/init/main.c
@@ -387,8 +387,6 @@ static int __init bootconfig_params(char *param, char *val,
 {
 	if (strcmp(param, "bootconfig") == 0) {
 		bootconfig_found = true;
-	} else if (strcmp(param, "--") == 0) {
-		initargs_found = true;
 	}
 	return 0;
 }
@@ -399,19 +397,23 @@ static void __init setup_boot_config(const char *cmdline)
 	const char *msg;
 	int pos;
 	u32 size, csum;
-	char *data, *copy;
+	char *data, *copy, *err;
 	int ret;
 
 	/* Cut out the bootconfig data even if we have no bootconfig option */
 	data = get_boot_config_from_initrd(&size, &csum);
 
 	strlcpy(tmp_cmdline, boot_command_line, COMMAND_LINE_SIZE);
-	parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
-		   bootconfig_params);
+	err = parse_args("bootconfig", tmp_cmdline, NULL, 0, 0, 0, NULL,
+			 bootconfig_params);
 
-	if (!bootconfig_found)
+	if (IS_ERR(err) || !bootconfig_found)
 		return;
 
+	/* parse_args() stops at '--' and returns an address */
+	if (err)
+		initargs_found = true;
+
 	if (!data) {
 		pr_err("'bootconfig' found on command line, but no bootconfig found\n");
 		return;

