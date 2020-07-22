Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE0228D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 03:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbgGVBSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 21:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731662AbgGVBR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 21:17:57 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4490022D01;
        Wed, 22 Jul 2020 01:17:56 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jy3ON-005sH8-9Q; Tue, 21 Jul 2020 21:17:55 -0400
Message-ID: <20200722011755.158091410@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 21 Jul 2020 21:16:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>
Subject: [PATCH 19/23 v3] tools lib traceevent: Improve error handling of
 tep_plugin_add_option() API
References: <20200722011628.925541477@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

In case of memory error, ensure all allocated resources are freed.
Do not append broken option in trace_plugin_options list.

Link: https://lore.kernel.org/r/CAM9d7cizjF+fbK7YzmsBDgrx__4YAOsmEq67D3sWET8FF+YdFA@mail.gmail.com
Link: https://lore.kernel.org/linux-trace-devel/20200714103027.2477584-5-tz.stoyanov@gmail.com
Link: https://lore.kernel.org/linux-trace-devel/20200716092014.2613403-5-tz.stoyanov@gmail.com

Suggested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-plugin.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/lib/traceevent/event-plugin.c b/tools/lib/traceevent/event-plugin.c
index f8d253a61970..6b84b9c4e6ba 100644
--- a/tools/lib/traceevent/event-plugin.c
+++ b/tools/lib/traceevent/event-plugin.c
@@ -361,23 +361,25 @@ int tep_plugin_add_option(const char *name, const char *val)
 	if (!op) {
 		op = malloc(sizeof(*op));
 		if (!op)
-			return -ENOMEM;
+			goto out_free;
 		memset(op, 0, sizeof(*op));
-		op->next = trace_plugin_options;
-		trace_plugin_options = op;
-
 		op->plugin = plugin;
 		op->option = option_str;
-
 		if (val) {
 			op->value = strdup(val);
-			if (!op->value)
+			if (!op->value) {
+				free(op);
 				goto out_free;
+			}
 		}
+		op->next = trace_plugin_options;
+		trace_plugin_options = op;
 	}
 
 	return process_option(plugin, option_str, val);
- out_free:
+
+out_free:
+	free(plugin);
 	free(option_str);
 	return -ENOMEM;
 }
-- 
2.26.2


