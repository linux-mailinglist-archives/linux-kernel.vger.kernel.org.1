Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3628E57D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389796AbgJNRhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389503AbgJNRhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9504722267;
        Wed, 14 Oct 2020 17:37:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiP-002yId-Cg; Wed, 14 Oct 2020 13:37:29 -0400
Message-ID: <20201014173729.272669456@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 08/12] tracing: Add synthetic event error logging
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add support for synthetic event error logging, which entails adding a
logging function for it, a way to save the synthetic event command,
and a set of specific synthetic event parse error strings and
handling.

Link: https://lkml.kernel.org/r/ed099c66df13b40cfc633aaeb17f66c37a923066.1602598160.git.zanussi@kernel.org

[ <rostedt@goodmis.org>: wrote save_cmdstr() seq_buf implementation. ]
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 92 ++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 8c9d6e464da0..f77851018121 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -20,6 +20,48 @@
 
 #include "trace_synth.h"
 
+#undef ERRORS
+#define ERRORS	\
+	C(BAD_NAME,		"Illegal name"),		\
+	C(CMD_INCOMPLETE,	"Incomplete command"),		\
+	C(EVENT_EXISTS,		"Event already exists"),	\
+	C(TOO_MANY_FIELDS,	"Too many fields"),		\
+	C(INCOMPLETE_TYPE,	"Incomplete type"),		\
+	C(INVALID_TYPE,		"Invalid type"),		\
+	C(INVALID_FIELD,	"Invalid field"),		\
+	C(CMD_TOO_LONG,		"Command too long"),
+
+#undef C
+#define C(a, b)		SYNTH_ERR_##a
+
+enum { ERRORS };
+
+#undef C
+#define C(a, b)		b
+
+static const char *err_text[] = { ERRORS };
+
+static char last_cmd[MAX_FILTER_STR_VAL];
+
+static int errpos(const char *str)
+{
+	return err_pos(last_cmd, str);
+}
+
+static void last_cmd_set(char *str)
+{
+	if (!str)
+		return;
+
+	strncpy(last_cmd, str, MAX_FILTER_STR_VAL - 1);
+}
+
+static void synth_err(u8 err_type, u8 err_pos)
+{
+	tracing_log_err(NULL, "synthetic_events", last_cmd, err_text,
+			err_type, err_pos);
+}
+
 static int create_synth_event(int argc, const char **argv);
 static int synth_event_show(struct seq_file *m, struct dyn_event *ev);
 static int synth_event_release(struct dyn_event *ev);
@@ -545,8 +587,10 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		field_type++;
 
 	if (!strcmp(field_type, "unsigned")) {
-		if (argc < 3)
+		if (argc < 3) {
+			synth_err(SYNTH_ERR_INCOMPLETE_TYPE, errpos(field_type));
 			return ERR_PTR(-EINVAL);
+		}
 		prefix = "unsigned ";
 		field_type = argv[1];
 		field_name = argv[2];
@@ -573,6 +617,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		goto free;
 	}
 	if (!is_good_name(field->name)) {
+		synth_err(SYNTH_ERR_BAD_NAME, errpos(field_name));
 		ret = -EINVAL;
 		goto free;
 	}
@@ -601,6 +646,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
+		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
@@ -621,6 +667,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 			field->is_dynamic = true;
 			size = sizeof(u64);
 		} else {
+			synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
 			ret = -EINVAL;
 			goto free;
 		}
@@ -1098,12 +1145,47 @@ int synth_event_gen_cmd_array_start(struct dynevent_cmd *cmd, const char *name,
 }
 EXPORT_SYMBOL_GPL(synth_event_gen_cmd_array_start);
 
+static int save_cmdstr(int argc, const char *name, const char **argv)
+{
+	struct seq_buf s;
+	char *buf;
+	int i;
+
+	buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	seq_buf_init(&s, buf, MAX_DYNEVENT_CMD_LEN);
+
+	seq_buf_puts(&s, name);
+
+	for (i = 0; i < argc; i++) {
+		seq_buf_putc(&s, ' ');
+		seq_buf_puts(&s, argv[i]);
+	}
+
+	if (!seq_buf_buffer_left(&s)) {
+		synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
+		kfree(buf);
+		return -EINVAL;
+	}
+	buf[s.len] = 0;
+	last_cmd_set(buf);
+
+	kfree(buf);
+	return 0;
+}
+
 static int __create_synth_event(int argc, const char *name, const char **argv)
 {
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
 	struct synth_event *event = NULL;
 	int i, consumed = 0, n_fields = 0, ret = 0;
 
+	ret = save_cmdstr(argc, name, argv);
+	if (ret)
+		return ret;
+
 	/*
 	 * Argument syntax:
 	 *  - Add synthetic event: <event_name> field[;field] ...
@@ -1111,18 +1193,22 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	 *      where 'field' = type field_name
 	 */
 
-	if (name[0] == '\0' || argc < 1)
+	if (name[0] == '\0' || argc < 1) {
+		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
 		return -EINVAL;
+	}
 
 	mutex_lock(&event_mutex);
 
 	if (!is_good_name(name)) {
+		synth_err(SYNTH_ERR_BAD_NAME, errpos(name));
 		ret = -EINVAL;
 		goto out;
 	}
 
 	event = find_synth_event(name);
 	if (event) {
+		synth_err(SYNTH_ERR_EVENT_EXISTS, errpos(name));
 		ret = -EEXIST;
 		goto out;
 	}
@@ -1131,6 +1217,7 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 		if (strcmp(argv[i], ";") == 0)
 			continue;
 		if (n_fields == SYNTH_FIELDS_MAX) {
+			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
 			ret = -EINVAL;
 			goto err;
 		}
@@ -1145,6 +1232,7 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 	}
 
 	if (i < argc && strcmp(argv[i], ";") != 0) {
+		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(argv[i]));
 		ret = -EINVAL;
 		goto err;
 	}
-- 
2.28.0


