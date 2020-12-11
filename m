Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB432D7F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 20:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731854AbgLKTOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 14:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgLKTNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 14:13:39 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD4DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:12:58 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id s6so4706225qvn.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 11:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zsoUYUzeV+WYjhEE59eI7KcDVcT0csVZgAWDGlms7yM=;
        b=kRVbaxKsVtuB9xR5/ithehd+S3+lc5m4TqR9PfE1lGIRdax0xelGjMS9p2p4P+Yn3S
         dEPIiWNiN+0SgSsG8TuuihbuGI+9O5oDyy55/jsIPAwWurbT+ql161kfzZk7oKuSJ970
         53ticomgrtC/Ks2AcKSV+AoHY3afOGvAWu/BP6ecILrtOxD8l9A2gDsFtcTkZ6KITDoo
         B1ZP/t093Felghtvn7hFHQDuP/ID7u+ZGxZCTGQLzKCIGsgGJVinDphB+v4E0lO2TBON
         hUuZ4tGVHEP/qqPEQxnknwdS0a366AaW7kyILDUBHnZEAymrwtZNqosiVFYdz06gAtbM
         iTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zsoUYUzeV+WYjhEE59eI7KcDVcT0csVZgAWDGlms7yM=;
        b=hkdxgOcZopXHo1FLpa8X76tuH8htDUVUxZeFDn6seXxJq/CdBocMVGegAzYKjIZiF5
         JOB5hnqHi+lR+p+ffFZSrvhouLWkB7iB+MQ4sO9WOWttPbe5bZxqEtVFrRAkoezaoreR
         j62JZ1QuaEXr9pMC1cnorxYUbMGka1g4ozfFQix4UfuBHQgc50/sWZpD6mcI7ODeeEPY
         GXbioaJEjQZL/4SbCC2bkSaOG7SaKFL5EHybxdkq1xX5NZDjpaoAfq6N+MCFqSVsQ68w
         jjRdGLQgD8evA+icU0J/F+maAm8UDeiKpHddMfLuMKxd+Ed/GKmkL1lU/XWUAPzl/82Y
         Rx/w==
X-Gm-Message-State: AOAM532c1yu2CxmZg2skFszkBndAczZ6nBda/Y95BrfhM69TntCYQKGG
        SALDXHxh342zJSvckkIDugI=
X-Google-Smtp-Source: ABdhPJw1Nf9IItxmdoQvOn93AmWK6UPBwH7PwCBy6NYe1GHhWzDwJcWz8qnQ7lUMDyLFcKuXc8JkNQ==
X-Received: by 2002:a0c:c48e:: with SMTP id u14mr8117651qvi.39.1607713977826;
        Fri, 11 Dec 2020 11:12:57 -0800 (PST)
Received: from atris.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id r1sm6838163qta.32.2020.12.11.11.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 11:12:56 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, geert@linux-m68k.org, kishon@ti.com,
        vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/1] phy: tusb1210: use bitmasks to set VENDOR_SPECIFIC2
Date:   Fri, 11 Dec 2020 14:12:41 -0500
Message-Id: <20201211191241.21306-1-liambeguin@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Start by reading the content of the VENDOR_SPECIFIC2 register and update
each bit field based on device properties when defined.

The use of bit masks prevents fields from overriding each other and
enables users to clear bits which are set by default, like datapolarity
in this instance.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
Changes since v1:
- use set_mask_bits

Changes since v2:
- fix missing bit shift dropped in v2
- rebase on 5.9-rc1

Changes since v3:
- switch to u8p_replace_bits() since there's little reason to protect
  against concurrent access

Changes since v4:
- rebase on latest master

 drivers/phy/ti/phy-tusb1210.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/ti/phy-tusb1210.c b/drivers/phy/ti/phy-tusb1210.c
index d8d0cc11d187..a63213f5972a 100644
--- a/drivers/phy/ti/phy-tusb1210.c
+++ b/drivers/phy/ti/phy-tusb1210.c
@@ -7,15 +7,16 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 #include <linux/module.h>
+#include <linux/bitfield.h>
 #include <linux/ulpi/driver.h>
 #include <linux/ulpi/regs.h>
 #include <linux/gpio/consumer.h>
 #include <linux/phy/ulpi_phy.h>
 
 #define TUSB1210_VENDOR_SPECIFIC2		0x80
-#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT	0
-#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT	4
-#define TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT	6
+#define TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK	GENMASK(3, 0)
+#define TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK	GENMASK(5, 4)
+#define TUSB1210_VENDOR_SPECIFIC2_DP_MASK	BIT(6)
 
 struct tusb1210 {
 	struct ulpi *ulpi;
@@ -118,22 +119,22 @@ static int tusb1210_probe(struct ulpi *ulpi)
 	 * diagram optimization and DP/DM swap.
 	 */
 
+	reg = ulpi_read(ulpi, TUSB1210_VENDOR_SPECIFIC2);
+
 	/* High speed output drive strength configuration */
-	device_property_read_u8(&ulpi->dev, "ihstx", &val);
-	reg = val << TUSB1210_VENDOR_SPECIFIC2_IHSTX_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "ihstx", &val))
+		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_IHSTX_MASK);
 
 	/* High speed output impedance configuration */
-	device_property_read_u8(&ulpi->dev, "zhsdrv", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "zhsdrv", &val))
+		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_ZHSDRV_MASK);
 
 	/* DP/DM swap control */
-	device_property_read_u8(&ulpi->dev, "datapolarity", &val);
-	reg |= val << TUSB1210_VENDOR_SPECIFIC2_DP_SHIFT;
+	if (!device_property_read_u8(&ulpi->dev, "datapolarity", &val))
+		u8p_replace_bits(&reg, val, (u8)TUSB1210_VENDOR_SPECIFIC2_DP_MASK);
 
-	if (reg) {
-		ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
-		tusb->vendor_specific2 = reg;
-	}
+	ulpi_write(ulpi, TUSB1210_VENDOR_SPECIFIC2, reg);
+	tusb->vendor_specific2 = reg;
 
 	tusb->phy = ulpi_phy_create(ulpi, &phy_ops);
 	if (IS_ERR(tusb->phy))

base-commit: 33dc9614dc208291d0c4bcdeb5d30d481dcd2c4c
-- 
2.27.0

