Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564202ECF59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbhAGMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:09:08 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:21798 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbhAGMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1610021347; x=1641557347;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Pq/1QFmMwIoQiLmPrNgwyVK1ezuCrlRevhqPdfRTny8=;
  b=huUfGYoAxCTFq0EF3NTuEUNidZPybN/SgBsTYqr/k60/bCDNK20R9plX
   HM7IzHzKv1Rl7+3Rthf87/wg9mBraiJVVH6n40jCU6pDj7ik597jd6fVc
   o/Jx19oQGmZeQOboskbtv6CCBne6TVoZl5rJK4lJkQqVzT+I6EODpxeN3
   8=;
X-IronPort-AV: E=Sophos;i="5.79,329,1602547200"; 
   d="scan'208";a="73626685"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-af6a10df.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 07 Jan 2021 12:08:19 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1a-af6a10df.us-east-1.amazon.com (Postfix) with ESMTPS id A8E4EA207D;
        Thu,  7 Jan 2021 12:08:07 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.66) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 7 Jan 2021 12:07:50 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <elver@google.com>, <fan.du@intel.com>,
        <foersleo@amazon.de>, <gthelen@google.com>, <irogers@google.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <riel@surriel.com>, <rientjes@google.com>,
        <rostedt@goodmis.org>, <rppt@kernel.org>, <sblbir@amazon.com>,
        <shakeelb@google.com>, <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] tools/perf: Integrate DAMON in perf
Date:   Thu, 7 Jan 2021 13:07:29 +0100
Message-ID: <20210107120729.22328-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.66]
X-ClientProxiedBy: EX13D23UWC003.ant.amazon.com (10.43.162.81) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

NOTE: This RFC has a dependancy on DAMON (Data Access MONitor)
patchset[1], which is not merged in the mainline yet.  The aim of this
is to show how DAMON would be evolved once it is merged in and get some
comments early.  So, if you have some interest in this, please consider
reviewing the DAMON patchset, either.

[1] https://lore.kernel.org/linux-mm/20201215115448.25633-1-sjpark@amazon.com

---

Though there is a simple debugfs interface for DAMON and even a
dedicated user space tool, integrating the interface in perf will make
best user experiences.  For the reason, this commit adds perf scripts
for DAMON.  After this commit, users can record the data access
monitoring results and read in human readable form with:

    $ sudo perf script record damon
    $ sudo perf script report damon

or simply,

    $ sudo perf script damon

Nevertheless, above commands do not start the monitoring by themselves,
so the user should turn it on in background.  To make it easy, this
commit also adds a convenient version of 'perf script record damon',
which executes a command, turns on DAMON for the process, and records
DAMON trace events.  For example, it can be used as:

    $ sudo ~/libexec/perf-core/scripts/python/bin/damon-record.sh <cmd>
    $ sudo perf script report damon

Currently, the report command supports only raw format.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/perf/scripts/python/bin/damon-record    |   4 +
 tools/perf/scripts/python/bin/damon-record.sh | 163 ++++++++++++++++++
 tools/perf/scripts/python/bin/damon-report    |   4 +
 tools/perf/scripts/python/damon.py            |  44 +++++
 4 files changed, 215 insertions(+)
 create mode 100644 tools/perf/scripts/python/bin/damon-record
 create mode 100644 tools/perf/scripts/python/bin/damon-record.sh
 create mode 100644 tools/perf/scripts/python/bin/damon-report
 create mode 100644 tools/perf/scripts/python/damon.py

