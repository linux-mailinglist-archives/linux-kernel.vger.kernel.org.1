Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81FE2ECD84
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbhAGKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbhAGKJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:09:35 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E51C0612FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:08:55 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kxSDZ-0004cu-17; Thu, 07 Jan 2021 11:08:33 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kxSDY-0007vN-52; Thu, 07 Jan 2021 11:08:32 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v6 2/5] dt-bindings: arm: fsl: add Kverneland UT1, UT1Q and UI1P boards
Date:   Thu,  7 Jan 2021 11:08:28 +0100
Message-Id: <20210107100831.30389-3-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210107100831.30389-1-o.rempel@pengutronix.de>
References: <20210107100831.30389-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Kverneland UT1 (imx6dl), UT1Q (imx6q) and UT1P (imx6dp) based boards

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 51b8d6fac792..bf78ad71b37e 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -210,6 +210,7 @@ properties:
               - kiebackpeter,imx6q-tpc    # K+P i.MX6 Quad TPC Board
               - kontron,imx6q-samx6i      # Kontron i.MX6 Dual/Quad SMARC Module
               - kosagi,imx6q-novena       # Kosagi Novena Dual/Quad
+              - kvg,vicut1q               # Kverneland UT1Q board
               - logicpd,imx6q-logicpd
               - lwn,display5              # Liebherr Display5 i.MX6 Quad Board
               - lwn,mccmon6               # Liebherr Monitor6 i.MX6 Quad Board
@@ -331,6 +332,7 @@ properties:
               - fsl,imx6qp-sabreauto      # i.MX6 Quad Plus SABRE Automotive Board
               - fsl,imx6qp-sabresd        # i.MX6 Quad Plus SABRE Smart Device Board
               - karo,imx6qp-tx6qp         # Ka-Ro electronics TX6QP-8037 Module
+              - kvg,vicutp                # Kverneland UT1P board
               - prt,prtwd3                # Protonic WD3 board
               - wand,imx6qp-wandboard     # Wandboard i.MX6 QuadPlus Board
               - zii,imx6qp-zii-rdu2       # ZII RDU2+ Board
@@ -364,6 +366,7 @@ properties:
               - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
               - karo,imx6dl-tx6dl         # Ka-Ro electronics TX6U Modules
               - kontron,imx6dl-samx6i     # Kontron i.MX6 Solo SMARC Module
+              - kvg,vicut1                # Kverneland UT1 board
               - ply,plybas                # Plymovent BAS board
               - ply,plym2m                # Plymovent M2M board
               - poslab,imx6dl-savageboard # Poslab SavageBoard Dual
-- 
2.30.0

