Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7402D20F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 03:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgLHCjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 21:39:06 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:54282 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727816AbgLHCjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 21:39:05 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1253207|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.123485-0.00280262-0.873712;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.J4N61uS_1607395099;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J4N61uS_1607395099)
          by smtp.aliyun-inc.com(10.147.41.158);
          Tue, 08 Dec 2020 10:38:21 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [PATCH v3 3/6] arm64: dts: allwinner: a100: Add clocks to CPU cores
Date:   Tue,  8 Dec 2020 10:38:18 +0800
Message-Id: <20201208023818.22951-1-huangshuosheng@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks to CPU cores for a100.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index cc321c04f121..a669eb1fc965 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -23,6 +23,7 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			reg = <0x0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu@1 {
@@ -30,6 +31,7 @@ cpu@1 {
 			device_type = "cpu";
 			reg = <0x1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu@2 {
@@ -37,6 +39,7 @@ cpu@2 {
 			device_type = "cpu";
 			reg = <0x2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 
 		cpu@3 {
@@ -44,6 +47,7 @@ cpu@3 {
 			device_type = "cpu";
 			reg = <0x3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
 		};
 	};
 
-- 
2.28.0

