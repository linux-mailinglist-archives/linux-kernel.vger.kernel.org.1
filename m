Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287CE2F2BDB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392815AbhALJxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:53:49 -0500
Received: from comms.puri.sm ([159.203.221.185]:34620 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732824AbhALJxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:53:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 825F6DFDF5;
        Tue, 12 Jan 2021 01:53:07 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zJfNdeBxeYlV; Tue, 12 Jan 2021 01:53:06 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 3/9] arm64: dts: imx8mq-librem5: Don't mark buck3 as always on
Date:   Tue, 12 Jan 2021 10:51:45 +0100
Message-Id: <20210112095151.4995-4-martin.kepplinger@puri.sm>
In-Reply-To: <20210112095151.4995-1-martin.kepplinger@puri.sm>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

With the pmic driver fixed we can now shut off the regulator in the gpc.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 9928e941ee21..95d710831f28 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -679,7 +679,6 @@
 				regulator-min-microvolt = <700000>;
 				regulator-max-microvolt = <1300000>;
 				rohm,dvs-run-voltage = <900000>;
-				regulator-always-on;
 			};
 
 			buck4_reg: BUCK4 {
-- 
2.20.1

