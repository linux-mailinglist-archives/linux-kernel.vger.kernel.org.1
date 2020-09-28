Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A627B0DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 17:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgI1PXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 11:23:51 -0400
Received: from m12-11.163.com ([220.181.12.11]:41169 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1PXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=0AbSO
        /2ajW7ejel1OR5U2kjqf40m+Ty0LPkKZF30WGg=; b=hT6GRLyDZWbF4rwymfS3w
        2meb3Q9MJ0CycWnsTOGCheLnE/xRD4WQr6G6oaijFgr3J8nLg17UalehfqHReE2T
        omc+Kocy3UkLVV9wI+BcXTBSwkX0H3Ana8TuUaG2pQrwf1s/oGfVluD+t3Rp5gfp
        UehYEpXbdY3K6CcHLSNM60=
Received: from localhost (unknown [101.86.214.224])
        by smtp7 (Coremail) with SMTP id C8CowABHU_Cd_3Ffq2hqAA--.17886S2;
        Mon, 28 Sep 2020 23:22:05 +0800 (CST)
Date:   Mon, 28 Sep 2020 23:22:05 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/rt.c: handle exceptions gracefully
Message-ID: <20200928152205.GA17900@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: C8CowABHU_Cd_3Ffq2hqAA--.17886S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw4DGF1kGF4rXr4DJF4xZwb_yoWfGwb_X3
        s8ur18Aws0yrn8Zay7Aws5ZryFkFZ8tF1xZa1DGryUJF93J3s5JryDXFZYy3Z5WFs7uF9r
        Arnaqa4qkr1DWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8HUDJUUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitx2tX1aEFx8+CAAAs0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

handle exceptions gracefully, and avoid using
if (0) .

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/rt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f215eea6a966..1dd6cbd67e6e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2753,14 +2753,15 @@ int sched_rt_handler(struct ctl_table *table, int write, void *buffer,
 		sched_rt_do_global();
 		sched_dl_do_global();
 	}
-	if (0) {
-undo:
-		sysctl_sched_rt_period = old_period;
-		sysctl_sched_rt_runtime = old_runtime;
-	}
-	mutex_unlock(&mutex);
 
+out:
+	mutex_unlock(&mutex);
 	return ret;
+
+undo:
+	sysctl_sched_rt_period = old_period;
+	sysctl_sched_rt_runtime = old_runtime;
+	goto out;
 }
 
 int sched_rr_handler(struct ctl_table *table, int write, void *buffer,
-- 
2.25.1


