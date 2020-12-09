Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7412D3F6C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgLIKBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:01:02 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:8314 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729523AbgLIKBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:01:01 -0500
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6HGqpg2w="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 47.6.2 DYNA|AUTH)
        with ESMTPSA id 908871wB99vi5Sm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 9 Dec 2020 10:57:44 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linus.walleij@linaro.org
Cc:     linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        Maxime Ripard <maxime.ripard@bootlin.com>, thesven73@gmail.com,
        lukas@wunner.de, laurent.pinchart@ideasonboard.com,
        andreas@kemnade.info, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] spi: dt-bindings: clarify CS behavior for spi-cs-high and gpio descriptors
Date:   Wed,  9 Dec 2020 10:57:44 +0100
Message-Id: <3bed61807fff6268789e7d411412fbc5cd6ffe2a.1607507863.git.hns@goldelico.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Behavior of CS signal in combination of spi-cs-high and gpio descriptors
is not clearly defined and documented. So clarify the documentation

Cc: linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 .../bindings/spi/spi-controller.yaml          | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-controller.yaml b/Documentation/devicetree/bindings/spi/spi-controller.yaml
index 1b56d5e40f1fc..5f505810104dd 100644
--- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
@@ -42,6 +42,33 @@ properties:
         cs2 : &gpio1 1 0
         cs3 : &gpio1 2 0
 
+      The second flag of a gpio descriptor can be GPIO_ACTIVE_HIGH (0)
+      or GPIO_ACTIVE_LOW(1). Legacy device trees often use 0.
+
+      There is a special rule set for combining the second flag of an
+      cs-gpio with the optional spi-cs-high flag for SPI slaves.
+
+      Each table entry defines how the CS pin is to be physically
+      driven (not considering potential gpio inversions by pinmux):
+
+      device node     | cs-gpio       | CS pin state active | Note
+      ================+===============+=====================+=====
+      spi-cs-high     | -             | H                   |
+      -               | -             | L                   |
+      spi-cs-high     | ACTIVE_HIGH   | H                   |
+      -               | ACTIVE_HIGH   | L                   | 1
+      spi-cs-high     | ACTIVE_LOW    | H                   | 2
+      -               | ACTIVE_LOW    | L                   |
+
+      Notes:
+      1) Should print a warning about polarity inversion.
+         Here it would be wise to avoid and define the gpio as
+         ACTIVE_LOW.
+      2) Should print a warning about polarity inversion
+         because ACTIVE_LOW is overridden by spi-cs-high.
+         Should be generally avoided and be replaced by
+         spi-cs-high + ACTIVE_HIGH.
+
   num-cs:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
-- 
2.26.2

