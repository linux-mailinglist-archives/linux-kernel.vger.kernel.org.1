Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7002F9656
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 00:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730813AbhAQXou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 18:44:50 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:39587 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729128AbhAQXoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:22 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id EADC55C0115;
        Sun, 17 Jan 2021 18:43:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sun, 17 Jan 2021 18:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=Ua2hz2ockS+fhQT1CoQlw/0yz7
        pRrE2jiu2BjbpcR3I=; b=bxigC4xn4Tbegnhlnc2IIKrNMWSvxBm4LGosvyaenA
        aspbjJ6B6JjV8cTNj5fDpqDS/0Vcv14RaCd9eRIOzEdoE1cUKpmU12vsdE3SfEea
        s9+sG55/QJlUQ49e7PTUrhvR7oULVBTPh550lyuq2OLvL/J18YNT1no19AgFNsdq
        WntrAQw6O2tkoekFI/pxy8AgvHJvszslc9ycU/QtYLyKXroag76Smp63jNLmzLcG
        3UTnf5x8gOYTWGxCBakNjr3R5QoMckb9C6vzhDY//AIEGI2PQJXzRjmXTJR3Id47
        Y3Pn8cf8LHfOVdWEKO1A0IMa7r3Upoi9RKN+tC2gLtDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Ua2hz2ockS+fhQT1C
        oQlw/0yz7pRrE2jiu2BjbpcR3I=; b=DXPSR/X943Mml+KuQxhBuihTUDnPV+hIB
        UBkkLcrcso1HGqIy/3q2WQGdjnOFj0tndXN1WUBdbKwIvyFnWgA8JNSK5DMRRkAc
        pvtuUV+Q6kF8eb7mO90gaO5tD50ngtf9YC8O6mkqaJXXPeokFkg2vZMtW4yQ3pZt
        yMxyg1LnJMkhgqKU44BJN5U6aSNhk1B4JsO/sceqwk29cCwxV/7357eCJg96slXa
        Hyy6E3OF0ubY+NZt8ZrGNp4tdwYVPDIjfG2KNk00dSwd6G40r0yfOHs5OT+NWDbh
        Qj9dJNMv0Pj4CplQRh5P4kPAB2kUaHnP+ee62BvAlLc4V40k7xZEg==
X-ME-Sender: <xms:pssEYKdJfeKBcld3GGZ4lXpJfOuLKEXYF9k5T0qpZS8nIZS8XGaWjA>
    <xme:pssEYEOCbv-oFdAGQgkqCLuldb7KN9ljCBTxDk0uhfP5dfpwr0bxpWOkCvhjfPdbY
    MNMa4P3mywAGOgVUUY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertdertd
    dtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhes
    rghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepveeiueduhfevheetle
    dvgfeuhfejgfffieejhedttdffudfhheegjeefjeffleehnecuffhomhgrihhnpeguvghv
    ihgtvghtrhgvvgdrohhrghenucfkphepjeefrdelfedrkeegrddvtdeknecuvehluhhsth
    gvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegr
    lhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:pssEYLgAOjLoHyD4H_nyzyK9pmpmIXK_t1s1EmhdvPhZKexFLATOFQ>
    <xmx:pssEYH8K2_1C_Wi2clBW0lVLXvMXI2ui9Mj73zl_Esvr1A7bfmpF-Q>
    <xmx:pssEYGtWCe2vj339K3uFDDw8-wiJfC-L279lUXHV8_9gSZ1c4oStNQ>
    <xmx:pssEYKhmfCe9YE3uTsm21sVqFA-GHzAOyAvgeZf-CCDjOsHjva4PHw>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 89083240057;
        Sun, 17 Jan 2021 18:43:33 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 1/6] devicetree/bindings: Initial commit of silergy,sy7636a.yaml
Date:   Sat, 16 Jan 2021 20:25:34 -0800
Message-Id: <20210117042539.1609-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A Power Management chip
driver.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../bindings/mfd/silergy,sy7636a.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..37541a7fcc5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/silergy,sy7636a.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/silergy,sy7636a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: silergy sy7636a PMIC
+
+maintainers:
+  - Alistair Francis <alistair@alistair23.me>
+
+properties:
+  compatible:
+    enum:
+      - silergy,sy7636a
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@60 {
+          compatible = "silergy,sy7636a";
+          reg = <0x60>;
+        };
+    };
+
+...
-- 
2.29.2

