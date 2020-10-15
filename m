Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F4228EEE4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbgJOJAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388330AbgJOJAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:00:21 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333E32222E;
        Thu, 15 Oct 2020 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602752420;
        bh=8g4rnJL50+RWuyiZ98/LTN/270KBeiyldVTlJZ8PqN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BY6LeF5Ec7P7gfxWTqa3vTEhQ9Bp8a1SiyQ6ZdJMfUSaMrqGg1ieNvoH3crOjQie3
         /iH7acH4OQTXL+PIre3vxL707+Futd4+AccwIDnKmpkxrWYmyt9zrexjBLRuaK5Tbs
         UjzOHZ9NVqKwJsfn2d1+ZSTJh5HZtTiQw+YPz7OI=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH v2 2/3] tracing: Update the stage 3 of trace event macro comment
Date:   Thu, 15 Oct 2020 18:00:17 +0900
Message-Id: <160275241674.115066.16421925783973307130.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160275239876.115066.10891356497426857018.stgit@devnote2>
References: <160275239876.115066.10891356497426857018.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the comment of the 3rd stage of trace event macro
expansion code. Now there are 2 macros makes different
trace_raw_output_<call>() functions.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 include/trace/trace_events.h |   29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 4ad9abf465b0..a96301317842 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -231,9 +231,11 @@ TRACE_MAKE_SYSTEM_STR();
  * {
  *	struct trace_seq *s = &iter->seq;
  *	struct trace_event_raw_<call> *field; <-- defined in stage 1
- *	struct trace_entry *entry;
  *	struct trace_seq *p = &iter->tmp_seq;
- *	int ret;
+ *
+ * -------(for event)-------
+ *
+ *	struct trace_entry *entry;
  *
  *	entry = iter->ent;
  *
@@ -245,14 +247,23 @@ TRACE_MAKE_SYSTEM_STR();
  *	field = (typeof(field))entry;
  *
  *	trace_seq_init(p);
- *	ret = trace_seq_printf(s, "%s: ", <call>);
- *	if (ret)
- *		ret = trace_seq_printf(s, <TP_printk> "\n");
- *	if (!ret)
- *		return TRACE_TYPE_PARTIAL_LINE;
+ *	return trace_output_call(iter, <call>, <TP_printk> "\n");
  *
- *	return TRACE_TYPE_HANDLED;
- * }
+ * ------(or, for event class)------
+ *
+ *	int ret;
+ *
+ *	field = (typeof(field))iter->ent;
+ *
+ *	ret = trace_raw_output_prep(iter, trace_event);
+ *	if (ret != TRACE_TYPE_HANDLED)
+ *		return ret;
+ *
+ *	trace_event_printf(iter, <TP_printk> "\n");
+ *
+ *	return trace_handle_return(s);
+ * -------
+ *  }
  *
  * This is the method used to print the raw event to the trace
  * output format. Note, this is not needed if the data is read

