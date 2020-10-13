Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8128D00A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgJMOSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:18:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729235AbgJMOSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:18:08 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C45CC24800;
        Tue, 13 Oct 2020 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602598687;
        bh=1nTNF2rhyE/TEx3iRNjmVwJLrRaZexjyVsMxKzV4wck=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=DMp4/74Q03F9PRZ9Ozfq7XgGWAzqYbmwD3OZvomK86Qt+sTG64V9YdnhJvGhOWAcw
         aJxzNTOkEpCvHtcn+GS/aOxU+6R8/qJj3Y7IcTEmOmVsYg6i6jZGdoHzc+UHUvfNg3
         9FoP4gJ6ViDJWV6lJrF05R4MU9AukJFy8aa4B7QI=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/7] tracing: Add synthetic event error logging
Date:   Tue, 13 Oct 2020 09:17:55 -0500
Message-Id: <ed099c66df13b40cfc633aaeb17f66c37a923066.1602598160.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for synthetic event error logging, which entails adding a
logging function for it, a way to save the synthetic event command,
and a set of specific synthetic event parse error strings and
handling.

[ <rostedt@goodmis.org>: wrote save_cmdstr() seq_buf implementation. ]
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 92 ++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 8c9d6e464da0..7efe39be6576 100644
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
+        struct seq_buf s;
+	char *buf;
+	int i;
+
+        buf = kzalloc(MAX_DYNEVENT_CMD_LEN, GFP_KERNEL);
+        if (!buf)
+                return -ENOMEM;
+
+        seq_buf_init(&s, buf, MAX_DYNEVENT_CMD_LEN);
+
+        seq_buf_puts(&s, name);
+
+        for (i = 0; i < argc; i++) {
+                seq_buf_putc(&s, ' ');
+                seq_buf_puts(&s, argv[i]);
+        }
+
+        if (!seq_buf_buffer_left(&s)) {
+                synth_err(SYNTH_ERR_CMD_TOO_LONG, 0);
+                kfree(buf);
+                return -EINVAL;
+        }
+        buf[s.len] = 0;
+        last_cmd_set(buf);
+
+        kfree(buf);
+        return 0;
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
2.17.1

