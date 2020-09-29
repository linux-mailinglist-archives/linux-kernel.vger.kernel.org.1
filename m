Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89C027BF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgI2Iac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:30:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:42744 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgI2Iab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:30:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 13773AD7F;
        Tue, 29 Sep 2020 08:30:30 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun8i: h2+: Enable optional SPI flash on Orange Pi Zero board
Date:   Tue, 29 Sep 2020 10:30:25 +0200
Message-Id: <20200929083025.2089-1-msuchanek@suse.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flash is present on all new boards and users went out of their way
to add it on the old ones.

Enabling it makes a more reasonable default.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index f19ed981da9d..061d295bbba7 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -163,8 +163,8 @@ &ohci1 {
 };
 
 &spi0 {
-	/* Disable SPI NOR by default: it optional on Orange Pi Zero boards */
-	status = "disabled";
+	/* Enable optional SPI NOR by default */
+	status = "okay";
 
 	flash@0 {
 		#address-cells = <1>;
-- 
2.28.0

