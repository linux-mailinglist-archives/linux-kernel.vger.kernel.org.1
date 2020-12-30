Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193E02E788A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 13:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgL3Map (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 07:30:45 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:40101 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgL3Map (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 07:30:45 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=rocking@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UKEQQDP_1609331386;
Received: from localhost(mailfrom:rocking@linux.alibaba.com fp:SMTPD_---0UKEQQDP_1609331386)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 30 Dec 2020 20:30:01 +0800
From:   Peng Wang <rocking@linux.alibaba.com>
To:     apw@canonical.com, joe@perches.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v3] checkpatch: ignore warning designated initializers using NR_CPUS
Date:   Wed, 30 Dec 2020 20:29:21 +0800
Message-Id: <5d4998aa8a8ac7efada2c7daffa9e73559f8b186.1609331255.git.rocking@linux.alibaba.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <5ca6c2d28f6cf091a676f8e7d8f14a933da0b267.camel@perches.com>
References: <5ca6c2d28f6cf091a676f8e7d8f14a933da0b267.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some max_length wants to hold as large room as possible to
ensure enough size to tackle with the biggest NR_CPUS.
An example below:

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
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 92e888e..6f112fb 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -7028,12 +7028,14 @@ sub process {
 
 # use of NR_CPUS is usually wrong
 # ignore definitions of NR_CPUS and usage to define arrays as likely right
+# ignore designated initializers using NR_CPUS
 		if ($line =~ /\bNR_CPUS\b/ &&
 		    $line !~ /^.\s*\s*#\s*if\b.*\bNR_CPUS\b/ &&
 		    $line !~ /^.\s*\s*#\s*define\b.*\bNR_CPUS\b/ &&
 		    $line !~ /^.\s*$Declare\s.*\[[^\]]*NR_CPUS[^\]]*\]/ &&
 		    $line !~ /\[[^\]]*\.\.\.[^\]]*NR_CPUS[^\]]*\]/ &&
-		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/)
+		    $line !~ /\[[^\]]*NR_CPUS[^\]]*\.\.\.[^\]]*\]/ &&
+		    $line !~ /^.\s*\.\w+\s*=\s*.*\bNR_CPUS\b/)
 		{
 			WARN("NR_CPUS",
 			     "usage of NR_CPUS is often wrong - consider using cpu_possible(), num_possible_cpus(), for_each_possible_cpu(), etc\n" . $herecurr);
-- 
2.9.5

