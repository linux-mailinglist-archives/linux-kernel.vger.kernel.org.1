Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327752D2439
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 08:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgLHHVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:21:22 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:45455 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgLHHVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:21:21 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1498677|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.142907-0.00168358-0.855409;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.J4TgxhS_1607412035;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J4TgxhS_1607412035)
          by smtp.aliyun-inc.com(10.147.40.7);
          Tue, 08 Dec 2020 15:20:38 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [PATCH v4 4/6] arm64: dts: allwinner: a100: Add CPU speed grade efuse cell
Date:   Tue,  8 Dec 2020 15:20:34 +0800
Message-Id: <20201208072034.3432-1-huangshuosheng@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU speed grade efuse cell for a100.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
index a669eb1fc965..8f370a175ce6 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a100.dtsi
@@ -125,6 +125,10 @@ efuse@3006000 {
 			ths_calibration: calib@14 {
 				reg = <0x14 8>;
 			};
+
+			cpu_speed_grade: cpu-speed-grade@1c {
+				reg = <0x1c 0x2>;
+			};
 		};
 
 		pio: pinctrl@300b000 {
-- 
2.28.0

