Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B16B284E20
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgJFOgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726534AbgJFOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B53C2100A;
        Tue,  6 Oct 2020 14:35:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3b-002zCi-Jw; Tue, 06 Oct 2020 10:35:11 -0400
Message-ID: <20201006143511.456924028@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:34:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 06/15] tracing: Add README information for synthetic_events file
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add an entry with a basic description of events/synthetic_events along
with a simple example.

Link: https://lkml.kernel.org/r/3c7f178cf95aaeebc01eda7d95600dd937233eb7.1601848695.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 3f2533adae72..73fd0e0c0f39 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5249,7 +5249,12 @@ static const char readme_msg[] =
 	"\t        trace(<synthetic_event>,param list)  - generate synthetic event\n"
 	"\t        save(field,...)                      - save current event fields\n"
 #ifdef CONFIG_TRACER_SNAPSHOT
-	"\t        snapshot()                           - snapshot the trace buffer\n"
+	"\t        snapshot()                           - snapshot the trace buffer\n\n"
+#endif
+#ifdef CONFIG_SYNTH_EVENTS
+	"  events/synthetic_events\t- Create/append/remove/show synthetic events\n"
+	"\t  Write into this file to define/undefine new synthetic events.\n"
+	"\t     example: echo 'myevent u64 lat; char name[]' >> synthetic_events\n"
 #endif
 #endif
 ;
-- 
2.28.0


