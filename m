Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A642AD3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgKJK0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgKJK0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:26:02 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83AFC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 02:26:01 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kcQqZ-0008HI-JX; Tue, 10 Nov 2020 11:25:55 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kcQqY-00029c-M7; Tue, 10 Nov 2020 11:25:54 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: arm: stm32: add extra SiP compatible for lxa,stm32mp157c-mc1
Date:   Tue, 10 Nov 2020 11:25:50 +0100
Message-Id: <20201110102552.7270-2-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201110102552.7270-1-a.fatoum@pengutronix.de>
References: <20201110102552.7270-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Automation MC-1 is built around an OSD32MP15x SiP with CPU,
RAM, PMIC, Oscillator and EEPROM. Adjust the binding, so the SiP
compatible is contained as well. This allows boot firmware to match
against it to apply fixups if necessary.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 -> v2:
 - split up binding and device tree change
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
index 009b424e456e..9127094f0208 100644
--- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
@@ -40,7 +40,6 @@ properties:
       - items:
           - enum:
               - arrow,stm32mp157a-avenger96 # Avenger96
-              - lxa,stm32mp157c-mc1
               - shiratech,stm32mp157a-iot-box # IoT Box
               - shiratech,stm32mp157a-stinger96 # Stinger96
               - st,stm32mp157c-ed1
@@ -52,6 +51,13 @@ properties:
           - const: st,stm32mp157c-ev1
           - const: st,stm32mp157c-ed1
           - const: st,stm32mp157
+      - description: Octavo OSD32MP15x System-in-Package based boards
+        items:
+          - enum:
+              - lxa,stm32mp157c-mc1 # Linux Automation MC-1
+          - const: oct,stm32mp15xx-osd32
+          - enum:
+              - st,stm32mp157
       - description: Odyssey STM32MP1 SoM based Boards
         items:
           - enum:
-- 
2.28.0

