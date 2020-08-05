Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06A8723C65E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 09:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgHEHEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 03:04:23 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:2577 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEHEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596611061; x=1628147061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=VIt0QPHvmvqG4Kch/PM9e/Zwtiyux2gOnoeb9rYl0nc=;
  b=GPdcbAZGHGu4b++JO9L0EYWIB2/F5N2ecg4JXQ07W6bSjkqVFLFbUWeE
   ZcJjabShjwiKgN4xd9dlPzSOuW6bm+pqsjEP8gNaNknqV33x0RXI/EO2X
   W2d/D89ioMGkJZiw5PHhpgBfSfhaUvjr0PjgVgk1G2Y9XLdMzvB/2N4xA
   I=;
IronPort-SDR: IMs5RNHvt7l/Hi6VrOTnuBSid7dno/JsfipzFL9qFFGB7VVXGk73vua7VJZTtySs/qwKBYWhUC
 EmLm/YSu6kMA==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="65698539"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 05 Aug 2020 07:04:17 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id C8B87A278C;
        Wed,  5 Aug 2020 07:04:05 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:04:04 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:03:48 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     <akpm@linux-foundation.org>
CC:     SeongJae Park <sjpark@amazon.de>, <Jonathan.Cameron@Huawei.com>,
        <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <david@redhat.com>,
        <dwmw@amazon.com>, <fan.du@intel.com>, <foersleo@amazon.de>,
        <gthelen@google.com>, <irogers@google.com>, <jolsa@redhat.com>,
        <kirill@shutemov.name>, <mark.rutland@arm.com>, <mgorman@suse.de>,
        <minchan@kernel.org>, <mingo@redhat.com>, <namhyung@kernel.org>,
        <peterz@infradead.org>, <rdunlap@infradead.org>,
        <riel@surriel.com>, <rientjes@google.com>, <rostedt@goodmis.org>,
        <rppt@kernel.org>, <sblbir@amazon.com>, <shakeelb@google.com>,
        <shuah@kernel.org>, <sj38.park@gmail.com>, <snu@amazon.de>,
        <vbabka@suse.cz>, <vdavydov.dev@gmail.com>,
        <yang.shi@linux.alibaba.com>, <ying.huang@intel.com>,
        <linux-damon@amazon.com>, <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC v6 09/10] tools/damon/record: Support NUMA specific recording
Date:   Wed, 5 Aug 2020 08:59:50 +0200
Message-ID: <20200805065951.18221-10-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805065951.18221-1-sjpark@amazon.com>
References: <20200805065951.18221-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.26]
X-ClientProxiedBy: EX13D24UWB002.ant.amazon.com (10.43.161.159) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit updates the DAMON user space tool (damo-record) for NUMA
specific physical memory monitoring.  With this change, users can
monitor accesses to physical memory of specific NUMA node.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/damon/_paddr_layout.py | 147 +++++++++++++++++++++++++++++++++++
 tools/damon/record.py        |  18 ++++-
 2 files changed, 164 insertions(+), 1 deletion(-)
 create mode 100644 tools/damon/_paddr_layout.py

