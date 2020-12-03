Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71DD2CDCC4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387895AbgLCRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:51:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:46702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbgLCRvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:51:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41B1A207A2;
        Thu,  3 Dec 2020 17:51:07 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kkskz-002quS-Vz; Thu, 03 Dec 2020 12:51:05 -0500
Message-ID: <20201203175105.868760819@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Dec 2020 12:50:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [for-next][PATCH 1/3] tracing: Clean up after filter logic rewriting
References: <20201203175013.038902435@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

The functions event_{set,clear,}_no_set_filter_flag were only used in
replace_system_preds() [now, renamed to process_system_preds()].

Commit 80765597bc58 ("tracing: Rewrite filter logic to be simpler and
faster") removed the use of those functions in replace_system_preds().

Since then, the functions event_{set,clear,}_no_set_filter_flag were
unused. Fortunately, make CC=clang W=1 indicates this with
-Wunused-function warnings on those three functions.

So, clean up these obsolete unused functions.

Link: https://lkml.kernel.org/r/20201115155336.20248-1-lukas.bulwahn@gmail.com

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index d0f515ac9b7c..e91259f6a722 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1561,27 +1561,6 @@ static inline void event_clear_filter(struct trace_event_file *file)
 	RCU_INIT_POINTER(file->filter, NULL);
 }
 
-static inline void
-event_set_no_set_filter_flag(struct trace_event_file *file)
-{
-	file->flags |= EVENT_FILE_FL_NO_SET_FILTER;
-}
-
-static inline void
-event_clear_no_set_filter_flag(struct trace_event_file *file)
-{
-	file->flags &= ~EVENT_FILE_FL_NO_SET_FILTER;
-}
-
-static inline bool
-event_no_set_filter_flag(struct trace_event_file *file)
-{
-	if (file->flags & EVENT_FILE_FL_NO_SET_FILTER)
-		return true;
-
-	return false;
-}
-
 struct filter_list {
 	struct list_head	list;
 	struct event_filter	*filter;
-- 
2.28.0


