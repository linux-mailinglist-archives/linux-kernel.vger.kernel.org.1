Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393342CBDCE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730096AbgLBNGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:06:36 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:37222 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgLBNGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606914393; x=1638450393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HYvqfDOJAQzsbDFrol1vkz2s/fsDFmkTjeSVK52uWyE=;
  b=o1pLjajU8nylW4LUDM64uGpY78j5JFUyRinYPguMsLt0lGcrfPr4U7Ho
   u6/f+KS2PqMc2j1fqA8/nbZkLDkKkrrlgf/7PIQjAom9CohfAN+IRw5IZ
   rHhxkv3znJFONQMPXgreVvmp1N2oCeGmeG+XgeoomXE4N6rl45mbnlTEk
   EPwpMyyYaPqMZoVnTQQplYfIsTBOYkzaLviXVO1w01wU9nMrWQ0MpjQu8
   n0QSKKh0GpTwJ+y8x1Oea2DJRao5ScEXFzCODee3B99qmONb/fMTYQBK2
   qB9nZDLKr41PIfsNgEYsVpUsejP+YGhwsfI0HkWftTnbntXnCrhrCm3Gt
   Q==;
IronPort-SDR: qMBwXqbhTb9ByfjEJF/NyXGfnM7jpbUWCMhjk28eTX6DzJKO6ZCkPaY0ZdDVVFpqG6CE3fesZK
 GZ9FcuMQbRKCuD3uiawVV2hHbytl5EhartV7uh7l15glRg0z1C0iAxj/3JJ4RnHUnI2g2+hvUn
 tUviLqBq8ABQYChUPf9NmeYtzKug4G1VO767G+2Tsm3eYCqYcN9L3TwF8d6WJ7wpUfUQZo0ARB
 nQashFVVyffinJklSmzz+RO5HBaP+xCi9r4lrne4Hk2qEaFxrne07SpUSAAabF67lY1z9I2jJy
 cnM=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="101125153"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 06:04:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 06:04:57 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 06:04:55 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Bjarni Jonasson <bjarni.jonasson@microchip.com>,
        Microchip UNG Driver List <UNGLinuxDriver@microchip.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 4/4] arm64: dts: sparx5: Add Sparx5 serdes driver node
Date:   Wed, 2 Dec 2020 14:04:38 +0100
Message-ID: <20201202130438.3330228-5-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202130438.3330228-1-steen.hegelund@microchip.com>
References: <20201202130438.3330228-1-steen.hegelund@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Sparx5 serdes driver node, and enable it generally for all
reference boards.

Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
Signed-off-by: Steen Hegelund <steen.hegelund@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 8e7724d413fb..797601a9d542 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -287,5 +287,13 @@ tmon0: tmon@610508110 {
 			#thermal-sensor-cells = <0>;
 			clocks = <&ahb_clk>;
 		};
+
+		serdes: serdes@10808000 {
+			compatible = "microchip,sparx5-serdes";
+			#phy-cells = <1>;
+			clocks = <&sys_clk>;
+			reg = <0x6 0x10808000 0x5d0000>;
+		};
+
 	};
 };
-- 
2.29.2

