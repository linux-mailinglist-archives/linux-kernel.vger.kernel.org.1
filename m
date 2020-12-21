Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B822E022A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgLUVpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgLUVpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:45:20 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE736229F0;
        Mon, 21 Dec 2020 21:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608587078;
        bh=8WdveKLB0zbLmpci9DohSmjtTorXEvuwrMobkcLPPLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=P1C8ToxqHVTJdsULbh8L/ugUbhfGWeoj+v9iw0K/jDIK/1zkITxkOpJX4s2OG2Cwb
         nXJiXXcS6ipuzkuX8msCOTu45a0KoRFpLkJn15hqIeZk/IGVYbDqYy0L971Cp9BhE1
         VXP7nZNwASRoTPCT/U91saLyFgR0FiaZen4F79rT2rrqR/2vAQpQLuA7a0RQLeE6hg
         RR0ootwpAo5cy8ME+Vgp1rsfVo5j8M9lFNLTHefvZKVm+JWnqITo+sBZN30BHiAPXL
         i+GN4S1wEYMccNUWl5UXVpVNTmTwUvyQHgIh1vYon7fHREf3TZLdZ3jkUWaYDhl+8M
         P5ugRimd8h7TQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] tracing: Rework synthetic event command parsing
Date:   Mon, 21 Dec 2020 15:44:28 -0600
Message-Id: <cc39d3737ffa8b330c3d3754b062709dbc1c50f6.1608586464.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1608586464.git.zanussi@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
In-Reply-To: <cover.1608586464.git.zanussi@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that command parsing has been delegated to the create functions
and we're no longer constrained by argv_split(), we can modify the
synthetic event command parser to better match the higher-level
structure of the synthetic event commands, which is basically an event
name followed by a set of semicolon-separated fields.

