Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB3E2A0861
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgJ3Osu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:48:50 -0400
Received: from m12-17.163.com ([220.181.12.17]:43967 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbgJ3Ost (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=vR3TF
        aORq8UB42QxLQXhJMqDJEgOMINgJTMsHq0D48A=; b=DRDWsb8BbosicWxE0W5va
        DTEnwEP66A5hBjoUL1FZge8toJluWt5QY3RzvMFg7avQmYBiEboTyEP+izJUsyB2
        wQTkRTO/0bkxzENR10vBnHDkrpuGqcxxM0aDr0AvPoTszVvSsHMT5zZ/rW5YuUgF
        dG7wf8UKn+OrYJ776K2i14=
Received: from localhost (unknown [101.86.209.82])
        by smtp13 (Coremail) with SMTP id EcCowAAnLJQ9J5xfdQkwQw--.32426S2;
        Fri, 30 Oct 2020 22:46:21 +0800 (CST)
Date:   Fri, 30 Oct 2020 22:46:21 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org, sh_def@163.com
Subject: [PATCH] sched/fair: remove the spin_lock operations
Message-ID: <20201030144621.GA96974@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EcCowAAnLJQ9J5xfdQkwQw--.32426S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gw4fWFWkZF4fAFW8JrW7twb_yoW3GFX_C3
        WruryfKr12vr1UurWxC395Kry0qa1IqF1I9Fn2qFW5JrySqryDArZ5CF93Cr9xXFs7Ja4D
        ArsxWFWDWryDKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR_Ma7UUUUU==
X-Originating-IP: [101.86.209.82]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLh3NX1SIqqQV2AAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since 'ab93a4bc955b ("sched/fair: Remove
distribute_running fromCFS bandwidth")',there is
nothing to protect between raw_spin_lock_irqsave/store()
in do_sched_cfs_slack_timer().

So remove it.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 290f9e38378c..5ecbf5e63198 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5105,9 +5105,6 @@ static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
 		return;
 
 	distribute_cfs_runtime(cfs_b);
-
-	raw_spin_lock_irqsave(&cfs_b->lock, flags);
-	raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
 }
 
 /*
-- 
2.29.0


