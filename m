Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E78E2B1E38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgKMPHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:07:20 -0500
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:42339 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726889AbgKMPHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:07:19 -0500
X-Originating-IP: 84.44.14.226
Received: from nexussix.ar.arcelik (unknown [84.44.14.226])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 2081720003;
        Fri, 13 Nov 2020 15:07:09 +0000 (UTC)
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Cengiz Can <cengiz@kernel.wtf>
Subject: [PATCH] dt-bindings: fsl-imx-drm: fix example compatible string
Date:   Fri, 13 Nov 2020 18:06:19 +0300
Message-Id: <20201113150618.417424-1-cengiz@kernel.wtf>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Example `display-subsystem` has an incorrect compatible string.

Required properties section tells that developers should use
"fsl,imx-display-subsystem" as "compatible" string but the example
misses 'imx-' prefix.

Change example to have correct "compatible" string.

Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
---
 Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt b/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
index 5a99490c17b9..3c35338a2867 100644
--- a/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
+++ b/Documentation/devicetree/bindings/display/imx/fsl-imx-drm.txt
@@ -12,7 +12,7 @@ Required properties:
 example:
 
 display-subsystem {
-	compatible = "fsl,display-subsystem";
+	compatible = "fsl,imx-display-subsystem";
 	ports = <&ipu_di0>;
 };
 
-- 
2.29.2

