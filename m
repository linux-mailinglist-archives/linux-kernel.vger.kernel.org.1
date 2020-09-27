Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22C27A249
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 20:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgI0SNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 14:13:37 -0400
Received: from m12-16.163.com ([220.181.12.16]:33719 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgI0SNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 14:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=/Hgrj
        ncw77Fy4quJ/Ig2IdueGnQOP8siza/tZVARSgw=; b=d2hAfFfvvuB7al0oD/aHl
        V/ykJ03UnUTOp/RsMZoMH8yMzcuaZpZ9X+0ymf3QlaXbLvpJDyatKEabu8OGtUxt
        v6c4jnHFYWZhbyhPeISf5nmQPVRCdiSJlVyq0zTxvp4RzMqdzviufjswOx3O6f0B
        07EmPQ1XY3sgrL6HIL6oRM=
Received: from localhost (unknown [101.86.214.224])
        by smtp12 (Coremail) with SMTP id EMCowACXRmO41XBfz0blDA--.4134S2;
        Mon, 28 Sep 2020 02:11:04 +0800 (CST)
Date:   Mon, 28 Sep 2020 02:11:04 +0800
From:   Hui Su <sh_def@163.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sched/idle.c: fix comment in cpuidle_idle_call()
Message-ID: <20200927181104.GA9332@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EMCowACXRmO41XBfz0blDA--.4134S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JryUJr43ZFyfAF1rAry5urg_yoWfKrc_W3
        sYkrn7Kw4FvF42ga9rtan8Xr1rt343tFyru34xtrWxGay8A398t3Z0kF1fJrsaqFZrGrn7
        Jr93KryrXryDGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUe7UU5UUUUU==
X-Originating-IP: [101.86.214.224]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLhisX1SIqMrhyAAAsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is some typos in cpuidle_idle_call(), so fix
it.

s/stratight/straight

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f324dc36fc43..4710fef20678 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -173,7 +173,7 @@ static void cpuidle_idle_call(void)
 	 * Suspend-to-idle ("s2idle") is a system state in which all user space
 	 * has been frozen, all I/O devices have been suspended and the only
 	 * activity happens here and in interrupts (if any). In that case bypass
-	 * the cpuidle governor and go stratight for the deepest idle state
+	 * the cpuidle governor and go straight for the deepest idle state
 	 * available.  Possibly also suspend the local tick and the entire
 	 * timekeeping to prevent timer interrupts from kicking us out of idle
 	 * until a proper wakeup interrupt happens.
-- 
2.25.1


