Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36FAB2780FB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbgIYGyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgIYGyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:54:38 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37081C0613D3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 23:54:38 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so2267616pfk.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 23:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2durK184bkZhr5uNqjCIpCLzFSfTXNNXV6rELvHa38=;
        b=AzTp/MsqJD4ypbPw6ynmJElRR13Xpo7J3MBBmUXgaDmcvP6AkCCeSKRtT0qeMrYtEc
         JYQcK5zauvnG+KD0rL4pXdhqPcYjR6LClOb1bJycXsGPDcyH7E75znEJglTlKqybmyKh
         1SjkA2gDCatg0n3fbfp5sG0p9oCSCRyrENtRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2durK184bkZhr5uNqjCIpCLzFSfTXNNXV6rELvHa38=;
        b=L6txd2wNw8Ub2i/m/vJoHnuer4nKreF9TZHp+fq4gh26jvQuq5bjSW9genQH4oLL++
         x5XNeVzlz4m9DMc7+gj9P2lFaJGSodXA3z+XMIgdo7F2IgNv8DjeEfGWiHGZMktf2wpA
         l1fbMtpytC/Auj/VISKUPKi61kkUKsX1VAuYU5WK14OvD8QVUDajC9gK6hGWQbyFsmnj
         0nkMJCeX8Xy2G030wEUE84UGNd4t1XQiOvoliOcSv4LdKQ3W0qcdERXJvIIws/+N3gBY
         mNCV4RUHWr9SExDh4k9DdOZfLlNxlH2LNQJMeKHYdkMTBWVQc9uRmnWWgA3T5Q6yvv1C
         8ObQ==
X-Gm-Message-State: AOAM531MH7Nsscjfljq2vWLFQ2JJPxGlKgzVdEFAVBEahGlGNQIEJlKJ
        1lhLSyKG5w87DkF4lXz4zZqucA==
X-Google-Smtp-Source: ABdhPJwkLQdjAg/a8gdsInNhR893pp8mKtdtxXqsEIrTz/fZNeBtAlaDLQgyb21XG7dJ/qPvt8wzZw==
X-Received: by 2002:aa7:989a:0:b029:142:2501:34da with SMTP id r26-20020aa7989a0000b0290142250134damr2838533pfl.51.1601016877699;
        Thu, 24 Sep 2020 23:54:37 -0700 (PDT)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id x27sm1549612pfp.128.2020.09.24.23.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 23:54:37 -0700 (PDT)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 4/6] spi: spi-mtk-nor: use dma_alloc_coherent() for bounce buffer
Date:   Fri, 25 Sep 2020 14:54:15 +0800
Message-Id: <20200925145255.v3.4.I06cb65401ab5ad63ea30c4788d26633928d80f38@changeid>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200925065418.1077472-1-ikjn@chromium.org>
References: <20200925065418.1077472-1-ikjn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dma_alloc_coherent() for bounce buffer instead of kmalloc() to
make sure the bounce buffer to be allocated within its DMAable range.

Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

---

(no changes since v1)

 drivers/spi/spi-mtk-nor.c | 93 +++++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 42 deletions(-)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index e7719d249095..8dbafee7f431 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -100,6 +100,7 @@ struct mtk_nor {
 	struct device *dev;
 	void __iomem *base;
 	u8 *buffer;
+	dma_addr_t buffer_dma;
 	struct clk *spi_clk;
 	struct clk *ctlr_clk;
 	unsigned int spi_freq;
@@ -148,6 +149,11 @@ static void mtk_nor_set_addr(struct mtk_nor *sp, const struct spi_mem_op *op)
 	}
 }
 
+static bool need_bounce(struct mtk_nor *sp, const struct spi_mem_op *op)
+{
+	return ((uintptr_t)op->data.buf.in & MTK_NOR_DMA_ALIGN_MASK);
+}
+
 static bool mtk_nor_match_read(const struct spi_mem_op *op)
 {
 	int dummy = 0;
@@ -191,6 +197,7 @@ static bool mtk_nor_check_prg(const struct spi_mem_op *op)
 
 static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
+	struct mtk_nor *sp = spi_controller_get_devdata(mem->spi->master);
 	size_t len;
 
 	if (!op->data.nbytes)
@@ -202,8 +209,7 @@ static int mtk_nor_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 			if ((op->addr.val & MTK_NOR_DMA_ALIGN_MASK) ||
 			    (op->data.nbytes < MTK_NOR_DMA_ALIGN))
 				op->data.nbytes = 1;
-			else if (!((ulong)(op->data.buf.in) &
-				   MTK_NOR_DMA_ALIGN_MASK))
+			else if (!need_bounce(sp, op))
 				op->data.nbytes &= ~MTK_NOR_DMA_ALIGN_MASK;
 			else if (op->data.nbytes > MTK_NOR_BOUNCE_BUF_SIZE)
 				op->data.nbytes = MTK_NOR_BOUNCE_BUF_SIZE;
@@ -288,19 +294,12 @@ static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
 	mtk_nor_rmw(sp, MTK_NOR_REG_BUSCFG, reg, MTK_NOR_BUS_MODE_MASK);
 }
 
-static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
-			    u8 *buffer)
+static int mtk_nor_dma_exec(struct mtk_nor *sp, u32 from, unsigned int length,
+			    dma_addr_t dma_addr)
 {
 	int ret = 0;
 	ulong delay;
 	u32 reg;
-	dma_addr_t dma_addr;
-
-	dma_addr = dma_map_single(sp->dev, buffer, length, DMA_FROM_DEVICE);
-	if (dma_mapping_error(sp->dev, dma_addr)) {
-		dev_err(sp->dev, "failed to map dma buffer.\n");
-		return -EINVAL;
-	}
 
 	writel(from, sp->base + MTK_NOR_REG_DMA_FADR);
 	writel(dma_addr, sp->base + MTK_NOR_REG_DMA_DADR);
@@ -325,30 +324,49 @@ static int mtk_nor_read_dma(struct mtk_nor *sp, u32 from, unsigned int length,
 					 (delay + 1) * 100);
 	}
 