diff --git a/tools/damon/_paddr_layout.py b/tools/damon/_paddr_layout.py
new file mode 100644
index 000000000000..561c2b6729f6
--- /dev/null
+++ b/tools/damon/_paddr_layout.py
@@ -0,0 +1,147 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import os
+
+class PaddrRange:
+    start = None
+    end = None
+    nid = None
+    state = None
+    name = None
+
+    def __init__(self, start, end, nid, state, name):
+        self.start = start
+        self.end = end
+        self.nid = nid
+        self.state = state
+        self.name = name
+
+    def interleaved(self, prange):
+        if self.end <= prange.start:
+            return None
+        if prange.end <= self.start:
+            return None
+        return [max(self.start, prange.start), min(self.end, prange.end)]
+
+    def __str__(self):
+        return '%x-%x, nid %s, state %s, name %s' % (self.start, self.end,
+                self.nid, self.state, self.name)
+
+class MemBlock:
+    nid = None
+    index = None
+    state = None
+
+    def __init__(self, nid, index, state):
+        self.nid = nid
+        self.index = index
+        self.state = state
+
+    def __str__(self):
+        return '%d (%s)' % (self.index, self.state)
+
+    def __repr__(self):
+        return self.__str__()
+
+def readfile(file_path):
+    with open(file_path, 'r') as f:
+        return f.read()
+
+def collapse_ranges(ranges):
+    ranges = sorted(ranges, key=lambda x: x.start)
+    merged = []
+    for r in ranges:
+        if not merged:
+            merged.append(r)
+            continue
+        last = merged[-1]
+        if last.end != r.start or last.nid != r.nid or last.state != r.state:
+            merged.append(r)
+        else:
+            last.end = r.end
+    return merged
+
+def memblocks_to_ranges(blocks, block_size):
+    ranges = []
+    for b in blocks:
+        ranges.append(PaddrRange(b.index * block_size,
+            (b.index + 1) * block_size, b.nid, b.state, None))
+
+    return collapse_ranges(ranges)
+
+def memblock_ranges():
+    SYSFS='/sys/devices/system/node'
+    sz_block = int(readfile('/sys/devices/system/memory/block_size_bytes'), 16)
+    sys_nodes = [x for x in os.listdir(SYSFS) if x.startswith('node')]
+
+    blocks = []
+    for sys_node in sys_nodes:
+        nid = int(sys_node[4:])
+
+        sys_node_files = os.listdir(os.path.join(SYSFS, sys_node))
+        for f in sys_node_files:
+            if not f.startswith('memory'):
+                continue
+            index = int(f[6:])
+            sys_state = os.path.join(SYSFS, sys_node, f, 'state')
+            state = readfile(sys_state).strip()
+
+            blocks.append(MemBlock(nid, index, state))
+
+    return memblocks_to_ranges(blocks, sz_block)
+
+def iomem_ranges():
+    ranges = []
+
+    with open('/proc/iomem', 'r') as f:
+        # example of the line: '100000000-42b201fff : System RAM'
+        for line in f:
+            fields = line.split(':')
+            if len(fields) < 2:
+                continue
+            name = ':'.join(fields[1:]).strip()
+            addrs = fields[0].split('-')
+            if len(addrs) != 2:
+                continue
+            start = int(addrs[0], 16)
+            end = int(addrs[1], 16) + 1
+            ranges.append(PaddrRange(start, end, None, None, name))
+
+    return ranges
+
+def integrate(memblock_parsed, iomem_parsed):
+    merged = []
+
+    for r in iomem_parsed:
+        for r2 in memblock_parsed:
+            if r2.start <= r.start and r.end <= r2.end:
+                r.nid = r2.nid
+                r.state = r2.state
+                merged.append(r)
+            elif r2.start <= r.start and r.start < r2.end and r2.end < r.end:
+                sub = PaddrRange(r2.end, r.end, None, None, r.name)
+                iomem_parsed.append(sub)
+                r.end = r2.end
+                r.nid = r2.nid
+                r.state = r2.state
+                merged.append(r)
+    merged = sorted(merged, key=lambda x: x.start)
+    return merged
+
+def paddr_ranges():
+    return integrate(memblock_ranges(), iomem_ranges())
+
+def pr_ranges(ranges):
+    print('#%12s %13s\tnode\tstate\tresource\tsize' % ('start', 'end'))
+    for r in ranges:
+        print('%13d %13d\t%s\t%s\t%s\t%d' % (r.start, r.end, r.nid,
+            r.state, r.name, r.end - r.start))
+
+def main():
+    ranges = paddr_ranges()
+
+    pr_ranges(ranges)
+
+if __name__ == '__main__':
+    main()
diff --git a/tools/damon/record.py b/tools/damon/record.py
index 6fd0b59c73e0..e9d6bfc70ead 100644
--- a/tools/damon/record.py
+++ b/tools/damon/record.py
@@ -12,6 +12,7 @@ import subprocess
 import time
 
 import _damon
+import _paddr_layout
 
 def pidfd_open(pid):
     import ctypes
@@ -98,6 +99,8 @@ def set_argparser(parser):
             help='use pidfd type target id')
     parser.add_argument('-l', '--rbuf', metavar='<len>', type=int,
             default=1024*1024, help='length of record result buffer')
+    parser.add_argument('--numa_node', metavar='<node id>', type=int,
+            help='if target is \'paddr\', limit it to the numa node')
     parser.add_argument('-o', '--out', metavar='<file path>', type=str,
             default='damon.data', help='output file path')
 
@@ -124,6 +127,15 @@ def default_paddr_region():
                 ret = [start, end]
     return ret
 
+def paddr_region_of(numa_node):
+    regions = []
+    paddr_ranges = _paddr_layout.paddr_ranges()
+    for r in paddr_ranges:
+        if r.nid == numa_node and r.name == 'System RAM':
+            regions.append([r.start, r.end])
+
+    return regions
+
 def main(args=None):
     global orig_attrs
     if not args:
@@ -142,12 +154,16 @@ def main(args=None):
     pidfd = args.pidfd
     new_attrs = _damon.cmd_args_to_attrs(args)
     init_regions = _damon.cmd_args_to_init_regions(args)
+    numa_node = args.numa_node
     target = args.target
 
     target_fields = target.split()
     if target == 'paddr':   # physical memory address space
         if not init_regions:
-            init_regions = [default_paddr_region()]
+            if numa_node:
+                init_regions = paddr_region_of(numa_node)
+            else:
+                init_regions = [default_paddr_region()]
         do_record(target, False, init_regions, new_attrs, orig_attrs, pidfd)
     elif not subprocess.call('which %s &> /dev/null' % target_fields[0],
             shell=True, executable='/bin/bash'):
-- 
2.17.1

