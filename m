Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D8328DC28
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgJNI5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:57:43 -0400
Received: from smtp25.cstnet.cn ([159.226.251.25]:55216 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgJNI5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:57:43 -0400
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-05 (Coremail) with SMTP id zQCowADHqLV0vYZfzIpxAg--.4329S2;
        Wed, 14 Oct 2020 16:57:25 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     b.zolnierkie@samsung.com, gustavoars@kernel.org, arnd@arndb.de,
        daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: sh_mobile_lcdcfb: Remove redundant null check before clk_prepare_enable/clk_disable_unprepare
Date:   Wed, 14 Oct 2020 08:57:22 +0000
Message-Id: <20201014085722.26069-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowADHqLV0vYZfzIpxAg--.4329S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZFy8CFyfJF4UXFWDGFWktFb_yoW8JrWrp3
        W8ZFyFy397Zr1DKan8ArWjgF1Yva45tFyrZFykKa45uF9xAF1UXFy5t3s2qFn5JFZYyrWa
        yryjqa45uF18uFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkIb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r43MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Tv3UUUUUU==
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgYJA1z4jD+P4AAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter, so the additional checks are unnecessary, just
remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index c1043420dbd3..c0952cc96bdb 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -341,8 +341,7 @@ static void lcdc_wait_bit(struct sh_mobile_lcdc_priv *priv,
 static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 {
 	if (atomic_inc_and_test(&priv->hw_usecnt)) {
-		if (priv->dot_clk)
-			clk_prepare_enable(priv->dot_clk);
+		clk_prepare_enable(priv->dot_clk);
 		pm_runtime_get_sync(priv->dev);
 	}
 }
@@ -351,8 +350,7 @@ static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 {
 	if (atomic_sub_return(1, &priv->hw_usecnt) == -1) {
 		pm_runtime_put(priv->dev);
-		if (priv->dot_clk)
-			clk_disable_unprepare(priv->dot_clk);
+		clk_disable_unprepare(priv->dot_clk);
 	}
 }
 
-- 
2.17.1

