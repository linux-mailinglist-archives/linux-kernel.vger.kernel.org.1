Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C2627E39E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 10:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgI3IY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 04:24:56 -0400
Received: from smtp23.cstnet.cn ([159.226.251.23]:35538 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725776AbgI3IYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 04:24:55 -0400
Received: from localhost.localdomain (unknown [159.226.5.100])
        by APP-03 (Coremail) with SMTP id rQCowACnrVXMQHRftxmjAA--.49057S2;
        Wed, 30 Sep 2020 16:24:45 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     paul@crapouillou.net, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/ingenic: remove redundant null check
Date:   Wed, 30 Sep 2020 08:24:41 +0000
Message-Id: <20200930082441.52621-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: rQCowACnrVXMQHRftxmjAA--.49057S2
X-Coremail-Antispam: 1UD129KBjvJXoW7JF4UZF47GFy5Wry3ZFy8Grg_yoW8Jr4Upa
        y7JrWFkan7ZF4j9F98Ja9rG3W5ta17WFyI9F15G3ZrKFn8AFyvvFyFy347ZFn0yr1xCF43
        JwnrCFy8uF40kFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r43MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5RrW7UUUUU==
X-Originating-IP: [159.226.5.100]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQQPA102Zm8Z1gAAss
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because clk_disable_unprepare already checked NULL clock parameter,
so the additional checks are unnecessary, just remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index b7074161ccf0..9dce02e779ad 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -932,8 +932,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	return 0;
 
 err_devclk_disable:
-	if (priv->lcd_clk)
-		clk_disable_unprepare(priv->lcd_clk);
+	clk_disable_unprepare(priv->lcd_clk);
 err_pixclk_disable:
 	clk_disable_unprepare(priv->pix_clk);
 	return ret;
@@ -953,8 +952,7 @@ static void ingenic_drm_unbind(struct device *dev)
 {
 	struct ingenic_drm *priv = dev_get_drvdata(dev);
 
-	if (priv->lcd_clk)
-		clk_disable_unprepare(priv->lcd_clk);
+	clk_disable_unprepare(priv->lcd_clk);
 	clk_disable_unprepare(priv->pix_clk);
 
 	drm_dev_unregister(&priv->drm);
-- 
2.17.1

