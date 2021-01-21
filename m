Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8042FF159
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388420AbhAURGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:06:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387463AbhAURB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:01:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CB3B23A5B;
        Thu, 21 Jan 2021 17:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611248478;
        bh=CyUEN64VZvwd/7eySQ2+QFzthDwNm2lsKVWifvnrnwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=PxCybMMP0r1fHuxtxpC+YxmI21TbOjELaTTRBk8iLALiiaPKIzTd2gz3BK0mSobUC
         BXGRDIJEI9FcUg1D4vJ2/7Amu6bvtZm87Z2lFzcRMVmKpXr6d6tyRdpRagCIw0h581
         pLW0jEya9399KT1Z+vauF1X9RaUzgk9EuijfB0BGzwAB7sUBEkB8534QYrP8e9+F/v
         tTFBp1UAbP6SLAr4FEwOsSN44TqkN51SmgBGqJsYO6p4BrfmqtZTiDErIBnk1Oa0E0
         6CvlhCQyGo9mEvNPFeju5kVP9IuB5nUjmQKT71KoITKk1BCWy6X0KhGBxpGPh+6RO6
         jx6V4bAigwN6w==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/6] tracing: Update synth command errors
Date:   Thu, 21 Jan 2021 11:01:06 -0600
Message-Id: <18090ccadf2c33b03e4eaad429867d7088782721.1611243025.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
In-Reply-To: <cover.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
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
 kernel/trace/trace_events_synth.c | 72 +++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index a79c17b97add..dd141ee6b3fc 100644
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
@@ -655,7 +656,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
 
 	size = synth_field_size(field->type);
 	if (size < 0) {
-		synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
+		if (array)
+			synth_err(SYNTH_ERR_INVALID_ARRAY_SPEC, errpos(field_name));
+		else
+			synth_err(SYNTH_ERR_INVALID_TYPE, errpos(field_type));
 		ret = -EINVAL;
 		goto free;
 	} else if (size == 0) {
@@ -1176,7 +1180,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	mutex_lock(&event_mutex);
 
 	if (name[0] == '\0') {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1228,7 +1232,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 	}
 
 	if (n_fields == 0) {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto err;
 	}
@@ -1366,6 +1370,40 @@ int synth_event_delete(const char *event_name)
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
+	if (name_and_field[0] == '!')
+		goto free;
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
@@ -1377,9 +1415,15 @@ static int create_or_delete_synth_event(const char *raw_command)
 
 	last_cmd_set(raw_command);
 
+	ret = check_command(raw_command);
+	if (ret) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
+		return ret;
+	}
+
 	p = strpbrk(raw_command, " \t");
 	if (!p && raw_command[0] != '!') {
-		synth_err(SYNTH_ERR_CMD_INCOMPLETE, 0);
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		ret = -EINVAL;
 		goto free;
 	}
@@ -1956,8 +2000,10 @@ static int create_synth_event(const char *raw_command)
 	last_cmd_set(raw_command);
 
 	p = strpbrk(raw_command, " \t");
-	if (!p)
+	if (!p) {
+		synth_err(SYNTH_ERR_INVALID_CMD, 0);
 		return -EINVAL;
+	}
 
 	fields = skip_spaces(p);
 
@@ -1970,13 +2016,21 @@ static int create_synth_event(const char *raw_command)
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
 	if (!name)
 		return -ENOMEM;
-- 
2.17.1

