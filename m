Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0E62F0ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbhAKJO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 04:14:56 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38803 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728155AbhAKJOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 04:14:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0ULMkbyW_1610356416;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0ULMkbyW_1610356416)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 11 Jan 2021 17:13:47 +0800
From:   YANG LI <abaci-bugfix@linux.alibaba.com>
To:     tglx@linutronix.de
Cc:     qais.yousef@arm.com, peterz@infradead.org, mpe@ellerman.id.au,
        bristot@redhat.com, ethp@qq.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org,
        YANG LI <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] kernel: cpu: style: Simplify bool comparison
Date:   Mon, 11 Jan 2021 17:13:34 +0800
Message-Id: <1610356414-47080-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:
./kernel/cpu.c:1824:5-23: WARNING: Comparison to bool

Signed-off-by: YANG LI <abaci-bugfix@linux.alibaba.com>
Reported-by: Abaci Robot<abaci@linux.alibaba.com>
---
 kernel/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 4e11e91..ad72a57 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1824,7 +1824,7 @@ int __cpuhp_state_add_instance_cpuslocked(enum cpuhp_state state,
 	lockdep_assert_cpus_held();
 
 	sp = cpuhp_get_step(state);
-	if (sp->multi_instance == false)
+	if (!sp->multi_instance)
 		return -EINVAL;
 
 	mutex_lock(&cpuhp_state_mutex);
-- 
1.8.3.1

