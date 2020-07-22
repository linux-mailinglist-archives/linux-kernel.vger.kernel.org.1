Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA92228D79
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 03:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbgGVBSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 21:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731642AbgGVBRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:17:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5609322D07;
        Wed, 22 Jul 2020 01:17:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jy3OM-005sDW-8M; Tue, 21 Jul 2020 21:17:54 -0400
Message-ID: <20200722011754.115095430@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 21 Jul 2020 21:16:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [PATCH 12/23 v3] tools lib traceevent: Move kernel_stack event handler to "function"
 plugin.
References: <20200722011628.925541477@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

The "kernel_stack" event handler does not depend on any trace-cmd
context, it can be used aside from the application. The code is
moved to libtraceevent "function" plugin.

Link: http://lore.kernel.org/linux-trace-devel/20190726124308.18735-2-tz.stoyanov@gmail.com
Link: http://lore.kernel.org/linux-trace-devel/20200702174950.123454-4-tz.stoyanov@gmail.com

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../lib/traceevent/plugins/plugin_function.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/lib/traceevent/plugins/plugin_function.c b/tools/lib/traceevent/plugins/plugin_function.c
index cafddd6be983..c7d321968f39 100644
--- a/tools/lib/traceevent/plugins/plugin_function.c
+++ b/tools/lib/traceevent/plugins/plugin_function.c
@@ -184,11 +184,52 @@ static int function_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+static int
+trace_stack_handler(struct trace_seq *s, struct tep_record *record,
+		    struct tep_event *event, void *context)
+{
+	struct tep_format_field *field;
+	unsigned long long addr;
+	const char *func;
+	int long_size;
+	void *data = record->data;
+
+	field = tep_find_any_field(event, "caller");
+	if (!field) {
+		trace_seq_printf(s, "<CANT FIND FIELD %s>", "caller");
+		return 0;
+	}
+
+	trace_seq_puts(s, "<stack trace >\n");
+
+	long_size = tep_get_long_size(event->tep);
+
+	for (data += field->offset; data < record->data + record->size;
+	     data += long_size) {
+		addr = tep_read_number(event->tep, data, long_size);
+
+		if ((long_size == 8 && addr == (unsigned long long)-1) ||
+		    ((int)addr == -1))
+			break;
+
+		func = tep_find_function(event->tep, addr);
+		if (func)
+			trace_seq_printf(s, "=> %s (%llx)\n", func, addr);
+		else
+			trace_seq_printf(s, "=> %llx\n", addr);
+	}
+
+	return 0;
+}
+
 int TEP_PLUGIN_LOADER(struct tep_handle *tep)
 {
 	tep_register_event_handler(tep, -1, "ftrace", "function",
 				   function_handler, NULL);
 
+	tep_register_event_handler(tep, -1, "ftrace", "kernel_stack",
+				      trace_stack_handler, NULL);
+
 	tep_plugin_add_options("ftrace", plugin_options);
 
 	return 0;
-- 
2.26.2


