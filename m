Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C7A220C82
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 13:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730583AbgGOLz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 07:55:27 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:55819 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725852AbgGOLz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 07:55:27 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1505735|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0298392-0.00123236-0.968928;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03279;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.I264RN7_1594814118;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.I264RN7_1594814118)
          by smtp.aliyun-inc.com(10.147.41.199);
          Wed, 15 Jul 2020 19:55:23 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH 2/3] ARM: dts: allwinner: convert gpio.h to sunxi-gpio.h
Date:   Wed, 15 Jul 2020 19:55:07 +0800
Message-Id: <20200715115507.2690-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Use names instead of numbers to describe GPIO. We clean arm64 first.
Since H5 uses the DTS file in arm directory, we need to modify the
header file in advance.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>

---
 arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi  | 2 +-
 arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi b/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
index fc67e30fe212..93f9653b43f4 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5-emlid-neutis.dtsi
@@ -7,7 +7,7 @@
 
 #include "sunxi-common-regulators.dtsi"
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
index 19b3b23cfaa8..f6f14b5175e3 100644
--- a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
+++ b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2017 Chen-Yu Tsai <wens@csie.org>
  */
 
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/gpio/sunxi-gpio.h>
 #include <dt-bindings/input/input.h>
 
 / {
-- 
2.24.0

