Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B972A57E0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 22:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732344AbgKCVq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 16:46:29 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:57342 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732031AbgKCUwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:52:05 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 8E45DBFBC2;
        Tue,  3 Nov 2020 21:52:03 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id D7C37C1D56; Tue,  3 Nov 2020 21:52:02 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 0B0C2C1D43;
        Tue,  3 Nov 2020 21:51:01 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 1/6] dt-bindings: irq: sun7i-nmi: Add binding documentation for the V3s NMI
Date:   Tue,  3 Nov 2020 21:50:53 +0100
Message-Id: <20201103205058.435207-2-contact@paulk.fr>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201103205058.435207-1-contact@paulk.fr>
References: <20201103205058.435207-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to a register layout that's different from any other supported
Allwinner SoC, the NMI interrupt controller takes a specific compatible
for the V3s. Add it to the device-tree bindings documentation.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index 8acca0ae3129..077803277b34 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -29,6 +29,7 @@ properties:
       - items:
           - const: allwinner,sun8i-a83t-r-intc
           - const: allwinner,sun6i-a31-r-intc
+      - const: allwinner,sun8i-v3s-sc-nmi
       - const: allwinner,sun9i-a80-nmi
       - items:
           - const: allwinner,sun50i-a64-r-intc
-- 
2.29.1