Since we're also now passed the raw command, we can also save it
directly and can get rid of save_cmdstr().

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 184 +++++++++++++++---------------
 1 file changed, 90 insertions(+), 94 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index b2588a5650c9..66ccbab3483b 100644
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
@@ -579,7 +579,7 @@ static void free_synth_field(struct synth_field *field)
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(int argc, const char **argv,
+static struct synth_field *parse_synth_field(int argc, char **argv,
 					     int *consumed)
 {
 	struct synth_field *field;
@@ -588,9 +588,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	struct seq_buf s;
 	ssize_t size;
 
-	if (field_type[0] == ';')
-		field_type++;
-
 	if (!strcmp(field_type, "unsigned")) {
 		if (argc < 3) {
 			synth_err(SYNTH_ERR_INCOMPLETE_TYPE, errpos(field_type));
@@ -605,6 +602,11 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		*consumed = 2;
 	}
 
+	if (!field_name) {
+		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
+		return ERR_PTR(-EINVAL);
+	}
+
 	field = kzalloc(sizeof(*field), GFP_KERNEL);
 	if (!field)
 		return ERR_PTR(-ENOMEM);
@@ -613,8 +615,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	array = strchr(field_name, '[');
 	if (array)
 		len -= strlen(array);
-	else if (field_name[len - 1] == ';')
-		len--;
 
 	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
 	if (!field->name)
@@ -626,8 +626,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		goto free;
 	}
 
-	if (field_type[0] == ';')
-		field_type++;
 	len = strlen(field_type) + 1;
 
 	if (array)
@@ -644,11 +642,8 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	if (prefix)
 		seq_buf_puts(&s, prefix);
 	seq_buf_puts(&s, field_type);
-	if (array) {
+	if (array)
 		seq_buf_puts(&s, array);
-		if (s.buffer[s.len - 1] == ';')
-			s.len--;
-	}
 	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
 		goto free;
 
@@ -656,7 +651,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
-		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
@@ -1160,46 +1154,12 @@ int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd, const char *name,
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
-static int __create_synth_event(int argc, const char *name, const char **argv)
+static int __create_synth_event(const char *name, const char *raw_fields)
 {
+	int i, argc, n_fields = 0, ret = 0, consumed;
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
+	char **argv, *field_str, *tmp_fields, *saved_fields = NULL;
 	struct synth_event *event = NULL;
-	int i, consumed = 0, n_fields = 0, ret = 0;
-
-	ret = save_cmdstr(argc, name, argv);
-	if (ret)
-		return ret;
 
 	/*
 	 * Argument syntax:
@@ -1208,13 +1168,14 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	 *      where 'field' = type field_name
 	 */
 
-	if (name[0] == '\0' || argc < 1) {
+	mutex_lock(&event_mutex);
+
+	if (name[0] == '\0') {
 		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out;
 	}
 
-	mutex_lock(&event_mutex);
-
 	if (!is_good_name(name)) {
 		synth_err(SYNTH_ERR_BAD_NAME, errpos(name));
 		ret = -EINVAL;
@@ -1228,26 +1189,47 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 		goto out;
 	}
 
-	for (i = 0; i < argc - 1; i++) {
-		if (strcmp(argv[i], ";") == 0)
-			continue;
+	tmp_fields = saved_fields = kstrdup(raw_fields, GFP_KERNEL);
+	if (!tmp_fields) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
 		if (n_fields == SYNTH_FIELDS_MAX) {
 			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
 			ret = -EINVAL;
 			goto err;
 		}
 
-		field = parse_synth_field(argc - i, &argv[i], &consumed);
+		argv = argv_split(GFP_KERNEL, field_str, &argc);
+		if (!argv) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		if (!argc)
+			continue;
+
+		field = parse_synth_field(argc, argv, &consumed);
 		if (IS_ERR(field)) {
+			argv_free(argv);
 			ret = PTR_ERR(field);
 			goto err;
 		}
+
+		argv_free(argv);
+
+		if (consumed < argc) {
+			ret = -EINVAL;
+			goto err;
+		}
+
 		fields[n_fields++] = field;
-		i += consumed - 1;
 	}
 
-	if (i < argc && strcmp(argv[i], ";") != 0) {
-		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
+	if (n_fields == 0) {
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1266,6 +1248,8 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
  out:
 	mutex_unlock(&event_mutex);
 
+	kfree(saved_fields);
+
 	return ret;
  err:
 	for (i = 0; i < n_fields; i++)
@@ -1385,29 +1369,35 @@ EXPORT_SYMBOL_GPL(synth_event_delete);
 
 static int create_or_delete_synth_event(const char *raw_command)
 {
-	char **argv, *name = NULL;
-	int argc = 0, ret = 0;
+	char *name = NULL, *fields, *p;
+	int ret = 0;
 
-	argv = argv_split(GFP_KERNEL, raw_command, &argc);
-	if (!argv)
-		return -ENOMEM;
+	raw_command = skip_spaces(raw_command);
+	if (raw_command[0] == '\0')
+		return ret;
 
-	if (!argc)
-		goto free;
+	last_cmd_set(raw_command);
 
-	name = argv[0];
+	p = strpbrk(raw_command, " \t");
+	if (!p)
+		return -EINVAL;
+
+	name = kmemdup_nul(raw_command, p - raw_command, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	fields = skip_spaces(p);
 
-	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
 		ret = synth_event_delete(name + 1);
 		goto free;
 	}
 
-	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
+	ret = __create_synth_event(name, fields);
 free:
-	argv_free(argv);
+	kfree(name);
 
-	return ret == -ECANCELED ? -EINVAL : ret;
+	return ret;
 }
 
 static int synth_event_run_command(struct dynevent_cmd *cmd)
@@ -1953,39 +1943,45 @@ EXPORT_SYMBOL_GPL(synth_event_trace_end);
 
 static int create_synth_event(const char *raw_command)
 {
-	char **argv, *name;
-	int len, argc = 0, ret = 0;
+	char *fields, *p;
+	const char *name;
+	int len, ret = 0;
 
-	argv = argv_split(GFP_KERNEL, raw_command, &argc);
-	if (!argv) {
-		ret = -ENOMEM;
+	raw_command = skip_spaces(raw_command);
+	if (raw_command[0] == '\0')
 		return ret;
-	}
 
-	if (!argc)
-		goto free;
+	last_cmd_set(raw_command);
 
-	name = argv[0];
+	p = strpbrk(raw_command, " \t");
+	if (!p)
+		return -EINVAL;
 
-	if (name[0] != 's' || name[1] != ':') {
-		ret = -ECANCELED;
-		goto free;
-	}
+	fields = skip_spaces(p);
+
+	name = raw_command;
+
+	if (name[0] != 's' || name[1] != ':')
+		return -ECANCELED;
 	name += 2;
 
 	/* This interface accepts group name prefix */
 	if (strchr(name, '/')) {
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
-		if (len == 0) {
-			ret = -EINVAL;
-			goto free;
-		}
+		if (len == 0)
+			return -EINVAL;
 		name += len;
 	}
 
-	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
-free:
-	argv_free(argv);
+	len = name - raw_command;
+
+	name = kmemdup_nul(raw_command + len, p - raw_command - len, GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
+
+	ret = __create_synth_event(name, fields);
+
+	kfree(name);
 
 	return ret;
 }
-- 
2.17.1

