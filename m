Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABCE72E022C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgLUVpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:58454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726429AbgLUVpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:45:22 -0500
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B04AC22AAA;
        Mon, 21 Dec 2020 21:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608587081;
        bh=HCHz4uU83qXokjVFQ2uLiZUV9IvWcjE9twzkv+fmMDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=KpTLMFOvVVm2T03in1OjzQIV2tyIFvTaL0Y5PAZdWDzgy+vaEQJv3FDUlj9y/SRdi
         KyUQqlm4HL1jMtJmJF48Pql1coW0OjED/BBWd5ppAr8zROkREGLFsMvWh68Yodwh5l
         UD7oNVan9P+Udm9v5McjJf03NHWwuWu9NvtAjkV3RjijbdvWW3PwCJoNqM6JH0Ernu
         YGS7Sy2OOY77R/zznj3f26CVHINI1F2qikFOGyId/hpQZQ0Lb1fJwKeQxfXkzFihS1
         2/qrjp+oqwnyLCKWIiHMSs53xz6d+lrVMd/5d2/GPOUjLXbc56s0imrDQZ8iSWPC9G
         frN9yvAfX3K3g==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] tracing: Add a backward-compatibility check for synthetic event creation
Date:   Mon, 21 Dec 2020 15:44:30 -0600
Message-Id: <fd1299dbfc04a338b017576afb669a8b0d2a527f.1608586464.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1608586464.git.zanussi@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
In-Reply-To: <cover.1608586464.git.zanussi@kernel.org>
References: <cover.1608586464.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthetic event parsing rework requiring semicolons between
synthetic event fields.  That requirement breaks existing users who
might already have used the old form, so this adds a pre-parsing pass
that adds semicolons between fields to any string missing them.  If
none are required, the original string is used.

In the future, if/when new features are added, the requirement will be
that any string containing the new feature will be required to use
semicolons, and the audit_old_buffer() check can check for those and
avoid the pre-parsing semicolon pass altogether.

As it stands, the pre-parsing pass creates a new string with
semicolons only if one or more semicolons were actually needed and
only if no errors were found in pre-parsing.  The assumption is that
the real parsing pass will find and flag any errors and the user
should see them in reference to the original unmodified string.

[ zanussi: Added missing variable initializations reported by Dan
  Carpenter <dan.carpenter@oracle.com> and kernel test robot
  <lkp@intel.com> ]

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 292 ++++++++++++++++++++++++++++--
 1 file changed, 272 insertions(+), 20 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 2a9c8bf74bb2..2aaa1a202beb 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1373,6 +1373,243 @@ int synth_event_delete(const char *event_name)
 }
 EXPORT_SYMBOL_GPL(synth_event_delete);
 
