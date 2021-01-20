Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742B32FCCAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 09:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbhATIZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 03:25:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:10949 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbhATIVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 03:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611130876; x=1642666876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VNLrzjgoabE8/kewp0resFlpEskWy7DNy5ntsw+R3ns=;
  b=C+bMEw3KE+TeS8GObf02kFYdQNzqVFVoymTZCzcBFsu4k/9z9WTyN1d9
   exwy4P1FpgNizmU/LOtS/HO7QprfxAojQoWlwqgIeErL3gH9qMPiz1UOQ
   GBQ5PCp+GXCvqOLnb0UbmqqfKAKtVZ/vLc5pUdG67NOuEEp1lcBTLpZPH
   tZoGJc2yGvQs8GTFojd9vsFWBA49u2mp44fSXf9lf04XF3YU1ZAuXG1vu
   lEcQBy7lGrvaAI/w3x6M73bdbaxr9lIFZjvi3gzMZilRY4uYdQmU3+MzM
   VmS1JhsKwle7PWAD7NoD89dngWb6xNTJpU8mc/NDBSSdH0I01D1gjAh6j
   Q==;
IronPort-SDR: ej0lc+9QZlL8fcZ2/QYpWfNXzGIXe3o0KeV7cJMDx7ASJ9xUVYIYPSni6FXDx5hHyrCYNlrfGB
 FKZrLjK7axkgUbwLJz41hCislhGUV8XsgPTpePbbhJ6DbbgECkTgauxxs1LkliM53oqjaHa/Z5
 OE1hJrZ0SojkPXhtyb1Z1hLHrJbUZENR9uloFiJrvo0wYDo11aMky1EvXF+v17mMNN+R1YpBBp
 xnON19sKb9NYjau9YRTcLp0VhDPkc1DseaOaTrqevfIONlFhLKdI+GLRW+dHEIC30aoxHbAgrg
 n8A=
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="106072383"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 01:19:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 01:19:35 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 20 Jan 2021 01:19:33 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v4 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Wed, 20 Jan 2021 09:19:21 +0100
Message-ID: <20210120081921.3315847-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120081921.3315847-1-steen.hegelund@microchip.com>
References: <20210120081921.3315847-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This provides reset driver support for the Microchip Sparx5 PCB134 and
PCB135 reference boards.

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 380281f312d8..4edbb9fcdce0 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -132,9 +132,17 @@ mux: mux-controller {
 			};
 		};
 
-		reset@611010008 {
-			compatible = "microchip,sparx5-chip-reset";
-			reg = <0x6 0x11010008 0x4>;
+		gcb_ctrl: syscon@611010000 {
+			compatible = "microchip,sparx5-gcb-syscon", "syscon";
+			reg = <0x6 0x11010000 0x10000>;
+		};
+
+		reset: reset-controller@0 {
+			compatible = "microchip,sparx5-switch-reset";
+			reg = <0x6 0x0 0x0>;
+			#reset-cells = <1>;
+			cpu-syscon = <&cpu_ctrl>;
+			gcb-syscon = <&gcb_ctrl>;
 		};
 
 		uart0: serial@600100000 {
-- 
2.29.2

