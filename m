Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B87212F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 00:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgGBV7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 17:59:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgGBV6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:58:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83BA821927;
        Thu,  2 Jul 2020 21:58:33 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.93)
        (envelope-from <rostedt@goodmis.org>)
        id 1jr7E0-004BgT-JR; Thu, 02 Jul 2020 17:58:32 -0400
Message-ID: <20200702215832.479842024@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 02 Jul 2020 17:58:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [for-next][PATCH 07/18] tracing: define DEFINE_EVENT_PRINT not related to DEFINE_EVENT
References: <20200702215812.428188663@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yang <richard.weiyang@linux.alibaba.com>

Current definition define DEFINE_EVENT_PRINT to be DEFINE_EVENT.
Actually, at this point DEFINE_EVENT is already an empty macro. Let's
cut the relationship between DEFINE_EVENT_PRINT and DEFINE_EVENT.

Link: http://lkml.kernel.org/r/20200612092844.56107-4-richard.weiyang@linux.alibaba.com

Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index 5219f81b9d74..43023c3e9d74 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -210,8 +210,7 @@ TRACE_MAKE_SYSTEM_STR();
 #define DEFINE_EVENT(template, name, proto, args)
 
 #undef DEFINE_EVENT_PRINT
-#define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
+#define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
 #undef TRACE_EVENT_FLAGS
 #define TRACE_EVENT_FLAGS(event, flag)
@@ -444,8 +443,7 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 	{} };
 
 #undef DEFINE_EVENT_PRINT
-#define DEFINE_EVENT_PRINT(template, name, proto, args, print)	\
-	DEFINE_EVENT(template, name, PARAMS(proto), PARAMS(args))
+#define DEFINE_EVENT_PRINT(template, name, proto, args, print)
 
 #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
 
-- 
2.26.2


