Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361E528C229
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgJLUSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:18:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728155AbgJLUSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:18:24 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24463214DB;
        Mon, 12 Oct 2020 20:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602533903;
        bh=lnOmyZgQzXWF7I5Gm5JUDbVEHr2az9SwfjZVgYkZPsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=1jxjWnkO9lFujqAu450t3EmBnwyfcWniicIGr7KEzK6dReJ0/lnKk7Nj2ocUVGK7F
         NaDAPX8JNAJ0IroSG7ZEzbPodd7j1KdAA0xY3CE69qhMUjZkCMJ+Sq67bS10ue83sW
         p0RZhPyZnocF5ENDg08qqQuxOcwHbIksjgKyIfGA=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 7/7] selftests/ftrace: Add test case for synthetic event syntax errors
Date:   Mon, 12 Oct 2020 15:18:09 -0500
Message-Id: <4f445625d0d6dc0656e550057aa784d56832b5f2.1602533267.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a selftest that verifies that the syntax error messages and caret
positions are correct for most of the possible synthetic event syntax
error cases.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../trigger-synthetic_event_syntax_errors.tc  | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
new file mode 100644
index 000000000000..136276b11386
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic_event_syntax_errors.tc
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Synthetic event parser error log check
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
2.17.1

