Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C1F2CE9F7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgLDIhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:37:46 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:56436 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725969AbgLDIhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:37:46 -0500
Received: from localhost.localdomain (unknown [124.16.141.242])
        by APP-01 (Coremail) with SMTP id qwCowAC3v1cg9clf1czZAA--.26586S2;
        Fri, 04 Dec 2020 16:36:49 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        p.zabel@pengutronix.de, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc2: Remove redundant null check before clk_prepare_enable/clk_disable_unprepare
Date:   Fri,  4 Dec 2020 08:36:44 +0000
Message-Id: <20201204083644.2704-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowAC3v1cg9clf1czZAA--.26586S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CFyfJF4DuFW8uF4UArb_yoWDtwc_W3
        W8WrsrJF15ZwsFyr9Fk34DAr9FgF1vvF4xXF1IvrW3ta43WrWUZryjvrZxZ3yDX3yjyF9r
        Cr4UGrWxCr43ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbFkYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
        80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
        zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx
        8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s02
        6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
        I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
        6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
        0_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWU
        JVW8JbIYCTnIWIevJa73UjIFyTuYvjxUc9mRUUUUU
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCggAA1z4jMgD1gAAs0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because clk_prepare_enable() and clk_disable_unprepare() already checked
NULL clock parameter, so the additional checks are unnecessary, just
remove them.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/usb/dwc2/platform.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 5f18acac7406..ba2b491c7f82 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -143,11 +143,9 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		return ret;
 
-	if (hsotg->clk) {
-		ret = clk_prepare_enable(hsotg->clk);
-		if (ret)
-			return ret;
-	}
+	ret = clk_prepare_enable(hsotg->clk);
+	if (ret)
+		return ret;
 
 	if (hsotg->uphy) {
 		ret = usb_phy_init(hsotg->uphy);
@@ -195,8 +193,7 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		return ret;
 
-	if (hsotg->clk)
-		clk_disable_unprepare(hsotg->clk);
+	clk_disable_unprepare(hsotg->clk);
 
 	return 0;
 }
-- 
2.17.1

