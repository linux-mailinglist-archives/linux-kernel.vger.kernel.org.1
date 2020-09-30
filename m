Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD21F27EB88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbgI3O5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:57:05 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33857 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgI3O5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:57:05 -0400
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5503010000D;
        Wed, 30 Sep 2020 14:57:02 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: aT91: remove legacy DMA left overs
Date:   Wed, 30 Sep 2020 16:56:54 +0200
Message-Id: <20200930145655.3044490-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit dc6df6e90de9 ("i2c: at91: remove legacy DMA support") removed legcy
DMA support from the driver. Remove the last use of the definitions from
linux/platform_data/dma-atmel.h and stop including this header.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/i2c/busses/i2c-at91-master.c | 1 -
 drivers/i2c/busses/i2c-at91.h        | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index 66864f9cf7ac..1cceb6866689 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -26,7 +26,6 @@
 #include <linux/of_device.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/dma-atmel.h>
 #include <linux/pm_runtime.h>
 
 #include "i2c-at91.h"
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index eae673ae786c..942e9c3973bb 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -18,7 +18,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/i2c.h>
-#include <linux/platform_data/dma-atmel.h>
 #include <linux/platform_device.h>
 
 #define AT91_I2C_TIMEOUT	msecs_to_jiffies(100)	/* transfer timeout */
@@ -123,7 +122,6 @@ struct at91_twi_pdata {
 	bool has_adv_dig_filtr;
 	bool has_ana_filtr;
 	bool has_clear_cmd;
-	struct at_dma_slave dma_slave;
 };
 
 struct at91_twi_dma {
-- 
2.26.2

