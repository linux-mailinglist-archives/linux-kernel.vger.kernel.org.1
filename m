Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7022A8375
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731205AbgKEQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:25:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:45194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgKEQZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:25:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDAB121734;
        Thu,  5 Nov 2020 16:25:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kai54-007PeB-DG; Thu, 05 Nov 2020 11:25:46 -0500
Message-ID: <20201105162546.266768313@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Nov 2020 11:25:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [for-linus][PATCH 3/4] tracing: Make -ENOMEM the default error for parse_synth_field()
References: <20201105162458.408429167@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

parse_synth_field() returns a pointer and requires that errors get
surrounded by ERR_PTR(). The ret variable is initialized to zero, but should
never be used as zero, and if it is, it could cause a false return code and
produce a NULL pointer dereference. It makes no sense to set ret to zero.

Set ret to -ENOMEM (the most common error case), and have any other errors
set it to something else. This removes the need to initialize ret on *every*
error branch.

Fixes: 761a8c58db6b ("tracing, synthetic events: Replace buggy strcat() with seq_buf operations")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_synth.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 84b7cab55291..881df991742a 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -584,7 +584,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 {
 	struct synth_field *field;
 	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
-	int len, ret = 0;
+	int len, ret = -ENOMEM;
 	struct seq_buf s;
 	ssize_t size;
 
@@ -617,10 +617,9 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		len--;
 
 	field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
-	if (!field->name) {
-		ret = -ENOMEM;
+	if (!field->name)
 		goto free;
-	}
+
 	if (!is_good_name(field->name)) {
 		synth_err(SYNTH_ERR_BAD_NAME, errpos(field_name));
 		ret = -EINVAL;
@@ -638,10 +637,9 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 		len += strlen(prefix);
 
 	field->type = kzalloc(len, GFP_KERNEL);
-	if (!field->type) {
-		ret = -ENOMEM;
+	if (!field->type)
 		goto free;
-	}
+
 	seq_buf_init(&s, field->type, len);
 	if (prefix)
 		seq_buf_puts(&s, prefix);
@@ -653,6 +651,7 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 	}
 	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
 		goto free;
+
 	s.buffer[s.len] = '\0';
 
 	size = synth_field_size(field->type);
@@ -666,10 +665,8 @@ static struct synth_field *parse_synth_field(int argc, const char **argv,
 
 			len = sizeof("__data_loc ") + strlen(field->type) + 1;
 			type = kzalloc(len, GFP_KERNEL);
-			if (!type) {
-				ret = -ENOMEM;
+			if (!type)
 				goto free;
-			}
 
 			seq_buf_init(&s, type, len);
 			seq_buf_puts(&s, "__data_loc ");
-- 
2.28.0


