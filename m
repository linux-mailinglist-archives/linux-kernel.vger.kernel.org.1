Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48F6E23C65C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgHEHDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Aug 2020 03:03:35 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:59114 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHEHDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1596611013; x=1628147013;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=SDTWTIuns68067ycCo53gHcSzqHDZT2Wd+5vAeZKPQU=;
  b=IxZtwhvOWVZzMkISnuBrMjszsPeCA3nFrIndmZOsn63zcp1yKTym94ds
   UxrMlza8q0dqkpy4SZKCugWaapyYhQC1/rcKJOUoTNgIVQADUhFOqlMhF
   ave6fegdwkC8qrjOGRuVAR9Gqoz3nXqUfkWF4jwJDMiHJMQ7O65D4ZjWt
   o=;
IronPort-SDR: QMK5LcNseUorcF1JmclcIFRIzUsIaWvOLOM2nbo82TSPlY9nSU46rYmZJAMzI2PNYZfQZFmL+T
 vevD+PezMdCQ==
X-IronPort-AV: E=Sophos;i="5.75,436,1589241600"; 
   d="scan'208";a="47558917"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 05 Aug 2020 07:03:32 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id CBFA2A235B;
        Wed,  5 Aug 2020 07:03:29 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:03:29 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.26) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 5 Aug 2020 07:03:12 +0000
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
Subject: [RFC v6 08/10] tools/damon/record: Support physical memory monitoring
Date:   Wed, 5 Aug 2020 08:59:49 +0200
Message-ID: <20200805065951.18221-9-sjpark@amazon.com>
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
index a22ec3777c16..cf14a0d59b94 100644
--- a/tools/damon/_damon.py
+++ b/tools/damon/_damon.py
@@ -27,6 +27,8 @@ def set_target(tid, init_regions=[]):
     if not os.path.exists(debugfs_init_regions):
         return 0
 
+    if tid == 'paddr':
+        tid = -1
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

