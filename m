Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2BF41E4E47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 21:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgE0Tfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 15:35:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgE0Tfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:35:45 -0400
Received: from localhost.localdomain (unknown [194.230.155.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BF72078B;
        Wed, 27 May 2020 19:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590608144;
        bh=fyfTwfnYczyhGudUu/tTRSlOPONlV1JmPl8Bq04dYlU=;
        h=From:To:Cc:Subject:Date:From;
        b=H0l0W750dS/ExK3CPavpqtcEj9/eHkuYo2ijgilbuMwi+nu4aJy9fAxK4SOPs4aPx
         xrzAVMxEQYsydkHIqq5hEuvWSteMApERMWyaSauJHZQtKcjDCXKU+r6ZJIG/r0Zoe4
         eJ3Kl4RPtOwCZXydYdPwVdvcEs66ZNHReKYVKxKg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH v4] ARM: dts: keystone: Rename "msmram" node to "sram"
Date:   Wed, 27 May 2020 21:35:38 +0200
Message-Id: <20200527193538.17424-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device node name should reflect generic class of a device so rename
the "msmram" node and its children to "sram".  This will be also in sync
with upcoming DT schema.  No functional change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v3:
1. Rename also children.

v3 is here:
https://lore.kernel.org/linux-arm-kernel/20191002164316.14905-7-krzk@kernel.org/
---
 arch/arm/boot/dts/keystone-k2e.dtsi  | 4 ++--
 arch/arm/boot/dts/keystone-k2g.dtsi  | 4 ++--
 arch/arm/boot/dts/keystone-k2hk.dtsi | 4 ++--
 arch/arm/boot/dts/keystone-k2l.dtsi  | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 085e7326ea8e..2d94faf31fab 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -86,14 +86,14 @@
 			};
 		};
 
-		msm_ram: msmram@c000000 {
+		msm_ram: sram@c000000 {
 			compatible = "mmio-sram";
 			reg = <0x0c000000 0x200000>;
 			ranges = <0x0 0x0c000000 0x200000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			sram-bm@1f0000 {
+			bm-sram@1f0000 {
 				reg = <0x001f0000 0x8000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 08ba31780baa..05a75019275e 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -95,14 +95,14 @@
 		ranges = <0x0 0x0 0x0 0xc0000000>;
 		dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
 
-		msm_ram: msmram@c000000 {
+		msm_ram: sram@c000000 {
 			compatible = "mmio-sram";
 			reg = <0x0c000000 0x100000>;
 			ranges = <0x0 0x0c000000 0x100000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			sram-bm@f7000 {
+			bm-sram@f7000 {
 				reg = <0x000f7000 0x8000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2hk.dtsi b/arch/arm/boot/dts/keystone-k2hk.dtsi
index ca0f198ba627..8a9447703310 100644
--- a/arch/arm/boot/dts/keystone-k2hk.dtsi
+++ b/arch/arm/boot/dts/keystone-k2hk.dtsi
@@ -57,14 +57,14 @@
 &soc0 {
 		/include/ "keystone-k2hk-clocks.dtsi"
 
-		msm_ram: msmram@c000000 {
+		msm_ram: sram@c000000 {
 			compatible = "mmio-sram";
 			reg = <0x0c000000 0x600000>;
 			ranges = <0x0 0x0c000000 0x600000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			sram-bm@5f0000 {
+			bm-sram@5f0000 {
 				reg = <0x5f0000 0x8000>;
 			};
 		};
diff --git a/arch/arm/boot/dts/keystone-k2l.dtsi b/arch/arm/boot/dts/keystone-k2l.dtsi
index 374c80124c4e..dff5fea72b2f 100644
--- a/arch/arm/boot/dts/keystone-k2l.dtsi
+++ b/arch/arm/boot/dts/keystone-k2l.dtsi
@@ -255,14 +255,14 @@
 			};
 		};
 
-		msm_ram: msmram@c000000 {
+		msm_ram: sram@c000000 {
 			compatible = "mmio-sram";
 			reg = <0x0c000000 0x200000>;
 			ranges = <0x0 0x0c000000 0x200000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			sram-bm@1f8000 {
+			bm-sram@1f8000 {
 				reg = <0x001f8000 0x8000>;
 			};
 		};
-- 
2.17.1

