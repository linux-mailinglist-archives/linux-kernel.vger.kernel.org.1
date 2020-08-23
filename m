Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE024EC3F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 10:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbgHWIt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 04:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbgHWIt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:49:26 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D2912075B;
        Sun, 23 Aug 2020 08:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598172565;
        bh=FROyJKtY0WGr6aY+7wywTeBUEey6klPy6NuDadBA7Ao=;
        h=From:To:Cc:Subject:Date:From;
        b=VeeSbH4tcJ6j+KCKv7VlJouhrQjXReXdojBxpSMwR0si7D4FdMGfh9uC27vxk4eJv
         9HW0r9Vtciqi+e44eppqVwxcxQ5tIIGlmzcV73EOxAVAdfUOYIGG33xH40uR8L6Eu7
         p7Ww+jv7BWWDpl7NgkNKytQuanUs0VePJ+jd26U0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] ARM: dts: imx6q-kontron-samx6i: Remove old fsl,spi-num-chipselects
Date:   Sun, 23 Aug 2020 10:49:20 +0200
Message-Id: <20200823084920.3723-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The property "fsl,spi-num-chipselects" is gone since commit 790739c4417c
("dt-bindings: spi: Convert imx cspi to json-schema").

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi b/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi
index 2618eccfe50d..11c072cca492 100644
--- a/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi
+++ b/arch/arm/boot/dts/imx6q-kontron-samx6i.dtsi
@@ -14,7 +14,6 @@
 
 /* Quad/Dual SoMs have 3 chip-select signals */
 &ecspi4 {
-	fsl,spi-num-chipselects = <3>;
 	cs-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>,
 		   <&gpio3 29 GPIO_ACTIVE_HIGH>,
 		   <&gpio3 25 GPIO_ACTIVE_HIGH>;
-- 
2.17.1

