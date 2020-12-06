Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CC32D060B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgLFQmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 11:42:12 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:38194 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgLFQmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 11:42:12 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 1F990C0139;
        Sun,  6 Dec 2020 17:41:30 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 73CC7C1D2B; Sun,  6 Dec 2020 17:41:29 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id E396AC1D27;
        Sun,  6 Dec 2020 17:41:20 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] dt-bindings: sram: Document Allwinner V3s bindings for system-control
Date:   Sun,  6 Dec 2020 17:41:19 +0100
Message-Id: <20201206164119.1040880-1-contact@paulk.fr>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation about the Allwinner system-control bindings used
for the V3s SoC. The bindings are already in use in the device-tree
files and produced warnings in dt bindings checks.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../bindings/sram/allwinner,sun4i-a10-system-control.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
index 6ebcbc153691..5c978cb96632 100644
--- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
+++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
@@ -36,6 +36,9 @@ properties:
       - items:
           - const: allwinner,sun8i-r40-system-control
           - const: allwinner,sun4i-a10-system-control
+      - items:
+          - const: allwinner,sun8i-v3s-system-control
+          - const: allwinner,sun8i-h3-system-control
       - const: allwinner,sun50i-a64-sram-controller
         deprecated: true
       - const: allwinner,sun50i-a64-system-control
-- 
2.29.2

