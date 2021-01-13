Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6D72F5404
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 21:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbhAMUVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 15:21:09 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:26935 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbhAMUVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 15:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610569269; x=1642105269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iidB/SH6YvMVxsRVtLw+6IrKQ/PkSr13r9FBSRtqThk=;
  b=gMTtX85EHkukVNMWERLkgd2RLB0TXn+G+T2mhTyTIHleDHrmt0YoYUbi
   RH3hYy+yoH8On9KAw0CDcHzFruARvGEnIJnkky1ZwDaNvtzaQsWN1YGeF
   TwP2CovVjz5bPQSAwbRTiYPEtVEY9N3F9nd/q/qz/XGxXuXnXcVtN4Wbb
   X0z9KACx9hlZmDoBJB0nGN7ob33AYBEEOzY8WfJ1tmiUUjc+cjtvcSGM7
   S0LE9fjbmzGIsgq1zHNbgm1eLhZsRqduBT2OrqHm7Iyn81XX/zPFenYLx
   V2saJSU/AWTWUXcTs7jbIwoUJDClrXrz52H5ibMQs1s8MyPdhLWGw2RK3
   w==;
IronPort-SDR: se4KIWRlK6R8G9HokD2o13mfrgxpEJhmpqV1JrHIOeW4YAFlGv8wsIOfXRrv8ngXME3kpE+rvw
 gseVaBICIACVrWEkV5NAVLjg+vmJJ+LO8RLAK8qVczO7qWihW1N0owZCyXuoD9fHMN43WdFlFS
 VMo92ag4z6DSG8+Ce1+65SrEfjSYtzMPn9ek+bEepScO1vf0MxBKdyNYOK5W0UKC9zJ1A61ETh
 DXIEyHhuUg9kjJnOEcf8682EKTJs2bDrn4ZPEw+NhmSqcQaVd1iD0sfjhozLQwgUfbJ1Zcgd31
 ky8=
X-IronPort-AV: E=Sophos;i="5.79,345,1602572400"; 
   d="scan'208";a="105886843"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jan 2021 13:19:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 13 Jan 2021 13:19:34 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 13 Jan 2021 13:19:32 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH 3/3] arm64: dts: reset: add microchip sparx5 switch reset driver
Date:   Wed, 13 Jan 2021 21:19:15 +0100
Message-ID: <20210113201915.2734205-4-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113201915.2734205-1-steen.hegelund@microchip.com>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
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

