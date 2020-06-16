Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2221FB3D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgFPOM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 10:12:28 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:43387 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726606AbgFPOM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592316745; x=1623852745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=w1Wrf62e73x+SRZTs2supCzGH7vYA1IEmIfHRiOCQt8=;
  b=U+XMYBKkQxWtMChQYipgYhNytgEWZ/EBfACBwNB/Bad40dvu7Wpqby15
   gAr+Z+LinTR0RRrzHw7lfVyFTICBJHD7cFP3+Vlx2YZyg0WsT4cwkVKvm
   dYwK16HEMe8/NUk3T2T0Md81i2tLLnSbSgmJMaRlBI3r+o1DxDrSf0qbE
   g=;
IronPort-SDR: Q7vc99IXsCqljdqDle+7g6R/Hu+R7fF3+WAAXICsYy4e3/KZpWColZqgNokHRGLbDyKGPSQQW/
 BKv5fjpf3ILQ==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="51356971"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 16 Jun 2020 14:12:23 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 922C12218D4;
        Tue, 16 Jun 2020 14:12:20 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:12:20 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:11:52 +0000
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
Subject: [RFC v4 7/8] tools/damon/record: Support physical memory address spce
Date:   Tue, 16 Jun 2020 16:08:12 +0200
Message-ID: <20200616140813.17863-8-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616140813.17863-1-sjpark@amazon.com>
References: <20200616140813.17863-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.109]
X-ClientProxiedBy: EX13D01UWB004.ant.amazon.com (10.43.161.157) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

This commit allows users to record the data accesses on physical memory
address space by passing 'paddr' as target to 'damo-record'.  If the
init regions are given, the regions will be monitored.  Else, it will
monitor biggest conitguous 'System RAM' region in '/proc/iomem' and
monitor the region.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/damon/_damon.py |  2 ++
 tools/damon/heats.py  |  2 +-
 tools/damon/record.py | 29 ++++++++++++++++++++++++++++-
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tools/damon/_damon.py b/tools/damon/_damon.py
index ad476cc61421..95d23c2ab6ee 100644
--- a/tools/damon/_damon.py
+++ b/tools/damon/_damon.py
@@ -27,6 +27,8 @@ def set_target(pid, init_regions=[]):
     if not os.path.exists(debugfs_init_regions):
         return 0
 
+    if pid == 'paddr':
+        pid = -1
     string = ' '.join(['%s %d %d' % (pid, r[0], r[1]) for r in init_regions])
     return subprocess.call('echo "%s" > %s' % (string, debugfs_init_regions),
             shell=True, executable='/bin/bash')
diff --git a/tools/damon/heats.py b/tools/damon/heats.py
index 99837083874e..34dbcf1a839d 100644
--- a/tools/damon/heats.py
+++ b/tools/damon/heats.py
@@ -307,7 +307,7 @@ def plot_heatmap(data_file, output_file):
     set xrange [0:];
     set yrange [0:];
     set xlabel 'Time (ns)';
-    set ylabel 'Virtual Address (bytes)';
+    set ylabel 'Address (bytes)';
     plot '%s' using 1:2:3 with image;""" % (terminal, output_file, data_file)
     subprocess.call(['gnuplot', '-e', gnuplot_cmd])
     os.remove(data_file)
diff --git a/tools/damon/record.py b/tools/damon/record.py
index 6ce8721d782a..416dca940c1d 100644
--- a/tools/damon/record.py
+++ b/tools/damon/record.py
@@ -73,6 +73,29 @@ def set_argparser(parser):
     parser.add_argument('-o', '--out', metavar='<file path>', type=str,
             default='damon.data', help='output file path')
 
+def default_paddr_region():
+    "Largest System RAM region becomes the default"
+    ret = []
+    with open('/proc/iomem', 'r') as f:
+        # example of the line: '100000000-42b201fff : System RAM'
+        for line in f:
+            fields = line.split(':')
+            if len(fields) != 2:
+                continue
+            name = fields[1].strip()
+            if name != 'System RAM':
+                continue
+            addrs = fields[0].split('-')
+            if len(addrs) != 2:
+                continue
+            start = int(addrs[0], 16)
+            end = int(addrs[1], 16)
+
+            sz_region = end - start
+            if not ret or sz_region > (ret[1] - ret[0]):
+                ret = [start, end]
+    return ret
+
 def main(args=None):
     global orig_attrs
     if not args:
@@ -93,7 +116,11 @@ def main(args=None):
     target = args.target
 
     target_fields = target.split()
-    if not subprocess.call('which %s > /dev/null' % target_fields[0],
+    if target == 'paddr':   # physical memory address space
+        if not init_regions:
+            init_regions = [default_paddr_region()]
+        do_record(target, False, init_regions, new_attrs, orig_attrs)
+    elif not subprocess.call('which %s > /dev/null' % target_fields[0],
             shell=True, executable='/bin/bash'):
         do_record(target, True, init_regions, new_attrs, orig_attrs)
     else:
-- 
2.17.1

