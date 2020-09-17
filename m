Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B0226E494
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIQSws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:52:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:54492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbgIQSwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:52:24 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8DE206B2;
        Thu, 17 Sep 2020 18:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600368740;
        bh=XKp/ALCXKdogV898R63aYemHxOz/vb5HEsd5afFXsHs=;
        h=From:To:Subject:Date:From;
        b=xha31VWNPbcwTWQ1Qj7OW9FmHR3AheCdYBldwkejJwo8vrXEg+kjAy479DUWHSe6T
         dUM8nf1AkP9wW3GZRCYtPkVnmyegqczuSCko7yCBte5/cwLSewA1ZFTLCvlEAmD2KU
         qA9os2y9kMuaxIUqO0knW4W1GjYj4JRflneqn79Q=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Alexis Ballier <aballier@gentoo.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Anand Moon <linux.amoon@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ARM: dts: rk3188: correct interrupt flags
Date:   Thu, 17 Sep 2020 20:52:10 +0200
Message-Id: <20200917185211.5483-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags without affecting the code:
  ACTIVE_HIGH => IRQ_TYPE_NONE

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.

Changes since v1:
1. Correct title
---
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index 66a0ff196eb1..b191347894f6 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -7,6 +7,7 @@
 /dts-v1/;
 #include <dt-bindings/i2c/i2c.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include "rk3188.dtsi"
 
 / {
@@ -479,7 +480,7 @@
 		reg = <1>;
 		compatible = "brcm,bcm4329-fmac";
 		interrupt-parent = <&gpio3>;
-		interrupts = <RK_PD2 GPIO_ACTIVE_HIGH>;
+		interrupts = <RK_PD2 IRQ_TYPE_NONE>;
 		interrupt-names = "host-wake";
 		brcm,drive-strength = <5>;
 		pinctrl-names = "default";
-- 
2.17.1