+static int save_synth_field(int argc, char **argv, int *consumed,
+			    struct seq_buf *s, bool *added_semi)
+{
+	const char *prefix = NULL, *field_name, *field_type = argv[0];
+	const char *save_field_type, *array, *next_tok;
+	int len, ret = -EINVAL;
+	struct seq_buf f;
+	ssize_t size;
+	char *tmp;
+
+	*added_semi = false;
+
+	if (field_type[0] == ';')
+		field_type++;
+
+	if (!strcmp(field_type, "unsigned")) {
+		if (argc < 3)
+			goto out;
+		prefix = "unsigned";
+		field_type = argv[1];
+		field_name = argv[2];
+		*consumed = 3;
+	} else {
+		field_type = argv[0];
+		field_name = argv[1];
+		*consumed = 2;
+	}
+
+	len = strlen(field_name);
+	array = strchr(field_name, '[');
+	if (array)
+		len -= strlen(array);
+	else if (field_name[len - 1] == ';')
+		len--;
+
+	tmp = kmemdup_nul(field_name, len, GFP_KERNEL);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (!is_good_name(tmp)) {
+		kfree(tmp);
+		goto out;
+	}
+
+	kfree(tmp);
+
+	save_field_type = field_type;
+	if (field_type[0] == ';')
+		field_type++;
+	len = strlen(field_type) + 1;
+
+	if (array)
+		len += strlen(array);
+
+	if (prefix)
+		len += strlen(prefix) + 1;
+
+	tmp = kzalloc(len, GFP_KERNEL);
+	if (!tmp) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	seq_buf_init(&f, tmp, len);
+	if (prefix) {
+		seq_buf_puts(&f, prefix);
+		seq_buf_putc(&f, ' ');
+	}
+	seq_buf_puts(&f, field_type);
+	if (array) {
+		seq_buf_puts(&f, array);
+		if (f.buffer[f.len - 1] == ';')
+			f.len--;
+	}
+	if (WARN_ON_ONCE(!seq_buf_buffer_left(&f))) {
+		kfree(tmp);
+		goto out;
+	}
+
+	f.buffer[f.len] = '\0';
+
+	field_type = save_field_type;
+
+	size = synth_field_size(tmp);
+	if (size < 0 || ((size == 0) && (!synth_field_is_string(tmp)))) {
+		kfree(tmp);
+		goto out;
+	}
+
+	kfree(tmp);
+
+	if (prefix) {
+		seq_buf_puts(s, prefix);
+		seq_buf_putc(s, ' ');
+	}
+	seq_buf_puts(s, field_type);
+	seq_buf_putc(s, ' ');
+	seq_buf_puts(s, field_name);
+	if (field_name[strlen(field_name) - 1] == ';')
+		seq_buf_putc(s, ' ');
+
+	if (*consumed < argc) {
+		next_tok = argv[*consumed];
+		if (field_name[strlen(field_name) - 1] != ';' &&
+		    next_tok[0] != ';') {
+			seq_buf_puts(s, "; ");
+			*added_semi = true;
+		}
+	}
+
+	ret = 0;
+ out:
+	return ret;
+}
+
+static char *insert_semicolons(const char *raw_command)
+{
+	int i, argc = 0, consumed = 0, n_fields = 0, semis_added = 0;
+	char *name, **argv, **save_argv = NULL, *buf = NULL;
+	int ret = -EINVAL;
+	struct seq_buf s;
+	bool added_semi;
+
+	argv = argv_split(GFP_KERNEL, raw_command, &argc);
+	if (!argv)
+		return NULL;
+
+	if (!argc)
+		goto free;
+
+	name = argv[0];
+	save_argv = argv;
+	argv++;
+	argc--;
+
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	seq_buf_init(&s, buf, MAX_DYNEVENT_CMD_LEN);
+
+	seq_buf_puts(&s, name);
+	seq_buf_putc(&s, ' ');
+
+	if (name[0] == '\0' || argc < 1)
+		goto err;
+
+	for (i = 0; i < argc - 1; i++) {
+		if (strcmp(argv[i], ";") == 0) {
+			seq_buf_puts(&s, " ; ");
+			continue;
+		}
+
+		if (n_fields == SYNTH_FIELDS_MAX)
+			goto err;
+
+		ret = save_synth_field(argc - i, &argv[i], &consumed,
+				       &s, &added_semi);
+		if (ret)
+			goto err;
+
+		if (added_semi)
+			semis_added++;
+
+		i += consumed - 1;
+	}
+
+	if (i < argc && strcmp(argv[i], ";") != 0)
+		goto err;
+
+	if (!semis_added) {
+		kfree(buf);
+		buf = NULL;
+		goto free;
+	}
+
+	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
+		goto err;
+
+	buf[s.len] = '\0';
+ free:
+	if (save_argv)
+		argv_free(save_argv);
+
+	return buf;
+ err:
+	kfree(buf);
+	buf = ERR_PTR(ret);
+
+	goto free;
+}
+
+static bool audit_old_buffer(const char *cmd)
+{
+	/* as of now, every cmd is an old cmd */
+	return true;
+}
+
+/**
+ * get_parseable_cmd - Return a modifiable string for parsing
+ * @raw_command: The command to start with
+ *
+ * Create a cmd string that can be modified by the caller for command
+ * parsing purposes. If successful, the caller must free the command
+ * returned.
+ *
+ * The input string will first be checked to see whether or not it can
+ * be considered an 'old command' - a command that doesn't require
+ * semicolons between fields - for which backward compatibility must
+ * be maintained.  If it can be considered an old command, a semicolon
+ * will be added between any two fields missing one.  If no semicolons
+ * were required, or if the preparsing required for the pass
+ * encountered errors, a modifiable copy of the original string will
+ * be returned.
+ *
+ * Return: parseable cmd if successful, error or NULL string otherwise.
+ */
+static char *get_parseable_cmd(const char *raw_command)
+{
+	char *cmd = NULL;
+
+	if (audit_old_buffer(raw_command))
+		cmd = insert_semicolons(raw_command);
+
+	if (IS_ERR_OR_NULL(cmd)) {
+		cmd = kstrdup(raw_command, GFP_KERNEL);
+		if (!cmd)
+			cmd = ERR_PTR(-ENOMEM);
+	}
+
+	return cmd;
+}
+
 static int check_command(const char *raw_command)
 {
 	char **argv = NULL, *cmd, *saved_cmd, *name_and_field;
@@ -1406,28 +1643,33 @@ static int check_command(const char *raw_command)
 
 static int create_or_delete_synth_event(const char *raw_command)
 {
-	char *name = NULL, *fields, *p;
+	char *name = NULL, *fields, *p, *cmd;
 	int ret = 0;
 
 	raw_command = skip_spaces(raw_command);
 	if (raw_command[0] == '\0')
 		return ret;
 
-	last_cmd_set(raw_command);
+	cmd = get_parseable_cmd(raw_command);
+	if (IS_ERR(cmd))
+		return PTR_ERR(cmd);
 
-	ret = check_command(raw_command);
+	last_cmd_set(cmd);
+
+	ret = check_command(cmd);
 	if (ret) {
 		synth_err(SYNTH_ERR_INVALID_CMD, 0);
-		return ret;
+		goto free;
 	}
 
-	p = strpbrk(raw_command, " \t");
+	p = strpbrk(cmd, " \t");
 	if (!p) {
 		synth_err(SYNTH_ERR_INVALID_CMD, 0);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free;
 	}
 
-	name = kmemdup_nul(raw_command, p - raw_command, GFP_KERNEL);
+	name = kmemdup_nul(cmd, p - cmd, GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
 
@@ -1441,6 +1683,7 @@ static int create_or_delete_synth_event(const char *raw_command)
 	ret = __create_synth_event(name, fields);
 free:
 	kfree(name);
+	kfree(cmd);
 
 	return ret;
 }
@@ -1988,7 +2231,7 @@ EXPORT_SYMBOL_GPL(synth_event_trace_end);
 
 static int create_synth_event(const char *raw_command)
 {
-	char *fields, *p;
+	char *fields, *p, *cmd;
 	const char *name;
 	int len, ret = 0;
 
@@ -1996,20 +2239,27 @@ static int create_synth_event(const char *raw_command)
 	if (raw_command[0] == '\0')
 		return ret;
 
-	last_cmd_set(raw_command);
+	cmd = get_parseable_cmd(raw_command);
+	if (IS_ERR(cmd))
+		return PTR_ERR(cmd);
+
+	last_cmd_set(cmd);
 
-	p = strpbrk(raw_command, " \t");
+	p = strpbrk(cmd, " \t");
 	if (!p) {
 		synth_err(SYNTH_ERR_INVALID_CMD, 0);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto free;
 	}
 
 	fields = skip_spaces(p);
 
-	name = raw_command;
+	name = cmd;
 
-	if (name[0] != 's' || name[1] != ':')
-		return -ECANCELED;
+	if (name[0] != 's' || name[1] != ':') {
+		ret = -ECANCELED;
+		goto free;
+	}
 	name += 2;
 
 	/* This interface accepts group name prefix */
@@ -2017,26 +2267,28 @@ static int create_synth_event(const char *raw_command)
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
 		if (len == 0) {
 			synth_err(SYNTH_ERR_INVALID_DYN_CMD, 0);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto free;
 		}
 		name += len;
 	}
 
-	len = name - raw_command;
+	len = name - cmd;
 
-	ret = check_command(raw_command + len);
+	ret = check_command(cmd + len);
 	if (ret) {
 		synth_err(SYNTH_ERR_INVALID_CMD, 0);
-		return ret;
+		goto free;
 	}
 
-	name = kmemdup_nul(raw_command + len, p - raw_command - len, GFP_KERNEL);
+	name = kmemdup_nul(cmd + len, p - cmd - len, GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
 
 	ret = __create_synth_event(name, fields);
-
 	kfree(name);
+ free:
+	kfree(cmd);
 
 	return ret;
 }
-- 
2.17.1

