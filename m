Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CCA297846
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756167AbgJWUeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:34:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756146AbgJWUeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:34:02 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78A02137B;
        Fri, 23 Oct 2020 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603485242;
        bh=oiidRMk8IHctpEubZJ1Ms7x0dfcNRZpfLaJqumux8rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=yT8r0NGpe4RVofJgToHCGRXsjGw7MSq2bgZCG52SDOu8V7PBfkB759i7orNDLp3HY
         VnjtpiFhiSjNm7TlKwzEJZcTNCt/IDHJzsLJLB8X4dJyTD8EBsSD5WT2oa7Jg6LplW
         /+XNAbycMPW7BAff3klq+Ib43FjymprttOwviMtY=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] tracing: Update synth command errors
Date:   Fri, 23 Oct 2020 15:33:53 -0500
Message-Id: <338e7cbe92e1d1c7db119ce240352010ac841535.1603484117.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603484117.git.zanussi@kernel.org>
References: <cover.1603484117.git.zanussi@kernel.org>
In-Reply-To: <cover.1603484117.git.zanussi@kernel.org>
References: <cover.1603484117.git.zanussi@kernel.org>
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
 kernel/trace/trace_events_synth.c | 66 +++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 90c1790ed1d6..1aa808791f56 100644
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
@@ -643,6 +644,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
+		if (array)
+			synth_err(SYNTH_ERR_INVALID_ARRAY_SPEC, errpos(field_name));
+		else
+			synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
@@ -1158,7 +1163,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	mutex_lock(&event_mutex);
 
 	if (name[0] == '\0') {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1212,7 +1217,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	}
 
 	if (n_fields == 0) {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1350,13 +1355,42 @@ int synth_event_delete(const char *event_name)
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
 	char **argv, *name = NULL, *fields;
 	int argc = 0, ret = 0;
 
-	last_cmd_set(raw_command);
-
 	argv = argv_split(GFP_KERNEL, raw_command, &argc);
 	if (!argv)
 		return -ENOMEM;
@@ -1364,9 +1398,16 @@ static int create_or_delete_synth_event(const char *raw_command)
 	if (!argc)
 		goto free;
 
+	last_cmd_set(raw_command);
+
+	ret = check_command(raw_command);
+	if (ret) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
+		goto free;
+	}
+
 	name = argv[0];
 
-	/* trace_run_command() ensures argc != 0 */
 	if (name[0] == '!') {
 		ret = synth_event_delete(name + 1);
 		goto free;
@@ -1951,12 +1992,21 @@ static int create_synth_event(const char *raw_command)
 	if (strchr(name, '/')) {
 		len = str_has_prefix(name, SYNTH_SYSTEM "/");
 		if (len == 0) {
+			synth_err(SYNTH_ERR_INVALID_DYN_CMD, 0);
 			ret = -EINVAL;
 			goto free;
 		}
 		name += len;
 	}
 
+	len = name - argv[0];
+
+	ret = check_command(raw_command + len);
+	if (ret) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
+		goto free;
+	}
+
 	fields = strstr(raw_command, name);
 	fields += strlen(name);
 
-- 
2.17.1

