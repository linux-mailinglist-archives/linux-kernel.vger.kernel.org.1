Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460FE2D1804
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLGR64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgLGR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:58:55 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECCDC061794;
        Mon,  7 Dec 2020 09:58:15 -0800 (PST)
Received: from allenwind.lan (unknown [IPv6:2a02:169:3df5:0:6d9:f5ff:fe22:28bf])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2ADCF5C2BA0;
        Mon,  7 Dec 2020 18:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1607363894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yonEw/CHHn6f+8TLYCRua/I7Nb0Xqw32aR/6o9P86v0=;
        b=bEwvH/9fPXUyH5NvnW8iQKgot7gRLFx8s8AnemqDGz9ajBYnBMqx+vjBSVMzJDNU0/Tmme
        Q2UQcCyINbE2BCH4rdIabin/CPnwlneR+z0iH828c3tWUXkzx2ovCTowByBIUFd6mgYkcL
        67FHP4dbIRzSfoPXBTrJOFwm6QYo1OU=
From:   Stefan Agner <stefan@agner.ch>
To:     khilman@baylibre.com
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, christianshewitt@gmail.com,
        jian.hu@amlogic.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 3/5] ARM: dts: meson: fix PHY deassert timing requirements
Date:   Mon,  7 Dec 2020 18:58:01 +0100
Message-Id: <ff78772b306411e145769c46d4090554344db41e.1607363522.git.stefan@agner.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <df3f5c4fc6e43c55429fd3662a636036a21eed49.1607363522.git.stefan@agner.ch>
References: <df3f5c4fc6e43c55429fd3662a636036a21eed49.1607363522.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet (Rev. 1.9) the RTL8211F requires at least
72ms "for internal circuits settling time" before accessing the PHY
registers. On similar boards with the same PHY this fixes an issue where
Ethernet link would not come up when using ip link set down/up.

Fixes: a2c6e82e5341 ("ARM: dts: meson: switch to the generic Ethernet PHY reset bindings")
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com> # on Odroid-C1+
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

