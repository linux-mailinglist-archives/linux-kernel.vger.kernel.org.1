Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014092A197C
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 19:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgJaSXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 14:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgJaSXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 14:23:38 -0400
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E861C0617A6;
        Sat, 31 Oct 2020 11:23:38 -0700 (PDT)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id AFF05C036C;
        Sat, 31 Oct 2020 19:23:35 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 190F2C1D75; Sat, 31 Oct 2020 19:23:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE autolearn=no
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (unknown [192.168.1.101])
        by gagarine.paulk.fr (Postfix) with ESMTP id 4F0A7C1D6E;
        Sat, 31 Oct 2020 19:21:57 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 8/9] dt-bindings: arm: sunxi: Add SL631 with IMX179 bindings
Date:   Sat, 31 Oct 2020 19:21:36 +0100
Message-Id: <20201031182137.1879521-9-contact@paulk.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182137.1879521-1-contact@paulk.fr>
References: <20201031182137.1879521-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible strings for the SL631 Action Camera with IMX179.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index afa00268c7db..0fa0c0b5d89f 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -754,6 +754,12 @@ properties:
           - const: sinlinx,sina33
           - const: allwinner,sun8i-a33
 
+      - description: SL631 Action Camera with IMX179
+        items:
+          - const: unknown,sl631-imx179
+          - const: unknown,sl631
+          - const: allwinner,sun8i-v3
+
       - description: Tanix TX6
         items:
           - const: oranth,tanix-tx6
-- 
2.28.0

