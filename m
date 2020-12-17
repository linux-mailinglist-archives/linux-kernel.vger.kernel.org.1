Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5E2DDAB0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 22:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731838AbgLQVPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 16:15:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgLQVPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 16:15:55 -0500
From:   Tom Zanussi <zanussi@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] selftests/ftrace: Update synthetic event syntax errors
Date:   Thu, 17 Dec 2020 15:14:30 -0600
Message-Id: <6cb978ea1a56e76f723fb7aee74422b0766db8e9.1608238451.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1608238451.git.zanussi@kernel.org>
References: <cover.1608238451.git.zanussi@kernel.org>
In-Reply-To: <cover.1608238451.git.zanussi@kernel.org>
References: <cover.1608238451.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the synthetic event errors and positions have changed in the
code - update those and add several more tests.

Also add a runtime check to ensure that the kernel supports dynamic
strings in synthetic events, which these tests require.

Fixes: 81ff92a93d95 (selftests/ftrace: Add test case for synthetic
event syntax errors)

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../trigger-synthetic_event_syntax_errors.tc  | 35 ++++++++++++++-----
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
index ada594fe16cb..955e3ceea44b 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
@@ -1,19 +1,38 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 # description: event trigger - test synthetic_events syntax parser errors
-# requires: synthetic_events error_log
+# requires: synthetic_events error_log "char name[]' >> synthetic_events":README
 
 check_error() { # command-with-error-pos-by-^
     ftrace_errlog_check 'synthetic_events' "$1" 'synthetic_events'
 }
 
+check_dyn_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'synthetic_events' "$1" 'dynamic_events'
+}
+
 check_error 'myevent ^chr arg'			# INVALID_TYPE
-check_error 'myevent ^char str[];; int v'	# INVALID_TYPE
-check_error 'myevent char ^str]; int v'		# INVALID_NAME
-check_error 'myevent char ^str;[]'		# INVALID_NAME
-check_error 'myevent ^char str[; int v'		# INVALID_TYPE
-check_error '^mye;vent char str[]'		# BAD_NAME
-check_error 'myevent char str[]; ^int'		# INVALID_FIELD
-check_error '^myevent'				# INCOMPLETE_CMD
+check_error 'myevent ^unsigned arg'		# INCOMPLETE_TYPE
+
+check_error 'myevent char ^str]; int v'		# BAD_NAME
+check_error '^mye-vent char str[]'		# BAD_NAME
+check_error 'myevent char ^st-r[]'		# BAD_NAME
+
+check_error 'myevent char str;^[]'		# INVALID_FIELD
+check_error 'myevent char str; ^int'		# INVALID_FIELD
+
+check_error 'myevent char ^str[; int v'		# INVALID_ARRAY_SPEC
+check_error 'myevent char ^str[kdjdk]'		# INVALID_ARRAY_SPEC
+check_error 'myevent char ^str[257]'		# INVALID_ARRAY_SPEC
+
+check_error '^mye;vent char str[]'		# INVALID_CMD
+check_error '^myevent ; char str[]'		# INVALID_CMD
+check_error '^myevent; char str[]'		# INVALID_CMD
+check_error '^myevent ;char str[]'		# INVALID_CMD
+check_error '^; char str[]'			# INVALID_CMD
+check_error '^;myevent char str[]'		# INVALID_CMD
+check_error '^myevent'				# INVALID_CMD
+
+check_dyn_error '^s:junk/myevent char str['	# INVALID_DYN_CMD
 
 exit 0
-- 
2.17.1

