Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1E2EBF4D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbhAFOKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAFOKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:10:31 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20DC06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:09:50 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c7so4498895edv.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 06:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=As8f8sygbZBfueY7JO/Eyp1IFwhU/oja0yGtvjK51KU=;
        b=CDHZCksfoNuidqgwe4TD90l7FF+e1hblPngHRFgZSkPVlkfJrxcN5pItLVlyci+Yne
         AkxOXiwSNfHl0MTuwSP+DHOGMaWJr1+8TAic8+diBZenifsHHolK3sonpMn3kh6K6fOL
         axTiQ2yjkbr+4/vKRjFzmqwMb9kI87e7ubnC9MX/QySg1/mPVUQ/JyqyN6sPF2mafQ2T
         7ZXIS6INdZ6PgevODnG5nYrBiYMIvW4aTD17ufFYU+AKh6ui5MtmfdYsz/ZTFHAXFK0n
         4yiUNLfZL7GLwn/becV/5HEhmPNmNQ5YZKx/4FeSsMPm5gdxKp/qs7A15CNcb14bD7dO
         a++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=As8f8sygbZBfueY7JO/Eyp1IFwhU/oja0yGtvjK51KU=;
        b=Caumb/3vJxapM9KrvmdkAFapraKzHMF2uTRieivDcGAJhNygf2Mol0nChBtY4Ikff4
         N2DP9GZeNq3Z3nA0PhXzMZSJisM99r/gBRZx9EmlEdLrKMgTJ6VxjRUK9u+UTNJh5JZV
         WoM6lfoLO7daac/vKXm3zG3iKYLqAccqvPQT6xJ3YidDBiKJ8hmxZTSHu7gzJTc7N+5G
         llYdK4/iyQSJQC7E7D+Q4mnFmrSXCI2OfFyBylmBaurcNtHjs1DUQY97URlb9MHaVnrq
         ctDoSmOk07xUtdWz0aLENCyDvvxFuNjOrl/8IsIhwEjZD6oMB884JgAEFq8CyrP4r/b/
         twAg==
X-Gm-Message-State: AOAM532ZhPzht8dJNUvqmJ0/tVvV0fgbne6P7kKxtiBn8nM7MBmqxx37
        DEm7AfAyqTyrZtmza47RtW8=
X-Google-Smtp-Source: ABdhPJx0hWjzJguOO3vUzQ24g06XvMFqE521N02FoeeaGSep5w+g2Zw37XhKEcAgszUIpagvNWf89A==
X-Received: by 2002:a05:6402:41:: with SMTP id f1mr4028853edu.286.1609942189329;
        Wed, 06 Jan 2021 06:09:49 -0800 (PST)
Received: from localhost.localdomain (p200300f13711ec00428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3711:ec00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f17sm1495952edu.25.2021.01.06.06.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 06:09:48 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     vadivel.muruganx.ramuthevar@linux.intel.com,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2] mtd: rawnand: intel: check the mtd name only after setting the variable
Date:   Wed,  6 Jan 2021 15:09:43 +0100
Message-Id: <20210106140943.98072-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the check for mtd->name after the mtd variable has actually been
initialized.

While here, also drop the NULL assignment to the mtd variable as it's
overwritten later on anyways and the NULL value is never read.

Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
changes since v1:
- don't drop the check but actually move it after the mtd variable has
  been initialized as suggested by Miquel Raynal


 drivers/mtd/nand/raw/intel-nand-controller.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/intel-nand-controller.c b/drivers/mtd/nand/raw/intel-nand-controller.c
index fdb112e8a90d..a304fda5d1fa 100644
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
@@ -647,12 +647,13 @@ static int ebu_nand_probe(struct platform_device *pdev)
 	       ebu_host->ebu + EBU_ADDR_SEL(cs));
 
 	nand_set_flash_node(&ebu_host->chip, dev->of_node);
+
+	mtd = nand_to_mtd(&ebu_host->chip);
 	if (!mtd->name) {
 		dev_err(ebu_host->dev, "NAND label property is mandatory\n");
 		return -EINVAL;
 	}
 
-	mtd = nand_to_mtd(&ebu_host->chip);
 	mtd->dev.parent = dev;
 	ebu_host->dev = dev;
 
-- 
2.30.0

