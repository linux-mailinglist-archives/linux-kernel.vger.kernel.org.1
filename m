Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730A828E57A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389683AbgJNRhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389532AbgJNRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53A5E2222E;
        Wed, 14 Oct 2020 17:37:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiO-002yHB-UJ; Wed, 14 Oct 2020 13:37:28 -0400
Message-ID: <20201014173728.806837346@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 05/12] tracing: Dont show dynamic string internals in synthetic event
 description
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

For synthetic event dynamic fields, the type contains "__data_loc",
which is basically an internal part of the type which is only meant to
be displayed in the format, not in the event description itself, which
is confusing to users since they can't use __data_loc on the
command-line to define an event field, which printing it would lead
them to believe.

So filter it out from the description, while leaving it in the type.

Link: https://lkml.kernel.org/r/b3b7baf7813298a5ede4ff02e2e837b91c05a724.1602598160.git.zanussi@kernel.org

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 3b2dcc42b8ee..b19e2f4159ab 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1867,14 +1867,22 @@ static int __synth_event_show(struct seq_file *m, struct synth_event *event)
 {
 	struct synth_field *field;
 	unsigned int i;
+	char *type, *t;
 
 	seq_printf(m, "%s\t", event->name);
 
 	for (i = 0; i < event->n_fields; i++) {
 		field = event->fields[i];
 
+		type = field->type;
+		t = strstr(type, "__data_loc");
+		if (t) { /* __data_loc belongs in format but not event desc */
+			t += sizeof("__data_loc");
+			type = t;
+		}
+
 		/* parameter values */
-		seq_printf(m, "%s %s%s", field->type, field->name,
+		seq_printf(m, "%s %s%s", type, field->name,
 			   i == event->n_fields - 1 ? "" : "; ");
 	}
 
-- 
2.28.0


