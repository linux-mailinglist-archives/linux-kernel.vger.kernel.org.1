Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6B1AFC8C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgDSRMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 13:12:32 -0400
Received: from v6.sk ([167.172.42.174]:44022 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgDSRMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 13:12:32 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id EAC34610BB;
        Sun, 19 Apr 2020 17:12:30 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     soc@kernel.org
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 12/15] ARM: dts: mmp3: Add the fifth SD HCI
Date:   Sun, 19 Apr 2020 19:11:54 +0200
Message-Id: <20200419171157.672999-13-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200419171157.672999-1-lkundrak@v3.sk>
References: <20200419171157.672999-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's one extra SDHCI on MMP3, used by the internal SD card on OLPC
XO-4. Add it to the device tree.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/boot/dts/mmp3.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/mmp3.dtsi b/arch/arm/boot/dts/mmp3.dtsi
index a4d8d846f81af..ae264af12c287 100644
--- a/arch/arm/boot/dts/mmp3.dtsi
+++ b/arch/arm/boot/dts/mmp3.dtsi
@@ -281,6 +281,16 @@ mmc4: mmc@d4281800 {
 				status = "disabled";
 			};
 
+			mmc5: mmc@d4217000 {
+				compatible = "mrvl,pxav3-mmc";
+				reg = <0xd4217000 0x120>;
+				clocks = <&soc_clocks MMP3_CLK_SDH4>;
+				clock-names = "io";
+				interrupt-parent = <&hsi1_mux>;
+				interrupts = <0>;
+				status = "disabled";
+			};
+
 			camera0: camera@d420a000 {
 				compatible = "marvell,mmp2-ccic";
 				reg = <0xd420a000 0x800>;
-- 
2.26.0

