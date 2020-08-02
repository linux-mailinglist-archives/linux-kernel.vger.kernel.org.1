Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E26235698
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Aug 2020 13:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgHBLQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Aug 2020 07:16:10 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:44809 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728270AbgHBLPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 07:15:46 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U4Tqfqu_1596366941;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U4Tqfqu_1596366941)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 19:15:42 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     ysato@users.sourceforge.jp, daniel.lezcano@linaro.org,
        tglx@linutronix.de
Cc:     uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org, tianjia.zhang@alibaba.com
Subject: [PATCH] clocksource/h8300_timer8: Fix wrong return value in h8300_8timer_init()
Date:   Sun,  2 Aug 2020 19:15:41 +0800
Message-Id: <20200802111541.5429-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of calling of_iomap() failed, a positive value ENXIO is
returned here. I think this is a typo error. It is necessary to return
a negative error value.

Fixes: 691f8f878290f ("clocksource/drivers/h8300_timer8: Convert init function to return error")
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 drivers/clocksource/h8300_timer8.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/h8300_timer8.c b/drivers/clocksource/h8300_timer8.c
index 1d740a8c42ab..47114c2a7cb5 100644
--- a/drivers/clocksource/h8300_timer8.c
+++ b/drivers/clocksource/h8300_timer8.c
@@ -169,7 +169,7 @@ static int __init h8300_8timer_init(struct device_node *node)
 		return PTR_ERR(clk);
 	}
 
-	ret = ENXIO;
+	ret = -ENXIO;
 	base = of_iomap(node, 0);
 	if (!base) {
 		pr_err("failed to map registers for clockevent\n");
-- 
2.26.2

