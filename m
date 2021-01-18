Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC42FA027
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404212AbhARMms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 07:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404047AbhARMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 07:36:57 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCFFC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 04:35:44 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id JCbi2400h4C55Sk06CbiEp; Mon, 18 Jan 2021 13:35:42 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1Tl0-004aJd-3l; Mon, 18 Jan 2021 13:35:42 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1l1Tkz-002MtG-9f; Mon, 18 Jan 2021 13:35:41 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Robin van der Gracht <robin@protonic.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kaplan <M.KAPLAN@evva.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] dt-bindings: auxdisplay: ht16k33: Keyscan function should be optional
Date:   Mon, 18 Jan 2021 13:35:36 +0100
Message-Id: <20210118123538.564597-2-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118123538.564597-1-geert@linux-m68k.org>
References: <20210118123538.564597-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robin van der Gracht <robin@protonic.nl>

Keyscan should be optional to support simple LED matrix displays (output
only).

Reported-by: Michael Kaplan <M.KAPLAN@evva.com>
Signed-off-by: Robin van der Gracht <robin@protonic.nl>
[geert: Rebased]
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 .../devicetree/bindings/display/ht16k33.txt        | 11 +++++++----
 drivers/auxdisplay/ht16k33.c                       | 14 ++++++--------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/ht16k33.txt b/Documentation/devicetree/bindings/display/ht16k33.txt
index d5a8b070b46779a4..3d602f5b9eb6bb74 100644
--- a/Documentation/devicetree/bindings/display/ht16k33.txt
+++ b/Documentation/devicetree/bindings/display/ht16k33.txt
@@ -4,16 +4,19 @@ Holtek ht16k33 RAM mapping 16*8 LED controller driver with keyscan
 Required properties:
 - compatible:		"holtek,ht16k33"
 - reg:			I2C slave address of the chip.
-- interrupts:		Interrupt specification for the key pressed interrupt.
 - refresh-rate-hz:	Display update interval in HZ.
-- debounce-delay-ms:	Debouncing interval time in milliseconds.
-- linux,keymap: 	The keymap for keys as described in the binding
-			document (devicetree/bindings/input/matrix-keymap.txt).
 
 Optional properties:
 - linux,no-autorepeat:	Disable keyrepeat.
 - default-brightness-level: Initial brightness level [0-15] (default: 15).
 
+- Keypad
+ Supply the 'interrupts' property to enable the keyscan feature.
+ - interrupts:		Interrupt specification for the key pressed interrupt.
+ - debounce-delay-ms:	Debouncing interval time in milliseconds.
+ - linux,keymap: 	The keymap for keys as described in the binding
+			document (devicetree/bindings/input/matrix-keymap.txt).
+
 Example:
 
 &i2c1 {
diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
index d951d54b26f5239b..444f3b1019e3d425 100644
--- a/drivers/auxdisplay/ht16k33.c
+++ b/drivers/auxdisplay/ht16k33.c
@@ -402,11 +402,6 @@ static int ht16k33_probe(struct i2c_client *client,
 		return -EIO;
 	}
 
-	if (client->irq <= 0) {
-		dev_err(&client->dev, "No IRQ specified\n");
-		return -EINVAL;
-	}
-
 	priv = devm_kzalloc(&client->dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
@@ -459,9 +454,12 @@ static int ht16k33_probe(struct i2c_client *client,
 	if (err)
 		goto err_fbdev_info;
 
-	err = ht16k33_keypad_probe(client, &priv->keypad);
-	if (err)
-		goto err_fbdev_unregister;
+	/* Keypad */
+	if (client->irq > 0) {
+		err = ht16k33_keypad_probe(client, &priv->keypad);
+		if (err)
+			goto err_fbdev_unregister;
+	}
 
 	/* Backlight */
 	memset(&bl_props, 0, sizeof(struct backlight_properties));
-- 
2.25.1

