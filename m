Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3962520478C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 04:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgFWCwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 22:52:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:33226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731946AbgFWCvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 22:51:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13A89B19A;
        Tue, 23 Jun 2020 02:51:39 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?James=20Tai=20=5B=E6=88=B4=E5=BF=97=E5=B3=B0=5D?= 
        <james.tai@realtek.com>,
        =?UTF-8?q?Stanley=20Chang=20=5B=E6=98=8C=E8=82=B2=E5=BE=B7=5D?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 20/29] arm64: dts: realtek: rtd129x: Add eFuse node
Date:   Tue, 23 Jun 2020 04:50:57 +0200
Message-Id: <20200623025106.31273-21-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200623025106.31273-1-afaerber@suse.de>
References: <20200623025106.31273-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for eFuse.

Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/realtek/rtd129x.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/realtek/rtd129x.dtsi b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
index 30a7782aa0d9..8f96d4e4c46b 100644
--- a/arch/arm64/boot/dts/realtek/rtd129x.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd129x.dtsi
@@ -81,6 +81,14 @@ iso: syscon@7000 {
 				ranges = <0x0 0x7000 0x1000>;
 			};
 
+			efuse: efuse@17000 {
+				compatible = "realtek,rtd1195-efuse";
+				reg = <0x17000 0x400>;
+				read-only;
+				#address-cells = <1>;
+				#size-cells = <1>;
+			};
+
 			sb2: syscon@1a000 {
 				compatible = "syscon", "simple-mfd";
 				reg = <0x1a000 0x1000>;
@@ -194,6 +202,13 @@ uart2: serial@400 {
 	};
 };
 
+&otp {
+	otp_package_id: package-id@1d8 {
+		reg = <0x1d8 0x1>;
+		bits = <0 2>;
+	};
+};
+
 &sb2 {
 	sb2_hd_sem: hwspinlock@0 {
 		compatible = "realtek,rtd1195-sb2-sem";
-- 
2.26.2

