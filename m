Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2734D2FE10C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 05:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAUErZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 23:47:25 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:55437 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbhAUEpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 23:45:32 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=chenshiyan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UMOTFdl_1611204274;
Received: from localhost(mailfrom:chenshiyan@linux.alibaba.com fp:SMTPD_---0UMOTFdl_1611204274)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jan 2021 12:44:45 +0800
From:   chenshiyan <chenshiyan@linux.alibaba.com>
To:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] nohz: Restart tick before do softirq
Date:   Thu, 21 Jan 2021 12:44:34 +0800
Message-Id: <1611204274-16966-1-git-send-email-chenshiyan@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the cpu is continuously idle, tick_irq_exit() will count next tick
expiry with maybe several periodic ticks, but if it enters softirq
before next tick, invoke_softirq() is called before tick_irq_exit(),
there will be no ticks during softirq. So with sched_clock_irqtime
closing, sirq is very low in nohz idle even if the softirq costs much
time beause of the sampling ticks missing(sirq will be much higher and
seem exact if the cpu is busy).

Signed-off-by: chenshiyan <chenshiyan@linux.alibaba.com>
---
 kernel/softirq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9d71046..8f3f71b9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -210,6 +210,7 @@ static inline void invoke_softirq(void)
 		return;
 
 	if (!force_irqthreads) {
+		tick_nohz_idle_restart_tick();
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
 		 * We can safely execute softirq on the current stack if
-- 
1.8.3.1

