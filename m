Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDDE1F3486
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 08:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgFIG47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 02:56:59 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:16236 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgFIG46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:56:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1591685815; x=1623221815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=KUyrJoUtzw78Klau0DvJXqUaX3OAB3h8tsjeSmrj5AQ=;
  b=DWgzkT+Tq4VpThRzXY9Jn0RfceBV4kS63pSfyFxOF1Y2FjyUt+RB0E4o
   G1/rU8P2sb30X5ScxHdZpXfmVJBCoCvmlBIAY8jITf22pAEG0CuytCrPI
   5tH01PKpbLImfqY6pHPkB/Kebl8H1IloYB2+cWNSPaeWRxSpLytoXfBkZ
   E=;
IronPort-SDR: OW+6tlit35EZkmofYfvgjhy7MrxBm3p+fiKGuNqU9RpDGhmI47EtFp5BHdcsNP1SAfjJh17WHz
 4IuvRJDcTSFQ==
X-IronPort-AV: E=Sophos;i="5.73,490,1583193600"; 
   d="scan'208";a="35222415"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Jun 2020 06:56:55 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id A56971418F1;
        Tue,  9 Jun 2020 06:56:43 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 06:56:42 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.53) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 9 Jun 2020 06:56:26 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <foersleo@amazon.de>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <sblbir@amazon.com>, <shakeelb@google.com>, <shuah@kernel.org>,
        <sj38.park@gmail.com>, <snu@amazon.de>, <vbabka@suse.cz>,
        <vdavydov.dev@gmail.com>, <yang.shi@linux.alibaba.com>,
        <ying.huang@intel.com>, <david@redhat.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v11 7/8] damon/tools: Support more human friendly 'schemes' control
Date:   Tue, 9 Jun 2020 08:53:19 +0200
Message-ID: <20200609065320.12941-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609065320.12941-1-sjpark@amazon.com>
References: <20200609065320.12941-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.53]
X-ClientProxiedBy: EX13D31UWA004.ant.amazon.com (10.43.160.217) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit implements 'schemes' subcommand of the damon userspace tool.
It can be used to describe and apply the data access monitoring-based
operation schemes in more human friendly fashion.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/damon/_convert_damos.py | 128 +++++++++++++++++++++++++++++
 tools/damon/_damon.py         | 146 ++++++++++++++++++++++++++++++++++
 tools/damon/damo              |   7 ++
 tools/damon/record.py         | 139 ++++----------------------------
 tools/damon/schemes.py        | 109 +++++++++++++++++++++++++
 5 files changed, 404 insertions(+), 125 deletions(-)
 create mode 100755 tools/damon/_convert_damos.py
 create mode 100644 tools/damon/_damon.py
 create mode 100644 tools/damon/schemes.py

