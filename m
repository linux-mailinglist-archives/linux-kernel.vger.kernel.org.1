Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C558C2D1809
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgLGR7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgLGR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:58:55 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947B5C06179C;
        Mon,  7 Dec 2020 09:58:15 -0800 (PST)
Received: from allenwind.lan (unknown [IPv6:2a02:169:3df5:0:6d9:f5ff:fe22:28bf])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 3CF635C2DC7;
        Mon,  7 Dec 2020 18:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1607363894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kP4cdz/3tSpxSicOOh12rcBPCsaNwvBjLo2OKb8ClH0=;
        b=aa2T+qElCGh5fu0FnBZpQNW/PGr/S1cJwqVXh8BCKZOar4T5QlZSbxWqPC9W/4WRcy2ygg
        fETBTotH5j3ZYBPi3QLJ7R/9Di7DV7soW9PMXjkve/YvxV7Ws3erTae2SoSFDoqxXC+lcR
        sv/KABkokMnQg68MbIjhMn2FEd5sauM=
From:   Stefan Agner <stefan@agner.ch>
To:     khilman@baylibre.com
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, christianshewitt@gmail.com,
        jian.hu@amlogic.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 4/5] arm64: dts: meson: g12a: x96-max: fix PHY deassert timing requirements
Date:   Mon,  7 Dec 2020 18:58:02 +0100
Message-Id: <12506964ca5d5f936579a280ad0a7e7f9a0a2d4c.1607363522.git.stefan@agner.ch>
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

Fixes: ed5e8f689154 ("arm64: dts: meson: g12a: x96-max: fix the Ethernet PHY reset line")
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 1b07c8c06eac..463a72d6bb7c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -340,7 +340,7 @@ external_phy: ethernet-phy@0 {
 		eee-broken-1000t;
 
 		reset-assert-us = <10000>;
-		reset-deassert-us = <30000>;
+		reset-deassert-us = <80000>;
 		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
 
 		interrupt-parent = <&gpio_intc>;
-- 
2.29.2

