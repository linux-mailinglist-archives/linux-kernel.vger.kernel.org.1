Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB332A5E9E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 08:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728766AbgKDHNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 02:13:31 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:47908 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725926AbgKDHNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 02:13:31 -0500
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-05 (Coremail) with SMTP id zQCowACHj8MUVKJfePP7AA--.26397S2;
        Wed, 04 Nov 2020 15:11:16 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     paul@crapouillou.net, mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.or
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] clk: ingenic/TCU: Remove NULL pointer check before clk_enable/disable
Date:   Wed,  4 Nov 2020 07:11:14 +0000
Message-Id: <20201104071114.6322-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowACHj8MUVKJfePP7AA--.26397S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr1fCFy5uF1UXr4fGw15urg_yoWfZrgEkF
        40qr4SkF4rCrn7Ar1UAwn5AFyI9F1xZ3Z5Z34ft3Zay3srAw1Yv3yjqF15Cwn8JFWrCayI
        qFnrAryxZr4xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbcxYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
        C2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJV
        WxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8CwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
        0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8BbytUUUUU==
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgUKA1z4jHSv5QAAsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because clk_enable and clk_disable already checked NULL clock parameter,
so the additional checks are unnecessary, just remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/clk/ingenic/tcu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
index 9382dc3aa27e..ffcb3667fd2b 100644
--- a/drivers/clk/ingenic/tcu.c
+++ b/drivers/clk/ingenic/tcu.c
@@ -445,8 +445,7 @@ static int __maybe_unused tcu_pm_suspend(void)
 {
 	struct ingenic_tcu *tcu = ingenic_tcu;
 
-	if (tcu->clk)
-		clk_disable(tcu->clk);
+	clk_disable(tcu->clk);
 
 	return 0;
 }
@@ -455,8 +454,7 @@ static void __maybe_unused tcu_pm_resume(void)
 {
 	struct ingenic_tcu *tcu = ingenic_tcu;
 
-	if (tcu->clk)
-		clk_enable(tcu->clk);
+	clk_enable(tcu->clk);
 }
 
 static struct syscore_ops __maybe_unused tcu_pm_ops = {
-- 
2.17.1

