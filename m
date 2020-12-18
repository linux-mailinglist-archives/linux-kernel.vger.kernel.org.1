Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1C2DE6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 16:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgLRPoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 10:44:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:43184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbgLRPoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 10:44:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4C86AADE1;
        Fri, 18 Dec 2020 15:43:38 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, tim.gover@raspberrypi.com,
        phil@raspberrypi.com
Subject: [PATCH v2 3/5] ARM: dts: bcm2711: Add reserved memory template to hold firmware configuration
Date:   Fri, 18 Dec 2020 16:43:18 +0100
Message-Id: <20201218154320.28368-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201218154320.28368-1-nsaenzjulienne@suse.de>
References: <20201218154320.28368-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPi4's co-processor will copy the board's bootloader[1] configuration
into memory for the OS to consume. Specifically, for the bootloader
configuration and upgrade user-space routines to query it through
nvmem's sysfs interface.

Introduce a reserved-memory area template for the co-processor to edit
before booting the system so as for Linux not to overwrite that memory
and to expose it as an nvmem device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

[1] https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_bootloader_config.md
---

Changes since v1:
 - Introduce compatible string
 - Change alias name to something more explicit

 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index 403bacf986eb..3b4ab947492a 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -25,6 +25,7 @@ aliases {
 		emmc2bus = &emmc2bus;
 		ethernet0 = &genet;
 		pcie0 = &pcie0;
+		blconfig = &blconfig;
 	};
 
 	leds {
@@ -218,6 +219,22 @@ &pwm1 {
 	status = "okay";
 };
 
+&rmem {
+	/*
+	 * RPi4's co-processor will copy the board's bootloader configuration
+	 * into memory for the OS to consume. It'll also update this node with
+	 * its placement information.
+	 */
+	blconfig: nvram@0 {
+		compatible = "raspberrypi,bootloader-config", "nvmem-rmem";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0x0 0x0 0x0>;
+		no-map;
+		status = "disabled";
+	};
+};
+
 /* SDHCI is used to control the SDIO for wireless */
 &sdhci {
 	#address-cells = <1>;
-- 
2.29.2