-	dma_unmap_single(sp->dev, dma_addr, length, DMA_FROM_DEVICE);
 	if (ret < 0)
 		dev_err(sp->dev, "dma read timeout.\n");
 
 	return ret;
 }
 
-static int mtk_nor_read_bounce(struct mtk_nor *sp, u32 from,
-			       unsigned int length, u8 *buffer)
+static int mtk_nor_read_bounce(struct mtk_nor *sp, const struct spi_mem_op *op)
 {
 	unsigned int rdlen;
 	int ret;
 
-	if (length & MTK_NOR_DMA_ALIGN_MASK)
-		rdlen = (length + MTK_NOR_DMA_ALIGN) & ~MTK_NOR_DMA_ALIGN_MASK;
+	if (op->data.nbytes & MTK_NOR_DMA_ALIGN_MASK)
+		rdlen = (op->data.nbytes + MTK_NOR_DMA_ALIGN) & ~MTK_NOR_DMA_ALIGN_MASK;
 	else
-		rdlen = length;
+		rdlen = op->data.nbytes;
 
-	ret = mtk_nor_read_dma(sp, from, rdlen, sp->buffer);
-	if (ret)
-		return ret;
+	ret = mtk_nor_dma_exec(sp, op->addr.val, rdlen, sp->buffer_dma);
 
-	memcpy(buffer, sp->buffer, length);
-	return 0;
+	if (!ret)
+		memcpy(op->data.buf.in, sp->buffer, op->data.nbytes);
+
+	return ret;
+}
+
+static int mtk_nor_read_dma(struct mtk_nor *sp, const struct spi_mem_op *op)
+{
+	int ret;
+	dma_addr_t dma_addr;
+
+	if (need_bounce(sp, op))
+		return mtk_nor_read_bounce(sp, op);
+
+	dma_addr = dma_map_single(sp->dev, op->data.buf.in,
+				  op->data.nbytes, DMA_FROM_DEVICE);
+
+	if (dma_mapping_error(sp->dev, dma_addr))
+		return -EINVAL;
+
+	ret = mtk_nor_dma_exec(sp, op->addr.val, op->data.nbytes, dma_addr);
+
+	dma_unmap_single(sp->dev, dma_addr, op->data.nbytes, DMA_FROM_DEVICE);
+
+	return ret;
 }
 
 static int mtk_nor_read_pio(struct mtk_nor *sp, const struct spi_mem_op *op)
@@ -452,15 +470,8 @@ static int mtk_nor_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		if (op->data.nbytes == 1) {
 			mtk_nor_set_addr(sp, op);
 			return mtk_nor_read_pio(sp, op);
-		} else if (((ulong)(op->data.buf.in) &
-			    MTK_NOR_DMA_ALIGN_MASK)) {
-			return mtk_nor_read_bounce(sp, op->addr.val,
-						   op->data.nbytes,
-						   op->data.buf.in);
 		} else {
-			return mtk_nor_read_dma(sp, op->addr.val,
-						op->data.nbytes,
-						op->data.buf.in);
+			return mtk_nor_read_dma(sp, op);
 		}
 	}
 
@@ -634,7 +645,6 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	struct spi_controller *ctlr;
 	struct mtk_nor *sp;
 	void __iomem *base;
-	u8 *buffer;
 	struct clk *spi_clk, *ctlr_clk;
 	int ret, irq;
 
@@ -650,16 +660,6 @@ static int mtk_nor_probe(struct platform_device *pdev)
 	if (IS_ERR(ctlr_clk))
 		return PTR_ERR(ctlr_clk);
 
-	buffer = devm_kmalloc(&pdev->dev,
-			      MTK_NOR_BOUNCE_BUF_SIZE + MTK_NOR_DMA_ALIGN,
-			      GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	if ((ulong)buffer & MTK_NOR_DMA_ALIGN_MASK)
-		buffer = (u8 *)(((ulong)buffer + MTK_NOR_DMA_ALIGN) &
-				~MTK_NOR_DMA_ALIGN_MASK);
-
 	ctlr = spi_alloc_master(&pdev->dev, sizeof(*sp));
 	if (!ctlr) {
 		dev_err(&pdev->dev, "failed to allocate spi controller\n");
@@ -679,13 +679,22 @@ static int mtk_nor_probe(struct platform_device *pdev)
 
 	sp = spi_controller_get_devdata(ctlr);
 	sp->base = base;
-	sp->buffer = buffer;
 	sp->has_irq = false;
 	sp->wbuf_en = false;
 	sp->ctlr = ctlr;
 	sp->dev = &pdev->dev;
 	sp->spi_clk = spi_clk;
 	sp->ctlr_clk = ctlr_clk;
+	sp->buffer = dmam_alloc_coherent(&pdev->dev,
+				MTK_NOR_BOUNCE_BUF_SIZE + MTK_NOR_DMA_ALIGN,
+				&sp->buffer_dma, GFP_KERNEL);
+	if (!sp->buffer)
+		return -ENOMEM;
+
+	if ((uintptr_t)sp->buffer & MTK_NOR_DMA_ALIGN_MASK) {
+		dev_err(sp->dev, "misaligned allocation of internal buffer.\n");
+		return -ENOMEM;
+	}
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq < 0) {
-- 
2.28.0.681.g6f77f65b4e-goog

