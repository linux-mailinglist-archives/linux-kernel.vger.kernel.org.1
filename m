Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C212FBD22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391073AbhASRCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:02:32 -0500
Received: from esa7.hc324-48.eu.iphmx.com ([207.54.71.126]:40724 "EHLO
        esa7.hc324-48.eu.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389743AbhASQwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:52:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1611075170; x=1642611170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JtbhU+MEjxnH0ndi81FLN6q3gxthENEMNOMd1VdQ7F8=;
  b=HWeF2TwMzE1D/lJ4Ku7B+hm3tHPgRKbqWXg6ZNTZx9lbD2AnAqSewBkk
   4hr9thZ7FpFQcKWNqZy0QBYkHXOG9RxO9pnrPwBfHuhTpY7sUNlSrFXek
   x+GNpZpTc2buTDnNZMJjUaPJK1OUVphQmCMn6Rni/Y2yFitw/vtD2bW0c
   g=;
Received: from esagw6.bmwgroup.com (HELO esagw6.muc) ([160.46.252.49]) by
 esa7.hc324-48.eu.iphmx.com with ESMTP/TLS; 19 Jan 2021 17:43:53 +0100
Received: from esabb2.muc ([160.50.100.34])  by esagw6.muc with ESMTP/TLS;
 19 Jan 2021 17:43:53 +0100
Received: from smucm10m.bmwgroup.net (HELO smucm10m.europe.bmw.corp) ([160.48.96.49])
 by esabb2.muc with ESMTP/TLS; 19 Jan 2021 17:43:53 +0100
Received: from greenhouse.bmw-carit.intra (192.168.221.38) by smucm10m.europe.bmw.corp
 (160.48.96.49) with Microsoft SMTP Server (TLS;
 Tue, 19 Jan 2021 17:43:52 +0100
From:   Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>
CC:     Ingo Molnar <mingo@redhat.com>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Subject: [RFC PATCH 1/2] Use pause-on-trace with the latency tracers
Date:   Tue, 19 Jan 2021 17:43:43 +0100
Message-ID: <20210119164344.37500-2-Viktor.Rosendahl@bmw.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119164344.37500-1-Viktor.Rosendahl@bmw.de>
References: <20210119164344.37500-1-Viktor.Rosendahl@bmw.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SMUCM30K.europe.bmw.corp (160.46.167.47) To
 smucm10m.europe.bmw.corp (160.48.96.49)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eaerlier, tracing was disabled when reading the trace file. This behavior
was changed with:

commit 06e0a548bad0 ("tracing: Do not disable tracing when reading the
trace file").

This doesn't seem to work with the latency tracers.

The above mentioned commit dit not only change the behavior but also added
an option to emulate the old behavior. The idea with this patch is to
enable this pause-on-trace option when the latency tracers are used.

This is a workaround, perhaps it would be better to make the latency
tracers work without pausing but I am not sure how to do that, or even
how feasible it is without significant rework.

Signed-off-by: Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
---
 kernel/trace/trace_irqsoff.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index d06aab4dcbb8..6756379b661f 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -562,6 +562,8 @@ static int __irqsoff_tracer_init(struct trace_array *tr)
 	/* non overwrite screws up the latency tracers */
 	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, 1);
 	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, 1);
+	/* without pause, we will produce garbage if another latency occurs */
+	set_tracer_flag(tr, TRACE_ITER_PAUSE_ON_TRACE, 1);
 
 	tr->max_latency = 0;
 	irqsoff_trace = tr;
@@ -583,11 +585,13 @@ static void __irqsoff_tracer_reset(struct trace_array *tr)
 {
 	int lat_flag = save_flags & TRACE_ITER_LATENCY_FMT;
 	int overwrite_flag = save_flags & TRACE_ITER_OVERWRITE;
+	int pause_flag = save_flags & TRACE_ITER_PAUSE_ON_TRACE;
 
 	stop_irqsoff_tracer(tr, is_graph(tr));
 
 	set_tracer_flag(tr, TRACE_ITER_LATENCY_FMT, lat_flag);
 	set_tracer_flag(tr, TRACE_ITER_OVERWRITE, overwrite_flag);
+	set_tracer_flag(tr, TRACE_ITER_PAUSE_ON_TRACE, pause_flag);
 	ftrace_reset_array_ops(tr);
 
 	irqsoff_busy = false;
-- 
2.25.1

