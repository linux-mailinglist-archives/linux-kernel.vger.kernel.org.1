Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9501D870E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 20:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbgERS33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 14:29:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:51072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728819AbgERS31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:29:27 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E966120657;
        Mon, 18 May 2020 18:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589826566;
        bh=vdMQj/9qhGZqyThEDHAJCjVdXrJdtn/z0t5QJuWwo9Y=;
        h=Subject:From:To:Cc:Date:From;
        b=ZAmBTRT0wRPcr4ErnfK4yk9nqpO3KMYFjdQJLpBaUw386nYyFJYh4xFZfiPb6ni0+
         ksLTy9NrNqleMgrTEodjEsDS+JNn8i1f0JZ9CEk+KIRpFmbuysc0MpBWAoFAjhILX/
         AzL+Q1D2bJ+aWij5tzj9wHuv/NNcE3hxScvaHEiE=
Message-ID: <90ea854dfb728390b50ddf8a8675238973ee014a.camel@kernel.org>
Subject: [PATCH] tracing: Fix events.rst section numbering
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     lixinhai.lxh@gmail.com, linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 18 May 2020 13:29:24 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The in-kernel trace event API should have its own section, and the
duplicate section numbers need fixing as well.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Reported-by: Li Xinhai <lixinhai.lxh@gmail.com>
---
 Documentation/trace/events.rst | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index ed79b220bd07..1a3b7762cb0f 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -526,8 +526,8 @@ The following commands are supported:
 
   See Documentation/trace/histogram.rst for details and examples.
 
-6.3 In-kernel trace event API
------------------------------
+7. In-kernel trace event API
+============================
 
 In most cases, the command-line interface to trace events is more than
 sufficient.  Sometimes, however, applications might find the need for
@@ -559,8 +559,8 @@ following:
   - tracing synthetic events from in-kernel code
   - the low-level "dynevent_cmd" API
 
-6.3.1 Dyamically creating synthetic event definitions
------------------------------------------------------
+7.1 Dyamically creating synthetic event definitions
+---------------------------------------------------
 
 There are a couple ways to create a new synthetic event from a kernel
 module or other kernel code.
@@ -665,8 +665,8 @@ registered by calling the synth_event_gen_cmd_end() function:
 At this point, the event object is ready to be used for tracing new
 events.
 
-6.3.3 Tracing synthetic events from in-kernel code
---------------------------------------------------
+7.2 Tracing synthetic events from in-kernel code
+------------------------------------------------
 
 To trace a synthetic event, there are several options.  The first
 option is to trace the event in one call, using synth_event_trace()
@@ -677,8 +677,8 @@ synth_event_trace_start() and synth_event_trace_end() along with
 synth_event_add_next_val() or synth_event_add_val() to add the values
 piecewise.
 
-6.3.3.1 Tracing a synthetic event all at once
----------------------------------------------
+7.2.1 Tracing a synthetic event all at once
+-------------------------------------------
 
 To trace a synthetic event all at once, the synth_event_trace() or
 synth_event_trace_array() functions can be used.
@@ -779,8 +779,8 @@ remove the event:
 
        ret = synth_event_delete("schedtest");
 
-6.3.3.1 Tracing a synthetic event piecewise
--------------------------------------------
+7.2.2 Tracing a synthetic event piecewise
+-----------------------------------------
 
 To trace a synthetic using the piecewise method described above, the
 synth_event_trace_start() function is used to 'open' the synthetic
@@ -863,8 +863,8 @@ Note that synth_event_trace_end() must be called at the end regardless
 of whether any of the add calls failed (say due to a bad field name
 being passed in).
 
-6.3.4 Dyamically creating kprobe and kretprobe event definitions
-----------------------------------------------------------------
+7.3 Dyamically creating kprobe and kretprobe event definitions
+--------------------------------------------------------------
 
 To create a kprobe or kretprobe trace event from kernel code, the
 kprobe_event_gen_cmd_start() or kretprobe_event_gen_cmd_start()
@@ -940,8 +940,8 @@ used to give the kprobe event file back and delete the event:
 
   ret = kprobe_event_delete("gen_kprobe_test");
 
-6.3.4 The "dynevent_cmd" low-level API
---------------------------------------
+7.4 The "dynevent_cmd" low-level API
+------------------------------------
 
 Both the in-kernel synthetic event and kprobe interfaces are built on
 top of a lower-level "dynevent_cmd" interface.  This interface is
-- 
2.17.1


