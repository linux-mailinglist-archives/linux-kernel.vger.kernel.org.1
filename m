Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A73F261F30
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732497AbgIHUAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730477AbgIHPf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:35:26 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8297E22BF3;
        Tue,  8 Sep 2020 14:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577199;
        bh=M1E3QlEcopkB9Ss9cwMDRhMIEQp6FQqI/zsyQ4VIOes=;
        h=From:To:Cc:Subject:Date:From;
        b=CCHK8NRNe+g16m0fl8p/+qr8DXPm6O+ZWmX5mXl9dowWRiVB5eqVd22tZ4QmhZme/
         bectj1Ex58awbfrGqq2hFsweAsiG4LqEkbPv8OmAp2ECeWXGv8KxYZtjOVqW4yCqjC
         aU0U4erElfxRY9UTBIXT8N1Hg/JhWY3O0Nb5sZaQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ASoC: dt-bindings:  Correct interrupt flags in examples
Date:   Tue,  8 Sep 2020 16:59:54 +0200
Message-Id: <20200908145954.4629-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted some
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_HIGH => IRQ_TYPE_LEVEL_HIGH

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/sound/max98090.txt | 2 +-
 Documentation/devicetree/bindings/sound/rt5640.txt   | 2 +-
 Documentation/devicetree/bindings/sound/rt5659.txt   | 2 +-
 Documentation/devicetree/bindings/sound/rt5665.txt   | 2 +-
 Documentation/devicetree/bindings/sound/rt5668.txt   | 2 +-
 Documentation/devicetree/bindings/sound/rt5677.txt   | 2 +-
 Documentation/devicetree/bindings/sound/rt5682.txt   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/max98090.txt b/Documentation/devicetree/bindings/sound/max98090.txt
index 7e1bbd5c27fd..39d640294c62 100644
--- a/Documentation/devicetree/bindings/sound/max98090.txt
+++ b/Documentation/devicetree/bindings/sound/max98090.txt
@@ -55,5 +55,5 @@ audio-codec@10 {
 	compatible = "maxim,max98090";
 	reg = <0x10>;
 	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(H, 4) GPIO_ACTIVE_HIGH>;
+	interrupts = <TEGRA_GPIO(H, 4) IRQ_TYPE_LEVEL_HIGH>;
 };
diff --git a/Documentation/devicetree/bindings/sound/rt5640.txt b/Documentation/devicetree/bindings/sound/rt5640.txt
index e40e4893eed8..ff1228713f7e 100644
--- a/Documentation/devicetree/bindings/sound/rt5640.txt
+++ b/Documentation/devicetree/bindings/sound/rt5640.txt
@@ -88,7 +88,7 @@ rt5640 {
 	compatible = "realtek,rt5640";
 	reg = <0x1c>;
 	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+	interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_HIGH>;
 	realtek,ldo1-en-gpios =
 		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 };
diff --git a/Documentation/devicetree/bindings/sound/rt5659.txt b/Documentation/devicetree/bindings/sound/rt5659.txt
index 1766e0543fc5..56788f50b6cf 100644
--- a/Documentation/devicetree/bindings/sound/rt5659.txt
+++ b/Documentation/devicetree/bindings/sound/rt5659.txt
@@ -72,7 +72,7 @@ rt5659 {
 	compatible = "realtek,rt5659";
 	reg = <0x1b>;
 	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+	interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_HIGH>;
 	realtek,ldo1-en-gpios =
 		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 };
diff --git a/Documentation/devicetree/bindings/sound/rt5665.txt b/Documentation/devicetree/bindings/sound/rt5665.txt
index 8df170506986..f6ca96b4ce98 100644
--- a/Documentation/devicetree/bindings/sound/rt5665.txt
+++ b/Documentation/devicetree/bindings/sound/rt5665.txt
@@ -62,7 +62,7 @@ rt5659 {
 	compatible = "realtek,rt5665";
 	reg = <0x1b>;
 	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+	interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_HIGH>;
 	realtek,ldo1-en-gpios =
 		<&gpio TEGRA_GPIO(V, 3) GPIO_ACTIVE_HIGH>;
 };
diff --git a/Documentation/devicetree/bindings/sound/rt5668.txt b/Documentation/devicetree/bindings/sound/rt5668.txt
index c88b96e7764b..a2b7e9a2f2f3 100644
--- a/Documentation/devicetree/bindings/sound/rt5668.txt
+++ b/Documentation/devicetree/bindings/sound/rt5668.txt
@@ -41,7 +41,7 @@ rt5668 {
 	compatible = "realtek,rt5668b";
 	reg = <0x1a>;
 	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(U, 6) GPIO_ACTIVE_HIGH>;
+	interrupts = <TEGRA_GPIO(U, 6) IRQ_TYPE_LEVEL_HIGH>;
 	realtek,ldo1-en-gpios =
 		<&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
 	realtek,dmic1-data-pin = <1>;
diff --git a/Documentation/devicetree/bindings/sound/rt5677.txt b/Documentation/devicetree/bindings/sound/rt5677.txt
index 1b3c13d206ff..da2430099181 100644
--- a/Documentation/devicetree/bindings/sound/rt5677.txt
+++ b/Documentation/devicetree/bindings/sound/rt5677.txt
@@ -64,7 +64,7 @@ rt5677 {
 	compatible = "realtek,rt5677";
 	reg = <0x2c>;
 	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(W, 3) GPIO_ACTIVE_HIGH>;
+	interrupts = <TEGRA_GPIO(W, 3) IRQ_TYPE_LEVEL_HIGH>;
 
 	gpio-controller;
 	#gpio-cells = <2>;
diff --git a/Documentation/devicetree/bindings/sound/rt5682.txt b/Documentation/devicetree/bindings/sound/rt5682.txt
index ade1ece8b45f..707fa98d1310 100644
--- a/Documentation/devicetree/bindings/sound/rt5682.txt
+++ b/Documentation/devicetree/bindings/sound/rt5682.txt
@@ -58,7 +58,7 @@ rt5682 {
 	compatible = "realtek,rt5682i";
 	reg = <0x1a>;
 	interrupt-parent = <&gpio>;
-	interrupts = <TEGRA_GPIO(U, 6) GPIO_ACTIVE_HIGH>;
+	interrupts = <TEGRA_GPIO(U, 6) IRQ_TYPE_LEVEL_HIGH>;
 	realtek,ldo1-en-gpios =
 		<&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_HIGH>;
 	realtek,dmic1-data-pin = <1>;
-- 
2.17.1

