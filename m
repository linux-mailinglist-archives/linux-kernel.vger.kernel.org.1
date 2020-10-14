Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD14228E587
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390088AbgJNRiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:38:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389537AbgJNRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E07222264;
        Wed, 14 Oct 2020 17:37:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiP-002yI9-7w; Wed, 14 Oct 2020 13:37:29 -0400
Message-ID: <20201014173729.121264704@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 07/12] tracing: Check that the synthetic event and field names are legal
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Call the is_good_name() function used by probe events to make sure
synthetic event and field names don't contain illegal characters and
cause unexpected parsing of synthetic event commands.

Link: https://lkml.kernel.org/r/c4d4bb59d3ac39bcbd70fba0cf837d6b1cedb015.1602598160.git.zanussi@kernel.org

Fixes: 4b147936fa50 (tracing: Add support for 'synthetic' events)
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index b19e2f4159ab..8c9d6e464da0 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -572,6 +572,10 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		ret = -ENOMEM;
 		goto free;
 	}
+	if (!is_good_name(field->name)) {
+		ret = -EINVAL;
+		goto free;
+	}
 
 	if (field_type[0] == ';')
 		field_type++;
@@ -1112,6 +1116,11 @@ static int __create_synth_event(int argc, const char *name, const char **argv)
 
 	mutex_lock(&event_mutex);
 
+	if (!is_good_name(name)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	event = find_synth_event(name);
 	if (event) {
 		ret = -EEXIST;
-- 
2.28.0


