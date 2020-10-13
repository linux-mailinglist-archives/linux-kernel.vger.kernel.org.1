Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D555528D00E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgJMOSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgJMOSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:18:03 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00B3247FE;
        Tue, 13 Oct 2020 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602598683;
        bh=20EOdtXnWxOJ876IXC/aCEshOJ/JHm8zvad+Y0ixElM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=SB+TvbwoJQsweMOSZ80Ius85BTUjkDeTIKH/opQys90o86RvGUhbR/ckDKZAdWqDq
         4vIaMlrqfw7y8yuxi3qx3r3XukPOH7eYd0fa9onqFkdEYSuAn6i6Xr+FmFGvAE13CD
         kTLe94Mmw+T07afXYd2M5kM4WA/b8AfsDmSKlGvA=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] tracing: Don't show dynamic string internals in synthetic event description
Date:   Tue, 13 Oct 2020 09:17:52 -0500
Message-Id: <b3b7baf7813298a5ede4ff02e2e837b91c05a724.1602598160.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
In-Reply-To: <cover.1602598160.git.zanussi@kernel.org>
References: <cover.1602598160.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For synthetic event dynamic fields, the type contains "__data_loc",
which is basically an internal part of the type which is only meant to
be displayed in the format, not in the event description itself, which
is confusing to users since they can't use __data_loc on the
command-line to define an event field, which printing it would lead
them to believe.

So filter it out from the description, while leaving it in the type.

Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.17.1

