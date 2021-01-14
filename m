Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7993F2F65EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbhANQ0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:26:20 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:5560 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbhANQ0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:26:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610641580; x=1642177580;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FV0mNZSYHoDJ0ZsgJsY6Yx9jZI1zRcVnreXiCKznxwY=;
  b=M1ijNwMRjt+4SWLp9a9r092tAgs8bVUcLl5wB4cPR9eWHMAu2sxvf990
   d8Z8fG4/BuueXyEt/k8oK2iZqxzkt9kRFlCh4eH17yDN4GLKV4SOZjeS5
   gqLFDB1Vmrez0jxxotZ/kmPaFrK1Ak63YzX3QIuQMNo0rv+2ROCKtgSOV
   OVpbpXoiZ8ONnGp/WVk1VW2vrcpWJa2UM6c0MrMg4JRFBip7QfMlmww53
   /is4ntcqgxyA1o+QHFu93GibZym0CcYngBz8ZUv8gkWvrmYooLagXdXMm
   c9rk4kDQLqMOzdTFw32Jp5EBaj1SG5gz7MUCDAvI/3X7rrKs3v8LzcozY
   Q==;
IronPort-SDR: xQTm7zNlEeiJTYopBGTSLlw/2JE8UcGbX+7O6le+GXugSrQf3MbSFQAjOz5qnfP0dyVS/ZIo5S
 TQ62WfwzBALdQpQzR7srGb6AHzU6Yv0DJueVjSxxAwdGvFP/cYPfhplu2AyqiYU8uYGeR3WUH3
 2eJjeW6BsDPp2RGoFAqI6iZPIIcaP4DKx+O3eV+6VEyg5o1gt8+iqHvhWMAL6n1GAdyR9dL+AQ
 KSgdadNTDZH3fwDkPNLSxLuG8rCtS7s8dCPpvfAYV97kkv+JMUbIg0yhTTcY+kFuHntmSr7jmv
 W7I=
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; 
   d="scan'208";a="105447456"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 09:24:47 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 09:24:45 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 09:24:43 -0700
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
Subject: [PATCH v3 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Thu, 14 Jan 2021 17:24:32 +0100
Message-ID: <20210114162432.3039657-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210114162432.3039657-1-steen.hegelund@microchip.com>
References: <20210114162432.3039657-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

