Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78142283EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 17:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgGUPhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 11:37:06 -0400
Received: from comms.puri.sm ([159.203.221.185]:54724 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729612AbgGUPhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:37:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 04C88E031F;
        Tue, 21 Jul 2020 08:37:04 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 62QamMgfWfaW; Tue, 21 Jul 2020 08:37:03 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, kernel@puri.sm, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, mchehab@kernel.org, Anson.Huang@nxp.com,
        agx@sigxcpu.org, angus@akkea.ca, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v4 3/3] dt-bindings: arm: fsl: Add the librem 5 phone
Date:   Tue, 21 Jul 2020 17:32:25 +0200
Message-Id: <20200721153225.7593-3-martin.kepplinger@puri.sm>
In-Reply-To: <20200721153225.7593-1-martin.kepplinger@puri.sm>
References: <20200721153225.7593-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entries for the imx8mq based Librem 5 phone. The "Birch" and
"Chestnut" hardware revisions are supported by r2. The "Dogwood"
revision by r3.
See https://puri.sm/products/librem-5/ and https://developer.puri.sm/Librem5/
for the schematics and more information.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index f63895c8ce2d..1cce4ff58ff8 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -365,6 +365,8 @@ properties:
               - fsl,imx8mq-evk            # i.MX8MQ EVK Board
               - google,imx8mq-phanbell    # Google Coral Edge TPU
               - purism,librem5-devkit     # Purism Librem5 devkit
+              - purism,librem5r2          # Purism Librem5 phone "Chestnut"
+              - purism,librem5r3          # Purism Librem5 phone "Dogwood"
               - solidrun,hummingboard-pulse # SolidRun Hummingboard Pulse
               - technexion,pico-pi-imx8m  # TechNexion PICO-PI-8M evk
           - const: fsl,imx8mq
-- 
2.20.1

