Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4AA210BAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbgGANDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731025AbgGANDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:03:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8B2C03E97B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:03:48 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jqcOk-0003Cc-4F; Wed, 01 Jul 2020 15:03:34 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jqcOj-0002O0-Cm; Wed, 01 Jul 2020 15:03:33 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH v9 1/5] dt-bindings: arm: fsl: add different Protonic boards
Date:   Wed,  1 Jul 2020 15:03:26 +0200
Message-Id: <20200701130330.9089-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200701130330.9089-1-o.rempel@pengutronix.de>
References: <20200701130330.9089-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Protonic PRTI6Q, WD2, RVT, VT7 boards.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 05906e291e38..3bb4fbe552e4 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -120,6 +120,8 @@ properties:
               - fsl,imx6q-sabrelite
               - fsl,imx6q-sabresd
               - kontron,imx6q-samx6i      # Kontron i.MX6 Dual/Quad SMARC Module
+              - prt,prti6q                # Protonic PRTI6Q board
+              - prt,prtwd2                # Protonic WD2 board
               - technexion,imx6q-pico-dwarf   # TechNexion i.MX6Q Pico-Dwarf
               - technexion,imx6q-pico-hobbit  # TechNexion i.MX6Q Pico-Hobbit
               - technexion,imx6q-pico-nymph   # TechNexion i.MX6Q Pico-Nymph
@@ -172,6 +174,8 @@ properties:
               - fsl,imx6dl-sabreauto      # i.MX6 DualLite/Solo SABRE Automotive Board
               - fsl,imx6dl-sabresd        # i.MX6 DualLite SABRE Smart Device Board
               - kontron,imx6dl-samx6i     # Kontron i.MX6 Solo SMARC Module
+              - prt,prtrvt                # Protonic RVT board
+              - prt,prtvt7                # Protonic VT7 board
               - technexion,imx6dl-pico-dwarf   # TechNexion i.MX6DL Pico-Dwarf
               - technexion,imx6dl-pico-hobbit  # TechNexion i.MX6DL Pico-Hobbit
               - technexion,imx6dl-pico-nymph   # TechNexion i.MX6DL Pico-Nymph
-- 
2.27.0

