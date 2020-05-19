Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451B31DA126
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgESTmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:42:45 -0400
Received: from smtprelay0237.hostedemail.com ([216.40.44.237]:41006 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726943AbgESTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:42:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5BEBB182CED2A;
        Tue, 19 May 2020 19:42:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1534:1541:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:3138:3139:3140:3141:3142:3353:3865:4605:5007:6120:6261:7875:10004:11026:11473:11658:11914:12043:12291:12296:12297:12555:12683:12895:13069:13311:13357:13894:14110:14181:14384:14721:21080:21324:21627:30054:30090,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:10,LUA_SUMMARY:none
X-HE-Tag: touch60_4a0551226d0f
X-Filterd-Recvd-Size: 2634
Received: from joe-laptop.perches.com (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 19:42:41 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 2/2] init: Allow multi-line output of kernel command line
Date:   Tue, 19 May 2020 12:42:35 -0700
Message-Id: <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1589916689.git.joe@perches.com>
References: <cover.1589916689.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARM may have its longest possible command line larger than the longest
possible printk.

If necessary, emit the commend line on multiple lines.

Signed-off-by: Joe Perches <joe@perches.com>
---

compiled, untested

 init/main.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index b63a3c001ac4..b3ebbbc129ae 100644
--- a/init/main.c
+++ b/init/main.c
@@ -826,6 +826,34 @@ void __init __weak arch_call_rest_init(void)
 	rest_init();
 }
 
+static void __init print_cmdline(char *line)
+{
+#ifdef CONFIG_PRINTK
+	const char *prefix = "Kernel command line";
+	size_t len = strlen(line);
+
+	while (len > PRINTK_LOG_LINE_MAX) {
+		char *pos = line;
+		char *last_pos = pos + PRINTK_LOG_LINE_MAX - 1;
+		char saved_char;
+		/* Find last space char within the maximum line length */
+		while ((pos = memchr(pos, ' ', len - (pos - line))) &&
+		       (pos - line) < PRINTK_LOG_LINE_MAX - 1) {
+			last_pos = pos;
+		}
+		saved_char = line[last_pos - line];
+		line[last_pos - line] = 0;
+		pr_notice("%s: %s\n", prefix, line);
+		prefix = "Kernel command line (continued)";
+		line[last_pos - line] = saved_char;
+		len -= pos - line;
+		line += pos - line;
+	}
+
+	pr_notice("%s: %s\n", prefix, line);
+#endif
+}
+
 asmlinkage __visible void __init start_kernel(void)
 {
 	char *command_line;
@@ -859,7 +887,8 @@ asmlinkage __visible void __init start_kernel(void)
 	build_all_zonelists(NULL);
 	page_alloc_init();
 
-	pr_notice("Kernel command line: %s\n", saved_command_line);
+	print_cmdline(saved_command_line);
+
 	/* parameters may set static keys */
 	jump_label_init();
 	parse_early_param();
-- 
2.25.1

