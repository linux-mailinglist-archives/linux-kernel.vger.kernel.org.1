Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592E5228D77
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 03:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731806AbgGVBSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 21:18:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731645AbgGVBR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:17:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 702EF22CAE;
        Wed, 22 Jul 2020 01:17:55 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jy3OM-005sE2-Cl; Tue, 21 Jul 2020 21:17:54 -0400
Message-ID: <20200722011754.279610254@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 21 Jul 2020 21:16:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [PATCH 13/23 v3] tools lib traceevent: Add builtin handler for trace_marker_raw
References: <20200722011628.925541477@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When something is written into trace_marker_raw, it goes in as a binary. But
the printk_fmt() of the event that is created (raw_data)'s format file only
prints the first byte of data:

  print fmt: "id:%04x %08x", REC->id, (int)REC->buf[0]

This is not very useful if we want to see the full data output.

Implement the processing of the raw_data event like it is in the kernel.

Link: http://lore.kernel.org/linux-trace-devel/20200702174950.123454-5-tz.stoyanov@gmail.com

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
[ Ported from trace-cmd.git ]
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../lib/traceevent/plugins/plugin_function.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/lib/traceevent/plugins/plugin_function.c b/tools/lib/traceevent/plugins/plugin_function.c
index c7d321968f39..7e8e29b43d1c 100644
--- a/tools/lib/traceevent/plugins/plugin_function.c
+++ b/tools/lib/traceevent/plugins/plugin_function.c
@@ -222,6 +222,44 @@ trace_stack_handler(struct trace_seq *s, struct tep_record *record,
 	return 0;
 }
 
+static int
+trace_raw_data_handler(struct trace_seq *s, struct tep_record *record,
+		    struct tep_event *event, void *context)
+{
+	struct tep_format_field *field;
+	unsigned long long id;
+	int long_size;
+	void *data = record->data;
+
+	if (tep_get_field_val(s, event, "id", record, &id, 1))
+		return trace_seq_putc(s, '!');
+
+	trace_seq_printf(s, "# %llx", id);
+
+	field = tep_find_any_field(event, "buf");
+	if (!field) {
+		trace_seq_printf(s, "<CANT FIND FIELD %s>", "buf");
+		return 0;
+	}
+
+	long_size = tep_get_long_size(event->tep);
+
+	for (data += field->offset; data < record->data + record->size;
+	     data += long_size) {
+		int size = sizeof(long);
+		int left = (record->data + record->size) - data;
+		int i;
+
+		if (size > left)
+			size = left;
+
+		for (i = 0; i < size; i++)
+			trace_seq_printf(s, " %02x", *(unsigned char *)(data + i));
+	}
+
+	return 0;
+}
+
 int TEP_PLUGIN_LOADER(struct tep_handle *tep)
 {
 	tep_register_event_handler(tep, -1, "ftrace", "function",
@@ -230,6 +268,9 @@ int TEP_PLUGIN_LOADER(struct tep_handle *tep)
 	tep_register_event_handler(tep, -1, "ftrace", "kernel_stack",
 				      trace_stack_handler, NULL);
 
+	tep_register_event_handler(tep, -1, "ftrace", "raw_data",
+				      trace_raw_data_handler, NULL);
+
 	tep_plugin_add_options("ftrace", plugin_options);
 
 	return 0;
-- 
2.26.2


