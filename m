Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10161299488
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 18:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1788840AbgJZR4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 13:56:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33836 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1788742AbgJZRzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 13:55:45 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DD0421F44FD2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, weiyi.lu@mediatek.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 12/16] arm64: dts: mediatek: Add smi_common node for MT8183
Date:   Mon, 26 Oct 2020 18:55:21 +0100
Message-Id: <20201026175526.2915399-13-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026175526.2915399-1-enric.balletbo@collabora.com>
References: <20201026175526.2915399-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMI (Smart Multimedia Interface) Common is a bridge between the m4u
(Multimedia Memory Management Unit) and the Multimedia HW. This block is
needed to support different multimedia features, like display, video
decode, and camera. Also is needed to control the power domains of such
HW blocks.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9cfd961c45eb..c06778d21c4f 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -765,6 +765,16 @@ mmsys: syscon@14000000 {
 			#clock-cells = <1>;
 		};
 
+		smi_common: smi@14019000 {
+			compatible = "mediatek,mt8183-smi-common", "syscon";
+			reg = <0 0x14019000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_SMI_COMMON>,
+				 <&mmsys CLK_MM_GALS_COMM0>,
+				 <&mmsys CLK_MM_GALS_COMM1>;
+			clock-names = "apb", "smi", "gals0", "gals1";
+		};
+
 		imgsys: syscon@15020000 {
 			compatible = "mediatek,mt8183-imgsys", "syscon";
 			reg = <0 0x15020000 0 0x1000>;
-- 
2.28.0

