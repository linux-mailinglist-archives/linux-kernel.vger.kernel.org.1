Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FC1FB3C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729596AbgFPOKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 10:10:07 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:13356 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgFPOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592316602; x=1623852602;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=lCtpFdulZBcc+gNwg5rlkrBP9DmunmKCV7foIDqhGGw=;
  b=X694txtrxgQJF6o2+GbQ3MOYWI7WP8ewa8u5jhFT4VfDl2Un3b9MBWrY
   M+f6rinTywTMB/Sj3b/MhdE2mWyCxKkTINMNo2+M/6sit8ockyneu4w2K
   PaWUqqrO/+sjS88f0bkFXqZvwgfi4tXRjtgAZbvIzOKcTIyYUuYU60jYg
   w=;
IronPort-SDR: a8eMkPs1lh7jsRxSWN2+q3C+E7ibg7gurbneofAEotQlQNLnGPXmyxZOd/I+Jjp2+TVQjxU/Dl
 AhReX4SNufpg==
X-IronPort-AV: E=Sophos;i="5.73,518,1583193600"; 
   d="scan'208";a="36584441"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 16 Jun 2020 14:09:59 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-c6afef2e.us-west-2.amazon.com (Postfix) with ESMTPS id 4C357A2685;
        Tue, 16 Jun 2020 14:09:56 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:09:55 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.109) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 16 Jun 2020 14:09:32 +0000
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
Subject: [RFC v4 2/8] tools/damon: Implement init target regions feature
Date:   Tue, 16 Jun 2020 16:08:07 +0200
Message-ID: <20200616140813.17863-3-sjpark@amazon.com>
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

This commit updates the damon user space tool to support the initial
monitoring target regions feature.

Signed-off-by: SeongJae Park <sjpark@amazon.de>
---
 tools/damon/_damon.py  | 39 +++++++++++++++++++++++++++++++++++++++
 tools/damon/record.py  | 12 +++++++-----
 tools/damon/schemes.py | 12 +++++++-----
 3 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/tools/damon/_damon.py b/tools/damon/_damon.py
index 3620ef12a5ea..ad476cc61421 100644
--- a/tools/damon/_damon.py
+++ b/tools/damon/_damon.py
@@ -12,12 +12,25 @@ debugfs_attrs = None
 debugfs_record = None
 debugfs_schemes = None
 debugfs_pids = None
+debugfs_init_regions = None
 debugfs_monitor_on = None
 
 def set_target_pid(pid):
     return subprocess.call('echo %s > %s' % (pid, debugfs_pids), shell=True,
             executable='/bin/bash')
 
+def set_target(pid, init_regions=[]):
+    rc = set_target_pid(pid)
+    if rc:
+        return rc
+
+    if not os.path.exists(debugfs_init_regions):
+        return 0
+
+    string = ' '.join(['%s %d %d' % (pid, r[0], r[1]) for r in init_regions])
+    return subprocess.call('echo "%s" > %s' % (string, debugfs_init_regions),
+            shell=True, executable='/bin/bash')
+
 def turn_damon(on_off):
     return subprocess.call("echo %s > %s" % (on_off, debugfs_monitor_on),
             shell=True, executable="/bin/bash")
@@ -97,6 +110,7 @@ def chk_update_debugfs(debugfs):
     global debugfs_record
     global debugfs_schemes
     global debugfs_pids
+    global debugfs_init_regions
     global debugfs_monitor_on
 
     debugfs_damon = os.path.join(debugfs, 'damon')
@@ -104,6 +118,7 @@ def chk_update_debugfs(debugfs):
     debugfs_record = os.path.join(debugfs_damon, 'record')
     debugfs_schemes = os.path.join(debugfs_damon, 'schemes')
     debugfs_pids = os.path.join(debugfs_damon, 'pids')
+    debugfs_init_regions = os.path.join(debugfs_damon, 'init_regions')
     debugfs_monitor_on = os.path.join(debugfs_damon, 'monitor_on')
 
     if not os.path.isdir(debugfs_damon):
@@ -131,6 +146,26 @@ def cmd_args_to_attrs(args):
     return Attrs(sample_interval, aggr_interval, regions_update_interval,
             min_nr_regions, max_nr_regions, rbuf_len, rfile_path, schemes)
 
+def cmd_args_to_init_regions(args):
+    regions = []
+    for arg in args.regions.split():
+        addrs = arg.split('-')
+        try:
+            if len(addrs) != 2:
+                raise Exception('two addresses not given')
+            start = int(addrs[0])
+            end = int(addrs[1])
+            if start >= end:
+                raise Exception('start >= end')
+            if regions and regions[-1][1] > start:
+                raise Exception('regions overlap')
+        except Exception as e:
+            print('Wrong \'--regions\' argument (%s)' % e)
+            exit(1)
+
+        regions.append([start, end])
+    return regions
+
 def set_attrs_argparser(parser):
     parser.add_argument('-d', '--debugfs', metavar='<debugfs>', type=str,
             default='/sys/kernel/debug', help='debugfs mounted path')
