Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2B892E0C8B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgLVPO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:14:59 -0500
Received: from comms.puri.sm ([159.203.221.185]:54882 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727499AbgLVPO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:14:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 4D616DF318;
        Tue, 22 Dec 2020 07:14:18 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6fDrWgpGall8; Tue, 22 Dec 2020 07:14:17 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 4/4] arm64: dts: imx8mq-librem5-r3: workaround i2c1 issue with 1GHz cpu voltage
Date:   Tue, 22 Dec 2020 16:13:47 +0100
Message-Id: <20201222151347.7886-5-martin.kepplinger@puri.sm>
In-Reply-To: <20201222151347.7886-1-martin.kepplinger@puri.sm>
References: <20201222151347.7886-1-martin.kepplinger@puri.sm>
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

