Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACC32C44C7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbgKYQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbgKYQTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:19:03 -0500
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271A0C061A4F;
        Wed, 25 Nov 2020 08:19:03 -0800 (PST)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Ch5g84xGBz1rwvF;
        Wed, 25 Nov 2020 17:19:00 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Ch5g83rjVz1r0hQ;
        Wed, 25 Nov 2020 17:19:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id aNsQWL9L1B15; Wed, 25 Nov 2020 17:18:59 +0100 (CET)
X-Auth-Info: s7N8zCrkmvosxEotESk8L7E1ZgrPdis9ar1xXqwCZZw=
Received: from localhost.localdomain (89-64-5-98.dynamic.chello.pl [89.64.5.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 25 Nov 2020 17:18:59 +0100 (CET)
From:   Lukasz Majewski <lukma@denx.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Mans Rullgard <mans@mansr.com>
Subject: [PATCH 2/3] ARM: dts: imx28: add pinmux for USB1 overcurrent on pwm2
Date:   Wed, 25 Nov 2020 17:18:14 +0100
Message-Id: <20201125161815.2361-2-lukma@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201125161815.2361-1-lukma@denx.de>
References: <20201125161815.2361-1-lukma@denx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mans Rullgard <mans@mansr.com>

Add pinmux setting for USB1 overcurrent on pwm2 pad.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/boot/dts/imx28.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 6e7531b64bf7..6d24546f0abe 100644
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

