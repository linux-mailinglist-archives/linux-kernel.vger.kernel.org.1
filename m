Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23C42D4D5A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388606AbgLIWLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:11:08 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:49506 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388338AbgLIWLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:11:07 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Crrnh14rGz1qs0j;
        Wed,  9 Dec 2020 23:10:00 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Crrnh014pz1qy6P;
        Wed,  9 Dec 2020 23:09:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 71vQKepPl3AN; Wed,  9 Dec 2020 23:09:58 +0100 (CET)
X-Auth-Info: R4odLXJlFmOWfIxE8bkmUpJu6bfcjzVB0W9OybxRqrY=
Received: from localhost.localdomain (89-64-25-12.dynamic.chello.pl [89.64.25.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed,  9 Dec 2020 23:09:58 +0100 (CET)
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mans Rullgard <mans@mansr.com>,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2] ARM: dts: imx28: add pinmux for USB1 overcurrent on pwm2
Date:   Wed,  9 Dec 2020 23:09:03 +0100
Message-Id: <20201209220903.27058-1-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

Add pinmux setting for USB1 overcurrent on pwm2 pad.

Signed-off-by: Mans Rullgard <mans@mansr.com>
Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Add S-o-B
---
 arch/arm/boot/dts/imx28.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index bbe52150b165..84d0176d5193 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -948,6 +948,16 @@
 					fsl,pull-up = <MXS_PULL_DISABLE>;
 				};
 
+				usb1_pins_b: usb1@1 {
+					reg = <1>;
+					fsl,pinmux-ids = <
+						MX28_PAD_PWM2__USB1_OVERCURRENT
+					>;
+					fsl,drive-strength = <MXS_DRIVE_12mA>;
+					fsl,voltage = <MXS_VOLTAGE_HIGH>;
+					fsl,pull-up = <MXS_PULL_DISABLE>;
+				};
+
 				usb0_id_pins_a: usb0id@0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
-- 
2.20.1

