Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA6426E489
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 20:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIQSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 14:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:53156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbgIQSu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 14:50:59 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5882A206B2;
        Thu, 17 Sep 2020 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600368658;
        bh=EIFP5fdYl0NK4ED+IZFrpucD2i1ESwcvVrfUhfvX3WU=;
        h=From:To:Subject:Date:From;
        b=qI52GKlJ49udQyA+FXCl4IuCxAU06RHePjIHFJ7VQTXbCKo/3qt6P31lv2emucVOT
         smazvS4EEF+s2YnNL/H53KaqxiebL6AeBQZ9KGf0sddpDBglUDbTwLXKQ/9cqoG/Sg
         72giYy2NRdrD1m0YUItAaw5HTJLMXK/bmE7b6848=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: zynqmp-zcu100-revC: correct interrupt flags
Date:   Thu, 17 Sep 2020 20:50:52 +0200
Message-Id: <20200917185052.5084-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIO_ACTIVE_x flags are not correct in the context of interrupt flags.
These are simple defines so they could be used in DTS but they will not
have the same meaning:
1. GPIO_ACTIVE_HIGH = 0 = IRQ_TYPE_NONE
2. GPIO_ACTIVE_LOW  = 1 = IRQ_TYPE_EDGE_RISING

Correct the interrupt flags, assuming the author of the code wanted same
logical behavior behind the name "ACTIVE_xxx", this is:
  ACTIVE_LOW => IRQ_TYPE_LEVEL_LOW

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on HW.

Changes since v1:
1. Correct title
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index d60110ad8367..c9460693f4e9 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -186,7 +186,7 @@
 				compatible = "ti,tps65086";
 				reg = <0x5e>;
 				interrupt-parent = <&gpio>;
-				interrupts = <77 GPIO_ACTIVE_LOW>;
+				interrupts = <77 IRQ_TYPE_LEVEL_LOW>;
 				#gpio-cells = <2>;
 				gpio-controller;
 			};
-- 
2.17.1

