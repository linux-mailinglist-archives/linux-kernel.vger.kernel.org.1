Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0296B287BCF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgJHSkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:40:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:51406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728800AbgJHSkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:40:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 645DDADCA;
        Thu,  8 Oct 2020 18:40:11 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Bastian Germann <bage@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: sunxi: Fix Orange Pi Zero bindings
Date:   Thu,  8 Oct 2020 20:40:06 +0200
Message-Id: <e657976d8bb1bb627c983321fe9c61de5bc003b7.1602182270.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <59f7b5c566825838bbb62b778e05c514fe355e74.1602182270.git.msuchanek@suse.de>
References: <59f7b5c566825838bbb62b778e05c514fe355e74.1602182270.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two models of Orange Pi zero which are confusingly marketed
under the same name. Old model comes without a flash memory and current
model does have a flash memory. Add bindings for each model.

Signed-off-by: Michal Suchanek <msuchanek@suse.de>
---
 Documentation/devicetree/bindings/arm/sunxi.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index efc9118233b4..7e76ea544bf7 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -864,8 +864,15 @@ properties:
           - const: xunlong,orangepi-win
           - const: allwinner,sun50i-a64
 
+      - description: Xunlong OrangePi Zero  (old model without flash memory)
+        items:
+          - const: xunlong,orangepi-zero-no-flash
+          - const: xunlong,orangepi-zero
+          - const: allwinner,sun8i-h2-plus
+
       - description: Xunlong OrangePi Zero
         items:
+          - const: xunlong,orangepi-zero-with-flash
           - const: xunlong,orangepi-zero
           - const: allwinner,sun8i-h2-plus
 
-- 
2.28.0

