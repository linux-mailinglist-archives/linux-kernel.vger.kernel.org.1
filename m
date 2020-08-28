Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A13255C3C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgH1OVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 10:21:00 -0400
Received: from foss.arm.com ([217.140.110.172]:50376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgH1OUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:20:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13FD9106F;
        Fri, 28 Aug 2020 07:20:34 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 843FB3F71F;
        Fri, 28 Aug 2020 07:20:32 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH v2 3/6] ARM: dts: NSP: Fix SP804 compatible node
Date:   Fri, 28 Aug 2020 15:20:15 +0100
Message-Id: <20200828142018.43298-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828142018.43298-1-andre.przywara@arm.com>
References: <20200828142018.43298-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DT binding for SP804 requires to have an "arm,primecell" compatible
string.
Add this string so that the Linux primecell bus driver picks the device
up and activates the clock.

Fixes: a0efb0d28b77 ("ARM: dts: NSP: Add SP804 Support to DT")
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index 0346ea621f0f..1333ef8be0a2 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -368,7 +368,7 @@
 		};
 
 		ccbtimer0: timer@34000 {
-			compatible = "arm,sp804";
+			compatible = "arm,sp804", "arm,primecell";
 			reg = <0x34000 0x1000>;
 			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1

