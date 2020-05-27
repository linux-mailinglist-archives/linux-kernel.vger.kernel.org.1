Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03AF1E45AB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 16:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbgE0OVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 10:21:45 -0400
Received: from mail.loongson.cn ([114.242.206.163]:41058 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389103AbgE0OVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:21:44 -0400
Received: from linux.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxf91jd85eYK85AA--.655S2;
        Wed, 27 May 2020 22:21:23 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v3 1/2] clk: hisilicon: Use correct return value about hisi_reset_init()
Date:   Wed, 27 May 2020 22:21:22 +0800
Message-Id: <1590589283-31412-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
X-CM-TRANSID: AQAAf9Dxf91jd85eYK85AA--.655S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFW3WFWfGrW8uw1rJryfXrb_yoW5Ar17pF
        48JFW2ya4Yga17X3ZrX390yFy5Za42gayUGFW8Z3s8Zwn8JryDZr1fury8Xayqqrs3KFWa
        9r40kr48ua1jyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_Xryl
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
        4UMIIF0xvE42xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAI
        cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjtEf5UUUUU==
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value about hisi_reset_init() is not correct, fix it.

Fixes: e9a2310fb689 ("reset: hisilicon: fix potential NULL pointer dereference")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---

v2:
  - No changes, just add "Fixes:" tag

v3:
  - Use ERR_CAST(rstc->membase) to fix the sparse warning

 drivers/clk/hisilicon/clk-hi3519.c      | 4 ++--
 drivers/clk/hisilicon/crg-hi3516cv300.c | 4 ++--
 drivers/clk/hisilicon/crg-hi3798cv200.c | 4 ++--
 drivers/clk/hisilicon/reset.c           | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/hisilicon/clk-hi3519.c b/drivers/clk/hisilicon/clk-hi3519.c
index ad0c7f3..803fa66 100644
--- a/drivers/clk/hisilicon/clk-hi3519.c
+++ b/drivers/clk/hisilicon/clk-hi3519.c
@@ -149,8 +149,8 @@ static int hi3519_clk_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
+	if (IS_ERR(crg->rstc))
+		return PTR_ERR(crg->rstc);
 
 	crg->clk_data = hi3519_clk_register(pdev);
 	if (IS_ERR(crg->clk_data)) {
diff --git a/drivers/clk/hisilicon/crg-hi3516cv300.c b/drivers/clk/hisilicon/crg-hi3516cv300.c
index 5d4e61c..c2af03d 100644
--- a/drivers/clk/hisilicon/crg-hi3516cv300.c
+++ b/drivers/clk/hisilicon/crg-hi3516cv300.c
@@ -271,8 +271,8 @@ static int hi3516cv300_crg_probe(struct platform_device *pdev)
 		return -ENOENT;
 
 	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
+	if (IS_ERR(crg->rstc))
+		return PTR_ERR(crg->rstc);
 
 	crg->clk_data = crg->funcs->register_clks(pdev);
 	if (IS_ERR(crg->clk_data)) {
diff --git a/drivers/clk/hisilicon/crg-hi3798cv200.c b/drivers/clk/hisilicon/crg-hi3798cv200.c
index 08a19ba..66fd6a9 100644
--- a/drivers/clk/hisilicon/crg-hi3798cv200.c
+++ b/drivers/clk/hisilicon/crg-hi3798cv200.c
@@ -354,8 +354,8 @@ static int hi3798cv200_crg_probe(struct platform_device *pdev)
 		return -ENOENT;
 
 	crg->rstc = hisi_reset_init(pdev);
-	if (!crg->rstc)
-		return -ENOMEM;
+	if (IS_ERR(crg->rstc))
+		return PTR_ERR(crg->rstc);
 
 	crg->clk_data = crg->funcs->register_clks(pdev);
 	if (IS_ERR(crg->clk_data)) {
diff --git a/drivers/clk/hisilicon/reset.c b/drivers/clk/hisilicon/reset.c
index 93cee17..c733e2e 100644
--- a/drivers/clk/hisilicon/reset.c
+++ b/drivers/clk/hisilicon/reset.c
@@ -93,11 +93,11 @@ struct hisi_reset_controller *hisi_reset_init(struct platform_device *pdev)
 
 	rstc = devm_kmalloc(&pdev->dev, sizeof(*rstc), GFP_KERNEL);
 	if (!rstc)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	rstc->membase = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rstc->membase))
-		return NULL;
+		return ERR_CAST(rstc->membase);
 
 	spin_lock_init(&rstc->lock);
 	rstc->rcdev.owner = THIS_MODULE;
-- 
2.1.0

