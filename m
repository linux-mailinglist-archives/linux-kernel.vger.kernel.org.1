Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB59C28E57B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389744AbgJNRhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:57694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389556AbgJNRhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B802122272;
        Wed, 14 Oct 2020 17:37:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiP-002yJ7-Hl; Wed, 14 Oct 2020 13:37:29 -0400
Message-ID: <20201014173729.415132838@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 09/12] selftests/ftrace: Change synthetic event name for
 inter-event-combined test
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

This test uses waking+wakeup_latency as an event name, which doesn't
make sense since it includes an operator.  Illegal names are now
detected by the synthetic event command parsing, which causes this
test to fail.  Change the name to 'waking_plus_wakeup_latency' to
prevent this.

Link: https://lkml.kernel.org/r/a1ee2f76ff28ef7166fb788ca8be968887808920.1602598160.git.zanussi@kernel.org

Fixes: f06eec4d0f2c (selftests: ftrace: Add inter-event hist triggers testcases)
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../inter-event/trigger-inter-event-combined-hist.tc      | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 7449a4b8f1f9..9098f1e7433f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -25,12 +25,12 @@ echo 'wakeup_latency u64 lat pid_t pid' >> synthetic_events
 echo 'hist:keys=pid:ts1=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger
 echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts1:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid) if next_comm=="ping"' > events/sched/sched_switch/trigger
 
-echo 'waking+wakeup_latency u64 lat; pid_t pid' >> synthetic_events
-echo 'hist:keys=pid,lat:sort=pid,lat:ww_lat=$waking_lat+$wakeup_lat:onmatch(synthetic.wakeup_latency).waking+wakeup_latency($ww_lat,pid)' >> events/synthetic/wakeup_latency/trigger
-echo 'hist:keys=pid,lat:sort=pid,lat' >> events/synthetic/waking+wakeup_latency/trigger
+echo 'waking_plus_wakeup_latency u64 lat; pid_t pid' >> synthetic_events
+echo 'hist:keys=pid,lat:sort=pid,lat:ww_lat=$waking_lat+$wakeup_lat:onmatch(synthetic.wakeup_latency).waking_plus_wakeup_latency($ww_lat,pid)' >> events/synthetic/wakeup_latency/trigger
+echo 'hist:keys=pid,lat:sort=pid,lat' >> events/synthetic/waking_plus_wakeup_latency/trigger
 
 ping $LOCALHOST -c 3
-if ! grep -q "pid:" events/synthetic/waking+wakeup_latency/hist; then
+if ! grep -q "pid:" events/synthetic/waking_plus_wakeup_latency/hist; then
     fail "Failed to create combined histogram"
 fi
 
-- 
2.28.0


