Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCBC2EBB45
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 09:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbhAFIrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 03:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbhAFIrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 03:47:17 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07693C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 00:46:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e2so1779782pgi.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 00:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XfqO1B4CXfAktEO4OP7WVNtR8GYAt8b6FfkGFkAlye8=;
        b=JCMGXnw4hpCIMuCmzITNql8JVCFDO4s3SzbgoCqBvoN7yj3DnBQ3D0meZuqxG2QwOZ
         wZFU1mUN+DVDRxMvYYSscFVup0s3LwEYoukPjusvi4x9mUxcFhh4XyAEvm6ZzZCBEti2
         WzVgT2NXayAk80vQaQrdTUwP0qB2NHq9I1qd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XfqO1B4CXfAktEO4OP7WVNtR8GYAt8b6FfkGFkAlye8=;
        b=EOrdoCXmqwce5C8GHOHtToloWEVZjy/uMcTPUJa9FT35XXurvh9Ov7YuPJmGzpTT0+
         g3I3/SYwxi8o8VKcXuIE2pNF0smAo04HtRP64ta837C+hQDGB8oz4JPa7eW9rjc9h0bL
         dEcjATPBfR9MN/FsrZjNGy1dYYXwy8yz8Gxfb49JGSX2a1x3/OYXWa693PSQ1OoUDTEB
         5yVtS/g7KfJEdfsgMCIVliPSAE4XhlXdCJIGYyYdvQu6w8QkoiVw5JdK/Y7a4o73F3xn
         hLn/MFg/eYsc+yJCJw0NxaljhaESCV+mGY7QuiXvV+A+ZHOeQ1pNk+/wK/zP4PoRS0PJ
         tA7w==
X-Gm-Message-State: AOAM531OqOLvCOcs16YnLMy55uzmWqVbZv1S/+Df23/XaJcELihnQe92
        pUGjRfVrjcXuGeu71hptVH3apQ==
X-Google-Smtp-Source: ABdhPJw1OmoRcuh/NoSGaMxrAs1NAtbcRxJlotuwUZxrxa1f3/MMKUQpUnglVc6EVoPR9IDfvNeYYQ==
X-Received: by 2002:a63:105e:: with SMTP id 30mr3407174pgq.24.1609922796547;
        Wed, 06 Jan 2021 00:46:36 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id a31sm1913401pgb.93.2021.01.06.00.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 00:46:36 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: mt8183: Add krane-sku0 board.
Date:   Wed,  6 Jan 2021 16:46:26 +0800
Message-Id: <20210106084626.2181286-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210106084626.2181286-1-hsinyi@chromium.org>
References: <20210106084626.2181286-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to krane-sku176 but using a different panel source.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 .../devicetree/bindings/arm/mediatek.yaml     |  1 +
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt8183-kukui-krane-sku0.dts  | 30 +++++++++++++++++++
 3 files changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 53f0d4e3ea982..3276f7a2ce672 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -120,6 +120,7 @@ properties:
           - const: mediatek,mt8183
       - description: Google Krane (Lenovo IdeaPad Duet, 10e,...)
         items:
+          - const: google,krane-sku0
           - const: google,krane-sku176
           - const: google,krane
           - const: mediatek,mt8183
diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index 18f7b46c4095b..deba27ab76574 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-elm-hana-rev7.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku0.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8183-kukui-krane-sku176.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8192-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8516-pumpkin.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
new file mode 100644
index 0000000000000..4497291889506
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Copyright 2019 Google LLC
+ *
+ * Device-tree for Krane sku0.
+ *
+ * SKU is a 8-bit value (0x00 == 0):
+ *  - Bits 7..4: Panel ID: 0x0 (AUO)
+ *  - Bits 3..0: SKU ID:   0x0 (default)
+ */
+
+/dts-v1/;
+#include "mt8183-kukui-krane.dtsi"
+
+/ {
+	model = "MediaTek krane sku0 board";
+	compatible = "google,krane-sku0", "google,krane", "mediatek,mt8183";
+};
+
+&panel {
+	status = "okay";
+	compatible = "auo,kd101n80-45na";
+	reg = <0>;
+	enable-gpios = <&pio 45 0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&panel_pins_default>;
+	avdd-supply = <&ppvarn_lcd>;
+	avee-supply = <&ppvarp_lcd>;
+	pp1800-supply = <&pp1800_lcd>;
+};
-- 
2.29.2.729.g45daf8777d-goog

