Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F20E282E04
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 00:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgJDWO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 18:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726745AbgJDWOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 18:14:20 -0400
Received: from tzanussi-mobl.hsd1.il.comcast.net (c-73-209-127-30.hsd1.il.comcast.net [73.209.127.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86B1420796;
        Sun,  4 Oct 2020 22:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601849660;
        bh=OqBbst+jgSkswuSoNUHuMIdoUn5IJx5V+BYYAZkJmfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=cgWQTAAClQQuXzyt7+BWV+9ZbTyGltSbhrWWosGpJI68KAr7msiixXfuEl0x/45qd
         fXfrFPKqxfCabh7Tum9LPKIXVg6Rpfzuu0MLa+GRGlQARqnNOx10PEpUfG4D2JX6WA
         FM/AAt/wZqKPIELFAMI4F2kE61YSzzyh6Y3EyV2A=
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org, axelrasmussen@google.com
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/7] selftests/ftrace: Add test case for synthetic event dynamic strings
Date:   Sun,  4 Oct 2020 17:14:08 -0500
Message-Id: <74445afb005046d76d59fb06696a2ceaa164dec9.1601848695.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
In-Reply-To: <cover.1601848695.git.zanussi@kernel.org>
References: <cover.1601848695.git.zanussi@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a selftest that defines and traces a synthetic event that uses a
dynamic string event field.

Signed-off-by: Tom Zanussi <zanussi@kernel.org>
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
2.17.1