@@ -144,3 +179,7 @@ def set_attrs_argparser(parser):
             default=10, help='minimal number of regions')
     parser.add_argument('-m', '--maxr', metavar='<# regions>', type=int,
             default=1000, help='maximum number of regions')
+
+def set_init_regions_argparser(parser):
+    parser.add_argument('-r', '--regions', metavar='"<start>-<end> ..."',
+            type=str, default='', help='monitoring target address regions')
diff --git a/tools/damon/record.py b/tools/damon/record.py
index 44fa3a12af35..6ce8721d782a 100644
--- a/tools/damon/record.py
+++ b/tools/damon/record.py
@@ -13,7 +13,7 @@ import time
 
 import _damon
 
-def do_record(target, is_target_cmd, attrs, old_attrs):
+def do_record(target, is_target_cmd, init_regions, attrs, old_attrs):
     if os.path.isfile(attrs.rfile_path):
         os.rename(attrs.rfile_path, attrs.rfile_path + '.old')
 
@@ -24,8 +24,8 @@ def do_record(target, is_target_cmd, attrs, old_attrs):
     if is_target_cmd:
         p = subprocess.Popen(target, shell=True, executable='/bin/bash')
         target = p.pid
-    if _damon.set_target_pid(target):
-        print('pid setting (%s) failed' % target)
+    if _damon.set_target(target, init_regions):
+        print('target setting (%s, %s) failed' % (target, init_regions))
         cleanup_exit(old_attrs, -2)
     if _damon.turn_damon('on'):
         print('could not turn on damon' % target)
@@ -65,6 +65,7 @@ def chk_permission():
 
 def set_argparser(parser):
     _damon.set_attrs_argparser(parser)
+    _damon.set_init_regions_argparser(parser)
     parser.add_argument('target', type=str, metavar='<target>',
             help='the target command or the pid to record')
     parser.add_argument('-l', '--rbuf', metavar='<len>', type=int,
@@ -88,19 +89,20 @@ def main(args=None):
 
     args.schemes = ''
     new_attrs = _damon.cmd_args_to_attrs(args)
+    init_regions = _damon.cmd_args_to_init_regions(args)
     target = args.target
 
     target_fields = target.split()
     if not subprocess.call('which %s > /dev/null' % target_fields[0],
             shell=True, executable='/bin/bash'):
-        do_record(target, True, new_attrs, orig_attrs)
+        do_record(target, True, init_regions, new_attrs, orig_attrs)
     else:
         try:
             pid = int(target)
         except:
             print('target \'%s\' is neither a command, nor a pid' % target)
             exit(1)
-        do_record(target, False, new_attrs, orig_attrs)
+        do_record(target, False, init_regions, new_attrs, orig_attrs)
 
 if __name__ == '__main__':
     main()
diff --git a/tools/damon/schemes.py b/tools/damon/schemes.py
index 2d23dfb4fd13..654345dbdb62 100644
--- a/tools/damon/schemes.py
+++ b/tools/damon/schemes.py
@@ -14,7 +14,7 @@ import time
 import _convert_damos
 import _damon
 
-def run_damon(target, is_target_cmd, attrs, old_attrs):
+def run_damon(target, is_target_cmd, init_regions, attrs, old_attrs):
     if os.path.isfile(attrs.rfile_path):
         os.rename(attrs.rfile_path, attrs.rfile_path + '.old')
 
@@ -27,8 +27,8 @@ def run_damon(target, is_target_cmd, attrs, old_attrs):
     if is_target_cmd:
         p = subprocess.Popen(target, shell=True, executable='/bin/bash')
         target = p.pid
-    if _damon.set_target_pid(target):
-        print('pid setting (%s) failed' % target)
+    if _damon.set_target(target, init_regions):
+        print('target setting (%s, %s) failed' % (target, init_regions))
         cleanup_exit(old_attrs, -2)
     if _damon.turn_damon('on'):
         print('could not turn on damon' % target)
@@ -67,6 +67,7 @@ def chk_permission():
 
 def set_argparser(parser):
     _damon.set_attrs_argparser(parser)
+    _damon.set_init_regions_argparser(parser)
     parser.add_argument('target', type=str, metavar='<target>',
             help='the target command or the pid to record')
     parser.add_argument('-c', '--schemes', metavar='<file>', type=str,
@@ -91,19 +92,20 @@ def main(args=None):
     args.out = 'null'
     args.schemes = _convert_damos.convert(args.schemes, args.sample, args.aggr)
     new_attrs = _damon.cmd_args_to_attrs(args)
+    init_regions = _damon.cmd_args_to_init_regions(args)
     target = args.target
 
     target_fields = target.split()
     if not subprocess.call('which %s > /dev/null' % target_fields[0],
             shell=True, executable='/bin/bash'):
-        run_damon(target, True, new_attrs, orig_attrs)
+        run_damon(target, True, init_regions, new_attrs, orig_attrs)
     else:
         try:
             pid = int(target)
         except:
             print('target \'%s\' is neither a command, nor a pid' % target)
             exit(1)
-        run_damon(target, False, new_attrs, orig_attrs)
+        run_damon(target, False, init_regions, new_attrs, orig_attrs)
 
 if __name__ == '__main__':
     main()
-- 
2.17.1

