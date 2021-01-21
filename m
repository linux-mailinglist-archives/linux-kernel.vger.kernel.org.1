Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEF12FEE36
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbhAUPOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:14:51 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:34500 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732630AbhAUPNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:13:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=dxCtuewZmUbFHYW5UF
        gRE4hvEdTgAhczPMgdTnfqpBw=; b=cC41o/v0jR9RduYTzxxWCg/2lYaKsPNx+U
        Rh0Qa82oCyWKCkQNYGdm6ahncM1KXApYEYgYRs6V4KHuJLWMIqCWDcNJaE6qtYeB
        xxQ/1FKbIZBcQSJcvOnWtXwfqZDXX6NyhIDDDU0pPcKycf7qjsy/QcZyhirCansI
        zSEQcaF4g=
Received: from localhost.localdomain (unknown [111.201.134.89])
        by smtp2 (Coremail) with SMTP id GtxpCgCHtr6gmQlgM+tsJw--.5465S4;
        Thu, 21 Jan 2021 23:11:31 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Antoine Tenart <atenart@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] reset: berlin: Put parent device node on error path
Date:   Thu, 21 Jan 2021 07:11:26 -0800
Message-Id: <20210121151126.74627-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GtxpCgCHtr6gmQlgM+tsJw--.5465S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrKryfWFyrXF47uw1xJr4Dtwb_yoW3KFc_Cr
        WxXFZ7Wr98KFs2krWYva17ZrZ0kF98Wr1rZ3WDtFW3Gr47Jr15Ar98Zrn8X3y5X3y3Wr95
        AF1DA3W3Ar9xZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUD5r3UUUUU==
X-Originating-IP: [111.201.134.89]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBZwMhclet1hb+DQAAs+
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put parent device node parent_np if there is no enough memory.

Fixes: aed6f3cadc86 ("reset: berlin: convert to a platform driver")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/reset/reset-berlin.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-berlin.c b/drivers/reset/reset-berlin.c
index 371197bbd055..cae58e40f639 100644
--- a/drivers/reset/reset-berlin.c
+++ b/drivers/reset/reset-berlin.c
@@ -72,8 +72,10 @@ static int berlin2_reset_probe(struct platform_device *pdev)
 	struct berlin_reset_priv *priv;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
+	if (!priv) {
+		of_node_put(parent_np);
 		return -ENOMEM;
+	}
 
 	priv->regmap = syscon_node_to_regmap(parent_np);
 	of_node_put(parent_np);
-- 
2.17.1

