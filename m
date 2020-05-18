Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC87E1D84D9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 20:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732098AbgERR7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 13:59:41 -0400
Received: from rcdn-iport-8.cisco.com ([173.37.86.79]:28453 "EHLO
        rcdn-iport-8.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731609AbgERR7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1409; q=dns/txt; s=iport;
  t=1589824773; x=1591034373;
  h=from:to:cc:subject:date:message-id;
  bh=I6Ye1oWv20B/Y6eYK4Iqy3OEerd2+jAvxiUKGYznuqo=;
  b=MYFCMeDkjwhy+ggODO8sP8T2AQ7PgXmhypyokvTpyshWPHyB1JsIqlQJ
   d35Uk3T0qJRmdhchagZdepHNn94I/ivf0RKPfnDIjzpg0WZu2CnGBtlXR
   F1R7DngPWhZnHwyvnUU1l71h63RMnQcNe/KoNNOislgn7xHUjzL+SJ9DZ
   Q=;
X-IronPort-AV: E=Sophos;i="5.73,407,1583193600"; 
   d="scan'208";a="768458453"
Received: from rcdn-core-10.cisco.com ([173.37.93.146])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 18 May 2020 17:59:32 +0000
Received: from zorba.cisco.com ([10.24.1.223])
        by rcdn-core-10.cisco.com (8.15.2/8.15.2) with ESMTP id 04IHxUGL000659;
        Mon, 18 May 2020 17:59:32 GMT
From:   Daniel Walker <danielwa@cisco.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jinhua Wu <jinhwu@cisco.com>, xe-linux-external@cisco.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mtd: spi-nor: intel-spi: fix forced writable option
Date:   Mon, 18 May 2020 10:59:30 -0700
Message-Id: <20200518175930.10948-2-danielwa@cisco.com>
X-Mailer: git-send-email 2.17.1
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-Outbound-SMTP-Client: 10.24.1.223, [10.24.1.223]
X-Outbound-Node: rcdn-core-10.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option currently doesn't work as expected. If the BIOS has this
flash as read-only there is no way to change this thru the driver.
There is a parameter which allows the flash to become writable with the
"writable" option to the module, but it does nothing if the BIOS has it
set to read-only.

I would expect this option would make the flash writable regardless of
the BIOS settings. This patch changes this option so the BIOS setting
doesn't stop the writable option from enabling read write on the flash.

Original patch by Jinhua Wu <jinhwu@cisco.com>

Cc: Jinhua Wu <jinhwu@cisco.com>
Cc: xe-linux-external@cisco.com
Signed-off-by: Daniel Walker <danielwa@cisco.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index e5a3d51a2e4d..68a5877bfc0b 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -954,7 +954,7 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 	intel_spi_fill_partition(ispi, &part);
 
 	/* Prevent writes if not explicitly enabled */
-	if (!ispi->writeable || !writeable)
+	if (!ispi->writeable && !writeable)
 		ispi->nor.mtd.flags &= ~MTD_WRITEABLE;
 
 	ret = mtd_device_register(&ispi->nor.mtd, &part, 1);
-- 
2.17.1

