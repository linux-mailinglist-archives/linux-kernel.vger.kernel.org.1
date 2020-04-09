Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5451A3248
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgDIKMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 06:12:32 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:36308 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgDIKMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 06:12:31 -0400
Received: from localhost.localdomain ([93.22.150.119])
        by mwinf5d85 with ME
        id QaCV2200N2aoYT903aCWob; Thu, 09 Apr 2020 12:12:30 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 09 Apr 2020 12:12:30 +0200
X-ME-IP: 93.22.150.119
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] clocksource: davinci: axe a pointless __GFP_NOFAIL
Date:   Thu,  9 Apr 2020 12:12:26 +0200
Message-Id: <20200409101226.15432-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to specify __GFP_NOFAIL when allocating memory here, so
axe it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/clocksource/timer-davinci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
index aae938368230..bb4eee31ae08 100644
--- a/drivers/clocksource/timer-davinci.c
+++ b/drivers/clocksource/timer-davinci.c
@@ -270,7 +270,7 @@ int __init davinci_timer_register(struct clk *clk,
 	davinci_timer_init(base);
 	tick_rate = clk_get_rate(clk);
 
-	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL | __GFP_NOFAIL);
+	clockevent = kzalloc(sizeof(*clockevent), GFP_KERNEL);
 	if (!clockevent)
 		return -ENOMEM;
 
-- 
2.20.1

