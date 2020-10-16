Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5420D290D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbgJPVse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729088AbgJPVsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:48:33 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E83221D40;
        Fri, 16 Oct 2020 21:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602884912;
        bh=sQZcff7p63JdqRogIZiVWws9Zr97x6m0gZ7qvNtQwIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=GD/KZkVe8d8l5x73p+olDC91fhhMTMiobrm34tO/We2ZKq/6M9rNoaamr9vgyZX9s
         om/ug6bdJB+A6se177LSq3hRqe1QHbF6K2Tq1ulyj7wvyNVKLGYyZA9GeWWXWNgHbg
         x1ptnO7S8g03L81+mE/JQgOcqlMXBfQlKsdk2cUc=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] tracing: Use new trace_run_command() options
Date:   Fri, 16 Oct 2020 16:48:23 -0500
Message-Id: <abaff3ec048261c32a0e17b1ee6efc80ca04a6c8.1602883818.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602883818.git.zanussi@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
In-Reply-To: <cover.1602883818.git.zanussi@kernel.org>
References: <cover.1602883818.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the synthetic event command passes in ';' as an additional
separator to trace_parse_run_command(), all of the parsing related to
semicolon can be removed.

Additionally, the since create_or_delete_synth_event() now receives
the raw command string, it doesn't need save_cmdstr(), which can also
be removed.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 65 ++++---------------------------
 1 file changed, 8 insertions(+), 57 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e6659bb9a500..2333025ef31e 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -48,7 +48,7 @@ static int errpos(const char *str)
 	return err_pos(last_cmd, str);
 }
 
-static void last_cmd_set(char *str)
+static void last_cmd_set(const char *str)
 {
 	if (!str)
 		return;
@@ -587,9 +587,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	int len, ret = 0;
 	ssize_t size;
 
-	if (field_type[0] == ';')
-		field_type++;
-
 	if (!strcmp(field_type, "unsigned")) {
 		if (argc < 3) {
 			synth_err(SYNTH_ERR_INCOMPLETE_TYPE, errpos(field_type));
@@ -612,8 +609,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	array = strchr(field_name, '[');
 	if (array)
 		len -= strlen(array);
-	else if (field_name[len - 1] == ';')
-		len--;
 
 	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
 	if (!field->name) {
@@ -626,17 +621,11 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		goto free;
 	}
 
-	if (field_type[0] == ';')
-		field_type++;
 	len = strlen(field_type) + 1;
 
-        if (array) {
-                int l = strlen(array);
+        if (array)
+                len += strlen(array);
 
-                if (l && array[l - 1] == ';')
-                        l--;
-                len += l;
-        }
 	if (prefix)
 		len += strlen(prefix);
 
@@ -648,11 +637,8 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	if (prefix)
 		strcat(field->type, prefix);
 	strcat(field->type, field_type);
-	if (array) {
+	if (array)
 		strcat(field->type, array);
-		if (field->type[len - 1] == ';')
-			field->type[len - 1] = '\0';
-	}
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
@@ -1155,47 +1141,12 @@ int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd, const char *name,
 }
 EXPORT_SYMBOL_GPL(synth_event_gen_cmd_array_start);
 
-static int save_cmdstr(int argc, const char *name, const char **argv)
-{
-	struct seq_buf s;
-	char *buf;
-	int i;
-
-	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	seq_buf_init(&s, buf, MAX_DYNEVENT_CMD_LEN);
-
-	seq_buf_puts(&s, name);
-
-	for (i = 0; i < argc; i++) {
-		seq_buf_putc(&s, ' ');
-		seq_buf_puts(&s, argv[i]);
-	}
-
-	if (!seq_buf_buffer_left(&s)) {
-		synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
-		kfree(buf);
-		return -EINVAL;
-	}
-	buf[s.len] = 0;
-	last_cmd_set(buf);
-
-	kfree(buf);
-	return 0;
-}
-
 static int __create_synth_event(int argc, const char *name, const char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
 	struct synth_event *event = NULL;
 	int i, consumed = 0, n_fields = 0, ret = 0;
 
-	ret = save_cmdstr(argc, name, argv);
-	if (ret)
-		return ret;
-
 	/*
 	 * Argument syntax:
 	 *  - Add synthetic event: <event_name> field[;field] ...
@@ -1224,8 +1175,6 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	}
 
 	for (i = 0; i < argc - 1; i++) {
-		if (strcmp(argv[i], ";") == 0)
-			continue;
 		if (n_fields == SYNTH_FIELDS_MAX) {
 			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
 			ret = -EINVAL;
@@ -1241,7 +1190,7 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 		i += consumed - 1;
 	}
 
-	if (i < argc && strcmp(argv[i], ";") != 0) {
+	if (i < argc) {
 		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
 		ret = -EINVAL;
 		goto err;
@@ -1384,6 +1333,8 @@ static int create_or_delete_synth_event(int argc, char **argv,
 	const char *name = argv[0];
 	int ret;
 
+	last_cmd_set(raw_cmd);
+
 	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
 		ret = synth_event_delete(name + 1);
@@ -1399,7 +1350,7 @@ static int synth_event_run_command(struct dynevent_cmd *cmd)
 	struct synth_event *se;
 	int ret;
 
-	ret = trace_run_command(cmd->seq.buffer, create_or_delete_synth_event);
+	ret = trace_run_command_add_sep(cmd->seq.buffer, create_or_delete_synth_event, ';');
 	if (ret)
 		return ret;
 
-- 
2.17.1

