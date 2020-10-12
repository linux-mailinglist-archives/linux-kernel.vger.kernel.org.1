Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA628C226
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 22:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgJLUS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 16:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgJLUSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 16:18:21 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F8B520FC3;
        Mon, 12 Oct 2020 20:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602533901;
        bh=eHzwqavtVhpOJqis91Eh6XpW5fNq2o2eYisnJItGmFU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Jh73whjqw32Dz9bPOYcMmCSt4pX9PatPplh8H55++JGVNyqac1JmEG+CegYpBcjx5
         lsisngsNwgNTLgiQ9gmgTrreSJVnSjS8IjujMV2I8lrU4jV9EUFkwoBfNqtNqSE6Mv
         p/LpAAI1ErFGQEem1qW7K86HinwpkfginJQuZ150=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] selftests/ftrace: Change synthetic event name for inter-event-combined test
Date:   Mon, 12 Oct 2020 15:18:07 -0500
Message-Id: <59b683d34511125546deef334bb3dc67a4de52c9.1602533267.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
In-Reply-To: <cover.1602533267.git.zanussi@kernel.org>
References: <cover.1602533267.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test uses waking+wakeup_latency as an event name, which doesn't
make sense since it includes an operator.  Illegal names are now
detected by the synthetic event command parsing, which causes this
test to fail.  Change the name to 'waking_plus_wakeup_latency' to
prevent this.

Fixes: f06eec4d0f2c (selftests: ftrace: Add inter-event hist triggers testcases)
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.17.1

