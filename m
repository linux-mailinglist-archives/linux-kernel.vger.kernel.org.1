Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE9E2AB815
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgKIMVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:21:12 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44320 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729174AbgKIMVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:21:11 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3084485|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0285798-0.00149932-0.969921;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.IuVrwCJ_1604924464;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.IuVrwCJ_1604924464)
          by smtp.aliyun-inc.com(10.147.43.95);
          Mon, 09 Nov 2020 20:21:08 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tiny.windzz@gmail.com,
        Yangtao Li <frank@allwinnertech.com>
Subject: [PATCH] arm64: dts: allwinner: a64: fix sid node name
Date:   Mon,  9 Nov 2020 20:21:01 +0800
Message-Id: <20201109122101.23302-1-frank@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <frank@allwinnertech.com>

Sid should be an efuse type device accurately. And no one
needs sid label, so delete it.

Signed-off-by: Yangtao Li <frank@allwinnertech.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dc238814013c..96543df5d890 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -520,7 +520,7 @@ mmc2: mmc@1c11000 {
 			#size-cells = <0>;
 		};
 
-		sid: eeprom@1c14000 {
+		efuse@1c14000 {
 			compatible = "allwinner,sun50i-a64-sid";
 			reg = <0x1c14000 0x400>;
 			#address-cells = <1>;
-- 
2.28.0

