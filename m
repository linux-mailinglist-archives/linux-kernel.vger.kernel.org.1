Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1C52E66A0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731747AbgL1NS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 08:18:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbgL1NSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 08:18:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1441222582;
        Mon, 28 Dec 2020 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609161463;
        bh=S2Gm+2LduLGDibjztpCREUCr1DEBjI0No2m5GcTBuhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e/UTUGrMmwXDMWRVBSuQTdN0ud14m/8ULIwWXi34kibMyZove3yiFhQCvrIusJUMK
         ssJ32YQde75fjTAeDs1kpwHgmLqID4H67Um4odtbdKX1O9pk0BOHOqnMwsPFtE22Cj
         ccn0Ay03G6lVWlrlKp28wi9oDxFJGO+4+g8jxZPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 221/242] spi: davinci: Fix use-after-free on unbind
Date:   Mon, 28 Dec 2020 13:50:26 +0100
Message-Id: <20201228124915.546348145@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228124904.654293249@linuxfoundation.org>
References: <20201228124904.654293249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit 373afef350a93519b4b8d636b0895da8650b714b upstream.

davinci_spi_remove() accesses the driver's private data after it's been
freed with spi_master_put().

Fix by moving the spi_master_put() to the end of the function.

Fixes: fe5fd2540947 ("spi: davinci: Use dma_request_chan() for requesting DMA channel")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: <stable@vger.kernel.org> # v4.7+
Link: https://lore.kernel.org/r/412f7eb1cf8990e0a3a2153f4c577298deab623e.1607286887.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-davinci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -1085,13 +1085,13 @@ static int davinci_spi_remove(struct pla
 	spi_bitbang_stop(&dspi->bitbang);
 
 	clk_disable_unprepare(dspi->clk);
-	spi_master_put(master);
 
 	if (dspi->dma_rx) {
 		dma_release_channel(dspi->dma_rx);
 		dma_release_channel(dspi->dma_tx);
 	}
 
+	spi_master_put(master);
 	return 0;
 }
 


