Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651502DDB35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 23:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgLQWMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 17:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbgLQWMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 17:12:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C457C061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:11:58 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g24so293392edw.9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 14:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ctiK0mA4JK6QvRekJWEWOG1zeHLhg/gasLcxbxoVjc=;
        b=A8GA8OkuDewd4OZzGXgLg2SB0z//t9YORRY5DZf9LWIYIFt5Om0aDUsaVXYu5IsuP3
         ffkDcYVvWIAEo36FDAAo38dBcrXKKN2X2oQuVzJlRmujVIYEMhnusSK/sTNmM7GlPY20
         Uw8mCuwCXC/n9I95XjQx3E8wSpdrCmPD1PE1sWsCGxCXwhhwanoCqrX4poiocnlvtBzQ
         TPE/3wRqJhefWP6C9VAnAHZbTQtD/3cKE0RQUNzlMAVm//HNDnPvS/WO7k+dIDHmgaDo
         lA2IplvyRFUdSWoV2zIj+wysQd0TrUGEBH0VnFgEEinw5fZUD7L1FuqR8n09xw8Wlqce
         6JNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0ctiK0mA4JK6QvRekJWEWOG1zeHLhg/gasLcxbxoVjc=;
        b=lTUvti/wa9VCJx5Y+iv7sJJeNRfIJ6F2M1OXDZPLPQi5w++vnbXTJABZyPMG2kwxvb
         AUujXrBlqJJ49YQ1k3k+If8MEEfz/TLGHPPqV2yB9MeTu2XpBKrNjl+96BzOKdcJ7wJQ
         1iuqWpTLmFsvOo8SUNCf4APUNa/YqhQzwjtWODhCyUdPYNDieLhlVcX6+u7VykgZGazb
         kogjGXMxQAflRrq16LQLjsUdzc68Sj4oXKf3dHM7zf00MYytmj7l1+D3DHatmGyuK3sS
         gCBQfIa1AREIqQRH/EjzuPnCKpNotHs6wazaWhAaC6OgCkqmlTEnjt3CX+3CNunvyRIh
         +JAg==
X-Gm-Message-State: AOAM530cFtOnOjT8PcAoAsQR4DQy/FgKXUWUN9iOJzHZ/2Ykzkb/+27Y
        UnPA95oHK7al8QKC5+ATLmQ=
X-Google-Smtp-Source: ABdhPJwpxmgrhbd2dIZ1rE4ZcxAA/fLKKWS1bdrxMjIhPPMeXQmB/FtqRW/sCRJJx4PpPIzXFq9F7A==
X-Received: by 2002:a05:6402:1383:: with SMTP id b3mr1535936edv.100.1608243117145;
        Thu, 17 Dec 2020 14:11:57 -0800 (PST)
Received: from localhost.localdomain (p200300f137008a00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3700:8a00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id m7sm4627091ejr.119.2020.12.17.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 14:11:56 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-mtd@lists.infradead.org
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] mtd: rawnand: intel: remove broken code
Date:   Thu, 17 Dec 2020 23:11:48 +0100
Message-Id: <20201217221148.2877318-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the check for mtd->name as it's executed while the mtd variable is
always NULL. If some MTD name is needed then it should be validated by
the MTD core.

While here, also drop the NULL assignment to the mtd variable as it's
overwritten later on anyways and the NULL value is never read.

Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
I found this by looking at the new driver. This patch is compile-tested
only.


 drivers/mtd/nand/raw/intel-nand-controller.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index fdb112e8a90d..398de6ec68d7 100644
--- a/drivers/mtd/nand/raw/intel-nand-controller.c
+++ b/drivers/mtd/nand/raw/intel-nand-controller.c
@@ -579,7 +579,7 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct ebu_nand_controller *ebu_host;
 	struct nand_chip *nand;
-	struct mtd_info *mtd = NULL;
+	struct mtd_info *mtd;
 	struct resource *res;
 	char *resname;
 	int ret;
@@ -647,10 +647,6 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	       ebu_host->ebu + EBU_ADDR_SEL(cs));
 
 	nand_set_flash_node(&ebu_host->chip, dev->of_node);
-	if (!mtd->name) {
-		dev_err(ebu_host->dev, "NAND label property is mandatory\n");
-		return -EINVAL;
-	}
 
 	mtd = nand_to_mtd(&ebu_host->chip);
 	mtd->dev.parent = dev;
-- 
2.29.2