diff --git a/tools/damon/_convert_damos.py b/tools/damon/_convert_damos.py
new file mode 100755
index 000000000000..23cd52980a89
--- /dev/null
+++ b/tools/damon/_convert_damos.py
@@ -0,0 +1,128 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Change human readable data access monitoring-based operation schemes to the low
+level input for the '<debugfs>/damon/schemes' file.  Below is an example of the
+schemes written in the human readable format:
+
+    # format is:
+    # <min/max size> <min/max frequency (0-99)> <min/max age> <action>
+    #
+    # B/K/M/G/T for Bytes/KiB/MiB/GiB/TiB
+    # us/ms/s/m/h/d for micro-seconds/milli-seconds/seconds/minutes/hours/days
+    # 'null' means zero for size and age.
+
+    # if a region keeps a high access frequency for more than 100ms, put the
+    # region on the head of the LRU list (call madvise() with MADV_WILLNEED).
+    null    null    80      null    100ms   0s      willneed
+
+    # if a region keeps a low access frequency for more than 200ms and less
+    # than one hour, put the # region on the tail of the LRU list (call
+    # madvise() with MADV_COLD).
+    0B      0B      10      20      200ms   1h cold
+
+    # if a region keeps a very low access frequency for more than 1 minute,
+    # swap out the region immediately (call madvise() with MADV_PAGEOUT).
+    0B      null    0       10      60s     0s pageout
+
+    # if a region of a size bigger than 2MiB keeps a very high access frequency
+    # for more than 100ms, let the region to use huge pages (call madvise()
+    # with MADV_HUGEPAGE).
+    2M      null    90      99      100ms   0s hugepage
+
+    # If a regions of a size bigger than 2MiB keeps small access frequency for
+    # more than 100ms, avoid the region using huge pages (call madvise() with
+    # MADV_NOHUGEPAGE).
+    2M      null    0       25      100ms   0s nohugepage
+"""
+
+import argparse
+
+unit_to_bytes = {'B': 1, 'K': 1024, 'M': 1024 * 1024, 'G': 1024 * 1024 * 1024,
+        'T': 1024 * 1024 * 1024 * 1024}
+
+def text_to_bytes(txt):
+    if txt == 'null':
+        return 0
+    unit = txt[-1]
+    number = int(txt[:-1])
+    return number * unit_to_bytes[unit]
+
+unit_to_usecs = {'us': 1, 'ms': 1000, 's': 1000 * 1000, 'm': 60 * 1000 * 1000,
+        'h': 60 * 60 * 1000 * 1000, 'd': 24 * 60 * 60 * 1000 * 1000}
+
+def text_to_us(txt):
+    if txt == 'null':
+        return 0
+    unit = txt[-2:]
+    if unit in ['us', 'ms']:
+        number = int(txt[:-2])
+    else:
+        unit = txt[-1]
+        number = int(txt[:-1])
+    return number * unit_to_usecs[unit]
+
+damos_action_to_int = {'DAMOS_WILLNEED': 0, 'DAMOS_COLD': 1,
+        'DAMOS_PAGEOUT': 2, 'DAMOS_HUGEPAGE': 3, 'DAMOS_NOHUGEPAGE': 4,
+        'DAMOS_STAT': 5}
+
+def text_to_damos_action(txt):
+    return damos_action_to_int['DAMOS_' + txt.upper()]
+
+def text_to_nr_accesses(txt, max_nr_accesses):
+    if txt == 'null':
+        return 0
+    return int(int(txt) * max_nr_accesses / 100)
+
+def debugfs_scheme(line, sample_interval, aggr_interval):
+    fields = line.split()
+    if len(fields) != 7:
+        print('wrong input line: %s' % line)
+        exit(1)
+
+    limit_nr_accesses = aggr_interval / sample_interval
+    try:
+        min_sz = text_to_bytes(fields[0])
+        max_sz = text_to_bytes(fields[1])
+        min_nr_accesses = text_to_nr_accesses(fields[2], limit_nr_accesses)
+        max_nr_accesses = text_to_nr_accesses(fields[3], limit_nr_accesses)
+        min_age = text_to_us(fields[4]) / aggr_interval
+        max_age = text_to_us(fields[5]) / aggr_interval
+        action = text_to_damos_action(fields[6])
+    except:
+        print('wrong input field')
+        raise
+    return '%d\t%d\t%d\t%d\t%d\t%d\t%d' % (min_sz, max_sz, min_nr_accesses,
+            max_nr_accesses, min_age, max_age, action)
+
+def convert(schemes_file, sample_interval, aggr_interval):
+    lines = []
+    with open(schemes_file, 'r') as f:
+        for line in f:
+            if line.startswith('#'):
+                continue
+            line = line.strip()
+            if line == '':
+                continue
+            lines.append(debugfs_scheme(line, sample_interval, aggr_interval))
+    return '\n'.join(lines)
+
+def main():
+    parser = argparse.ArgumentParser()
+    parser.add_argument('input', metavar='<file>',
+            help='input file describing the schemes')
+    parser.add_argument('-s', '--sample', metavar='<interval>', type=int,
+            default=5000, help='sampling interval (us)')
+    parser.add_argument('-a', '--aggr', metavar='<interval>', type=int,
+            default=100000, help='aggregation interval (us)')
+    args = parser.parse_args()
+
+    schemes_file = args.input
+    sample_interval = args.sample
+    aggr_interval = args.aggr
+
+    print(convert(schemes_file, sample_interval, aggr_interval))
+
+if __name__ == '__main__':
+    main()
diff --git a/tools/damon/_damon.py b/tools/damon/_damon.py
new file mode 100644
index 000000000000..3620ef12a5ea
--- /dev/null
+++ b/tools/damon/_damon.py
@@ -0,0 +1,146 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Contains core functions for DAMON debugfs control.
+"""
+
+import os
+import subprocess
+
+debugfs_attrs = None
+debugfs_record = None
+debugfs_schemes = None
+debugfs_pids = None
+debugfs_monitor_on = None
+
+def set_target_pid(pid):
+    return subprocess.call('echo %s > %s' % (pid, debugfs_pids), shell=True,
+            executable='/bin/bash')
+
+def turn_damon(on_off):
+    return subprocess.call("echo %s > %s" % (on_off, debugfs_monitor_on),
+            shell=True, executable="/bin/bash")
+
+def is_damon_running():
+    with open(debugfs_monitor_on, 'r') as f:
+        return f.read().strip() == 'on'
+
+class Attrs:
+    sample_interval = None
+    aggr_interval = None
+    regions_update_interval = None
+    min_nr_regions = None
+    max_nr_regions = None
+    rbuf_len = None
+    rfile_path = None
+    schemes = None
+
+    def __init__(self, s, a, r, n, x, l, f, c):
+        self.sample_interval = s
+        self.aggr_interval = a
+        self.regions_update_interval = r
+        self.min_nr_regions = n
+        self.max_nr_regions = x
+        self.rbuf_len = l
+        self.rfile_path = f
+        self.schemes = c
+
+    def __str__(self):
+        return "%s %s %s %s %s %s %s\n%s" % (self.sample_interval,
+                self.aggr_interval, self.regions_update_interval,
+                self.min_nr_regions, self.max_nr_regions, self.rbuf_len,
+                self.rfile_path, self.schemes)
+
+    def attr_str(self):
+        return "%s %s %s %s %s " % (self.sample_interval, self.aggr_interval,
+                self.regions_update_interval, self.min_nr_regions,
+                self.max_nr_regions)
+
+    def record_str(self):
+        return '%s %s ' % (self.rbuf_len, self.rfile_path)
+
+    def apply(self):
+        ret = subprocess.call('echo %s > %s' % (self.attr_str(), debugfs_attrs),
+                shell=True, executable='/bin/bash')
+        if ret:
+            return ret
+        ret = subprocess.call('echo %s > %s' % (self.record_str(),
+            debugfs_record), shell=True, executable='/bin/bash')
+        if ret:
+            return ret
+        return subprocess.call('echo %s > %s' % (
+            self.schemes.replace('\n', ' '), debugfs_schemes), shell=True,
+            executable='/bin/bash')
+
+def current_attrs():
+    with open(debugfs_attrs, 'r') as f:
+        attrs = f.read().split()
+    attrs = [int(x) for x in attrs]
+
+    with open(debugfs_record, 'r') as f:
+        rattrs = f.read().split()
+    attrs.append(int(rattrs[0]))
+    attrs.append(rattrs[1])
+
+    with open(debugfs_schemes, 'r') as f:
+        schemes = f.read()
+
+    # The last two fields in each line are statistics.  Remove those.
+    schemes = [' '.join(x.split()[:-2]) for x in schemes.strip().split('\n')]
+    attrs.append('\n'.join(schemes))
+
+    return Attrs(*attrs)
+
+def chk_update_debugfs(debugfs):
+    global debugfs_attrs
+    global debugfs_record
+    global debugfs_schemes
+    global debugfs_pids
+    global debugfs_monitor_on
+
+    debugfs_damon = os.path.join(debugfs, 'damon')
+    debugfs_attrs = os.path.join(debugfs_damon, 'attrs')
+    debugfs_record = os.path.join(debugfs_damon, 'record')
+    debugfs_schemes = os.path.join(debugfs_damon, 'schemes')
+    debugfs_pids = os.path.join(debugfs_damon, 'pids')
+    debugfs_monitor_on = os.path.join(debugfs_damon, 'monitor_on')
+
+    if not os.path.isdir(debugfs_damon):
+        print("damon debugfs dir (%s) not found", debugfs_damon)
+        exit(1)
+
+    for f in [debugfs_attrs, debugfs_record, debugfs_schemes, debugfs_pids,
+            debugfs_monitor_on]:
+        if not os.path.isfile(f):
+            print("damon debugfs file (%s) not found" % f)
+            exit(1)
+
+def cmd_args_to_attrs(args):
+    "Generate attributes with specified arguments"
+    sample_interval = args.sample
+    aggr_interval = args.aggr
+    regions_update_interval = args.updr
+    min_nr_regions = args.minr
+    max_nr_regions = args.maxr
+    rbuf_len = args.rbuf
+    if not os.path.isabs(args.out):
+        args.out = os.path.join(os.getcwd(), args.out)
+    rfile_path = args.out
+    schemes = args.schemes
+    return Attrs(sample_interval, aggr_interval, regions_update_interval,
+            min_nr_regions, max_nr_regions, rbuf_len, rfile_path, schemes)
+
+def set_attrs_argparser(parser):
+    parser.add_argument('-d', '--debugfs', metavar='<debugfs>', type=str,
+            default='/sys/kernel/debug', help='debugfs mounted path')
+    parser.add_argument('-s', '--sample', metavar='<interval>', type=int,
+            default=5000, help='sampling interval')
+    parser.add_argument('-a', '--aggr', metavar='<interval>', type=int,
+            default=100000, help='aggregate interval')
+    parser.add_argument('-u', '--updr', metavar='<interval>', type=int,
+            default=1000000, help='regions update interval')
+    parser.add_argument('-n', '--minr', metavar='<# regions>', type=int,
+            default=10, help='minimal number of regions')
+    parser.add_argument('-m', '--maxr', metavar='<# regions>', type=int,
+            default=1000, help='maximum number of regions')
diff --git a/tools/damon/damo b/tools/damon/damo
index 58e1099ae5fc..ce7180069bef 100755
--- a/tools/damon/damo
+++ b/tools/damon/damo
@@ -5,6 +5,7 @@ import argparse
 
 import record
 import report
