Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3AE290D6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgJPVsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728681AbgJPVsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:48:32 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2676A218AC;
        Fri, 16 Oct 2020 21:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602884910;
        bh=ltqIFdwUy5pA2Ikznoul8Ai1PCEMzrkmOAzjV+OJWlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Hg6BDRONDaEjzQyXbomPFdgR/Kd5jO8QCl2K4Kb/SJHTnWeWWj5JE6GRMjyd7yLO/
         D39pHA5BHvi6Sdh/FuqhPT90KrRUsSERDoojtfBHRSDQhrQp4S7A+fYG3NtY2P7OZb
         fSJTD04qlY3j3r6DtWT3/i9IFGEOXfKzkuLvrGWY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] tracing: Make trace_*_run_command() more flexible
Date:   Fri, 16 Oct 2020 16:48:22 -0500
Message-Id: <e29c3ae1fc46892ec792d6f6f910f75d0e12584c.1602883818.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602883818.git.zanussi@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
In-Reply-To: <cover.1602883818.git.zanussi@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trace_run_command() and therefore functions that use it, such as
trace_parse_run_command(), uses argv_split() to split the command into
an array of args then passed to the callback to handle.

This works fine for most commands but some commands would like to
allow the user to use and additional separator to visually group items
in the command.  One example would be synthetic event commands, which
use semicolons to group fields:

  echo 'event_name int a; char b[]; u64 lat' >> synthetic_events

What gets passed as an args array to the command for a command like
this include tokens that have semicolons included with the token,
which the callback then needs to strip out, since argv_split() only
looks at whitespace as a separator.

It would be nicer to just have trace_run_command() strip out the
semicolons at its level rather than passing that task onto the
callback.  To accomplish that, this change adds an 'additional_sep'
arg to a new __trace_run_command() function that allows a caller to
pass an additional separator char that if non-zero simply replaces
that character with whitespace before splitting the command into args.
The original trace_run_command() remains as-is in this regard, simply
calling __trace_run_command() with 0 for the separator, while making a
new trace_run_command_add_sep() version that can be used to pass in a
separator.

The other change here simply has __trace_run_command() make a copy of
the original command to work on, while leaving the original command
string untouched.  This untouched string is now passed into the
callback as well - this allows the callback to use the original string
for error processing and caret placement rather than forcing the
callback to recreate the original string from the args, which isn't
always possible.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace.c              | 41 +++++++++++++++++++++++++------
 kernel/trace/trace.h              | 12 ++++++---
 kernel/trace/trace_dynevent.c     |  4 +--
 kernel/trace/trace_events_synth.c |  5 ++--
 kernel/trace/trace_kprobe.c       |  5 ++--
 kernel/trace/trace_uprobe.c       |  5 ++--
 6 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 63c97012ed39..afa526414b25 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9367,30 +9367,56 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 }
 EXPORT_SYMBOL_GPL(ftrace_dump);
 
