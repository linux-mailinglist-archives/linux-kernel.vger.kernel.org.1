Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D1273809
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgIVB0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:26:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgIVBYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:52 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4E623AC4;
        Tue, 22 Sep 2020 01:24:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX35-001sLD-Ht; Mon, 21 Sep 2020 21:24:51 -0400
Message-ID: <20200922012451.430245414@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [for-next][PATCH 10/26] tracing: Use __this_cpu_read() in trace_buffered_event_enable()
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xianting Tian <tian.xianting@h3c.com>

The code is executed with preemption disabled, so it's
safe to use __this_cpu_read().

Link: https://lkml.kernel.org/r/20200813112803.12256-1-tian.xianting@h3c.com

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8fac7d6db222..1c4ca25944ba 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2511,7 +2511,7 @@ void trace_buffered_event_enable(void)
 
 		preempt_disable();
 		if (cpu == smp_processor_id() &&
-		    this_cpu_read(trace_buffered_event) !=
+		    __this_cpu_read(trace_buffered_event) !=
 		    per_cpu(trace_buffered_event, cpu))
 			WARN_ON_ONCE(1);
 		preempt_enable();
-- 
2.28.0


