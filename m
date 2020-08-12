Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D847242701
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 10:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHLI4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 04:56:31 -0400
Received: from inva020.nxp.com ([92.121.34.13]:49026 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbgHLI4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:56:31 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A63AA1A0CAE;
        Wed, 12 Aug 2020 10:56:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CB74F1A004F;
        Wed, 12 Aug 2020 10:56:22 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 52DD14024E;
        Wed, 12 Aug 2020 10:56:15 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, gregkh@linuxfoundation.org,
        galak@codeaurora.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/5] dt-bindings: clock: Update i.MX28 example
Date:   Wed, 12 Aug 2020 16:51:20 +0800
Message-Id: <1597222284-32609-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the i.MX28 clock example to align with MXS AUART binding doc to
avoid below build error:

Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
  serial@8006a000: clocks: [[4294967295, 45]] is too short
Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
  serial@8006a000: compatible: Additional items are not allowed
  ('fsl,imx23-auart' was unexpected)
Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
  serial@8006a000: compatible: ['fsl,imx28-auart', 'fsl,imx23-auart']
  is too long
Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
  serial@8006a000: 'dmas' is a required property
Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml:
  serial@8006a000: 'dma-names' is a required property

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
new patch.
---
 Documentation/devicetree/bindings/clock/imx28-clock.yaml | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx28-clock.yaml b/Documentation/devicetree/bindings/clock/imx28-clock.yaml
index 72328d5..671b279 100644
--- a/Documentation/devicetree/bindings/clock/imx28-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/imx28-clock.yaml
@@ -108,8 +108,10 @@ examples:
     };
 
     serial@8006a000 {
-        compatible = "fsl,imx28-auart", "fsl,imx23-auart";
+        compatible = "fsl,imx28-auart";
         reg = <0x8006a000 0x2000>;
-        interrupts = <112 70 71>;
+        interrupts = <112>;
+        dmas = <&dma_apbx 8>, <&dma_apbx 9>;
+        dma-names = "rx", "tx";
         clocks = <&clks 45>;
     };
-- 
2.7.4

