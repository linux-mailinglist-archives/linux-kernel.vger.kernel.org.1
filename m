Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D2E28E584
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390112AbgJNRiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389570AbgJNRhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6A022253;
        Wed, 14 Oct 2020 17:37:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiP-002yK5-SN; Wed, 14 Oct 2020 13:37:29 -0400
Message-ID: <20201014173729.735017339@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 11/12] selftests/ftrace: Add test case for synthetic event syntax errors
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add a selftest that verifies that the syntax error messages and caret
positions are correct for most of the possible synthetic event syntax
error cases.

Link: https://lkml.kernel.org/r/af611928ce79f86eaf0af8654f1d7802d5cc21ff.1602598160.git.zanussi@kernel.org

Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger-synthetic_event_syntax_errors.tc  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
new file mode 100644
index 000000000000..ada594fe16cb
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test synthetic_events syntax parser errors
+# requires: synthetic_events error_log
+
+check_error() { # command-with-error-pos-by-^
+    ftrace_errlog_check 'synthetic_events' "$1" 'synthetic_events'
+}
+
+check_error 'myevent ^chr arg'			# INVALID_TYPE
+check_error 'myevent ^char str[];; int v'	# INVALID_TYPE
+check_error 'myevent char ^str]; int v'		# INVALID_NAME
+check_error 'myevent char ^str;[]'		# INVALID_NAME
+check_error 'myevent ^char str[; int v'		# INVALID_TYPE
+check_error '^mye;vent char str[]'		# BAD_NAME
+check_error 'myevent char str[]; ^int'		# INVALID_FIELD
+check_error '^myevent'				# INCOMPLETE_CMD
+
+exit 0
-- 
2.28.0


