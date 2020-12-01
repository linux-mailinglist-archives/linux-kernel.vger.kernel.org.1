Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14C22CA3B3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgLANWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgLANWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:22:32 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78D4C0613D4;
        Tue,  1 Dec 2020 05:21:51 -0800 (PST)
Received: from allenwind.lan (unknown [IPv6:2a02:169:3df5::979])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id A89C25C2AB5;
        Tue,  1 Dec 2020 14:21:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1606828909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4jPXXFT61h0+NZ5HlKP22zr51bhXqri0cz8N+6UjZ7I=;
        b=n/mHaQRe2O2Kt8bvt6Leuv5FobSungYHVVZ8ibNIy0vUc0UeWCXya2xMWDw6oWzvIC7WIN
        et7j5LcmeIySUUUrob4ox7KjkRuKQ0dqufQ7pEBBLPYyURDPufVsmKj0o+3zP3ENyxE6Le
        Md59+aH4CIy+QmdJ89ji7SOz293Cmqs=
From:   Stefan Agner <stefan@agner.ch>
To:     khilman@baylibre.com
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, christianshewitt@gmail.com,
        jian.hu@amlogic.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 3/5] ARM: dts: meson: fix PHY deassert timing requirements
Date:   Tue,  1 Dec 2020 14:21:39 +0100
Message-Id: <6bfe17d86ead62c20d236e2ebbc7b7fe3354829d.1606828668.git.stefan@agner.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
References: <14754fd95378b78eb9a0a3f8b6bab13f7263c7f1.1606828668.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet (Rev. 1.9) the RTL8211F requires at least
72ms "for internal circuits settling time" before accessing the PHY
egisters. On similar boards with the same PHY this fixes an issue where
Ethernet link would not come up when using ip link set down/up.

Fixes: a2c6e82e5341 ("ARM: dts: meson: switch to the generic Ethernet PHY reset bindings")
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 2 +-
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 0c26467de4d0..5963566dbcc9 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -224,7 +224,7 @@ eth_phy: ethernet-phy@0 {
 			reg = <0>;
 
 			reset-assert-us = <10000>;
-			reset-deassert-us = <30000>;
+			reset-deassert-us = <80000>;
 			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
 
 			interrupt-parent = <&gpio_intc>;
diff --git a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
index cc498191ddd1..8f4eb1ed4581 100644
--- a/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
+++ b/arch/arm/boot/dts/meson8m2-mxiii-plus.dts
@@ -81,7 +81,7 @@ eth_phy0: ethernet-phy@0 {
 			reg = <0>;
 
 			reset-assert-us = <10000>;
-			reset-deassert-us = <30000>;
+			reset-deassert-us = <80000>;
 			reset-gpios = <&gpio GPIOH_4 GPIO_ACTIVE_LOW>;
 		};
 	};
-- 
2.29.2

