Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74422688B2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgINJmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgINJmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:42:49 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D89C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:42:48 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id Tlik230094C55Sk01likE5; Mon, 14 Sep 2020 11:42:44 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kHl0W-0005Hb-F0; Mon, 14 Sep 2020 11:42:44 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kHl0W-00011p-CH; Mon, 14 Sep 2020 11:42:44 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mmc: mmc_spi: Fix mmc_spi_dma_alloc() return type for !HAS_DMA
Date:   Mon, 14 Sep 2020 11:42:43 +0200
Message-Id: <20200914094243.3912-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_NO_DMA=y (e.g. Sun-3 allmodconfig):

    drivers/mmc/host/mmc_spi.c:1323:15: warning: return type defaults to ‘int’ [-Wreturn-type]
     static inline mmc_spi_dma_alloc(struct mmc_spi_host *host) { return 0; }
		   ^~~~~~~~~~~~~~~~~

Fix this by adding the missing return type.

Fixes: a395acf0f6dc6409 ("mmc: mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is unset")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/mmc/host/mmc_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 5055a7eb134ac13f..18a850f37ddce27e 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1320,7 +1320,7 @@ static void mmc_spi_dma_free(struct mmc_spi_host *host)
 			 DMA_BIDIRECTIONAL);
 }
 #else
-static inline mmc_spi_dma_alloc(struct mmc_spi_host *host) { return 0; }
+static inline int mmc_spi_dma_alloc(struct mmc_spi_host *host) { return 0; }
 static inline void mmc_spi_dma_free(struct mmc_spi_host *host) {}
 #endif
 
-- 
2.17.1

