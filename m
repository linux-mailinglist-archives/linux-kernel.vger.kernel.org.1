Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120452F9659
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 00:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730911AbhAQXqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 18:46:03 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54631 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730324AbhAQXoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 18:44:24 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 00F275C0118;
        Sun, 17 Jan 2021 18:43:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 17 Jan 2021 18:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=5gKoN15dIUtAq
        Kn8b+J7kqUems84ofElKABi15OjQdY=; b=Hpp+eDAt/RB6ybRXi4tuGt6fjfLF+
        AcAc3IqBGVVTeFGWtsU6fCY5h1MMiQ9Pb9OYEvJtLjGeycF/hYL07k//Ygiekwnc
        4rGTmDU5+I4xNDG++XU45Xv6RUrlifGPINdgoF+cUX68O9bvce1EwrChFGClOeH5
        NCDiEzs4qXNGlluVxqMJYGJuDpbPW/ewFTsb884OMYWxIGqNoNQU7OoFhp4Mqeqj
        6xaLmx5Uubeo3g7jER03yxy/yIwxZI2VsUnF/Y4p4MTBk6rxMByr/sr7nk1ddjbi
        ZZJ97KrESxv1eqWhDXEPtE/5tsuYLs+ww3P6YomhntrqvVaZNJE33PbRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=5gKoN15dIUtAqKn8b+J7kqUems84ofElKABi15OjQdY=; b=EbRR7iiM
        6wwCiPcnBlHOGhe1gRZtdNBaMCgjHM8IUZO4Q3CsSIAfo9QVcN1Ce3/kzXicwHFm
        1xWc4YpXe65fV2Id0jX+3G2BFDQOOrc4U4GV9zitiPO7BvUTXXny3hALR1nHQbM9
        sZfrWhdNUO0D3Cx1KKcaHXTegIlhIbeVOdnrQDnBEVmWejbX3vavb3GMKmPC6xkL
        WYMer61RmbSZj3caqHwuYAEUnF3+DKaM1ev5ihRvuYkZy2EMJCdBXnlfdVNg+tkc
        w8cBkhIEOpBfZPAky36geQtJ6vqr2O7xJ9gNq97L72rVgzhdwf7EfdlUnSODAX8Q
        zMLKMjN9h4Ucig==
X-ME-Sender: <xms:qcsEYC0ow3-c94T8piGiw4uOPY7eRJdDcF5dBq-JpsbPksplNn8XBQ>
    <xme:qcsEYOs7QaeYCNMZFkBT6QQ7Lfni29ZnHDLTSsShv_bhYLyhVwLbbzGuMkEUymJCU
    ie0i2errteDVwBEhmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepffdthffggefgle
    fgkeejhfekiefgleelfefhtefhheefteelgeeggefgfeffvddtnecuffhomhgrihhnpegu
    vghvihgtvghtrhgvvgdrohhrghenucfkphepjeefrdelfedrkeegrddvtdeknecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:qcsEYK6cEYuNYld3wBzB_FULSPP9Oj-YQDLhsauc4L_2crLlz0fScQ>
    <xmx:qcsEYHISKpKzFDHeP_Ob8aCJdeKkzXo6yw0qPDr5HPA0M04YSNJXFQ>
    <xmx:qcsEYC7KXs52zRV4qj2AQz3b_K9gka20k86rv3DljHAWVUnPuDYxRQ>
    <xmx:qcsEYAxVTnR8KhDfOFuzacRXfaovR2JRCalcrBsE10OZuLrUqG7xnQ>
Received: from ThinkpadX1Yoga3.localdomain (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id DFE8C240057;
        Sun, 17 Jan 2021 18:43:35 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 3/6] devicetree/bindings: Initial commit of silergy,sy7636a-regulator.yaml
Date:   Sat, 16 Jan 2021 20:25:36 -0800
Message-Id: <20210117042539.1609-3-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210117042539.1609-1-alistair@alistair23.me>
References: <20210117042539.1609-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial support for the Silergy SY7636A-regulator Power Management chip
driver.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../bindings/regulator/silergy,sy7636a.yaml   | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/silergy,sy7636a.yaml

diff --git a/Documentation/devicetree/bindings/regulator/silergy,sy7636a.yaml b/Documentation/devicetree/bindings/regulator/silergy,sy7636a.yaml
new file mode 100644
index 000000000000..d88c4ab1be02
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/silergy,sy7636a.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/silergy,sy7636a-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: silergy sy7636a PMIC
+
+maintainers:
+  - Alistair Francis <alistair@alistair23.me>
+
+allOf:
+  - $ref: regulator.yaml#
+
+properties:
+  compatible:
+    enum:
+      - sy7636a-regulator
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        regulator@60 {
+          compatible = "sy7636a-regulator";
+          reg_epdpmic: vcom {
+            regulator-name = "vcom";
+            regulator-boot-on;
+          };
+        };
+    };
+
+...
-- 
2.29.2

