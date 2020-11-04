Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AFC2A637C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKDLj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKDLj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:39:56 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D302C061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 03:39:55 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kaH8m-0000Lv-6f; Wed, 04 Nov 2020 12:39:48 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kaH8j-0003vV-LI; Wed, 04 Nov 2020 12:39:45 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kernel@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: arm: stm32: lxa,stm32mp157c-mc1: add extra SiP compatible
Date:   Wed,  4 Nov 2020 12:39:31 +0100
Message-Id: <20201104113932.30702-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux Automation MC-1 is built around a SIP with CPU, RAM, PMIC,
Oscillator and EEPROM. Add a further compatible identifying the SiP,
so boot firmware can match against it to apply fixups if necessary.

To avoid intermittent dtbs_check breakage in the sole upstream device
tree that uses that SiP, patch it here as well.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
I know that bindings and device tree patches should be separate. Does
this apply here as well? Should I split the dts change into a follow-up
commit? Is it ok that dtbs_check will report an intermittent breakage?
---
 Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 8 +++++++-
 arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts              | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

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
diff --git a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
index 1e5333fd437f..cda8e871f999 100644
--- a/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts
@@ -15,7 +15,7 @@
 
 / {
 	model = "Linux Automation MC-1 board";
-	compatible = "lxa,stm32mp157c-mc1", "st,stm32mp157";
+	compatible = "lxa,stm32mp157c-mc1", "oct,stm32mp15xx-osd32", "st,stm32mp157";
 
 	aliases {
 		ethernet0 = &ethernet0;
-- 
2.28.0

