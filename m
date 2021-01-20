Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD822FD127
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbhATNKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:10:24 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41782 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733309AbhATM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:28:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UMKfCAa_1611145671;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UMKfCAa_1611145671)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Jan 2021 20:27:51 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH 4/4] sched/fair: Add document for burstable CFS bandwidth control
Date:   Wed, 20 Jan 2021 20:27:15 +0800
Message-Id: <20210120122715.29493-5-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210120122715.29493-1-changhuaixin@linux.alibaba.com>
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
 <20210120122715.29493-1-changhuaixin@linux.alibaba.com>
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
 Documentation/scheduler/sched-bwc.rst | 70 +++++++++++++++++++++++++++++++++--
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/Documentation/scheduler/sched-bwc.rst b/Documentation/scheduler/sched-bwc.rst
index 9801d6b284b1..2214ecaad393 100644
--- a/Documentation/scheduler/sched-bwc.rst
+++ b/Documentation/scheduler/sched-bwc.rst
@@ -21,18 +21,46 @@ cfs_quota units at each period boundary. As threads consume this bandwidth it
 is transferred to cpu-local "silos" on a demand basis. The amount transferred
 within each of these updates is tunable and described as the "slice".
 
+By default, CPU bandwidth consumption is strictly limited to quota within each
+given period. For the sequence of CPU usage u_i served under CFS bandwidth
+control, if for any j <= k N(j,k) is the number of periods from u_j to u_k:
+
+        u_j+...+u_k <= quota * N(j,k)
+
+For a bursty sequence among which interval u_j...u_k are at the peak, CPU
+requests might have to wait for more periods to replenish enough quota.
+Otherwise, larger quota is required.
+
+With "burst" buffer, CPU requests might be served as long as:
+
+        u_j+...+u_k <= B_j + quota * N(j,k)
+
+if for any j <= k N(j,k) is the number of periods from u_j to u_k and B_j is
+the accumulated quota from previous periods in burst buffer serving u_j.
+Burst buffer helps in that serving whole bursty CPU requests without throttling
+them can be done with moderate quota setting and accumulated quota in burst
+buffer, if:
+
+        u_0+...+u_n <= B_0 + quota * N(0,n)
+
+where B_0 is the initial state of burst buffer. The maximum accumulated quota in
+the burst buffer is capped by burst. With proper burst setting, the available
+bandwidth is still determined by quota and period on the long run.
+
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
@@ -48,6 +76,11 @@ more detail below.
 Writing any negative value to cpu.cfs_quota_us will remove the bandwidth limit
 and return the group to an unconstrained state once more.
 
+A value of 0 for cpu.cfs_burst_us indicates that the group can not accumulate
+any unused bandwidth. It makes the traditional bandwidth control behavior for
+CFS unchanged. Writing any (valid) positive value(s) into cpu.cfs_burst_us
+will enact the cap on unused bandwidth accumulation.
+
 Any updates to a group's bandwidth specification will result in it becoming
 unthrottled if it is in a constrained state.
 
@@ -65,9 +98,21 @@ This is tunable via procfs::
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
 
@@ -75,6 +120,11 @@ cpu.stat:
 - nr_throttled: Number of times the group has been throttled/limited.
 - throttled_time: The total time duration (in nanoseconds) for which entities
   of the group have been throttled.
+- current_bw: Current runtime in global pool.
+- nr_burst: Number of periods burst occurs.
+- burst_time: Cumulative wall-time that any cpus has used above quota in
+  respective periods
+
 
 This interface is read-only.
 
@@ -172,3 +222,15 @@ Examples
 
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

