Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6320ADFC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgFZIGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:06:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729115AbgFZIGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:50 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D012082E;
        Fri, 26 Jun 2020 08:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593158810;
        bh=p9ns/RNIl9ByFvU/vgmKZFspRmGj+ezQS80zvtYxBYE=;
        h=From:To:Cc:Subject:Date:From;
        b=Cmf+r2GCxhLLw1+kXasXg0E/AWLDiMI2DQfD+bMxjS61OaJ+oZ+rQhY/mpNWCLA1P
         Nzog2ZvYkA+/3AhDHOHADn2BdLrtiBLeWKBRLlB0d9O7lCCD2hM5V7JpKTaeYGJY3x
         xv6GLjLB8s3jEP9c12CaOgov4/RpmwyPCNMigDNg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: dts: bcm: Align L2 cache-controller nodename with dtschema
Date:   Fri, 26 Jun 2020 10:06:46 +0200
Message-Id: <20200626080646.4300-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix dtschema validator warnings like:
    l2-cache@22000: $nodename:0:
        'l2-cache@22000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 arch/arm/boot/dts/bcm-hr2.dtsi    | 2 +-
 arch/arm/boot/dts/bcm-nsp.dtsi    | 2 +-
 arch/arm/boot/dts/bcm21664.dtsi   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 1bc45cfd5453..35bdd0969f0a 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -91,7 +91,7 @@
 			      <0x20100 0x100>;
 		};
 
-		L2: l2-cache@22000 {
+		L2: cache-controller@22000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x22000 0x1000>;
 			cache-unified;
diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 5e5f5ca3c86f..cbebed5f050e 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -104,7 +104,7 @@
 			      <0x20100 0x100>;
 		};
 
-		L2: l2-cache@22000 {
+		L2: cache-controller@22000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x22000 0x1000>;
 			cache-unified;
diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index da6d70f09ef1..1c4a46e350e3 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -122,7 +122,7 @@
 			      <0x20100 0x100>;
 		};
 
-		L2: l2-cache@22000 {
+		L2: cache-controller@22000 {
 			compatible = "arm,pl310-cache";
 			reg = <0x22000 0x1000>;
 			cache-unified;
diff --git a/arch/arm/boot/dts/bcm21664.dtsi b/arch/arm/boot/dts/bcm21664.dtsi
index 3cf66faf3b56..58ec1b2f8ef6 100644
--- a/arch/arm/boot/dts/bcm21664.dtsi
+++ b/arch/arm/boot/dts/bcm21664.dtsi
@@ -90,7 +90,7 @@
 		reg-io-width = <4>;
 	};
 
-	L2: l2-cache@3ff20000 {
+	L2: cache-controller@3ff20000 {
 		compatible = "arm,pl310-cache";
 		reg = <0x3ff20000 0x1000>;
 		cache-unified;
-- 
2.17.1

