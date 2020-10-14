Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 660B828E57C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389774AbgJNRhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389575AbgJNRhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36E852225E;
        Wed, 14 Oct 2020 17:37:31 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiQ-002yKZ-18; Wed, 14 Oct 2020 13:37:30 -0400
Message-ID: <20201014173729.913068818@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michel Lespinasse <walken@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [for-next][PATCH 12/12] tracing: support "bool" type in synthetic trace events
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Axel Rasmussen <axelrasmussen@google.com>

It's common [1] to define tracepoint fields as "bool" when they contain
a true / false value. Currently, defining a synthetic event with a
"bool" field yields EINVAL. It's possible to work around this by using
e.g. u8 (assuming sizeof(bool) is 1, and bool is unsigned; if either of
these properties don't match, you get EINVAL [2]).

Supporting "bool" explicitly makes hooking this up easier and more
portable for userspace.

[1]: grep -r "bool" include/trace/events/
[2]: check_synth_field() in kernel/trace/trace_events_hist.c

Link: https://lkml.kernel.org/r/20201009220524.485102-2-axelrasmussen@google.com

Acked-by: Michel Lespinasse <walken@google.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index d239f0e2af8f..3212e2c653b3 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -229,6 +229,8 @@ static int synth_field_size(char *type)
 		size = sizeof(long);
 	else if (strcmp(type, "unsigned long") == 0)
 		size = sizeof(unsigned long);
+	else if (strcmp(type, "bool") == 0)
+		size = sizeof(bool);
 	else if (strcmp(type, "pid_t") == 0)
 		size = sizeof(pid_t);
 	else if (strcmp(type, "gfp_t") == 0)
@@ -271,6 +273,8 @@ static const char *synth_field_fmt(char *type)
 		fmt = "%ld";
 	else if (strcmp(type, "unsigned long") == 0)
 		fmt = "%lu";
+	else if (strcmp(type, "bool") == 0)
+		fmt = "%d";
 	else if (strcmp(type, "pid_t") == 0)
 		fmt = "%d";
 	else if (strcmp(type, "gfp_t") == 0)
-- 
2.28.0


