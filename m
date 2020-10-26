Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39777299083
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 16:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783155AbgJZPGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 11:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730680AbgJZPGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 11:06:22 -0400
Received: from localhost.localdomain (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EE7422450;
        Mon, 26 Oct 2020 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603724781;
        bh=IfMidxCdmYhjoIjvs8/I6BM6QFeZmKGSgAvEonhIEv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=gT3lTPmQhGPaobClBEWDzcgjoM23J6Xe9Rhd5b05jBJSYYCbleiCFc5aN7uAH2Ihp
         FT4oLs1Q04lftVSruZF11YVALlSY78FqYDNNcPThQvjxV3rKxaM2VNOLupkpk9zu5c
         ccG8iyUdG+Z4MtQP+P5qKnWDQP1gIarqSROxIUHw=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] selftests/ftrace: Add synthetic event field separators
Date:   Mon, 26 Oct 2020 10:06:12 -0500
Message-Id: <75a2816b4001e04e7d60bcc87aa91477ad5d90b3.1603723933.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1603723933.git.zanussi@kernel.org>
References: <cover.1603723933.git.zanussi@kernel.org>
In-Reply-To: <cover.1603723933.git.zanussi@kernel.org>
References: <cover.1603723933.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These tests omit field separators from the synthetic event definitions
so don't follow the syntax '<event_name> field[;field] ...' required
for synthetic events.

Fixes: f06eec4d0f2c (selftests: ftrace: Add inter-event hist triggers testcases)
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../trigger/inter-event/trigger-inter-event-combined-hist.tc  | 4 ++--
 .../test.d/trigger/inter-event/trigger-onmatch-action-hist.tc | 2 +-
 .../trigger/inter-event/trigger-onmatch-onmax-action-hist.tc  | 2 +-
 .../test.d/trigger/inter-event/trigger-trace-action-hist.tc   | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index 9098f1e7433f..29a03ed3377d 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -10,7 +10,7 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
-echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
+echo 'waking_latency  u64 lat; pid_t pid' > synthetic_events
 if [ ! -d events/synthetic/waking_latency ]; then
     fail "Failed to create waking_latency synthetic event"
 fi
@@ -21,7 +21,7 @@ echo 'hist:keys=pid:ts0=common_timestamp.usecs if comm=="ping"' > events/sched/s
 echo 'hist:keys=pid:waking_lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_waking).waking_latency($waking_lat,pid) if comm=="ping"' > events/sched/sched_wakeup/trigger
 echo 'hist:keys=pid,lat:sort=pid,lat' > events/synthetic/waking_latency/trigger
 
-echo 'wakeup_latency u64 lat pid_t pid' >> synthetic_events
+echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
 echo 'hist:keys=pid:ts1=common_timestamp.usecs if comm=="ping"' >> events/sched/sched_wakeup/trigger
 echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts1:onmatch(sched.sched_wakeup).wakeup_latency($wakeup_lat,next_pid) if next_comm=="ping"' > events/sched/sched_switch/trigger
 
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index 20e39471052e..5015d0d74de8 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -10,7 +10,7 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
-echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+echo 'wakeup_latency  u64 lat; pid_t pid; char comm[16]' > synthetic_events
 if [ ! -d events/synthetic/wakeup_latency ]; then
     fail "Failed to create wakeup_latency synthetic event"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index f4b03ab7c287..ac7ba2bbce47 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -10,7 +10,7 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
-echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+echo 'wakeup_latency  u64 lat; pid_t pid; char comm[16]' > synthetic_events
 if [ ! -d events/synthetic/wakeup_latency ]; then
     fail "Failed to create wakeup_latency synthetic event"
 fi
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index c126d2350a6d..76a213f197a0 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -10,7 +10,7 @@ fail() { #msg
 
 echo "Test create synthetic event"
 
-echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
+echo 'wakeup_latency  u64 lat; pid_t pid; char comm[16]' > synthetic_events
 if [ ! -d events/synthetic/wakeup_latency ]; then
     fail "Failed to create wakeup_latency synthetic event"
 fi
-- 
2.17.1

