Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A7A2F5B90
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbhANHuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:50:44 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:10967 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbhANHun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:50:43 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DGbzk3H1gzj6Jq;
        Thu, 14 Jan 2021 15:49:06 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 14 Jan 2021
 15:49:47 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <john.wanghui@huawei.com>
Subject: [PATCH v2 2/2] perf tools: Add documentation for 'perf irq' command
Date:   Thu, 14 Jan 2021 15:48:52 +0800
Message-ID: <20210114074852.13231-3-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210114074852.13231-1-cuibixuan@huawei.com>
References: <20210114074852.13231-1-cuibixuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for 'perf irq' command.

Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 tools/perf/Documentation/perf-irq.txt | 58 +++++++++++++++++++++++++++
 tools/perf/command-list.txt           |  1 +
 2 files changed, 59 insertions(+)
 create mode 100644 tools/perf/Documentation/perf-irq.txt

diff --git a/tools/perf/Documentation/perf-irq.txt b/tools/perf/Documentation/perf-irq.txt
new file mode 100644
index 000000000000..22709b6df62d
--- /dev/null
+++ b/tools/perf/Documentation/perf-irq.txt
@@ -0,0 +1,58 @@
+perf-irq(1)
+=============
+
+NAME
+----
+perf-irq - Tool to trace/measure hardware interrupts
+
+SYNOPSIS
+--------
+[verse]
+'perf irq' {record|report|script}
+
+DESCRIPTION
+-----------
+There are several variants of 'perf irq':
+
+  'perf irq record <command>' to record the irq handler events
+  of an arbitrary workload.
+
+  'perf irq script' to see a detailed trace of the workload that
+   was recorded (aliased to 'perf script' for now).
+
+  'perf irq report' to calculate the time consumed by each
+   hardware interrupt processing function.
+
+    Example usage:
+        perf irq record -- sleep 1
+        perf irq report
+
+   By default it shows the individual irq events, including the irq name,
+   cpu(execute the hardware interrupt processing function), time consumed,
+   entry time and exit time for the each hardware irq:
+
+   -------------------------------------------------------------------------------------------------------------------------------------------
+     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
+   -------------------------------------------------------------------------------------------------------------------------------------------
+     enp2s0f2-tx-0    | [0006] |      0.000001 s |   6631263.313329 s |   6631263.313330 s
+
+   -------------------------------------------------------------------------------------------------------------------------------------------
+     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
+   -------------------------------------------------------------------------------------------------------------------------------------------
+     megasas          | [0013] |      0.000003 s |   6631263.209564 s |   6631263.209567 s
+
+   -------------------------------------------------------------------------------------------------------------------------------------------
+     Irq name         |  CPU   | Time consume us | Handler entry time | Handler exit time
+   -------------------------------------------------------------------------------------------------------------------------------------------
+     acpi             | [0016] |      0.000018 s |   6631263.085787 s |   6631263.085805 s
+
+
+OPTIONS for 'perf irq report'
+----------------------------
+
+--cpus::
+	Show just entries with activities for the given CPUs.
+
+SEE ALSO
+--------
+linkperf:perf-record[1]
diff --git a/tools/perf/command-list.txt b/tools/perf/command-list.txt
index bc6c585f74fc..c5224ea3ac71 100644
--- a/tools/perf/command-list.txt
+++ b/tools/perf/command-list.txt
@@ -26,6 +26,7 @@ perf-report			mainporcelain common
 perf-sched			mainporcelain common
 perf-script			mainporcelain common
 perf-stat			mainporcelain common
+perf-irq			mainporcelain common
 perf-test			mainporcelain common
 perf-timechart			mainporcelain common
 perf-top			mainporcelain common
-- 
2.17.1

