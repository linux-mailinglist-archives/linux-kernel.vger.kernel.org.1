Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9761DA125
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 21:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgESTmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 15:42:43 -0400
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:40990 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726059AbgESTml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:42:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8B36F182CED5B;
        Tue, 19 May 2020 19:42:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:69:355:379:541:800:960:973:988:989:1260:1311:1314:1345:1359:1437:1515:1535:1544:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3165:3355:3865:3866:3870:3871:5007:6119:6120:6261:7875:8603:9036:9592:10004:10848:11026:11233:11473:11658:11914:12043:12048:12294:12296:12297:12438:12555:12679:12895:13095:13255:13894:14181:14721:14819:21080:21433:21451:21627:21795:21939:21966:21990:30051:30054,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: balls64_4511c8926d0f
X-Filterd-Recvd-Size: 5642
Received: from joe-laptop.perches.com (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 19 May 2020 19:42:39 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] printk: Move and rename maximum printk output line length defines
Date:   Tue, 19 May 2020 12:42:34 -0700
Message-Id: <f37c12c0df59b876236827fcd05b518e28d11a6c.1589916689.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1589916689.git.joe@perches.com>
References: <cover.1589916689.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the printk maximum line length globally available.

Miscellanea:

o Prefix the defines with PRINTK_

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/printk.h | 18 ++++++++++++++++++
 kernel/printk/printk.c | 28 ++++++++++------------------
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 38beb97e7018..850dc4d4356f 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -43,6 +43,24 @@ static inline const char *printk_skip_headers(const char *buffer)
 
 #define CONSOLE_EXT_LOG_MAX	8192
 
+/* Maximum length of a single printk */
+
+#ifdef CONFIG_PRINTK
+
+#ifdef CONFIG_PRINTK_CALLER
+#define PRINTK_PREFIX_MAX	48
+#else
+#define PRINTK_PREFIX_MAX	32
+#endif
+#define PRINTK_LOG_LINE_MAX	(1024 - PRINTK_PREFIX_MAX)
+
+#else
+
+#define PRINTK_PREFIX_MAX	0
+#define PRINTK_LOG_LINE_MAX	0
+
+#endif
+
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4f1cc4acef41..fc22a494ef0c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -443,13 +443,6 @@ static u64 exclusive_console_stop_seq;
 static u64 clear_seq;
 static u32 clear_idx;
 
-#ifdef CONFIG_PRINTK_CALLER
-#define PREFIX_MAX		48
-#else
-#define PREFIX_MAX		32
-#endif
-#define LOG_LINE_MAX		(1024 - PREFIX_MAX)
-
 #define LOG_LEVEL(v)		((v) & 0x07)
 #define LOG_FACILITY(v)		((v) >> 3 & 0xff)
 
@@ -825,7 +818,7 @@ static ssize_t devkmsg_write(struct kiocb *iocb, struct iov_iter *from)
 	size_t len = iov_iter_count(from);
 	ssize_t ret = len;
 
-	if (!user || len > LOG_LINE_MAX)
+	if (!user || len > PRINTK_LOG_LINE_MAX)
 		return -EINVAL;
 
 	/* Ignore when user logging is disabled. */
@@ -1341,7 +1334,7 @@ static size_t msg_print_text(const struct printk_log *msg, bool syslog,
 	const char *text = log_text(msg);
 	size_t text_size = msg->text_len;
 	size_t len = 0;
-	char prefix[PREFIX_MAX];
+	char prefix[PRINTK_PREFIX_MAX];
 	const size_t prefix_len = print_prefix(msg, syslog, time, prefix);
 
 	do {
@@ -1382,7 +1375,7 @@ static int syslog_print(char __user *buf, int size)
 	struct printk_log *msg;
 	int len = 0;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(PRINTK_LOG_LINE_MAX + PRINTK_PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
@@ -1412,7 +1405,7 @@ static int syslog_print(char __user *buf, int size)
 		skip = syslog_partial;
 		msg = log_from_idx(syslog_idx);
 		n = msg_print_text(msg, true, syslog_time, text,
-				   LOG_LINE_MAX + PREFIX_MAX);
+				   PRINTK_LOG_LINE_MAX + PRINTK_PREFIX_MAX);
 		if (n - syslog_partial <= size) {
 			/* message fits into buffer, move forward */
 			syslog_idx = log_next(syslog_idx);
@@ -1454,7 +1447,7 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	u32 idx;
 	bool time;
 
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
+	text = kmalloc(PRINTK_LOG_LINE_MAX + PRINTK_PREFIX_MAX, GFP_KERNEL);
 	if (!text)
 		return -ENOMEM;
 
@@ -1492,7 +1485,8 @@ static int syslog_print_all(char __user *buf, int size, bool clear)
 	while (len >= 0 && seq < next_seq) {
 		struct printk_log *msg = log_from_idx(idx);
 		int textlen = msg_print_text(msg, true, time, text,
-					     LOG_LINE_MAX + PREFIX_MAX);
+					     PRINTK_LOG_LINE_MAX +
+					     PRINTK_PREFIX_MAX);
 
 		idx = log_next(idx);
 		seq++;
@@ -1845,7 +1839,7 @@ static inline u32 printk_caller_id(void)
  * reached the console in case of a kernel crash.
  */
 static struct cont {
-	char buf[LOG_LINE_MAX];
+	char buf[PRINTK_LOG_LINE_MAX];
 	size_t len;			/* length == 0 means unused buffer */
 	u32 caller_id;			/* printk_caller_id() of first print */
 	u64 ts_nsec;			/* time of first print */
@@ -1931,7 +1925,7 @@ int vprintk_store(int facility, int level,
 		  const char *dict, size_t dictlen,
 		  const char *fmt, va_list args)
 {
-	static char textbuf[LOG_LINE_MAX];
+	static char textbuf[PRINTK_LOG_LINE_MAX];
 	char *text = textbuf;
 	size_t text_len;
 	enum log_flags lflags = 0;
@@ -2088,8 +2082,6 @@ EXPORT_SYMBOL(printk);
 
 #else /* CONFIG_PRINTK */
 
-#define LOG_LINE_MAX		0
-#define PREFIX_MAX		0
 #define printk_time		false
 
 static u64 syslog_seq;
@@ -2396,7 +2388,7 @@ static inline int can_use_console(void)
 void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
-	static char text[LOG_LINE_MAX + PREFIX_MAX];
+	static char text[PRINTK_LOG_LINE_MAX + PRINTK_PREFIX_MAX];
 	unsigned long flags;
 	bool do_cond_resched, retry;
 
-- 
2.25.1

