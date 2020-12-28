Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EC02E6B61
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgL1W4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:04 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:62613 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729450AbgL1UrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 15:47:04 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 167D240006;
        Mon, 28 Dec 2020 20:46:22 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] ARM: configs: multi_{v5,v7}: remove ATMEL_TCLIB
Date:   Mon, 28 Dec 2020 21:46:20 +0100
Message-Id: <20201228204620.2678264-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228204620.2678264-1-alexandre.belloni@bootlin.com>
References: <20201228204620.2678264-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver is gone, stop selecting it

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 arch/arm/configs/multi_v5_defconfig | 1 -
 arch/arm/configs/multi_v7_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index e00be9faa23b..81c45d1baba6 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -105,7 +105,6 @@ CONFIG_MTD_SPI_NOR=y
 CONFIG_SPI_ASPEED_SMC=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ATMEL_SSC=m
 CONFIG_EEPROM_AT24=y
 # CONFIG_SCSI_PROC_FS is not set
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c5f25710fedc..6492a3601e7c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -223,7 +223,6 @@ CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_VIRTIO_BLK=y
 CONFIG_AD525X_DPOT=y
 CONFIG_AD525X_DPOT_I2C=y
-CONFIG_ATMEL_TCLIB=y
 CONFIG_ICS932S401=y
 CONFIG_ATMEL_SSC=m
 CONFIG_QCOM_COINCELL=m
-- 
2.29.2

