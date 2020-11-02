Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A466D2A2D9F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgKBPHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:07:05 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:50362 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgKBPHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:07:05 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 32A40A6D999; Mon,  2 Nov 2020 16:07:03 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Heiko Stuebner <heiko@sntech.de>, Aditya Prayoga <aditya@kobol.io>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH] dt-bindings: arm: rockchip: Add Kobol Helios64
Date:   Mon,  2 Nov 2020 16:06:58 +0100
Message-Id: <20201102150658.167161-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new board by Kobol introduced recently in
rockchip/rk3399-kobol-helios64.dts.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
Hello,

Heiko pointed out in irc that I missed this bit when submitting support
for the helios64 board (last submission starting at Message-Id:
<20201014200030.845759-1-uwe@kleine-koenig.org>).

Best regards
Uwe

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index db2e35796795..5b1dba1a9bb6 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -376,6 +376,11 @@ properties:
               - khadas,edge-v
           - const: rockchip,rk3399
 
+      - description: Kobol Helios64
+        items:
+          - const: kobol,helios64
+          - const: rockchip,rk3399
+
       - description: Mecer Xtreme Mini S6
         items:
           - const: mecer,xms6
-- 
2.28.0

