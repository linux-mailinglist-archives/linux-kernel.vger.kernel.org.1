Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3EE279AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 18:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgIZQ3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 12:29:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730060AbgIZQ3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 12:29:19 -0400
Received: from localhost.localdomain (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE2CD21D82;
        Sat, 26 Sep 2020 16:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601137757;
        bh=IWVFinU2gJ+E1MF07J7h9v2WfL9kkI6gUXonDptfeCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cdqy+LbP9Z81nyfJCtgjygb/C+6YC3vgvH3ZUwF5ahfp9rwUkzDcS+xrLqBOxzyEb
         I/9Wpp/LMS20vLxyloynOKalFv6Ca7vYJaRgWGxVr0uL8ZjBPQUJK6Usk0+6md0yW8
         Gsw6zNN+VEoRBiy3iHu0D12IVAvF5vcn+BUIGGV4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>
Subject: [RFC 14/14] ARM: dts: imx6dl: add compatibles for Aristainetos boards
Date:   Sat, 26 Sep 2020 18:28:11 +0200
Message-Id: <20200926162811.5335-14-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200926162811.5335-1-krzk@kernel.org>
References: <20200926162811.5335-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Aristainetos and Aristainetos2 boards have only SoC compatible.

Cc: Heiko Schocher <hs@denx.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Unfortunately I have no clue what is it.
---
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts  | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
index b16603f27dce..241754305f51 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
@@ -46,7 +46,7 @@
 
 / {
 	model = "aristainetos2 i.MX6 Dual Lite Board 4";
-	compatible = "fsl,imx6dl";
+	compatible = "aristainetos,aristainetos2-imx6dl-4", "fsl,imx6dl";
 
 	memory@10000000 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
index abb2a1b9ce08..5ff0e55691f6 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
@@ -46,7 +46,7 @@
 
 / {
 	model = "aristainetos2 i.MX6 Dual Lite Board 7";
-	compatible = "fsl,imx6dl";
+	compatible = "aristainetos,aristainetos2-imx6dl-7", "fsl,imx6dl";
 
 	memory@10000000 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index 5c7e85300695..4a124f65cb10 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "aristainetos i.MX6 Dual Lite Board 4";
-	compatible = "fsl,imx6dl";
+	compatible = "aristainetos,aristainetos-imx6dl-4", "fsl,imx6dl";
 
 	backlight {
 		compatible = "pwm-backlight";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
index 4d58cb4436d9..6ad10d53562f 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "aristainetos i.MX6 Dual Lite Board 7";
-	compatible = "fsl,imx6dl";
+	compatible = "aristainetos,aristainetos-imx6dl-7", "fsl,imx6dl";
 
 	memory@10000000 {
 		device_type = "memory";
-- 
2.17.1