diff --git a/tools/perf/scripts/python/bin/damon-record b/tools/perf/scripts/python/bin/damon-record
new file mode 100644
index 000000000000..6e21802c8c0e
--- /dev/null
+++ b/tools/perf/scripts/python/bin/damon-record
@@ -0,0 +1,4 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+perf record -e damon:damon_aggregated $@
diff --git a/tools/perf/scripts/python/bin/damon-record.sh b/tools/perf/scripts/python/bin/damon-record.sh
new file mode 100644
index 000000000000..3e3e27343ccc
--- /dev/null
+++ b/tools/perf/scripts/python/bin/damon-record.sh
@@ -0,0 +1,163 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This is more convenient version of 'perf script record damon <command>'.
+# While the command assumes DAMON will be turned on by the user, this do that
+# instead.  That is, this command starts the command, turn DAMON on for the
+# process, and record the trace events.
+
+pr_usage()
+{
+	>&2 echo "Usage: $0 [OPTION]... <command>"
+	>&2 echo
+	>&2 echo "OPTION"
+	>&2 echo "  --sampling <interval>	Sampling interval (us)"
+	>&2 echo "  --aggregate <interval>	Aggregate interval (us)"
+	>&2 echo "  --update <interval>	Regions update interval (us)"
+	>&2 echo "  --min-reg <nr>		Minimum number of regions"
+	>&2 echo "  --max-reg <nr>		Maximum number of regions"
+}
+
+# Default values (intervals are in us)
+sampling_interval=5000
+aggregate_interval=100000
+regions_update_interval=1000000
+min_nr_regions=10
+max_nr_regions=1000
+cmd=""
+
+debugfs_dir=$(mount | grep -e "type debugfs" | awk '{print $3}')
+if [ -z "$debugfs_dir" ]
+then
+	>&2 echo "debugfs not found"
+	exit 1
+fi
+
+damon_dir="$debugfs_dir/damon"
+if [ ! -d "$damon_dir" ]
+then
+	>&2 echo "damon dir not found"
+	exit 1
+fi
+
+if [ $# -lt 1 ]
+then
+	pr_usage
+	exit 1
+fi
+
+while [ $# -ne 0 ]
+do
+	case $1 in
+	"--sampling")
+		if [ $# -lt 2 ]
+		then
+			>&2 echo "<interval> not given"
+			pr_usage
+			exit 1
+		fi
+		sampling_interval=$2
+		shift 2
+		continue
+		;;
+	"--aggregate")
+		if [ $# -lt 2 ]
+		then
+			>&2 echo "<interval> not given"
+			pr_usage
+			exit 1
+		fi
+		aggregate_interval=$2
+		shift 2
+		continue
+		;;
+	"--update")
+		if [ $# -lt 2 ]
+		then
+			>&2 echo "<interval> not given"
+			pr_usage
+			exit 1
+		fi
+		regions_update_interval=$2
+		shift 2
+		continue
+		;;
+	"--min_reg")
+		if [ $# -lt 2 ]
+		then
+			>&2 echo "<nr> not given"
+			pr_usage
+			exit 1
+		fi
+		min_nr_regions=$2
+		shift 2
+		continue
+		;;
+	"--max_reg")
+		if [ $# -lt 2 ]
+		then
+			>&2 echo "<nr> not given"
+			pr_usage
+			exit 1
+		fi
+		max_nr_regions=$2
+		shift 2
+		continue
+		;;
+	*)
+		if [ $# -lt 1 ]
+		then
+			>&2 echo "<command> not given"
+			pr_usage
+			exit 1
+		fi
+		cmd="$*"
+		break
+		;;
+	esac
+done
+
+if [ -z "$cmd" ]
+then
+	pr_usage
+	exit 1
+fi
+
+orig_attrs=$(cat "$damon_dir/attrs")
+attrs="$sampling_interval $aggregate_interval $regions_update_interval"
+attrs="$attrs $min_nr_regions $max_nr_regions"
+
+echo "$attrs" > "$damon_dir/attrs"
+
+$cmd &
+cmd_pid=$!
+
+echo "$cmd_pid" > "$damon_dir/target_ids"
+echo "on" > "$damon_dir/monitor_on"
+
+perf record -e damon:damon_aggregated &
+perf_pid=$!
+
+sigint_trap()
+{
+	kill 2 "$cmd_pid"
+	kill 2 "$perf_pid"
+	echo "$orig_attrs" > "$damon_dir/attrs"
+	exit
+}
+
+trap sigint_trap INT
+
+>&2 echo "Press Control+C to stop recording"
+
+while :;
+do
+	on_off=$(cat "$damon_dir/monitor_on")
+	if [ "$on_off" = "off" ]
+	then
+		kill 2 $perf_pid
+		echo "$orig_attrs" > "$damon_dir/attrs"
+		break
+	fi
+	sleep 1
+done
diff --git a/tools/perf/scripts/python/bin/damon-report b/tools/perf/scripts/python/bin/damon-report
new file mode 100644
index 000000000000..89ece171959e
--- /dev/null
+++ b/tools/perf/scripts/python/bin/damon-report
@@ -0,0 +1,4 @@
+#!/bin/bash
+# description: data access monitoring
+
+perf script $@ -s "$PERF_EXEC_PATH"/scripts/python/damon.py
diff --git a/tools/perf/scripts/python/damon.py b/tools/perf/scripts/python/damon.py
new file mode 100644
index 000000000000..b71a9bdf00e7
--- /dev/null
+++ b/tools/perf/scripts/python/damon.py
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Author: SeongJae Park <sjpark@amazon.de>
+
+from __future__ import print_function
+
+import os
+import sys
+
+sys.path.append(os.environ['PERF_EXEC_PATH'] + \
+	'/scripts/python/Perf-Trace-Util/lib/Perf/Trace')
+
+from perf_trace_context import *
+from Core import *
+
+
+def trace_begin():
+	pass
+
+def trace_end():
+	pass
+
+start_time = None
+nr_printed = 0
+def damon__damon_aggregated(event_name, context, common_cpu,
+		common_secs, common_nsecs, common_pid, common_comm,
+		common_callchain, target_id, nr_regions, start, end,
+		nr_accesses, perf_sample_dict):
+	global start_time
+	global nr_printed
+	time = common_secs * 1000000000 + common_nsecs
+	if not start_time:
+		start_time = time
+		print('start_time: %d' % start_time)
+	if nr_printed == 0:
+		print('rel time: %d' % (time - start_time))
+		print('target_id: %d' % target_id)
+		print('nr_regions: %d' % nr_regions)
+	print('%x-%x (%d): %u' % (start, end, end - start, nr_accesses))
+
+	nr_printed += 1
+	if nr_printed == nr_regions:
+		nr_printed = 0
+		print()
-- 
2.17.1

