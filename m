Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978FB2D1334
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgLGOLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgLGOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:11:15 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203DCC061A56
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:10:11 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kmHCx-0003cO-Bi; Mon, 07 Dec 2020 15:09:43 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kmHCu-00089v-U4; Mon, 07 Dec 2020 15:09:40 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v7 1/8] dt-bindings: display: simple: fix alphabetical order for EDT compatibles
Date:   Mon,  7 Dec 2020 15:09:32 +0100
Message-Id: <20201207140939.31297-2-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207140939.31297-1-o.rempel@pengutronix.de>
References: <20201207140939.31297-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder it alphabetically and remove one double entry.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 .../bindings/display/panel/panel-simple.yaml       | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index edb53ab0d9eb..7e459ff974dd 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -105,26 +105,24 @@ properties:
       - dlc,dlc1010gig
         # Emerging Display Technology Corp. 3.5" QVGA TFT LCD panel
       - edt,et035012dm6
+        # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
+      - edt,et057090dhu
         # Emerging Display Technology Corp. 480x272 TFT Display with capacitive touch
       - edt,etm043080dh6gp
         # Emerging Display Technology Corp. 480x272 TFT Display
       - edt,etm0430g0dh6
-        # Emerging Display Technology Corp. 5.7" VGA TFT LCD panel
-      - edt,et057090dhu
-        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
-      - edt,etm070080dh6
-        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
-      - edt,etm0700g0dh6
         # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
         # Same as ETM0700G0DH6 but with inverted pixel clock.
       - edt,etm070080bdh6
+        # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
+        # Same timings as the ETM0700G0DH6, but with resistive touch.
+      - edt,etm070080dh6
         # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
         # Same display as the ETM0700G0BDH6, but with changed hardware for the
         # backlight and the touch interface.
       - edt,etm070080edh6
         # Emerging Display Technology Corp. WVGA TFT Display with capacitive touch
-        # Same timings as the ETM0700G0DH6, but with resistive touch.
-      - edt,etm070080dh6
+      - edt,etm0700g0dh6
         # Evervision Electronics Co. Ltd. VGG804821 5.0" WVGA TFT LCD Panel
       - evervision,vgg804821
         # Foxlink Group 5" WVGA TFT LCD panel
-- 
2.29.2

