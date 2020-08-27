Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F93253F18
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 09:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgH0H0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 03:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgH0H0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:26:31 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00AA622BEA;
        Thu, 27 Aug 2020 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598513191;
        bh=90a9ZhlFuSPAOjQxk04wDw4LIX5PUnsmuyC3grz/ji8=;
        h=From:To:Cc:Subject:Date:From;
        b=oKECoV8CYsgDpAvjo7nOxplkehdURqkHPlg65V1JVtuu77hPtxa6fOKrcMnyoCKaQ
         DIt6A2PvzLkzmlx4pCEeF80ZdllmPjytdu/u23q6ubzm7RtTLbFWEPcTGlOjaAUGe5
         hfsdgV1C1q24sJ6MrAAE0rx1Hluvdr6ummKnbO4U=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] maiblox: mediatek: Fix handling of platform_get_irq() error
Date:   Thu, 27 Aug 2020 09:26:26 +0200
Message-Id: <20200827072626.23331-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() returns -ERRNO on error.  In such case comparison
to 0 would pass the check.

Fixes: 623a6143a845 ("mailbox: mediatek: Add Mediatek CMDQ driver")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 484d4438cd83..76e4dfcf5228 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -525,10 +525,8 @@ static int cmdq_probe(struct platform_device *pdev)
 	}
 
 	cmdq->irq = platform_get_irq(pdev, 0);
-	if (!cmdq->irq) {
-		dev_err(dev, "failed to get irq\n");
-		return -EINVAL;
-	}
+	if (!cmdq->irq < 0)
+		return cmdq->irq;
 
 	plat_data = (struct gce_plat *)of_device_get_match_data(dev);
 	if (!plat_data) {
-- 
2.17.1

