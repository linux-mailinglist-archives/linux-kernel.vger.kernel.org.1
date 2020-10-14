Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AD028E585
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390186AbgJNRif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389565AbgJNRhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D736122280;
        Wed, 14 Oct 2020 17:37:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiP-002yJb-Mr; Wed, 14 Oct 2020 13:37:29 -0400
Message-ID: <20201014173729.577913194@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 10/12] tracing: Handle synthetic event array field type checking correctly
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Since synthetic event array types are derived from the field name,
there may be a semicolon at the end of the type which should be
stripped off.

If there are more characters following that, normal type string
checking will result in an invalid type.

Without this patch, you can end up with an invalid field type string
that gets displayed in both the synthetic event description and the
event format:

Before:

  # echo 'myevent char str[16]; int v' >> synthetic_events
  # cat synthetic_events
    myevent	char[16]; str; int v

  name: myevent
  ID: 1936
  format:
  	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
  	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
  	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
  	field:int common_pid;	offset:4;	size:4;	signed:1;

  	field:char str[16];;	offset:8;	size:16;	signed:1;
  	field:int v;	offset:40;	size:4;	signed:1;

  print fmt: "str=%s, v=%d", REC->str, REC->v

After:

  # echo 'myevent char str[16]; int v' >> synthetic_events
  # cat synthetic_events
    myevent	char[16] str; int v

  # cat events/synthetic/myevent/format
  name: myevent
  ID: 1936
  format:
	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
	field:int common_pid;	offset:4;	size:4;	signed:1;

	field:char str[16];	offset:8;	size:16;	signed:1;
	field:int v;	offset:40;	size:4;	signed:1;

  print fmt: "str=%s, v=%d", REC->str, REC->v

Link: https://lkml.kernel.org/r/6587663b56c2d45ab9d8c8472a2110713cdec97d.1602598160.git.zanussi@kernel.org

[ <rostedt@goodmis.org>: wrote parse_synth_field() snippet. ]
Fixes: 4b147936fa50 (tracing: Add support for 'synthetic' events)
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index f77851018121..d239f0e2af8f 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -174,7 +174,7 @@ static int synth_field_string_size(char *type)
 	start += sizeof("char[") - 1;
 
 	end = strchr(type, ']');
-	if (!end || end < start)
+	if (!end || end < start || type + strlen(type) > end + 1)
 		return -EINVAL;
 
 	len = end - start;
@@ -625,8 +625,14 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	if (field_type[0] == ';')
 		field_type++;
 	len = strlen(field_type) + 1;
-	if (array)
-		len += strlen(array);
+
+        if (array) {
+                int l = strlen(array);
+
+                if (l && array[l - 1] == ';')
+                        l--;
+                len += l;
+        }
 	if (prefix)
 		len += strlen(prefix);
 
-- 
2.28.0


