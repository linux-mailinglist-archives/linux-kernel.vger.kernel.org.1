Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC811E6B09
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 21:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406605AbgE1Tcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 15:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406596AbgE1Tcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:32:46 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99580208A7;
        Thu, 28 May 2020 19:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590694365;
        bh=mo8syWUb5dCIXOQGeySjKP1v5HlAc8jyzUzRQllAlDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ctd2jI7iZvWmLnZ2YdDHQ70ooE8dop6R9BkuiawLzXHCWeUqSjvVIx75BO0pcfomY
         DcxrL4Svg+wapD002B5z4efNrp91gwGLojd58YElREh7Cnq2Ws6Ol6Ts74RJTit2ly
         Cuov2VqdS/wAzc316iVBLrT9JOGzPOLRDLcu/ZOg=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/ftrace: Distinguish between hist and synthetic event checks
Date:   Thu, 28 May 2020 14:32:38 -0500
Message-Id: <af36c539006ef2768114b4ed38e6b054f7c7a3bd.1590693308.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1590693308.git.zanussi@kernel.org>
References: <cover.1590693308.git.zanussi@kernel.org>
In-Reply-To: <cover.1590693308.git.zanussi@kernel.org>
References: <cover.1590693308.git.zanussi@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With synthetic events now a separate config item as a result of
'tracing: Move synthetic events to a separate file', tests that use
both need to explicitly check for hist trigger support rather than
relying on hist triggers to pull in synthetic events.

Add an additional hist trigger check to all the trigger tests that now
require it, otherwise they'll fail if synthetic events but not hist
triggers are enabled.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
---
 .../trigger/inter-event/trigger-field-variable-support.tc    | 5 +++++
 .../trigger/inter-event/trigger-inter-event-combined-hist.tc | 5 +++++
 .../trigger/inter-event/trigger-multi-actions-accept.tc      | 5 +++++
 .../trigger/inter-event/trigger-onmatch-action-hist.tc       | 5 +++++
 .../trigger/inter-event/trigger-onmatch-onmax-action-hist.tc | 5 +++++
 .../test.d/trigger/inter-event/trigger-onmax-action-hist.tc  | 5 +++++
 .../trigger/inter-event/trigger-snapshot-action-hist.tc      | 5 +++++
 .../test.d/trigger/inter-event/trigger-trace-action-hist.tc  | 5 +++++
 8 files changed, 40 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
index 77be6e1f6e7b..e232059a8ab2 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-field-variable-support.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test field variable support"
 
 echo 'wakeup_latency u64 lat; pid_t pid; int prio; char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
index f3eb8aacec0e..07cfcb8157b6 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-inter-event-combined-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test create synthetic event"
 
 echo 'waking_latency  u64 lat pid_t pid' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
index d281f056f980..73e413c2ca26 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-multi-actions-accept.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test multiple actions on hist trigger"
 echo 'wakeup_latency u64 lat; pid_t pid' >> synthetic_events
 TRIGGER1=events/sched/sched_wakeup/trigger
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
index a708f0e7858a..ebe0ad827f9f 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-action-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
index dfce6932d8be..2a2ef767249e 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmatch-onmax-action-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
index 0035995c2194..98d73bfb0296 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-onmax-action-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 echo "Test create synthetic event"
 
 echo 'wakeup_latency  u64 lat pid_t pid char comm[16]' > synthetic_events
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
index f546c1b66a9b..01b01b9c4e07 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-snapshot-action-hist.tc
@@ -12,6 +12,11 @@ if [ ! -f set_event ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 if [ ! -f snapshot ]; then
     echo "snapshot is not supported"
     exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
index 8021d60aafec..c3baa486aeb4 100644
--- a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-trace-action-hist.tc
@@ -17,6 +17,11 @@ if [ ! -f synthetic_events ]; then
     exit_unsupported
 fi
 
+if [ ! -f events/sched/sched_process_fork/hist ]; then
+    echo "hist trigger is not supported"
+    exit_unsupported
+fi
+
 grep -q "trace(<synthetic_event>" README || exit_unsupported # version issue
 
 echo "Test create synthetic event"
-- 
2.17.1

