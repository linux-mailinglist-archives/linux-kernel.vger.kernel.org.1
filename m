Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914C61EA3DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 14:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgFAM2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 08:28:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgFAM2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:28:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ACB72085B;
        Mon,  1 Jun 2020 12:28:08 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jfjXz-00275m-J4; Mon, 01 Jun 2020 08:28:07 -0400
Message-ID: <20200601122807.477111056@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 01 Jun 2020 08:27:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 04/12] tracing: Check state.disabled in synth event trace functions
References: <20200601122729.727113609@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Since trace_state.disabled is set in __synth_event_trace_start() at
the same time -ENOENT is returned, don't bother returning -ENOENT -
just have callers check trace_state.disabled instead, and avoid the
extra return val munging.

Link: http://lkml.kernel.org/r/87315c3889af870e8370e82b76cf48b426d70130.1585941485.git.zanussi@kernel.org

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@godmis.org>
---
 kernel/trace/trace_events_hist.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fcab11cc6833..5cfe8f998b3e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1845,7 +1845,6 @@ __synth_event_trace_start(struct trace_event_file *file,
 	if (!(file->flags & EVENT_FILE_FL_ENABLED) ||
 	    trace_trigger_soft_disabled(file)) {
 		trace_state->disabled = true;
-		ret = -ENOENT;
 		goto out;
 	}
 
@@ -1907,11 +1906,8 @@ int synth_event_trace(struct trace_event_file *file, unsigned int n_vals, ...)
 	int ret;
 
 	ret = __synth_event_trace_start(file, &state);
-	if (ret) {
-		if (ret == -ENOENT)
-			ret = 0; /* just disabled, not really an error */
+	if (ret || state.disabled)
 		return ret;
-	}
 
 	if (n_vals != state.event->n_fields) {
 		ret = -EINVAL;
@@ -1987,11 +1983,8 @@ int synth_event_trace_array(struct trace_event_file *file, u64 *vals,
 	int ret;
 
 	ret = __synth_event_trace_start(file, &state);
-	if (ret) {
-		if (ret == -ENOENT)
-			ret = 0; /* just disabled, not really an error */
+	if (ret || state.disabled)
 		return ret;
-	}
 
 	if (n_vals != state.event->n_fields) {
 		ret = -EINVAL;
@@ -2067,16 +2060,10 @@ EXPORT_SYMBOL_GPL(synth_event_trace_array);
 int synth_event_trace_start(struct trace_event_file *file,
 			    struct synth_event_trace_state *trace_state)
 {
-	int ret;
-
 	if (!trace_state)
 		return -EINVAL;
 
-	ret = __synth_event_trace_start(file, trace_state);
-	if (ret == -ENOENT)
-		ret = 0; /* just disabled, not really an error */
-
-	return ret;
+	return __synth_event_trace_start(file, trace_state);
 }
 EXPORT_SYMBOL_GPL(synth_event_trace_start);
 
-- 
2.26.2


