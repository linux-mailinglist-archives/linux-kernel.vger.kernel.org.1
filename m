Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB039272287
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 13:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgIUL3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 07:29:32 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53644 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbgIUL3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 07:29:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id DE4835750D;
        Mon, 21 Sep 2020 11:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1600687279; x=1602501680; bh=ii5ADmQuzyNneIFBkHAT3wYiVuvXA+hEUPb
        eRSzRgzU=; b=CdBg3tvdO4voY73ye3al1Mhr78debWUR32a8iZyjEB6Gj43LgAT
        lLQz78ZYukgD6obFMIznG15Ovat0SCx7288QpMVGfRpt07rN9njNdIqW4Xj+Xpj6
        TtYRdf8uMD3Ja1bt0etSMBrWDxQPv4Ya2UXltOq+BIH5ZXuMyOuo5rM4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id w6O96-ruWZsm; Mon, 21 Sep 2020 14:21:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 1C5BB535F4;
        Mon, 21 Sep 2020 14:21:18 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.3.38) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Mon, 21 Sep 2020 14:21:18 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RESEND PATCH 1/2] mtd: spi-nor: do not touch TB bit without SPI_NOR_HAS_TB
Date:   Mon, 21 Sep 2020 14:24:49 +0300
Message-ID: <20200921112450.4824-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200921112450.4824-1-i.mikhaylov@yadro.com>
References: <20200921112450.4824-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.3.38]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some chips like macronix don't have TB(Top/Bottom protection)
bit in the status register. Do not write tb_mask inside status
register, unless SPI_NOR_HAS_TB is present for the chip.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/mtd/spi-nor/core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0369d98b2d12..f9853dd566dc 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1735,13 +1735,18 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 			return -EINVAL;
 	}
 
-	status_new = (status_old & ~mask & ~tb_mask) | val;
+	if (nor->flags & SNOR_F_HAS_SR_TB)
+		status_new = (status_old & ~mask & ~tb_mask) | val;
+	else
+		status_new = (status_old & ~mask) | val;
 
 	/* Disallow further writes if WP pin is asserted */
 	status_new |= SR_SRWD;
 
-	if (!use_top)
-		status_new |= tb_mask;
+	if (!use_top) {
+		if (nor->flags & SNOR_F_HAS_SR_TB)
+			status_new |= tb_mask;
+	}
 
 	/* Don't bother if they're the same */
 	if (status_new == status_old)
@@ -1817,14 +1822,19 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 			return -EINVAL;
 	}
 
-	status_new = (status_old & ~mask & ~tb_mask) | val;
+	if (nor->flags & SNOR_F_HAS_SR_TB)
+		status_new = (status_old & ~mask & ~tb_mask) | val;
+	else
+		status_new = (status_old & ~mask) | val;
 
 	/* Don't protect status register if we're fully unlocked */
 	if (lock_len == 0)
 		status_new &= ~SR_SRWD;
 
-	if (!use_top)
-		status_new |= tb_mask;
+	if (!use_top) {
+		if (nor->flags & SNOR_F_HAS_SR_TB)
+			status_new |= tb_mask;
+	}
 
 	/* Don't bother if they're the same */
 	if (status_new == status_old)
-- 
2.21.1

