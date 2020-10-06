Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C3D284BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 14:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgJFMpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 08:45:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgJFMpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 08:45:15 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C5F0206F7;
        Tue,  6 Oct 2020 12:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601988314;
        bh=jQA9qf0zTXfGZnsRtTNqxf5HKnAXpEcc7RqoVbJW6bI=;
        h=From:To:Cc:Subject:Date:From;
        b=cYraoB7Ay9Spg6fd89ju1rqWG7xiW2NHArMm31qUx5EPDv0MmsMh5rXiDka3MokRA
         95JmZ7W08zOUOlAvVd5Ge+/MQlJtHv02LHeYj+iB43IcrkG5DWUtqSTt78F8Rliq0f
         KOV/D2O0diPvyyKZUerUEwh+zezTfzSvGcxJZKqY=
Received: by pali.im (Postfix)
        id E5C14891; Tue,  6 Oct 2020 14:45:11 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andre Heider <a.heider@gmail.com>,
        =?UTF-8?q?G=C3=A9rald=20Kerma?= <gerald@gk2.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: espressobin: Add support for LED2
Date:   Tue,  6 Oct 2020 14:44:55 +0200
Message-Id: <20201006124455.16617-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LED2 is connected to MPP1_2 pin. It is working only on V7 boards.
V5 boards have hw bug which cause that LED2 is non-working.

So enable LED2 only for Espressobin V7 boards.

Note that LED1 is connected to LED_WLAN# pin on miniPCIe card and LED3 to
power supply. Therefore on Espressobin board only LED2 can be controlled
directly from the host. LED1 is possible to control via WiFi card inserted
in miniPCIe slot if driver for particular card supports it.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Gérald Kerma <gerald@gk2.net>

---

Previous version of this patch was sent by Uwe in March 2018, but it did
not work on any tested V5 board. Now we know it was due to V5 HW bug.

https://lore.kernel.org/linux-arm-kernel/20180321105005.18426-3-u.kleine-koenig@pengutronix.de/
---
 .../dts/marvell/armada-3720-espressobin-v7-emmc.dts |  4 ++++
 .../boot/dts/marvell/armada-3720-espressobin-v7.dts |  4 ++++
 .../boot/dts/marvell/armada-3720-espressobin.dtsi   | 13 +++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
index 4775a7eda481..75401eab4d42 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
@@ -39,3 +39,7 @@
 &sdhci0 {
 	status = "okay";
 };
+
+&led2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
index c47a93978386..48a7f50fb427 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
@@ -34,3 +34,7 @@
 &switch0port3 {
 	label = "wan";
 };
+
+&led2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 8a1c678bea5f..daffe136c523 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -41,6 +41,19 @@
 			  3300000 0x0>;
 		enable-active-high;
 	};
+
+	led2: gpio-led2 {
+		/* led2 is working only on v7 board */
+		status = "disabled";
+
+		compatible = "gpio-leds";
+
+		led2 {
+			label = "led2";
+			gpios = <&gpionb 2 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
 };
 
 /* J9 */
-- 
2.20.1