-int trace_run_command(const char *buf, int (*createfn)(int, char **))
+static int __trace_run_command(const char *buf,
+			       int (*createfn)(int, char **, const char *),
+			       char additional_sep)
 {
-	char **argv;
 	int argc, ret;
+	char **argv, *cmd;
+
+	cmd = kstrdup(buf, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	if (additional_sep)
+		strreplace(cmd, additional_sep, ' ');
 
 	argc = 0;
 	ret = 0;
-	argv = argv_split(GFP_KERNEL, buf, &argc);
-	if (!argv)
+	argv = argv_split(GFP_KERNEL, cmd, &argc);
+	if (!argv) {
+		kfree(cmd);
 		return -ENOMEM;
+	}
 
 	if (argc)
-		ret = createfn(argc, argv);
+		ret = createfn(argc, argv, buf);
 
 	argv_free(argv);
+	kfree(cmd);
 
 	return ret;
 }
 
+int trace_run_command(const char *buf, int (*createfn)(int, char **,
+						       const char *))
+{
+	return __trace_run_command(buf, createfn, 0);
+}
+
+int trace_run_command_add_sep(const char *buf,
+			      int (*createfn)(int, char **, const char *),
+			      char additional_sep)
+{
+	return __trace_run_command(buf, createfn, additional_sep);
+}
+
 #define WRITE_BUFSIZE  4096
 
 ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos,
-				int (*createfn)(int, char **))
+				int (*createfn)(int, char **, const char *),
+				char additional_sep)
 {
 	char *kbuf, *buf, *tmp;
 	int ret = 0;
@@ -9438,7 +9464,8 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 			if (tmp)
 				*tmp = '\0';
 
-			ret = trace_run_command(buf, createfn);
+			ret = trace_run_command_add_sep(buf, createfn,
+							additional_sep);
 			if (ret)
 				goto out;
 			buf += size;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 34e0c4d5a6e7..ae6e0c2ec028 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1982,10 +1982,16 @@ extern int tracing_set_cpumask(struct trace_array *tr,
 
 #define MAX_EVENT_NAME_LEN	64
 
-extern int trace_run_command(const char *buf, int (*createfn)(int, char**));
+extern int trace_run_command(const char *buf,
+			     int (*createfn)(int, char **, const char *));
+extern int trace_run_command_add_sep(const char *buf,
+				     int (*createfn)(int, char **, const char *),
+				     char additional_sep);
 extern ssize_t trace_parse_run_command(struct file *file,
-		const char __user *buffer, size_t count, loff_t *ppos,
-		int (*createfn)(int, char**));
+				       const char __user *buffer,
+				       size_t count, loff_t *ppos,
+				       int (*createfn)(int, char **, const char *),
+				       char additional_sep);
 
 extern unsigned int err_pos(char *cmd, const char *str);
 extern void tracing_log_err(struct trace_array *tr,
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 5fa49cfd2bb6..4dc21c1879ae 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -75,7 +75,7 @@ int dyn_event_release(int argc, char **argv, struct dyn_event_operations *type)
 	return ret;
 }
 
-static int create_dyn_event(int argc, char **argv)
+static int create_dyn_event(int argc, char **argv, const char *raw_cmd)
 {
 	struct dyn_event_operations *ops;
 	int ret = -ENODEV;
@@ -191,7 +191,7 @@ static ssize_t dyn_event_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_dyn_event);
+				       create_dyn_event, ';');
 }
 
 static const struct file_operations dynamic_events_ops = {
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 3212e2c653b3..e6659bb9a500 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1378,7 +1378,8 @@ int synth_event_delete(const char *event_name)
 }
 EXPORT_SYMBOL_GPL(synth_event_delete);
 
-static int create_or_delete_synth_event(int argc, char **argv)
+static int create_or_delete_synth_event(int argc, char **argv,
+					const char *raw_cmd)
 {
 	const char *name = argv[0];
 	int ret;
@@ -2046,7 +2047,7 @@ static ssize_t synth_events_write(struct file *file,
 				  size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_or_delete_synth_event);
+				       create_or_delete_synth_event, ';');
 }
 
 static const struct file_operations synth_events_fops = {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index b911e9f6d9f5..54af5ff58923 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -907,7 +907,8 @@ static int trace_kprobe_create(int argc, const char *argv[])
 	goto out;
 }
 
-static int create_or_delete_trace_kprobe(int argc, char **argv)
+static int create_or_delete_trace_kprobe(int argc, char **argv,
+					 const char *raw_cmd)
 {
 	int ret;
 
@@ -1159,7 +1160,7 @@ static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-				       create_or_delete_trace_kprobe);
+				       create_or_delete_trace_kprobe, 0);
 }
 
 static const struct file_operations kprobe_events_ops = {
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 3cf7128e1ad3..b2840003b851 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -716,7 +716,8 @@ static int trace_uprobe_create(int argc, const char **argv)
 	return ret;
 }
 
-static int create_or_delete_trace_uprobe(int argc, char **argv)
+static int create_or_delete_trace_uprobe(int argc, char **argv,
+					 const char *raw_cmd)
 {
 	int ret;
 
@@ -793,7 +794,7 @@ static ssize_t probes_write(struct file *file, const char __user *buffer,
 			    size_t count, loff_t *ppos)
 {
 	return trace_parse_run_command(file, buffer, count, ppos,
-					create_or_delete_trace_uprobe);
+				       create_or_delete_trace_uprobe, 0);
 }
 
 static const struct file_operations uprobe_events_ops = {
-- 
2.17.1

