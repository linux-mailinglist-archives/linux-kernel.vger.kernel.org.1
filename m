Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F443253F29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 09:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgH0Hbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 03:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgH0Hbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:31:34 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 405912074A;
        Thu, 27 Aug 2020 07:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598513494;
        bh=wyrWStEXlF6vWD6HgqPUFEIkSSxMzHWsU8ftz8UEV1I=;
        h=From:To:Cc:Subject:Date:From;
        b=gBboUJHKF5W3YHnk6XESwwJ4AKZGdbUA+p0dzt/Vo1sIaeMW9nEqvu9zq8XhHqIg5
         QUGhGQAnIAFEvUmDFAfS3F0svsP5ewpQlKD9iCyaWe9jWS/78vrt6xDFuNLqAx8y+8
         IyCBCEQdUO+FQpevKeqofLxzgNfBYLrh4AW1KOGo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        HS Liao <hs.liao@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] maiblox: mediatek: Fix handling of platform_get_irq() error
Date:   Thu, 27 Aug 2020 09:31:28 +0200
Message-Id: <20200827073128.28389-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case casting to u32
and comparing to 0 would pass the check.

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Correct u32->int,
2. Fix left-over '!'.
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 484d4438cd83..5665b6ea8119 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -69,7 +69,7 @@ struct cmdq_task {
 struct cmdq {
 	struct mbox_controller	mbox;
 	void __iomem		*base;
-	u32			irq;
+	int			irq;
 	u32			thread_nr;
 	u32			irq_mask;
 	struct cmdq_thread	*thread;
@@ -525,10 +525,8 @@ static int cmdq_probe(struct platform_device *pdev)
 	}
 
 	cmdq->irq = platform_get_irq(pdev, 0);
-	if (!cmdq->irq) {
-		dev_err(dev, "failed to get irq\n");
-		return -EINVAL;
-	}
+	if (cmdq->irq < 0)
+		return cmdq->irq;
 
 	plat_data = (struct gce_plat *)of_device_get_match_data(dev);
 	if (!plat_data) {
-- 
2.17.1

