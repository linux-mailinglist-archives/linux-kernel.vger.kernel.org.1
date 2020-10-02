Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F815281815
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbgJBQif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:38:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBQie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:38:34 -0400
Received: from localhost.localdomain (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C39FB208A9;
        Fri,  2 Oct 2020 16:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601656713;
        bh=DIcAdd82aAxNps1kyGzzA6JzMtPt/nNptmBfBBz+YVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DYyCv/VMLoPc18UOF9L4AlmIO7Ur7fd1Fj0zW//caP44sA4nTXFwJ1EHTNJva5IMS
         Xz1C44c7B9jo5v/zMwYLiO4p5IMqGpqLA4BZeAm/LQl3dok4QBrOSgTowXc4VoowjU
         bsLSGEwVTc64v0fFq6sDmsTs0NK1M0WvKMbQb/Zs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [RESEND PATCH v3 2/2] ARM: dts: aspeed: align GPIO hog names with dtschema
Date:   Fri,  2 Oct 2020 18:38:22 +0200
Message-Id: <20201002163822.7678-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201002163822.7678-1-krzk@kernel.org>
References: <20201002163822.7678-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dtschema for pca95xx expects GPIO hogs to end with 'hog' suffix.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |  2 +-
 arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts  | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
index 21ae880c7530..d5ac379c909e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
@@ -564,7 +564,7 @@
 		gpio-controller;
 		#gpio-cells = <2>;
 
-		smbus0 {
+		smbus0-hog {
 			gpio-hog;
 			gpios = <4 GPIO_ACTIVE_HIGH>;
 			output-high;
diff --git a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
index cb85168f6761..577c211c469e 100644
--- a/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-opp-mihawk.dts
@@ -827,7 +827,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus0 {
+				smbus0-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -852,7 +852,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus1 {
+				smbus1-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -900,7 +900,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus2 {
+				smbus2-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -925,7 +925,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus3 {
+				smbus3-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -992,7 +992,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus4 {
+				smbus4-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -1017,7 +1017,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus5 {
+				smbus5-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -1065,7 +1065,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus6 {
+				smbus6-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
@@ -1090,7 +1090,7 @@
 				gpio-controller;
 				#gpio-cells = <2>;
 
-				smbus7 {
+				smbus7-hog {
 					gpio-hog;
 					gpios = <4 GPIO_ACTIVE_HIGH>;
 					output-high;
-- 
2.17.1

