Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8926E9C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 02:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIRAIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 20:08:22 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:55293 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725987AbgIRAIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 20:08:22 -0400
X-Greylist: delayed 1407 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 20:08:21 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 08HNiNT4008723;
        Fri, 18 Sep 2020 02:44:23 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10070)
        id BD984639D8; Fri, 18 Sep 2020 02:44:23 +0300 (IDT)
From:   Tomer Maimon <tmaimon77@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, tmaimon77@gmail.com
Subject: [PATCH v6 2/3] arm: dts: modify NPCM7xx device tree timer register size
Date:   Fri, 18 Sep 2020 02:44:19 +0300
Message-Id: <20200917234420.86137-3-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200917234420.86137-1-tmaimon77@gmail.com>
References: <20200917234420.86137-1-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify NPCM7xx device tree timer register size
from 0x50 to 0x1C to control only the timer registers
and not other hw modules.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
index 16a28c5c4131..72e364054e72 100644
--- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
@@ -120,7 +120,7 @@
 			timer0: timer@8000 {
 				compatible = "nuvoton,npcm750-timer";
 				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
-				reg = <0x8000 0x50>;
+				reg = <0x8000 0x1C>;
 				clocks = <&clk NPCM7XX_CLK_TIMER>;
 			};
 
-- 
2.22.0

