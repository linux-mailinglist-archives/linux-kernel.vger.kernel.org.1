Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6995E2A912A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKFIWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKFIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:22:35 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650F4C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:22:35 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t18so335810plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-description
         :content-disposition;
        bh=lEww5yAkFWrfhIg3JvC4XEkVJHdH/gtbEeQQICiYVw8=;
        b=OPL+0SzkpAeEampvzqnF3PNMQJC7r7rs9LfURTmHmuV4tiXFMt9cIPWweCsB66TOOg
         S+xt4z5F85XSS5R8gg3sVFql/nXzTDMturdzfU+Aj8eN4IEiXipDXLvoSBjsUYJLlcs8
         VtW8a5leVTEm1iTf/zc7pE7XzEQlsLWGyp+jYggaOqHp3RV/+rhm1mA/PdgXMfvd+YDT
         GBYcCH469RgA3FzezODAWQk91sz/02ba1OHJWZiTcJpIDX3j/EFjeZg7dsOXCFmU+u08
         6hdEP/loQ4uAvBuXz3qIQ+ZLm1riK305MXUvdccDhojpn+M4jXFljs/YZ8sBKbH83jMw
         sQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-description:content-disposition;
        bh=lEww5yAkFWrfhIg3JvC4XEkVJHdH/gtbEeQQICiYVw8=;
        b=JM5jryIB4KURp1E9xqJw0kHFUy68Vd58q2xrL850mFhaucU44UQiqlRbRw39Ul6/cQ
         YRvzmZxGzwvF93J6yPZad2m5acJF0N+ZAFcCU4bC1uxKfW4MORJ8oH8VCfHgXnM37fqR
         s6YfKr7oMOCkT0hNN0AsQMfHi/DpYiAOrI8E7kxB+3VW6yYDrZoXT4caHUEeg2aUeBoj
         RUg1+b+6HfQucRq524T8SWw5G14xEDG1xIJQMKQbWVlxGvjKnYp9fz9Ros1C6nOdcqcW
         p6Pz/F2SlTnvetGt7dY5jFppypo/KPIbSb0jnO1fcr1XbiBMgg+tq2UPeI9WR5GOTto3
         VT4w==
X-Gm-Message-State: AOAM530RX7rwyRssBV2cB4G5wFk++KhVnjn32LSqhsKqJnYJuTAA/WCw
        iaz1DHVJ1Hui/2bf2yG6QQ==
X-Google-Smtp-Source: ABdhPJwq+FtO2oHP5rTQ7rqeqmlSy3rIyrQhkXbZBVqUe3WbhYREA/E/s4IsPy1GACee46AHV2kRmw==
X-Received: by 2002:a17:902:8502:b029:d5:b4f4:8555 with SMTP id bj2-20020a1709028502b02900d5b4f48555mr982843plb.76.1604650954870;
        Fri, 06 Nov 2020 00:22:34 -0800 (PST)
Received: from Sleakybeast ([2405:204:8304:6bd6:e537:e8f9:e101:bb78])
        by smtp.gmail.com with ESMTPSA id h11sm1078196pfo.69.2020.11.06.00.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 00:22:34 -0800 (PST)
Date:   Fri, 6 Nov 2020 13:52:26 +0530
From:   Siddhant Gupta <siddhantgupta416@gmail.com>
To:     matthias.bgg@gmail.com
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        mamtashukla555@gmail.com, himadrispandya@gmail.com
Subject: [PATCH] staging: mt7621-dma: fix alignment warnings
Message-ID: <20201106082226.GA22990@Sleakybeast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: evel@driverdev.osuosl.org,
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the checkpatch warning of alignment should match open parenthesis
for some dev_dbg() calls

Signed-off-by: Siddhant Gupta <siddhantgupta416@gmail.com>
---
 drivers/staging/mt7621-dma/mtk-hsdma.c | 44 +++++++++++++-------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
