Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6480281820
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388179AbgJBQj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:39:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388139AbgJBQjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:39:55 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A944C2085B;
        Fri,  2 Oct 2020 16:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601656794;
        bh=HIJo8gpXFNpblNZVxsfWZ1cJpvXx8FFnljlsR+leaLc=;
        h=From:To:Cc:Subject:Date:From;
        b=R03QAa6nKFijWswSNgXR/CFvg6kL+tnW4yGQLtnaxl/mk9zQt2mdjQ2GwRDwAvPsg
         0T40uKBY2u/jgc3nU18wImJl/HCO2ow0aOFbWDbaP/7zSGRQK64fnNYTwAcnyfiTMe
         +FrNb9zo4clICiLmXPREJRnTnAMoO1VXEypY4VnY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH v3] arm64: dts: mediatek: align GPIO hog names with dtschema
Date:   Fri,  2 Oct 2020 18:39:40 +0200
Message-Id: <20201002163940.7837-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for node names is to use hyphens, not underscores.
dtschema for pca95xx expects GPIO hogs to end with 'hog' suffix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/mediatek/pumpkin-common.dtsi     | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

The dt-schema changes were applied.

diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
index 29d8cf6df46b..351a1905a074 100644
--- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
+++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
@@ -63,91 +63,91 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		eint20_mux_sel0 {
+		eint20-mux-sel0-hog {
 			gpio-hog;
 			gpios = <0 0>;
 			input;
 			line-name = "eint20_mux_sel0";
 		};
 
-		expcon_mux_sel1 {
+		expcon-mux-sel1-hog {
 			gpio-hog;
 			gpios = <1 0>;
 			input;
 			line-name = "expcon_mux_sel1";
 		};
 
-		mrg_di_mux_sel2 {
+		mrg-di-mux-sel2-hog {
 			gpio-hog;
 			gpios = <2 0>;
 			input;
 			line-name = "mrg_di_mux_sel2";
 		};
 
-		sd_sdio_mux_sel3 {
+		sd-sdio-mux-sel3-hog {
 			gpio-hog;
 			gpios = <3 0>;
 			input;
 			line-name = "sd_sdio_mux_sel3";
 		};
 
-		sd_sdio_mux_ctrl7 {
+		sd-sdio-mux-ctrl7-hog {
 			gpio-hog;
 			gpios = <7 0>;
 			output-low;
 			line-name = "sd_sdio_mux_ctrl7";
 		};
 
-		hw_id0 {
+		hw-id0-hog {
 			gpio-hog;
 			gpios = <8 0>;
 			input;
 			line-name = "hw_id0";
 		};
 
-		hw_id1 {
+		hw-id1-hog {
 			gpio-hog;
 			gpios = <9 0>;
 			input;
 			line-name = "hw_id1";
 		};
 
-		hw_id2 {
+		hw-id2-hog {
 			gpio-hog;
 			gpios = <10 0>;
 			input;
 			line-name = "hw_id2";
 		};
 
-		fg_int_n {
+		fg-int-n-hog {
 			gpio-hog;
 			gpios = <11 0>;
 			input;
 			line-name = "fg_int_n";
 		};
 
-		usba_pwr_en {
+		usba-pwr-en-hog {
 			gpio-hog;
 			gpios = <12 0>;
 			output-high;
 			line-name = "usba_pwr_en";
 		};
 
-		wifi_3v3_pg {
+		wifi-3v3-pg-hog {
 			gpio-hog;
 			gpios = <13 0>;
 			input;
 			line-name = "wifi_3v3_pg";
 		};
 
-		cam_rst {
+		cam-rst-hog {
 			gpio-hog;
 			gpios = <14 0>;
 			output-low;
 			line-name = "cam_rst";
 		};
 
-		cam_pwdn {
+		cam-pwdn-hog {
 			gpio-hog;
 			gpios = <15 0>;
 			output-low;
-- 
2.17.1

