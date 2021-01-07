Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804BF2ECE6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 12:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbhAGLIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 06:08:14 -0500
Received: from server.20disenoweb.com ([185.195.98.159]:55272 "EHLO
        server.20disenoweb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbhAGLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 06:08:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by server.20disenoweb.com (Postfix) with ESMTP id 4354FF41;
        Thu,  7 Jan 2021 11:59:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at server.20disenoweb.com
Received: from server.20disenoweb.com ([127.0.0.1])
        by localhost (server.20disenoweb.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u6AQ4YWnmmaP; Thu,  7 Jan 2021 11:59:56 +0100 (CET)
Received: from localhost.localdomain (105.red-95-125-237.dynamicip.rima-tde.net [95.125.237.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sergiosota@fanamoel.com)
        by server.20disenoweb.com (Postfix) with ESMTPSA id 566F4E74;
        Thu,  7 Jan 2021 11:59:39 +0100 (CET)
From:   Sergio Sota <sergiosota@fanamoel.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sergio Sota <sergiosota@fanamoel.com>
Subject: [PATCH] ARM: dts: sun5i: add A10s/A13 display frontend support fallback
Date:   Thu,  7 Jan 2021 11:59:27 +0100
Message-Id: <20210107105927.2815198-1-sergiosota@fanamoel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A10s/A13 display frontend driver is not implemented
Set A10 display frontend driver as a fallback for A10s/A13
Tested with Olimex-A13-SOM / Olimex-A13-OlinuXino-MICRO
"modetest -M sun4i-drm -s 49@47:800x480-60"  ( 7.0" tft lcd)
"modetest -M sun4i-drm -s 49@47:1024x600-60" (10.1" tft lcd)

Signed-off-by: Sergio Sota <sergiosota@fanamoel.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index c2b4fbf552a3..4ef14a8695ef 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -734,7 +734,8 @@ timer@1c60000 {
 		};
 
 		fe0: display-frontend@1e00000 {
-			compatible = "allwinner,sun5i-a13-display-frontend";
+			compatible = "allwinner,sun5i-a13-display-frontend",
+				     "allwinner,sun4i-a10-display-frontend";
 			reg = <0x01e00000 0x20000>;
 			interrupts = <47>;
 			clocks = <&ccu CLK_DE_FE>, <&ccu CLK_DE_FE>,
-- 
2.25.1

