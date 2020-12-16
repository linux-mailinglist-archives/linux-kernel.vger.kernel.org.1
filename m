Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C122DBCFA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgLPIsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 03:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgLPIsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:48:15 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3732BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 00:47:35 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id 4wnX2400v4C55Sk01wnXhA; Wed, 16 Dec 2020 09:47:32 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kpST5-00B6N3-H8; Wed, 16 Dec 2020 09:47:31 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kpST4-00Fzfo-UE; Wed, 16 Dec 2020 09:47:30 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dt-bindings: phy: Rename Intel Keem Bay USB PHY bindings
Date:   Wed, 16 Dec 2020 09:47:29 +0100
Message-Id: <20201216084729.3811627-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only file not using the "intel,keembay-*" pattern.
Fortunately the actual compatible value is already following the
standard scheme.

Fixes: 4086afa2a1627939 ("dt-bindings: phy: Add Intel Keem Bay USB PHY bindings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../{intel,phy-keembay-usb.yaml => intel,keembay-phy-usb.yaml}  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/phy/{intel,phy-keembay-usb.yaml => intel,keembay-phy-usb.yaml} (93%)

diff --git a/Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml b/Documentation/devicetree/bindings/phy/intel,keembay-phy-usb.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
rename to Documentation/devicetree/bindings/phy/intel,keembay-phy-usb.yaml
index a217bb8ac5bc0887..52815b6c2b88d019 100644
--- a/Documentation/devicetree/bindings/phy/intel,phy-keembay-usb.yaml
+++ b/Documentation/devicetree/bindings/phy/intel,keembay-phy-usb.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/intel,phy-keembay-usb.yaml#
+$id: http://devicetree.org/schemas/phy/intel,keembay-phy-usb.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Intel Keem Bay USB PHY bindings
-- 
2.25.1

