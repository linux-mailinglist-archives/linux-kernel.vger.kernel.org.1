Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2192C799F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 15:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgK2Ory (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 09:47:54 -0500
Received: from fgw21-4.mail.saunalahti.fi ([62.142.5.108]:55541 "EHLO
        fgw21-4.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgK2Ory (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 09:47:54 -0500
Received: from localhost.localdomain (85-76-71-224-nat.elisa-mobile.fi [85.76.71.224])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id c2e37b56-3251-11eb-9eb8-005056bdd08f;
        Sun, 29 Nov 2020 16:47:12 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Ford <aford173@gmail.com>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: OMAP3: disable AES on N950/N9
Date:   Sun, 29 Nov 2020 16:47:10 +0200
Message-Id: <20201129144710.25521-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AES needs to be disabled on Nokia N950/N9 as well (HS devices), otherwise
kernel fails to boot.

Fixes: c312f066314e ("ARM: dts: omap3: Migrate AES from hwmods to sysc-omap2")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/boot/dts/omap3-n950-n9.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-n950-n9.dtsi b/arch/arm/boot/dts/omap3-n950-n9.dtsi
index 11d41e86f814..7dde9fbb06d3 100644
--- a/arch/arm/boot/dts/omap3-n950-n9.dtsi
+++ b/arch/arm/boot/dts/omap3-n950-n9.dtsi
@@ -494,3 +494,11 @@
 		clock-names = "sysclk";
 	};
 };
+
+&aes1_target {
+	status = "disabled";
+};
+
+&aes2_target {
+	status = "disabled";
+};
-- 
2.17.0

