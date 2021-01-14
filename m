Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B6B2F5D60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 10:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbhANJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 04:26:49 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:52608 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbhANJ0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 04:26:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610616395; x=1642152395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iidB/SH6YvMVxsRVtLw+6IrKQ/PkSr13r9FBSRtqThk=;
  b=PwkUf/PknZ/ml1PvP8HXVple/KG3DRQ6CPWz5EdNIWcw/FAU59ZwSvDx
   OO8Kg+gYjQoM6LuFzyORy6tuhdjB40hdchJn5N10WDc7yc6ONZjPCH07Q
   9Gx1Gag3/fh+0uN3bT0mLHwY8VrMc9p+BqpUc2ml3UZ6Wwl4ybJEFcgzp
   9uOSN4aTwzXE6+Y14e4+2/pG+/eFR1IoQ39UCUote15MZnvTmziwseRk4
   9lUmx5hI3GS4mW3FrrJwSSQlxg1///tsffOe5r3TKU0NklxcpreE3tyI+
   TTvg4w0KdNAHPLPY238jVaSM5xmT0d5HDjTzcrYbEH0Evb9tRHHuIDStD
   w==;
IronPort-SDR: QnQUa8puhJcFBU1qQIRUrIuUE6S0onuN3kORZrd3pqkL3f5JiV41KtW0Ki4cKbt78efpeR2vij
 5oZf/l42UY+8Vl0/2bqKKZ+sntYs5crCk7BEiQNjH0gK1AbstGGZDLITnkPykYZshVvVCvubO5
 jH12IHwwRJQ4VjQJZZfh2EqjHex+jqjRdz66T4z+rIW9Vk00+RdIexW8EWNyaA+SPrXH/fBJ/7
 ngEkB+bz2n+ziwiwb5w+a2/a1Z6vRY/O6xTkapHhvT9oAXvo9V53lnx9Aa0pVZJFm23iirtAsY
 36Y=
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="111014978"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 02:25:20 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 02:25:19 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 02:25:17 -0700
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
Subject: [PATCH v2 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Thu, 14 Jan 2021 10:25:00 +0100
Message-ID: <20210114092500.2822208-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114092500.2822208-1-steen.hegelund@microchip.com>
References: <20210114092500.2822208-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 380281f312d8..6f0a21c362e3 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -132,9 +132,16 @@ mux: mux-controller {
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
+			syscons = <&cpu_ctrl>,<&gcb_ctrl>;
 		};
 
 		uart0: serial@600100000 {
-- 
2.29.2

