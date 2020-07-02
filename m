Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C191212AF7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 19:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGBRMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 13:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgGBRMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:12:01 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF11C208D5;
        Thu,  2 Jul 2020 17:12:00 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr2kg-004AsK-76; Thu, 02 Jul 2020 13:11:58 -0400
Message-ID: <20200702171158.102647075@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 13:10:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [PATCH 8/9] tools lib traceevent: Add plugin for tlb_flush
References: <20200702171016.178196716@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>

The tlb_flush tracepoints uses enums that are not yet known by
the traceevent library. Add a plugin to handle that.

Link: http://lore.kernel.org/linux-trace-devel/20200625100516.365338-9-tz.stoyanov@gmail.com

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/plugins/Build        |  1 +
 tools/lib/traceevent/plugins/Makefile     |  1 +
 tools/lib/traceevent/plugins/plugin_tlb.c | 81 +++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 tools/lib/traceevent/plugins/plugin_tlb.c

diff --git a/tools/lib/traceevent/plugins/Build b/tools/lib/traceevent/plugins/Build
index 210d26910613..b866f231a536 100644
--- a/tools/lib/traceevent/plugins/Build
+++ b/tools/lib/traceevent/plugins/Build
@@ -8,3 +8,4 @@ plugin_function-y     += plugin_function.o
 plugin_xen-y          += plugin_xen.o
 plugin_scsi-y         += plugin_scsi.o
 plugin_cfg80211-y     += plugin_cfg80211.o
+plugin_tlb-y          += plugin_tlb.o
\ No newline at end of file
diff --git a/tools/lib/traceevent/plugins/Makefile b/tools/lib/traceevent/plugins/Makefile
index 349bb81482ab..8e72707e8630 100644
--- a/tools/lib/traceevent/plugins/Makefile
+++ b/tools/lib/traceevent/plugins/Makefile
@@ -137,6 +137,7 @@ PLUGINS += plugin_function.so
 PLUGINS += plugin_xen.so
 PLUGINS += plugin_scsi.so
 PLUGINS += plugin_cfg80211.so
+PLUGINS += plugin_tlb.so
 
 PLUGINS    := $(addprefix $(OUTPUT),$(PLUGINS))
 PLUGINS_IN := $(PLUGINS:.so=-in.o)
diff --git a/tools/lib/traceevent/plugins/plugin_tlb.c b/tools/lib/traceevent/plugins/plugin_tlb.c
new file mode 100644
index 000000000000..1adade776306
--- /dev/null
+++ b/tools/lib/traceevent/plugins/plugin_tlb.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (C) 2015 Red Hat Inc, Steven Rostedt <srostedt@redhat.com>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation;
+ * version 2.1 of the License (not later!)
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this program; if not,  see <http://www.gnu.org/licenses>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "event-parse.h"
+
+enum tlb_flush_reason {
+	TLB_FLUSH_ON_TASK_SWITCH,
+	TLB_REMOTE_SHOOTDOWN,
+	TLB_LOCAL_SHOOTDOWN,
+	TLB_LOCAL_MM_SHOOTDOWN,
+	NR_TLB_FLUSH_REASONS,
+};
+
+static int tlb_flush_handler(struct trace_seq *s, struct tep_record *record,
+			     struct tep_event *event, void *context)
+{
+	unsigned long long val;
+
+	trace_seq_printf(s, "pages=");
+
+	tep_print_num_field(s, "%ld", event, "pages", record, 1);
+
+	if (tep_get_field_val(s, event, "reason", record, &val, 1) < 0)
+		return -1;
+
+	trace_seq_puts(s, " reason=");
+
+	switch (val) {
+	case TLB_FLUSH_ON_TASK_SWITCH:
+		trace_seq_puts(s, "flush on task switch");
+		break;
+	case TLB_REMOTE_SHOOTDOWN:
+		trace_seq_puts(s, "remote shootdown");
+		break;
+	case TLB_LOCAL_SHOOTDOWN:
+		trace_seq_puts(s, "local shootdown");
+		break;
+	case TLB_LOCAL_MM_SHOOTDOWN:
+		trace_seq_puts(s, "local mm shootdown");
+		break;
+	}
+
+	trace_seq_printf(s, " (%lld)", val);
+
+	return 0;
+}
+
+int TEP_PLUGIN_LOADER(struct tep_handle *tep)
+{
+	tep_register_event_handler(tep, -1, "tlb", "tlb_flush",
+				   tlb_flush_handler, NULL);
+
+	return 0;
+}
+
+void TEP_PLUGIN_UNLOADER(struct tep_handle *tep)
+{
+	tep_unregister_event_handler(tep, -1,
+				     "tlb", "tlb_flush",
+				     tlb_flush_handler, NULL);
+}
-- 
2.26.2


