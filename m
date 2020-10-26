Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74229907D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783120AbgJZPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:06:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1783098AbgJZPGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:06:21 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7443B239D2;
        Mon, 26 Oct 2020 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603724780;
        bh=0S1lNpt6nPnQcmwiQtEKAjQ4DLfZe9YHBSGXOYUKwIY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=kDXS8pV5H8cZkE5gUkles6CYsF7RTltSpO0i/d15jCGx7WpUpFC5nCYDWWI+hPQWD
         4Qj7Zs4XFRoK5wzow/SwLXtgHanjDlsyf3zG17D0sekE9bUXp1l6YoFxBFYuzsKMwV
         Vv1tOaxJIEGjBmdOGHe4MFG3jkYaAibEPkbdJnXc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] tracing: Update synth command errors
Date:   Mon, 26 Oct 2020 10:06:11 -0500
Message-Id: <8671adc7ce95ff1d5c7b037d371467e96f7f2914.1603723933.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603723933.git.zanussi@kernel.org>
References: <cover.1603723933.git.zanussi@kernel.org>
In-Reply-To: <cover.1603723933.git.zanussi@kernel.org>
References: <cover.1603723933.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since array types are handled differently, errors referencing them
also need to be handled differently.  Add and use a new
INVALID_ARRAY_SPEC error.  Also add INVALID_CMD and INVALID_DYN_CMD to
catch and display the correct form for badly-formed commands, which
can also be used in place of CMD_INCOMPLETE, which is removed, and
remove CMD_TOO_LONG, since it's no longer used.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 68 +++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 0d2fe4b6bd94..fdf0e85c0b8a 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -23,13 +23,14 @@
 #undef ERRORS
 #define ERRORS	\
 	C(BAD_NAME,		"Illegal name"),		\
-	C(CMD_INCOMPLETE,	"Incomplete command"),		\
+	C(INVALID_CMD,		"Command must be of the form: <name> field[;field] ..."),\
+	C(INVALID_DYN_CMD,	"Command must be of the form: s or -:[synthetic/]<name> field[;field] ..."),\
 	C(EVENT_EXISTS,		"Event already exists"),	\
 	C(TOO_MANY_FIELDS,	"Too many fields"),		\
 	C(INCOMPLETE_TYPE,	"Incomplete type"),		\
 	C(INVALID_TYPE,		"Invalid type"),		\
-	C(INVALID_FIELD,	"Invalid field"),		\
-	C(CMD_TOO_LONG,		"Command too long"),
+	C(INVALID_FIELD,        "Invalid field"),		\
+	C(INVALID_ARRAY_SPEC,	"Invalid array specification"),
 
 #undef C
 #define C(a, b)		SYNTH_ERR_##a
@@ -648,6 +649,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
+		if (array)
+			synth_err(SYNTH_ERR_INVALID_ARRAY_SPEC, errpos(field_name));
+		else
+			synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
@@ -1169,7 +1174,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	mutex_lock(&event_mutex);
 
 	if (name[0] == '\0') {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1222,7 +1227,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	}
 
 	if (n_fields == 0) {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1360,6 +1365,37 @@ int synth_event_delete(const char *event_name)
 }
 EXPORT_SYMBOL_GPL(synth_event_delete);
 
+static int check_command(const char *raw_command)
+{
+	char **argv = NULL, *cmd, *saved_cmd, *name_and_field;
+	int argc, ret = 0;
+
+	cmd = saved_cmd = kstrdup(raw_command, GFP_KERNEL);
+	if (!cmd)
+		return -ENOMEM;
+
+	name_and_field = strsep(&cmd, ";");
+	if (!name_and_field) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	argv = argv_split(GFP_KERNEL, name_and_field, &argc);
+	if (!argv) {
+		ret = -ENOMEM;
+		goto free;
+	}
+
+	if (argc < 3)
+		ret = -EINVAL;
+free:
+	kfree(saved_cmd);
+	if (argv)
+		argv_free(argv);
+
+	return ret;
+}
+
 static int create_or_delete_synth_event(const char *raw_command)
 {
 	char *name = NULL, *fields, *p;
@@ -1372,12 +1408,16 @@ static int create_or_delete_synth_event(const char *raw_command)
 	last_cmd_set(raw_command);
 
 	ret = check_command(raw_command);
-	if (ret)
+	if (ret) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		return ret;
+	}
 
 	p = strpbrk(raw_command, " \t");
-	if (!p)
+	if (!p) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		return -EINVAL;
+	}
 
 	name = kmemdup_nul(raw_command, p - raw_command, GFP_KERNEL);
 	fields = skip_spaces(p);
@@ -1948,8 +1988,10 @@ static int create_synth_event(const char *raw_command)
 	last_cmd_set(raw_command);
 
 	p = strpbrk(raw_command, " \t");
-	if (!p)
+	if (!p) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		return -EINVAL;
+	}
 
 	fields = skip_spaces(p);
 
@@ -1962,13 +2004,21 @@ static int create_synth_event(const char *raw_command)
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
-		if (len == 0)
+		if (len == 0) {
+			synth_err(SYNTH_ERR_INVALID_DYN_CMD, 0);
 			return -EINVAL;
+		}
 		name += len;
 	}
 
 	len = name - raw_command;
 
+	ret = check_command(raw_command + len);
+	if (ret) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
+		return ret;
+	}
+
 	name = kmemdup_nul(raw_command + len, p - raw_command - len, GFP_KERNEL);
 	ret = __create_synth_event(name, fields);
 
-- 
2.17.1

