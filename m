Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE55284E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgJFOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:35:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgJFOfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:35:13 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D100F207EA;
        Tue,  6 Oct 2020 14:35:12 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kPo3b-002zDC-Qi; Tue, 06 Oct 2020 10:35:11 -0400
Message-ID: <20201006143511.648495724@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 06 Oct 2020 10:34:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-linus][PATCH 07/15] selftests/ftrace: Add test case for synthetic event dynamic strings
References: <20201006143446.182666356@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

Add a selftest that defines and traces a synthetic event that uses a
dynamic string event field.

Link: https://lkml.kernel.org/r/74445afb005046d76d59fb06696a2ceaa164dec9.1601848695.git.zanussi@kernel.org

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 .../trigger-synthetic-event-dynstring.tc      | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc

diff --git a/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
new file mode 100644
index 000000000000..3d65c856eca3
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-dynstring.tc
@@ -0,0 +1,31 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event trigger - test inter-event histogram trigger trace action with dynamic string param
+# requires: set_event synthetic_events events/sched/sched_process_exec/hist "char name[]' >> synthetic_events":README
+
+fail() { #msg
+    echo $1
+    exit_fail
+}
+
+echo "Test create synthetic event"
+
+echo 'ping_test_latency u64 lat; char filename[]' > synthetic_events
+if [ ! -d events/synthetic/ping_test_latency ]; then
+    fail "Failed to create ping_test_latency synthetic event"
+fi
+
+echo "Test create histogram for synthetic event using trace action and dynamic strings"
+echo "Test histogram dynamic string variables,simple expression support and trace action"
+
+echo 'hist:key=pid:filenamevar=filename:ts0=common_timestamp.usecs' > events/sched/sched_process_exec/trigger
+echo 'hist:key=pid:lat=common_timestamp.usecs-$ts0:onmatch(sched.sched_process_exec).ping_test_latency($lat,$filenamevar) if comm == "ping"' > events/sched/sched_process_exit/trigger
+echo 'hist:keys=filename,lat:sort=filename,lat' > events/synthetic/ping_test_latency/trigger
+
+ping $LOCALHOST -c 5
+
+if ! grep -q "ping" events/synthetic/ping_test_latency/hist; then
+    fail "Failed to create dynamic string trace action inter-event histogram"
+fi
+
+exit 0
-- 
2.28.0