+import schemes
 
 class SubCmdHelpFormatter(argparse.RawDescriptionHelpFormatter):
     def _format_action(self, action):
@@ -25,6 +26,10 @@ parser_record = subparser.add_parser('record',
         help='record data accesses of the given target processes')
 record.set_argparser(parser_record)
 
+parser_schemes = subparser.add_parser('schemes',
+        help='apply operation schemes to the given target process')
+schemes.set_argparser(parser_schemes)
+
 parser_report = subparser.add_parser('report',
         help='report the recorded data accesses in the specified form')
 report.set_argparser(parser_report)
@@ -33,5 +38,7 @@ args = parser.parse_args()
 
 if args.command == 'record':
     record.main(args)
+elif args.command == 'schemes':
+    schemes.main(args)
 elif args.command == 'report':
     report.main(args)
diff --git a/tools/damon/record.py b/tools/damon/record.py
index 1e201d788bee..44fa3a12af35 100644
--- a/tools/damon/record.py
+++ b/tools/damon/record.py
@@ -6,28 +6,12 @@ Record data access patterns of the target process.
 """
 
 import argparse
-import copy
 import os
 import signal
 import subprocess
 import time
 
-debugfs_attrs = None
-debugfs_record = None
-debugfs_pids = None
-debugfs_monitor_on = None
-
-def set_target_pid(pid):
-    return subprocess.call('echo %s > %s' % (pid, debugfs_pids), shell=True,
-            executable='/bin/bash')
-
-def turn_damon(on_off):
-    return subprocess.call("echo %s > %s" % (on_off, debugfs_monitor_on),
-            shell=True, executable="/bin/bash")
-
-def is_damon_running():
-    with open(debugfs_monitor_on, 'r') as f:
-        return f.read().strip() == 'on'
+import _damon
 
 def do_record(target, is_target_cmd, attrs, old_attrs):
     if os.path.isfile(attrs.rfile_path):
@@ -36,98 +20,34 @@ def do_record(target, is_target_cmd, attrs, old_attrs):
     if attrs.apply():
         print('attributes (%s) failed to be applied' % attrs)
         cleanup_exit(old_attrs, -1)
-    print('# damon attrs: %s' % attrs)
+    print('# damon attrs: %s %s' % (attrs.attr_str(), attrs.record_str()))
     if is_target_cmd:
         p = subprocess.Popen(target, shell=True, executable='/bin/bash')
         target = p.pid
-    if set_target_pid(target):
+    if _damon.set_target_pid(target):
         print('pid setting (%s) failed' % target)
         cleanup_exit(old_attrs, -2)
-    if turn_damon('on'):
+    if _damon.turn_damon('on'):
         print('could not turn on damon' % target)
         cleanup_exit(old_attrs, -3)
-    while not is_damon_running():
+    while not _damon.is_damon_running():
         time.sleep(1)
     print('Press Ctrl+C to stop')
     if is_target_cmd:
         p.wait()
     while True:
         # damon will turn it off by itself if the target tasks are terminated.
-        if not is_damon_running():
+        if not _damon.is_damon_running():
             break
         time.sleep(1)
 
     cleanup_exit(old_attrs, 0)
 
-class Attrs:
-    sample_interval = None
-    aggr_interval = None
-    regions_update_interval = None
-    min_nr_regions = None
-    max_nr_regions = None
-    rbuf_len = None
-    rfile_path = None
-
-    def __init__(self, s, a, r, n, x, l, f):
-        self.sample_interval = s
-        self.aggr_interval = a
-        self.regions_update_interval = r
-        self.min_nr_regions = n
-        self.max_nr_regions = x
-        self.rbuf_len = l
-        self.rfile_path = f
-
-    def __str__(self):
-        return "%s %s %s %s %s %s %s" % (self.sample_interval, self.aggr_interval,
-                self.regions_update_interval, self.min_nr_regions,
-                self.max_nr_regions, self.rbuf_len, self.rfile_path)
-
-    def attr_str(self):
-        return "%s %s %s %s %s " % (self.sample_interval, self.aggr_interval,
-                self.regions_update_interval, self.min_nr_regions,
-                self.max_nr_regions)
-
-    def record_str(self):
-        return '%s %s ' % (self.rbuf_len, self.rfile_path)
-
-    def apply(self):
-        ret = subprocess.call('echo %s > %s' % (self.attr_str(), debugfs_attrs),
-                shell=True, executable='/bin/bash')
-        if ret:
-            return ret
-        return subprocess.call('echo %s > %s' % (self.record_str(),
-            debugfs_record), shell=True, executable='/bin/bash')
-
-def current_attrs():
-    with open(debugfs_attrs, 'r') as f:
-        attrs = f.read().split()
-    attrs = [int(x) for x in attrs]
-
-    with open(debugfs_record, 'r') as f:
-        rattrs = f.read().split()
-    attrs.append(int(rattrs[0]))
-    attrs.append(rattrs[1])
-    return Attrs(*attrs)
-
-def cmd_args_to_attrs(args):
-    "Generate attributes with specified arguments"
-    sample_interval = args.sample
-    aggr_interval = args.aggr
-    regions_update_interval = args.updr
-    min_nr_regions = args.minr
-    max_nr_regions = args.maxr
-    rbuf_len = args.rbuf
-    if not os.path.isabs(args.out):
-        args.out = os.path.join(os.getcwd(), args.out)
-    rfile_path = args.out
-    return Attrs(sample_interval, aggr_interval, regions_update_interval,
-            min_nr_regions, max_nr_regions, rbuf_len, rfile_path)
-
 def cleanup_exit(orig_attrs, exit_code):
-    if is_damon_running():
-        if turn_damon('off'):
+    if _damon.is_damon_running():
+        if _damon.turn_damon('off'):
             print('failed to turn damon off!')
-        while is_damon_running():
+        while _damon.is_damon_running():
             time.sleep(1)
     if orig_attrs:
         if orig_attrs.apply():
@@ -138,51 +58,19 @@ def sighandler(signum, frame):
     print('\nsignal %s received' % signum)
     cleanup_exit(orig_attrs, signum)
 
-def chk_update_debugfs(debugfs):
-    global debugfs_attrs
-    global debugfs_record
-    global debugfs_pids
-    global debugfs_monitor_on
-
-    debugfs_damon = os.path.join(debugfs, 'damon')
-    debugfs_attrs = os.path.join(debugfs_damon, 'attrs')
-    debugfs_record = os.path.join(debugfs_damon, 'record')
-    debugfs_pids = os.path.join(debugfs_damon, 'pids')
-    debugfs_monitor_on = os.path.join(debugfs_damon, 'monitor_on')
-
-    if not os.path.isdir(debugfs_damon):
-        print("damon debugfs dir (%s) not found", debugfs_damon)
-        exit(1)
-
-    for f in [debugfs_attrs, debugfs_record, debugfs_pids, debugfs_monitor_on]:
-        if not os.path.isfile(f):
-            print("damon debugfs file (%s) not found" % f)
-            exit(1)
-
 def chk_permission():
     if os.geteuid() != 0:
         print("Run as root")
         exit(1)
 
 def set_argparser(parser):
+    _damon.set_attrs_argparser(parser)
     parser.add_argument('target', type=str, metavar='<target>',
             help='the target command or the pid to record')
-    parser.add_argument('-s', '--sample', metavar='<interval>', type=int,
-            default=5000, help='sampling interval')
-    parser.add_argument('-a', '--aggr', metavar='<interval>', type=int,
-            default=100000, help='aggregate interval')
-    parser.add_argument('-u', '--updr', metavar='<interval>', type=int,
-            default=1000000, help='regions update interval')
-    parser.add_argument('-n', '--minr', metavar='<# regions>', type=int,
-            default=10, help='minimal number of regions')
-    parser.add_argument('-m', '--maxr', metavar='<# regions>', type=int,
-            default=1000, help='maximum number of regions')
     parser.add_argument('-l', '--rbuf', metavar='<len>', type=int,
             default=1024*1024, help='length of record result buffer')
     parser.add_argument('-o', '--out', metavar='<file path>', type=str,
             default='damon.data', help='output file path')
-    parser.add_argument('-d', '--debugfs', metavar='<debugfs>', type=str,
-            default='/sys/kernel/debug', help='debugfs mounted path')
 
 def main(args=None):
     global orig_attrs
@@ -192,13 +80,14 @@ def main(args=None):
         args = parser.parse_args()
 
     chk_permission()
-    chk_update_debugfs(args.debugfs)
+    _damon.chk_update_debugfs(args.debugfs)
 
     signal.signal(signal.SIGINT, sighandler)
     signal.signal(signal.SIGTERM, sighandler)
-    orig_attrs = current_attrs()
+    orig_attrs = _damon.current_attrs()
 
-    new_attrs = cmd_args_to_attrs(args)
+    args.schemes = ''
+    new_attrs = _damon.cmd_args_to_attrs(args)
     target = args.target
 
     target_fields = target.split()
diff --git a/tools/damon/schemes.py b/tools/damon/schemes.py
new file mode 100644
index 000000000000..2d23dfb4fd13
--- /dev/null
+++ b/tools/damon/schemes.py
@@ -0,0 +1,109 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Apply given operation schemes to the target process.
+"""
+
+import argparse
+import os
+import signal
+import subprocess
+import time
+
+import _convert_damos
+import _damon
+
+def run_damon(target, is_target_cmd, attrs, old_attrs):
+    if os.path.isfile(attrs.rfile_path):
+        os.rename(attrs.rfile_path, attrs.rfile_path + '.old')
+
+    if attrs.apply():
+        print('attributes (%s) failed to be applied' % attrs)
+        cleanup_exit(old_attrs, -1)
+    print('# damon attrs: %s %s' % (attrs.attr_str(), attrs.record_str()))
+    for line in attrs.schemes.split('\n'):
+        print('# scheme: %s' % line)
+    if is_target_cmd:
+        p = subprocess.Popen(target, shell=True, executable='/bin/bash')
+        target = p.pid
+    if _damon.set_target_pid(target):
+        print('pid setting (%s) failed' % target)
+        cleanup_exit(old_attrs, -2)
+    if _damon.turn_damon('on'):
+        print('could not turn on damon' % target)
+        cleanup_exit(old_attrs, -3)
+    while not _damon.is_damon_running():
+        sleep(1)
+    if is_target_cmd:
+        p.wait()
+    while True:
+        # damon will turn it off by itself if the target tasks are terminated.
+        if not _damon.is_damon_running():
+            break
+        time.sleep(1)
+
+    cleanup_exit(old_attrs, 0)
+
+def cleanup_exit(orig_attrs, exit_code):
+    if _damon.is_damon_running():
+        if _damon.turn_damon('off'):
+            print('failed to turn damon off!')
+        while _damon.is_damon_running():
+            sleep(1)
+    if orig_attrs:
+        if orig_attrs.apply():
+            print('original attributes (%s) restoration failed!' % orig_attrs)
+    exit(exit_code)
+
+def sighandler(signum, frame):
+    print('\nsignal %s received' % signum)
+    cleanup_exit(orig_attrs, signum)
+
+def chk_permission():
+    if os.geteuid() != 0:
+        print("Run as root")
+        exit(1)
+
+def set_argparser(parser):
+    _damon.set_attrs_argparser(parser)
+    parser.add_argument('target', type=str, metavar='<target>',
+            help='the target command or the pid to record')
+    parser.add_argument('-c', '--schemes', metavar='<file>', type=str,
+            default='damon.schemes',
+            help='data access monitoring-based operation schemes')
+
+def main(args=None):
+    global orig_attrs
+    if not args:
+        parser = argparse.ArgumentParser()
+        set_argparser(parser)
+        args = parser.parse_args()
+
+    chk_permission()
+    _damon.chk_update_debugfs(args.debugfs)
+
+    signal.signal(signal.SIGINT, sighandler)
+    signal.signal(signal.SIGTERM, sighandler)
+    orig_attrs = _damon.current_attrs()
+
+    args.rbuf = 0
+    args.out = 'null'
+    args.schemes = _convert_damos.convert(args.schemes, args.sample, args.aggr)
+    new_attrs = _damon.cmd_args_to_attrs(args)
+    target = args.target
+
+    target_fields = target.split()
+    if not subprocess.call('which %s > /dev/null' % target_fields[0],
+            shell=True, executable='/bin/bash'):
+        run_damon(target, True, new_attrs, orig_attrs)
+    else:
+        try:
+            pid = int(target)
+        except:
+            print('target \'%s\' is neither a command, nor a pid' % target)
+            exit(1)
+        run_damon(target, False, new_attrs, orig_attrs)
+
+if __name__ == '__main__':
+    main()
-- 
2.17.1