index a9e1a1b14035..838fd05d33ee 100644
--- a/drivers/staging/mt7621-dma/mtk-hsdma.c
+++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
@@ -208,24 +208,24 @@ static void mtk_hsdma_reset_chan(struct mtk_hsdam_engine *hsdma,
 
 static void hsdma_dump_reg(struct mtk_hsdam_engine *hsdma)
 {
-	dev_dbg(hsdma->ddev.dev, "tbase %08x, tcnt %08x, "
-			"tctx %08x, tdtx: %08x, rbase %08x, "
-			"rcnt %08x, rctx %08x, rdtx %08x\n",
-			mtk_hsdma_read(hsdma, HSDMA_REG_TX_BASE),
-			mtk_hsdma_read(hsdma, HSDMA_REG_TX_CNT),
-			mtk_hsdma_read(hsdma, HSDMA_REG_TX_CTX),
-			mtk_hsdma_read(hsdma, HSDMA_REG_TX_DTX),
-			mtk_hsdma_read(hsdma, HSDMA_REG_RX_BASE),
-			mtk_hsdma_read(hsdma, HSDMA_REG_RX_CNT),
-			mtk_hsdma_read(hsdma, HSDMA_REG_RX_CRX),
-			mtk_hsdma_read(hsdma, HSDMA_REG_RX_DRX));
-
-	dev_dbg(hsdma->ddev.dev, "info %08x, glo %08x, delay %08x, intr_stat %08x, intr_mask %08x\n",
-			mtk_hsdma_read(hsdma, HSDMA_REG_INFO),
-			mtk_hsdma_read(hsdma, HSDMA_REG_GLO_CFG),
-			mtk_hsdma_read(hsdma, HSDMA_REG_DELAY_INT),
-			mtk_hsdma_read(hsdma, HSDMA_REG_INT_STATUS),
-			mtk_hsdma_read(hsdma, HSDMA_REG_INT_MASK));
+	dev_dbg(hsdma->ddev.dev,
+		"tbase %08x, tcnt %08x, tctx %08x, tdtx: %08x, rbase %08x, rcnt %08x, rctx %08x, rdtx %08x\n",
+		mtk_hsdma_read(hsdma, HSDMA_REG_TX_BASE),
+		mtk_hsdma_read(hsdma, HSDMA_REG_TX_CNT),
+		mtk_hsdma_read(hsdma, HSDMA_REG_TX_CTX),
+		mtk_hsdma_read(hsdma, HSDMA_REG_TX_DTX),
+		mtk_hsdma_read(hsdma, HSDMA_REG_RX_BASE),
+		mtk_hsdma_read(hsdma, HSDMA_REG_RX_CNT),
+		mtk_hsdma_read(hsdma, HSDMA_REG_RX_CRX),
+		mtk_hsdma_read(hsdma, HSDMA_REG_RX_DRX));
+
+	dev_dbg(hsdma->ddev.dev,
+		"info %08x, glo %08x, delay %08x, intr_stat %08x, intr_mask %08x\n",
+		mtk_hsdma_read(hsdma, HSDMA_REG_INFO),
+		mtk_hsdma_read(hsdma, HSDMA_REG_GLO_CFG),
+		mtk_hsdma_read(hsdma, HSDMA_REG_DELAY_INT),
+		mtk_hsdma_read(hsdma, HSDMA_REG_INT_STATUS),
+		mtk_hsdma_read(hsdma, HSDMA_REG_INT_MASK));
 }
 
 static void hsdma_dump_desc(struct mtk_hsdam_engine *hsdma,
@@ -242,10 +242,10 @@ static void hsdma_dump_desc(struct mtk_hsdam_engine *hsdma,
 		tx_desc = &chan->tx_ring[i];
 		rx_desc = &chan->rx_ring[i];
 
-		dev_dbg(hsdma->ddev.dev, "%d tx addr0: %08x, flags %08x, "
-				"tx addr1: %08x, rx addr0 %08x, flags %08x\n",
-				i, tx_desc->addr0, tx_desc->flags,
-				tx_desc->addr1, rx_desc->addr0, rx_desc->flags);
+		dev_dbg(hsdma->ddev.dev,
+			"%d tx addr0: %08x, flags %08x, tx addr1: %08x, rx addr0 %08x, flags %08x\n",
+			i, tx_desc->addr0, tx_desc->flags,
+			tx_desc->addr1, rx_desc->addr0, rx_desc->flags);
 	}
 }
 
-- 
2.25.1

