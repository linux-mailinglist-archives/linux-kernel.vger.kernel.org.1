Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36F812EF0C7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 11:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbhAHKjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 05:39:32 -0500
Received: from server.20disenoweb.com ([185.195.98.159]:57122 "EHLO
        server.20disenoweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbhAHKjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 05:39:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by server.20disenoweb.com (Postfix) with ESMTP id 5FD67F60;
        Fri,  8 Jan 2021 11:38:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at server.20disenoweb.com
Received: from server.20disenoweb.com ([127.0.0.1])
        by localhost (server.20disenoweb.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0fNMQ4-cCF3b; Fri,  8 Jan 2021 11:38:48 +0100 (CET)
Received: from localhost.localdomain (195.red-95-124-155.dynamicip.rima-tde.net [95.124.155.195])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sergiosota@fanamoel.com)
        by server.20disenoweb.com (Postfix) with ESMTPSA id 2E4D2F5E;
        Fri,  8 Jan 2021 11:38:31 +0100 (CET)
From:   Sergio Sota <sergiosota@fanamoel.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergio Sota <sergiosota@fanamoel.com>
Subject: [PATCH v2] ARM: dts: sun5i: add A10s/A13 mali gpu support fallback
Date:   Fri,  8 Jan 2021 11:38:19 +0100
Message-Id: <20210108103819.322901-1-sergiosota@fanamoel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A10s/A13 mali gpu was not defined in device tree
Add A10 mali gpu as a fallback for A10s/A13
Tested with Olimex-A13-SOM / Olimex-A13-OlinuXino-MICRO
"kmscube" 3d cube on screen (60fps / 10%cpu)
Versions: Lima:1.1.0 EGL:1.4 OpenGLES:2.0 Mesa:20.2.2

Signed-off-by: Sergio Sota <sergiosota@fanamoel.com>
---
Changes in v2:
 - Add testing versions to changelog

 arch/arm/boot/dts/sun5i.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index 4ef14a8695ef..b4d46ecdf7ad 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -726,6 +726,18 @@ i2c2: i2c@1c2b400 {
 			#size-cells = <0>;
 		};
 
+		mali: gpu@1c40000 {
+			compatible = "allwinner,sun4i-a10-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <69>, <70>, <71>, <72>,  <73>;
+			interrupt-names = "gp", "gpmmu", "pp0", "ppmmu0", "pmu";
+			clocks = <&ccu CLK_AHB_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_GPU>;
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <320000000>;
+		};
+
 		timer@1c60000 {
 			compatible = "allwinner,sun5i-a13-hstimer";
 			reg = <0x01c60000 0x1000>;
-- 
2.25.1

