Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED82A2FF7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbgKBQja convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 11:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:46396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgKBQj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:39:29 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A87A22268;
        Mon,  2 Nov 2020 16:39:28 +0000 (UTC)
Date:   Mon, 2 Nov 2020 11:39:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kernel-janitors@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] tracing, synthetic events: Replace buggy strcat()
 with seq_buf operations
Message-ID: <20201102113926.3f43531b@gandalf.local.home>
In-Reply-To: <20201102074524.GA4040095@mwanda>
References: <20201102074524.GA4040095@mwanda>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Nov 2020 10:45:24 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> Hello Steven Rostedt (VMware),
> 
> The patch 761a8c58db6b: "tracing, synthetic events: Replace buggy
> strcat() with seq_buf operations" from Oct 23, 2020, leads to the
> following static checker warning:
> 
> 	kernel/trace/trace_events_synth.c:703 parse_synth_field()
> 	warn: passing zero to 'ERR_PTR'
> 
> kernel/trace/trace_events_synth.c
>    582  static struct synth_field *parse_synth_field(int argc, const char **argv,
>    583                                               int *consumed)
>    584  {
>    585          struct synth_field *field;
>    586          const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
>    587          int len, ret = 0;
>    588          struct seq_buf s;
>    589          ssize_t size;
>    590  
>    591          if (field_type[0] == ';')
>    592                  field_type++;
>    593  
>    594          if (!strcmp(field_type, "unsigned")) {
>    595                  if (argc < 3) {
>    596                          synth_err(SYNTH_ERR_INCOMPLETE_TYPE, errpos(field_type));
>    597                          return ERR_PTR(-EINVAL);
>    598                  }
>    599                  prefix = "unsigned ";
>    600                  field_type = argv[1];
>    601                  field_name = argv[2];
>    602                  *consumed = 3;
>    603          } else {
>    604                  field_name = argv[1];
>    605                  *consumed = 2;
>    606          }
>    607  
>    608          field = kzalloc(sizeof(*field), GFP_KERNEL);
>    609          if (!field)
>    610                  return ERR_PTR(-ENOMEM);
>    611  
>    612          len = strlen(field_name);
>    613          array = strchr(field_name, '[');
>    614          if (array)
>    615                  len -= strlen(array);
>    616          else if (field_name[len - 1] == ';')
>    617                  len--;
>    618  
>    619          field->name = kmemdup_nul(field_name, len, GFP_KERNEL);
>    620          if (!field->name) {
>    621                  ret = -ENOMEM;
>    622                  goto free;
>    623          }
>    624          if (!is_good_name(field->name)) {
>    625                  synth_err(SYNTH_ERR_BAD_NAME, errpos(field_name));
>    626                  ret = -EINVAL;
>    627                  goto free;
>    628          }
>    629  
>    630          if (field_type[0] == ';')
>    631                  field_type++;
>    632          len = strlen(field_type) + 1;
>    633  
>    634          if (array)
>    635                  len += strlen(array);
>    636  
>    637          if (prefix)
>    638                  len += strlen(prefix);
>    639  
>    640          field->type = kzalloc(len, GFP_KERNEL);
>    641          if (!field->type) {
>    642                  ret = -ENOMEM;
>    643                  goto free;
>    644          }
>    645          seq_buf_init(&s, field->type, len);
>    646          if (prefix)
>    647                  seq_buf_puts(&s, prefix);
>    648          seq_buf_puts(&s, field_type);
>    649          if (array) {
>    650                  seq_buf_puts(&s, array);
>    651                  if (s.buffer[s.len - 1] == ';')
>    652                          s.len--;
>    653          }
>    654          if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
>    655                  goto free;
> 
> This was originally reported by kbuild-bot, but it was somehow
> overlooked so now it's on my system.  The missing error code will lead
> to a NULL dereference in the caller.


I misread the original report, modified it to fix something else, and
didn't see the real problem.

Having to initialize ret for *every* error path is ridiculous. Here's the
fix.

-- Steve

From 2980f226a7fb08e37fd3948e206854fe5a1a8c50 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Mon, 2 Nov 2020 11:28:39 -0500
Subject: [PATCH] tracing: Make -ENOMEM the default error for
 parse_synth_field()

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
2.25.4


