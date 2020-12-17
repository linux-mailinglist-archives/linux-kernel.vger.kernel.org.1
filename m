Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01CCA2DCD0B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgLQHrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:47:23 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:55773 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbgLQHrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:47:15 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UIuSax9_1608191191;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UIuSax9_1608191191)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 15:46:31 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     bsegall@google.com, changhuaixin@linux.alibaba.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, mgorman@suse.de,
        mingo@redhat.com, pauld@redhead.com, peterz@infradead.org,
        pjt@google.com, rostedt@goodmis.org, vincent.guittot@linaro.org,
        khlebnikov@yandex-team.ru, xiyou.wangcong@gmail.com,
        shanpeic@linux.alibaba.com
Subject: [PATCH 4/4] sched/fair: Add document for burstable CFS bandwidth control
Date:   Thu, 17 Dec 2020 15:46:20 +0800
Message-Id: <20201217074620.58338-5-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Basic description of usage and effect for CFS Bandwidth Control Burst.

Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
---
 Documentation/scheduler/sched-bwc.rst | 49 ++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 9801d6b284b1..67c5de641149 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -16,6 +16,11 @@ assigned any additional requests for quota will result in those threads being
 throttled. Throttled threads will not be able to run again until the next
 period when the quota is replenished.
 
+With "burst", unused quota from previous periods might be accumulated and
+assigned when a task group requests more CPU than quota during a specific
+period, thus allowing CPU time requests as long as the average request is below
+quota on the long run. The maximum accumulation is capped by burst.
+
 A group's unassigned quota is globally tracked, being refreshed back to
 cfs_quota units at each period boundary. As threads consume this bandwidth it
 is transferred to cpu-local "silos" on a demand basis. The amount transferred
@@ -23,16 +28,18 @@ within each of these updates is tunable and described as the "slice".
 
 Management
 ----------
-Quota and period are managed within the cpu subsystem via cgroupfs.
+Quota, period and burst are managed within the cpu subsystem via cgroupfs.
 
-cpu.cfs_quota_us: the total available run-time within a period (in microseconds)
+cpu.cfs_quota_us: run-time replenished within a period (in microseconds)
 cpu.cfs_period_us: the length of a period (in microseconds)
+cpu.cfs_burst_us: the maximum accumulated run-time (in microseconds)
 cpu.stat: exports throttling statistics [explained further below]
 
 The default values are::
 
 	cpu.cfs_period_us=100ms
-	cpu.cfs_quota=-1
+	cpu.cfs_quota_us=-1
+	cpu.cfs_burst_us=0
 
 A value of -1 for cpu.cfs_quota_us indicates that the group does not have any
 bandwidth restriction in place, such a group is described as an unconstrained
@@ -48,6 +55,11 @@ more detail below.
 Writing any negative value to cpu.cfs_quota_us will remove the bandwidth limit
 and return the group to an unconstrained state once more.
 
+A value of 0 for cpu.cfs_burst_us indicates that the group can not accumulate
+any unused bandwidth. It makes the traditional bandwidth control behavior for
+CFS unchanged. Writing any (valid) positive value(s) into cpu.cfs_burst_us
+will enact the cap on unused bandwidth accumulation.
+
 Any updates to a group's bandwidth specification will result in it becoming
 unthrottled if it is in a constrained state.
 
@@ -65,9 +77,21 @@ This is tunable via procfs::
 Larger slice values will reduce transfer overheads, while smaller values allow
 for more fine-grained consumption.
 
+There is also a global switch to turn off burst for all groups::
+       /proc/sys/kernel/sched_cfs_bw_burst_enabled (default=1)
+
+By default it is enabled. Write 0 values means no accumulated CPU time can be
+used for any group, even if cpu.cfs_burst_us is configured.
+
+Sometimes users might want a group to burst without accumulation. This is
+tunable via::
+       /proc/sys/kernel/sched_cfs_bw_burst_onset_percent (default=0)
+
+Up to 100% runtime of cpu.cfs_burst_us might be given on setting bandwidth.
+
 Statistics
 ----------
-A group's bandwidth statistics are exported via 3 fields in cpu.stat.
+A group's bandwidth statistics are exported via 6 fields in cpu.stat.
 
 cpu.stat:
 
@@ -75,6 +99,11 @@ cpu.stat:
 - nr_throttled: Number of times the group has been throttled/limited.
 - throttled_time: The total time duration (in nanoseconds) for which entities
   of the group have been throttled.
+- current_bw: Current runtime in global pool.
+- nr_burst: Number of periods burst occurs.
+- burst_time: Cumulative wall-time that any cpus has used above quota in
+  respective periods
+
 
 This interface is read-only.
 
@@ -172,3 +201,15 @@ Examples
 
    By using a small period here we are ensuring a consistent latency
    response at the expense of burst capacity.
+
+4. Limit a group to 20% of 1 CPU, and allow accumulate up to 60% of 1 CPU
+   addtionally, in case accumulation has been done.
+
+   With 50ms period, 10ms quota will be equivalent to 20% of 1 CPU.
+   And 30ms burst will be equivalent to 60% of 1 CPU.
+
+	# echo 10000 > cpu.cfs_quota_us /* quota = 10ms */
+	# echo 50000 > cpu.cfs_period_us /* period = 50ms */
+	# echo 30000 > cpu.cfs_burst_us /* burst = 30ms */
+
+   Larger buffer setting allows greater burst capacity.
-- 
2.14.4.44.g2045bb6

