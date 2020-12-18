Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3998F2DE118
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbgLRKd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:33:26 -0500
Received: from comms.puri.sm ([159.203.221.185]:50092 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389120AbgLRKdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:33:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 55236E0090;
        Fri, 18 Dec 2020 02:32:45 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qbtwxkq7rE4L; Fri, 18 Dec 2020 02:32:44 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 4/4] arm64: dts: imx8mq-librem5-r3: workaround i2c1 issue with 1GHz cpu voltage
Date:   Fri, 18 Dec 2020 11:31:31 +0100
Message-Id: <20201218103131.22013-5-martin.kepplinger@puri.sm>
In-Reply-To: <20201218103131.22013-1-martin.kepplinger@puri.sm>
References: <20201218103131.22013-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a workaround for a hardware bug in the r3 revision that basically would
stop the system due to traffic on the i2c1 bus. A cpu voltage change would
trigger such traffic and that's what is avoided in order to work around it.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
index 6704ea2c72a3..0d38327043f8 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dts
@@ -10,6 +10,12 @@
 	compatible = "purism,librem5r3", "purism,librem5", "fsl,imx8mq";
 };
 
+&a53_opp_table {
+	opp-1000000000 {
+		opp-microvolt = <1000000>;
+	};
+};
+
 &accel_gyro {
 	mount-matrix =  "1",  "0",  "0",
 			"0",  "1",  "0",
-- 
2.20.1

