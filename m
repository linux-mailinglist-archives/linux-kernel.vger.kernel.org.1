Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCE2E75F2
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 05:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgL3EOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 23:14:46 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:41994 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgL3EOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 23:14:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UKCUbX8_1609301637;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0UKCUbX8_1609301637)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Dec 2020 12:14:04 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] checkpatch: ignore warning designated initializers using NR_CPUS
Date:   Wed, 30 Dec 2020 12:13:55 +0800
Message-Id: <2eba2ec8531f440410ee8164aaf2ab754bd5a0d1.1609301434.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some max_length wants to hold as large room as possible to
ensure enough size to tackle with the biggest NR_CPUS. As
an example below:

kernel/cgroup/cpuset.c:
static struct cftype legacy_files[] = {
        {
                .name = "cpus",
                .seq_show = cpuset_common_seq_show,
                .write = cpuset_write_resmask,
                .max_write_len = (100U + 6 * NR_CPUS),
                .private = FILE_CPULIST,
        },
	...
}

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
---
 scripts/checkpatch.pl | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 0008530..da8fc48 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7022,12 +7022,15 @@ sub process {
 
 # use of NR_CPUS is usually wrong
 # ignore definitions of NR_CPUS and usage to define arrays as likely right
+# ignore designated initializers using NR_CPUS
+
 		if ($line =~ /\bNR_CPUS\b/ &&
 		    $line !~ /^.\s*\s*#\s*if\b.*\bNR_CPUS\b/ &&
 		    $line !~ /^.\s*\s*#\s*define\b.*\bNR_CPUS\b/ &&
 		    $line !~ /^.\s*$Declare\s.*\[[^\]]*NR_CPUS[^\]]*\]/ &&
 		    $line !~ /\[[^\]]*\.\.\.[^\]]*NR_CPUS[^\]]*\]/ &&
-		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/)
+		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/ &&
+		    $line !~ /\s*\..*=.*\bNR_CPUS\b.*,$/)
 		{
 			WARN("NR_CPUS",
 			     "usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc\n" . $herecurr);
-- 
2.9.5

