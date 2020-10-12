Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 292C028C227
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731351AbgJLUSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387796AbgJLUSX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:18:23 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C85752145D;
        Mon, 12 Oct 2020 20:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602533902;
        bh=CSr/mI1AB8IpNlVHIASiNi7LI+Xt2sRBcHgVo0a0vkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=EncA5bZhoSgN8dhvSO5107N2FB72kZtt62iJaJUmnQJZLGThgYw/Ac6tz3fX0wCrI
         x0qNzssvYPRjmLbUsiyTK7yJIlDywZOI80e0aUme6qfoZYSB+oAHscbjkb3vrdkwn3
         9OfdqAIREo/vKEddPVg5AvrFPLGXOozi6E34K6Bs=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] tracing: Handle synthetic event array field type checking correctly
Date:   Mon, 12 Oct 2020 15:18:08 -0500
Message-Id: <65a8c7dc784df121ea4b1c0060124e218f2162d0.1602533267.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 4b147936fa50 (tracing: Add support for 'synthetic' events)
Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 kernel/trace/trace_events_synth.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 64c65be62dfe..5c3f5ae6f0bd 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -179,7 +179,7 @@ static int synth_field_string_size(char *type)
 	start += sizeof("char[") - 1;
 
 	end = strchr(type, ']');
-	if (!end || end < start)
+	if (!end || end < start || type + strlen(type) > end + 1)
 		return -EINVAL;
 
 	len = end - start;
@@ -630,8 +630,11 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	if (field_type[0] == ';')
 		field_type++;
 	len = strlen(field_type) + 1;
-	if (array)
+	if (array) {
 		len += strlen(array);
+		if (array[strlen(array) - 1] == ';')
+			len--;
+	}
 	if (prefix)
 		len += strlen(prefix);
 
-- 
2.17.1

