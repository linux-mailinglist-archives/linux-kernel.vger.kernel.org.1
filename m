Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1252F2BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392828AbhALJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:53:53 -0500
Received: from comms.puri.sm ([159.203.221.185]:34640 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388077AbhALJxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:53:51 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 9C1CEDFDFE;
        Tue, 12 Jan 2021 01:53:11 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WOYYpi_xYtu5; Tue, 12 Jan 2021 01:53:10 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 4/9] arm64: dts: imx8mq-librem5: Add usb-c chip as supplier for the charger
Date:   Tue, 12 Jan 2021 10:51:46 +0100
Message-Id: <20210112095151.4995-5-martin.kepplinger@puri.sm>
In-Reply-To: <20210112095151.4995-1-martin.kepplinger@puri.sm>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

The tps65982 feeds the bq25895 charge controller on the Librem 5.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 95d710831f28..d7d807cd72b3 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -928,6 +928,7 @@
 		ti,use-vinmin-threshold = <1>; /* enable VINDPM */
 		ti,vinmin-threshold = <3900000>; /* uV */
 		monitored-battery = <&bat>;
+		power-supplies = <&typec_pd>;
 	};
 };
 
-- 
2.20.1

