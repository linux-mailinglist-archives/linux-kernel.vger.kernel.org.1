Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852C626BAD3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgIPDpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:45:09 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:39732 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726239AbgIPDpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:45:04 -0400
Received: from localhost (unknown [159.226.5.99])
        by APP-05 (Coremail) with SMTP id zQCowAAnUFgWimFfo_WsAg--.60865S2;
        Wed, 16 Sep 2020 11:44:23 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
Subject: [PATCH] stats: Replace seq_printf with seq_puts
Date:   Wed, 16 Sep 2020 03:44:15 +0000
Message-Id: <20200916034415.25645-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowAAnUFgWimFfo_WsAg--.60865S2
X-Coremail-Antispam: 1UD129KBjvdXoWrWry7KFy5KFWfJrWkAFW5ZFb_yoWxWFgEqa
        4a9r1F9w1avr12v39ay3yFvrWFvay2qFs5C3ZrWFWUAryUJ3s8ta98XF1rJ3Z5WrsrGa4D
        ArsagFs8Wrn7ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb38FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
        0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
        8cxan2IY04v7MxkIecxEwVAFwVW8GwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
        WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
        67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
        IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1l
        IxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWI
        evJa73UjIFyTuYvjfUYdgADUUUU
X-Originating-IP: [159.226.5.99]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQIBA102Zk2htQAAsd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

seq_puts is a lot cheaper than seq_printf, so use that to print
literal strings.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 kernel/sched/stats.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/stats.c b/kernel/sched/stats.c
index 750fb3c67eed..0818fe03407a 100644
--- a/kernel/sched/stats.c
+++ b/kernel/sched/stats.c
@@ -37,7 +37,7 @@ static int show_schedstat(struct seq_file *seq, void *v)
 		    rq->rq_cpu_time,
 		    rq->rq_sched_info.run_delay, rq->rq_sched_info.pcount);
 
-		seq_printf(seq, "\n");
+		seq_putc(seq, '\n');
 
 #ifdef CONFIG_SMP
 		/* domain-specific stats */
-- 
2.17.1

