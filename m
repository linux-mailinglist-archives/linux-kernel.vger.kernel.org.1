Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA580294B51
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441788AbgJUKfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441780AbgJUKfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:35:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42656C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:35:00 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kVBSG-0006i7-8U; Wed, 21 Oct 2020 12:34:52 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kVBSE-00024Q-MQ; Wed, 21 Oct 2020 12:34:50 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Christophe Roullier <christophe.roullier@st.com>
Cc:     kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: arm: stm32: add simple-mfd compatible for tamp node
Date:   Wed, 21 Oct 2020 12:28:55 +0200
Message-Id: <20201021102855.18026-1-a.fatoum@pengutronix.de>
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

The stm32mp1 TAMP (Tamper and backup registers) does tamper detection
and features 32 backup registers that, being in the RTC domain, may
survive even with Vdd switched off.

This makes it suitable for use to communicate a reboot mode from OS
to bootloader via the syscon-reboot-mode binding. Add a "simple-mfd"
to support probing such a child node. The actual reboot mode
node could then be defined in a board.dts or fixed up by the bootloader.

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 available here:
https://lore.kernel.org/linux-arm-kernel/20200916142216.25142-1-a.fatoum@pengutronix.de/

v1 -> v2:
 - new patch, rebased on top of
   https://lore.kernel.org/r/20201014125441.2457-1-arnaud.pouliquen@st.com
---
 .../devicetree/bindings/arm/stm32/st,stm32-syscon.yaml       | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
index 6634b3e0853e..4684017a42e4 100644
--- a/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
+++ b/Documentation/devicetree/bindings/arm/stm32/st,stm32-syscon.yaml
@@ -19,8 +19,11 @@ properties:
               - st,stm32mp151-pwr-mcu
               - st,stm32-syscfg
               - st,stm32-power-config
-              - st,stm32-tamp
           - const: syscon
+      - items:
+          - const: st,stm32-tamp
+          - const: syscon
+          - const: simple-mfd
 
   reg:
     maxItems: 1
-- 
2.28.0

