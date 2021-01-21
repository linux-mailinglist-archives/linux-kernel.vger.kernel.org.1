Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A322FF154
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388376AbhAURFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 12:05:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:38562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733197AbhAURCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:02:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 036FA23A58;
        Thu, 21 Jan 2021 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611248479;
        bh=uGgChyM825CPuuuOldM33wsd02m1sFgY6MAinrcF28k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WSrl8DZ7lMcxItvWwC8232fmzQQW+gO4OjY9TGrcZ5R3+A+hOaDJTUbGdiSrUt4/X
         ERnQMlXROE6edQy/75PB/f8JqzRZ7zH12YBsLEaKzWS/M3qHernd8gCSjWHDaDHJNE
         JpMkjh1NeLklJ+SsQfH5+4RiPluSqsGg4+g35Yz2jA65F+/zNWLWAvPotlY0V3/LOT
         clzgMlokkJl8XpG9NTE58FLI5jZjwQw4OlrS3cHKWKvfAHQKvfwnepQSgQ9+aoQfiF
         O6io0uCo+gZCkKo5kc+86tuGxl4tVX1KKmsfRF6ogdkkAFyzaH53qdRgRaq+0hHkbQ
         fQm25VyVkUTTg==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/6] tracing: Add a backward-compatibility check for synthetic event creation
Date:   Thu, 21 Jan 2021 11:01:07 -0600
Message-Id: <c4e79b84ae0bee606fd89c8578ffbcb4ceb3010a.1611243025.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
In-Reply-To: <cover.1611243025.git.zanussi@kernel.org>
References: <cover.1611243025.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The synthetic event parsing rework now requires semicolons between
synthetic event fields.  That requirement breaks existing users who
might already have used the old synthetic event command format, so
this adds an inner loop that can parse more than one field, if
present, between semicolons.  For each field, parse_synth_field()
checks in which version that field was introduced, using
check_field_version().  The caller, __create_synth_event() can then use
that version information to determine whether or not to enforce the
requirement on the command as a whole.

In the future, if/when new features are added, the requirement will be
that any field/string containing the new feature must use semicolons,
and the check_field_version() check can then check for those and
enforce it.  Using a version number allows this scheme to be extended
if necessary.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 68 ++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index dd141ee6b3fc..1b7d1ff68140 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -580,11 +580,18 @@ static void free_synth_field(struct synth_field *field)
 	kfree(field);
 }
 
-static struct synth_field *parse_synth_field(int argc, char **argv)
+static int check_field_version(const char *prefix, const char *field_type,
+			       const char *field_name)
+{
+	return 1;
+}
+
+static struct synth_field *parse_synth_field(int argc, char **argv,
+					     int *consumed, int *field_version)
 {
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
-	int len, consumed, ret = -ENOMEM;
 	struct synth_field *field;
+	int len, ret = -ENOMEM;
 	struct seq_buf s;
 	ssize_t size;
 
@@ -596,15 +603,10 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
 		prefix = "unsigned ";
 		field_type = argv[1];
 		field_name = argv[2];
-		consumed = 3;
+		*consumed += 3;
 	} else {
 		field_name = argv[1];
-		consumed = 2;
-	}
-
-	if (consumed < argc) {
-		synth_err(SYNTH_ERR_INVALID_FIELD, errpos(field_type));
-		return ERR_PTR(-EINVAL);
+		*consumed += 2;
 	}
 
 	if (!field_name) {
@@ -612,6 +614,8 @@ static struct synth_field *parse_synth_field(int argc, char **argv)
 		return ERR_PTR(-EINVAL);
 	}
 
+	*field_version = check_field_version(prefix, field_type, field_name);
+
 	field = kzalloc(sizeof(*field), GFP_KERNEL);
 	if (!field)
 		return ERR_PTR(-ENOMEM);
@@ -1167,6 +1171,7 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 {
 	char **argv, *field_str, *tmp_fields, *saved_fields = NULL;
 	struct synth_field *field, *fields[SYNTH_FIELDS_MAX];
+	int consumed, cmd_version = 1, n_fields_this_loop;
 	int i, argc, n_fields = 0, ret = 0;
 	struct synth_event *event = NULL;
 
@@ -1214,21 +1219,46 @@ static int __create_synth_event(const char *name, const char *raw_fields)
 		if (!argc)
 			continue;
 
-		field = parse_synth_field(argc, argv);
-		if (IS_ERR(field)) {
-			argv_free(argv);
-			ret = PTR_ERR(field);
-			goto err;
-		}
+		n_fields_this_loop = 0;
+		consumed = 0;
+		while (argc > consumed) {
+			int field_version;
+
+			field = parse_synth_field(argc - consumed,
+						  argv + consumed, &consumed,
+						  &field_version);
+			if (IS_ERR(field)) {
+				argv_free(argv);
+				ret = PTR_ERR(field);
+				goto err;
+			}
 
-		argv_free(argv);
+			if (field_version > cmd_version)
+				cmd_version = field_version;
+
+			if (cmd_version > 1 && n_fields_this_loop >= 1) {
+				synth_err(SYNTH_ERR_INVALID_CMD, errpos(field_str));
+				ret = -EINVAL;
+				goto err;
+			}
+
+			fields[n_fields++] = field;
+			if (n_fields == SYNTH_FIELDS_MAX) {
+				synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
+				ret = -EINVAL;
+				goto err;
+			}
+
+			n_fields_this_loop++;
+		}
 
-		fields[n_fields++] = field;
-		if (n_fields == SYNTH_FIELDS_MAX) {
-			synth_err(SYNTH_ERR_TOO_MANY_FIELDS, 0);
+		if (consumed < argc) {
+			synth_err(SYNTH_ERR_INVALID_CMD, 0);
 			ret = -EINVAL;
 			goto err;
 		}
+
+		argv_free(argv);
 	}
 
 	if (n_fields == 0) {
-- 
2.17.1

