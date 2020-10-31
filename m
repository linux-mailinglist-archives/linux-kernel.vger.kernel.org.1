Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B68542A198A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 19:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbgJaS2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 14:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgJaS2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 14:28:47 -0400
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F3BC0617A7;
        Sat, 31 Oct 2020 11:28:46 -0700 (PDT)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 4D83EC0350;
        Sat, 31 Oct 2020 19:22:52 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id B1D51C1D67; Sat, 31 Oct 2020 19:22:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE autolearn=no
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (unknown [192.168.1.101])
        by gagarine.paulk.fr (Postfix) with ESMTP id 32357C1D69;
        Sat, 31 Oct 2020 19:21:55 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 4/9] dt-bindings: irq: sun7i-nmi: Add binding for the V3s NMI
Date:   Sat, 31 Oct 2020 19:21:32 +0100
Message-Id: <20201031182137.1879521-5-contact@paulk.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182137.1879521-1-contact@paulk.fr>
References: <20201031182137.1879521-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NMI interrupt controller takes a specific compatible for the V3s.
Add it to the device-tree bindings documentation.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index 8acca0ae3129..52364c2200ef 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -26,6 +26,7 @@ properties:
       - const: allwinner,sun6i-a31-sc-nmi
         deprecated: true
       - const: allwinner,sun7i-a20-sc-nmi
+      - const: allwinner,sun8i-v3s-sc-nmi
       - items:
           - const: allwinner,sun8i-a83t-r-intc
           - const: allwinner,sun6i-a31-r-intc
-- 
2.28.0

