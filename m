Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2C22D0623
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgLFQzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727301AbgLFQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:53:38 -0500
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEB4C0613D1;
        Sun,  6 Dec 2020 08:52:57 -0800 (PST)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 18864BFDEA;
        Sun,  6 Dec 2020 17:52:56 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 7E94AC1D4F; Sun,  6 Dec 2020 17:52:55 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id CA4EFC1D48;
        Sun,  6 Dec 2020 17:51:33 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 4/5] dt-bindings: arm: sunxi: Add SL631 with IMX179 bindings
Date:   Sun,  6 Dec 2020 17:51:30 +0100
Message-Id: <20201206165131.1041983-5-contact@paulk.fr>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206165131.1041983-1-contact@paulk.fr>
References: <20201206165131.1041983-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds documentation for the compatible strings of the
SL631 Action Camera with IMX179.

Note that the device is sold under various different names, such as the
SJCAM SJ4000 Air or F60 Action Camera. This is a similar situation to
the Q8 tablets and just like them, the allwinner vendor is used as
fallback.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 93e608aecae2..fd83805a2dfc 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -777,6 +777,12 @@ properties:
           - const: sinlinx,sina33
           - const: allwinner,sun8i-a33
 
+      - description: SL631 Action Camera with IMX179
+        items:
+          - const: allwinner,sl631-imx179
+          - const: allwinner,sl631
+          - const: allwinner,sun8i-v3
+
       - description: Tanix TX6
         items:
           - const: oranth,tanix-tx6
-- 
2.29.2

