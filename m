Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A6E2DB0D5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 17:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbgLOQC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 11:02:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:60924 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730664AbgLOP50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 10:57:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C1D3AEC4;
        Tue, 15 Dec 2020 15:56:44 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     srinivas.kandagatla@linaro.org,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        catalin.marinas@arm.com, will@kernel.org,
        tim.gover@raspberrypi.com, phil@raspberrypi.com
Subject: [PATCH 4/6] ARM: dts: bcm2711: Expose boot-loader configuration
Date:   Tue, 15 Dec 2020 16:56:24 +0100
Message-Id: <20201215155627.2513-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215155627.2513-1-nsaenzjulienne@suse.de>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RPi4's co-processor will copy the board's bootloader configuration in
memory. Expose it to user-space by using 'nvmem-rmem'.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
index c58e58e8ce39..261169eb5e3b 100644
--- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
+++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
@@ -26,6 +26,17 @@ aliases {
 		ethernet0 = &genet;
 		pcie0 = &pcie0;
 		eeprom = &eeprom;
+		fw_config = &fw_config;
+	};
+
+	fw_config: fw-config {
+		compatible = "nvmem-rmem";
+		memory-region = <&eeprom>;
+		/*
+		 * Will be enabled by the bootloader if the reserved memory
+		 * region is valid.
+		 */
+		status = "disabled";
 	};
 
 	leds {
-- 
2.29.2

