Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F25264645
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 14:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbgIJMpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 08:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730657AbgIJMkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:40:11 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 564EE21D79;
        Thu, 10 Sep 2020 12:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599741542;
        bh=TJduzfqrCcQcubA0V/fg7Urt0J3UWm7mZ6RqnqTC6L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=faLm4jkh7sfk8NBnvwhomAn2FwsqyF1FnNj3k5+xokDdPzWOCwqkvsnCAhXm9t4Tz
         +e7QsMFoTnGVAOUEsK+UM27njuZuOzq7aHeK7rlnGchFzeDiGBpdJSXJ7r+j5x26tH
         ozwZVXVY2M4UzCkQjsO9UnRvE2xwUalKRZerUVto=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 3/6] tracing: Enable adding dynamic events early stage
Date:   Thu, 10 Sep 2020 21:38:58 +0900
Message-Id: <159974153790.478751.3475515065034825374.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <159974150897.478751.17933810682730471522.stgit@devnote2>
References: <159974150897.478751.17933810682730471522.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split the event fields initialization from creating new
event directory.
This allows the boot-time tracing to define dynamic events
before initializing events directory on tracefs.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_events.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a2531301b44f..720b0d72ea52 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -38,6 +38,7 @@ DEFINE_MUTEX(event_mutex);
 LIST_HEAD(ftrace_events);
 static LIST_HEAD(ftrace_generic_fields);
 static LIST_HEAD(ftrace_common_fields);
+static bool eventdir_initialized;
 
 #define GFP_TRACE (GFP_KERNEL | __GFP_ZERO)
 
@@ -2486,7 +2487,10 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 	if (!file)
 		return -ENOMEM;
 
-	return event_create_dir(tr->event_dir, file);
+	if (eventdir_initialized)
+		return event_create_dir(tr->event_dir, file);
+	else
+		return event_define_fields(call);
 }
 
 /*
@@ -3483,6 +3487,9 @@ __init int event_trace_init(void)
 	if (ret)
 		pr_warn("Failed to register trace events module notifier\n");
 #endif
+
+	eventdir_initialized = true;
+
 	return 0;
 }
 

