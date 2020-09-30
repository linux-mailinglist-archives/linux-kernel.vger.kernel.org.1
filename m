Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE5E27F244
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgI3TCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 15:02:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730631AbgI3TCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 15:02:34 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0D920B1F;
        Wed, 30 Sep 2020 19:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492553;
        bh=m6Z4qPwp54ZpFOH70exhyYQqBLlYmXMTPr22YHd87vg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0ajlvV9ETBnY6OlWy9g0qJGv233dZrXlFQpOqmvcagQI/YaLu0vrFxzcqzHNg0six
         KkiCM4061EuTN5Kl6wU6fy0Qxwjjxc55bJexi70ULkrvmdpTHVxR99SeE1a3LwGvig
         l105PKxUtx5Fdmr8PyJw7MrKDosM6/SWLukRWTJ4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Robert Jones <rjones@gateworks.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Heiko Schocher <hs@denx.de>
Subject: [PATCH v2 11/12] ARM: dts: imx6dl: add compatibles for Aristainetos boards
Date:   Wed, 30 Sep 2020 21:01:42 +0200
Message-Id: <20200930190143.27032-12-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930190143.27032-1-krzk@kernel.org>
References: <20200930190143.27032-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Aristainetos and Aristainetos2 boards have only SoC compatible.

Cc: Heiko Schocher <hs@denx.de>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Use ABB vendor prefix
---
 arch/arm/boot/dts/imx6dl-aristainetos2_4.dts | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos2_7.dts | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_4.dts  | 2 +-
 arch/arm/boot/dts/imx6dl-aristainetos_7.dts  | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
index b16603f27dce..dfa6f64d43cc 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_4.dts
@@ -46,7 +46,7 @@
 
 / {
 	model = "aristainetos2 i.MX6 Dual Lite Board 4";
-	compatible = "fsl,imx6dl";
+	compatible = "abb,aristainetos2-imx6dl-4", "fsl,imx6dl";
 
 	memory@10000000 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
index abb2a1b9ce08..5e15212eaf3a 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos2_7.dts
@@ -46,7 +46,7 @@
 
 / {
 	model = "aristainetos2 i.MX6 Dual Lite Board 7";
-	compatible = "fsl,imx6dl";
+	compatible = "abb,aristainetos2-imx6dl-7", "fsl,imx6dl";
 
 	memory@10000000 {
 		device_type = "memory";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
index 5c7e85300695..cc861a43eb58 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_4.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "aristainetos i.MX6 Dual Lite Board 4";
-	compatible = "fsl,imx6dl";
+	compatible = "abb,aristainetos-imx6dl-4", "fsl,imx6dl";
 
 	backlight {
 		compatible = "pwm-backlight";
diff --git a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
index 4d58cb4436d9..b6cb78870cd5 100644
--- a/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
+++ b/arch/arm/boot/dts/imx6dl-aristainetos_7.dts
@@ -10,7 +10,7 @@
 
 / {
 	model = "aristainetos i.MX6 Dual Lite Board 7";
-	compatible = "fsl,imx6dl";
+	compatible = "abb,aristainetos-imx6dl-7", "fsl,imx6dl";
 
 	memory@10000000 {
 		device_type = "memory";
-- 
2.17.1

