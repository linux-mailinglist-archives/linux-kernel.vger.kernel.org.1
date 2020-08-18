Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4862247F73
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 09:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHRH2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 03:28:24 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:5910 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHRH2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1597735702; x=1629271702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kg6Pid/S3uyECtsR9/ZQNoRBSFk6tXHhc71xqlOp1H8=;
  b=YTPipOkkR5R4LrUIt+cHb3uckw8l8V2ZMLqsHx5i1DmFXmmYtYcRvu37
   Om9YqM3w0ydwPo/kXvE1ULOL1tT4jX6ajo9Dux6pP/4aWLU7Ug1D1nlD6
   GU+5CmevhU1Wmf9t0TIrtC/R4+zmSKCa7BRqI13Sy2jAyootBfaO814OX
   U=;
X-IronPort-AV: E=Sophos;i="5.76,326,1592870400"; 
   d="scan'208";a="60596917"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 18 Aug 2020 07:28:20 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 72002A18E4;
        Tue, 18 Aug 2020 07:28:17 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 07:28:16 +0000
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.73) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 18 Aug 2020 07:27:59 +0000
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
        <zgf574564920@gmail.com>, <linux-damon@amazon.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC v7 08/10] tools/damon/record: Support physical memory monitoring
Date:   Tue, 18 Aug 2020 09:24:59 +0200
Message-ID: <20200818072501.30396-9-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818072501.30396-1-sjpark@amazon.com>
References: <20200818072501.30396-1-sjpark@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D38UWB002.ant.amazon.com (10.43.161.171) To
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
 tools/damon/record.py | 29 ++++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/damon/_damon.py b/tools/damon/_damon.py
index a22ec3777c16..6ff278117e84 100644
--- a/tools/damon/_damon.py
+++ b/tools/damon/_damon.py
@@ -27,6 +27,8 @@ def set_target(tid, init_regions=[]):
     if not os.path.exists(debugfs_init_regions):
         return 0
 
+    if tid == 'paddr':
+        tid = 42
     string = ' '.join(['%s %d %d' % (tid, r[0], r[1]) for r in init_regions])
     return subprocess.call('echo "%s" > %s' % (string, debugfs_init_regions),
             shell=True, executable='/bin/bash')
diff --git a/tools/damon/record.py b/tools/damon/record.py
index 11fd54001472..6fd0b59c73e0 100644
--- a/tools/damon/record.py
+++ b/tools/damon/record.py
@@ -101,6 +101,29 @@ def set_argparser(parser):
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
@@ -122,7 +145,11 @@ def main(args=None):
     target = args.target
 
     target_fields = target.split()
-    if not subprocess.call('which %s &> /dev/null' % target_fields[0],
+    if target == 'paddr':   # physical memory address space
+        if not init_regions:
+            init_regions = [default_paddr_region()]
+        do_record(target, False, init_regions, new_attrs, orig_attrs, pidfd)
+    elif not subprocess.call('which %s &> /dev/null' % target_fields[0],
             shell=True, executable='/bin/bash'):
         do_record(target, True, init_regions, new_attrs, orig_attrs, pidfd)
     else:
-- 
2.17.1

