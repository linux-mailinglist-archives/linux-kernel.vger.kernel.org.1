Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9795527F192
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgI3SsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:48:21 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:49525 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgI3SsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:48:19 -0400
X-Originating-IP: 90.65.88.165
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr [90.65.88.165])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DF8F2240007;
        Wed, 30 Sep 2020 18:48:15 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] pcmcia: at91_cf: move definitions locally
Date:   Wed, 30 Sep 2020 20:48:02 +0200
Message-Id: <20200930184804.3127757-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: yes
X-Spam-Level: **************************
X-GND-Spam-Score: 400
X-GND-Status: SPAM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct at91_cf_data is only used in the driver since all the platforms moved
to device tree, move its definition locally.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/pcmcia/at91_cf.c            | 11 +++++++++++
 include/linux/platform_data/atmel.h | 12 ------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
index 7db0e9c74dfc..1d59c7240a09 100644
--- a/drivers/pcmcia/at91_cf.c
+++ b/drivers/pcmcia/at91_cf.c
@@ -35,6 +35,17 @@
 #define	CF_IO_PHYS	(1 << 23)
 #define	CF_MEM_PHYS	(0x017ff800)
 
+struct at91_cf_data {
+	int	irq_pin;		/* I/O IRQ */
+	int	det_pin;		/* Card detect */
+	int	vcc_pin;		/* power switching */
+	int	rst_pin;		/* card reset */
+	u8	chipselect;		/* EBI Chip Select number */
+	u8	flags;
+#define AT91_CF_TRUE_IDE	0x01
+#define AT91_IDE_SWAP_A0_A2	0x02
+};
+
 struct regmap *mc;
 
 /*--------------------------------------------------------------------------*/
diff --git a/include/linux/platform_data/atmel.h b/include/linux/platform_data/atmel.h
index 99e6069c5fd8..73f63be509c4 100644
--- a/include/linux/platform_data/atmel.h
+++ b/include/linux/platform_data/atmel.h
@@ -6,18 +6,6 @@
 #ifndef __ATMEL_H__
 #define __ATMEL_H__
 
- /* Compact Flash */
-struct at91_cf_data {
-	int	irq_pin;		/* I/O IRQ */
-	int	det_pin;		/* Card detect */
-	int	vcc_pin;		/* power switching */
-	int	rst_pin;		/* card reset */
-	u8	chipselect;		/* EBI Chip Select number */
-	u8	flags;
-#define AT91_CF_TRUE_IDE	0x01
-#define AT91_IDE_SWAP_A0_A2	0x02
-};
-
 /* FIXME: this needs a better location, but gets stuff building again */
 #ifdef CONFIG_ATMEL_PM
 extern int at91_suspend_entering_slow_clock(void);
-- 
2.26.2

