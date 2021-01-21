Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB6872FF157
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387948AbhAURGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732845AbhAURB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:01:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08B1023A59;
        Thu, 21 Jan 2021 17:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611248476;
        bh=LgE5J3cvyyaOWT0egghEk2Qt3juf5lbXpLLiktUi9aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=BfS/fS9FhjAfM8eQkE3qT3/Xgi0pBYKB5h/DgdkmyEwIStLyqa8Jn1a8LwCnTn8iR
         JCsyHEktAKNRpOmLxumjdZbxYzOs956N4ZlDXeytvuecThWZLyKpuwzWiJt8K7VgJU
         TOUNJ/9hi85kel0TLWsd/L6J7GremrABqrgC7iBSNBNSjaA26v+QJ+1FM/iAA0rT8W
         RvUkmUtRaWALNvBfFBZevFvX9//END7EUVFvaZ36E70M2aVFllQMDYAjtNdd+1O0CJ
         JTl7ly+8YnBNXv2jF9OqrlqthdyFyC0f3NKqsfIwAWIkM6V5F635wqdrSiopD9+HGQ
         CB0x9MJaVNWTw==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] tracing: Rework synthetic event command parsing
Date:   Thu, 21 Jan 2021 11:01:05 -0600
Message-Id: <f3c2d2841307de0a7624a250f8f9653d435602c9.1611243025.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
In-Reply-To: <cover.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
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
 kernel/trace/trace_events_synth.c | 198 +++++++++++++++---------------
 1 file changed, 98 insertions(+), 100 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index b2588a5650c9..a79c17b97add 100644
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
@@ -579,18 +579,14 @@ static void free_synth_field(struct synth_field *field)
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(int argc, const char **argv,
-					     int *consumed)
+static struct synth_field *parse_synth_field(int argc, char **argv)
 {
-	struct synth_field *field;
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
-	int len, ret = -ENOMEM;
+	int len, consumed, ret = -ENOMEM;
+	struct synth_field *field;
 	struct seq_buf s;
 	ssize_t size;
 
-	if (field_type[0] == ';')
-		field_type++;
-
 	if (!strcmp(field_type, "unsigned")) {
 		if (argc < 3) {
 			synth_err(SYNTH_ERR_INCOMPLETE_TYPE, errpos(field_type));
@@ -599,10 +595,20 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		prefix = "unsigned ";
 		field_type = argv[1];
 		field_name = argv[2];
-		*consumed = 3;
+		consumed = 3;
 	} else {
 		field_name = argv[1];
-		*consumed = 2;
+		consumed = 2;
+	}
+
+	if (consumed < argc) {
+		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (!field_name) {
+		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
+		return ERR_PTR(-EINVAL);
 	}
 
 	field = kzalloc(sizeof(*field), GFP_KERNEL);
@@ -613,8 +619,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	array = strchr(field_name, '[');
 	if (array)
 		len -= strlen(array);
-	else if (field_name[len - 1] == ';')
-		len--;
 
 	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
 	if (!field->name)
@@ -626,8 +630,6 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		goto free;
 	}
 
-	if (field_type[0] == ';')
-		field_type++;
 	len = strlen(field_type) + 1;
 
 	if (array)
@@ -644,11 +646,8 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
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
 
@@ -1160,46 +1159,12 @@ int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd, const char *name,
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
+	char **argv, *field_str, *tmp_fields, *saved_fields = NULL;
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
+	int i, argc, n_fields = 0, ret = 0;
 	struct synth_event *event = NULL;
-	int i, consumed = 0, n_fields = 0, ret = 0;
-
-	ret = save_cmdstr(argc, name, argv);
-	if (ret)
-		return ret;
 
 	/*
 	 * Argument syntax:
@@ -1208,13 +1173,14 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
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
@@ -1228,26 +1194,41 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 		goto out;
 	}
 
-	for (i = 0; i < argc - 1; i++) {
-		if (strcmp(argv[i], ";") == 0)
-			continue;
-		if (n_fields == SYNTH_FIELDS_MAX) {
-			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
-			ret = -EINVAL;
+	tmp_fields = saved_fields = kstrdup(raw_fields, GFP_KERNEL);
+	if (!tmp_fields) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	while ((field_str = strsep(&tmp_fields, ";")) != NULL) {
+		argv = argv_split(GFP_KERNEL, field_str, &argc);
+		if (!argv) {
+			ret = -ENOMEM;
 			goto err;
 		}
 
-		field = parse_synth_field(argc - i, &argv[i], &consumed);
+		if (!argc)
+			continue;
+
+		field = parse_synth_field(argc, argv);
 		if (IS_ERR(field)) {
+			argv_free(argv);
 			ret = PTR_ERR(field);
 			goto err;
 		}
+
+		argv_free(argv);
+
 		fields[n_fields++] = field;
-		i += consumed - 1;
+		if (n_fields == SYNTH_FIELDS_MAX) {
+			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
+			ret = -EINVAL;
+			goto err;
+		}
 	}
 
-	if (i < argc && strcmp(argv[i], ";") != 0) {
-		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
+	if (n_fields == 0) {
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1266,6 +1247,8 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
  out:
 	mutex_unlock(&event_mutex);
 
+	kfree(saved_fields);
+
 	return ret;
  err:
 	for (i = 0; i < n_fields; i++)
@@ -1385,29 +1368,38 @@ EXPORT_SYMBOL_GPL(synth_event_delete);
 
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
+
+	last_cmd_set(raw_command);
 
-	if (!argc)
+	p = strpbrk(raw_command, " \t");
+	if (!p && raw_command[0] != '!') {
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		ret = -EINVAL;
 		goto free;
+	}
 
-	name = argv[0];
+	name = kmemdup_nul(raw_command, p ? p - raw_command : strlen(raw_command), GFP_KERNEL);
+	if (!name)
+		return -ENOMEM;
 
-	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
 		ret = synth_event_delete(name + 1);
 		goto free;
 	}
 
-	ret = __create_synth_event(argc - 1, name, (const char **)argv + 1);
+	fields = skip_spaces(p);
+
+	ret = __create_synth_event(name, fields);
 free:
-	argv_free(argv);
+	kfree(name);
 
-	return ret == -ECANCELED ? -EINVAL : ret;
+	return ret;
 }
 
 static int synth_event_run_command(struct dynevent_cmd *cmd)
@@ -1953,39 +1945,45 @@ EXPORT_SYMBOL_GPL(synth_event_trace_end);
 
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

