Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 137031A329B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 12:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDIKkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 06:40:37 -0400
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:46387 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgDIKkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:40:37 -0400
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id 5E507FACA9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Apr 2020 11:40:36 +0100 (IST)
Received: (qmail 26492 invoked from network); 9 Apr 2020 10:40:36 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Apr 2020 10:40:36 -0000
Date:   Thu, 9 Apr 2020 11:40:34 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: Remove obsolete PREEMPTIRQ_EVENTS kconfig option
Message-ID: <20200409104034.GJ3818@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PREEMPTIRQ_EVENTS option is unused after commit c3bc8fd637a9 ("tracing:
Centralize preemptirq tracepoints and unify their usage"). Remove it.

Note that this option is hazardous as it stands. It enables TRACE_IRQFLAGS
event on non-preempt configurations without the irqsoff tracer enabled.
TRACE_IRQFLAGS as it stands incurs significant overhead on each IRQ
entry/exit. This is because trace_hardirqs_[on|off] does all the per-cpu
manipulations and NMI checks even if tracing is completely disabled for
some insane reason.  For example, netperf running UDP_STREAM on localhost
incurs a 4-6% performance penalty without any tracing if IRQFLAGS is
set. It can be put behind a static brach but even the function entry/exit
costs a little bit.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/trace/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 402eef84c859..568ad371e19c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -258,15 +258,6 @@ config TRACE_PREEMPT_TOGGLE
 	  Enables hooks which will be called when preemption is first disabled,
 	  and last enabled.
 
-config PREEMPTIRQ_EVENTS
-	bool "Enable trace events for preempt and irq disable/enable"
-	select TRACE_IRQFLAGS
-	select TRACE_PREEMPT_TOGGLE if PREEMPTION
-	select GENERIC_TRACER
-	default n
-	help
-	  Enable tracing of disable and enable events for preemption and irqs.
-
 config IRQSOFF_TRACER
 	bool "Interrupts-off Latency Tracer"
 	default n
