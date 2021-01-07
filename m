Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AF92EC9F6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 06:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbhAGFW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 00:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbhAGFWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 00:22:54 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11593C0612F4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 21:22:14 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id g3so2912809plp.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 21:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za0ag3gB6BLygdknHTVvvtS8ePIL/nwl6k31OOfDxZE=;
        b=Tnmzmw6gTBdTGrQLHVTJgg70+edzs3CwmWD24w5bKxEYd+cC6h+KH+WqeAgXhNKBC6
         9yGVmvX+9Vp12cpd96aW3er/3wAx6jbh5eCJ75e7Re3Z3RXY9+cwDtFSeA0/4k1KieEF
         pLd+5tiViTx4ii96oLIDQBlTC/pA6+q6EqnFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za0ag3gB6BLygdknHTVvvtS8ePIL/nwl6k31OOfDxZE=;
        b=YMC+jW8T0sMGOvFgEbuQ4h+KEFneBQYClsvBOOKD7gsrhjzW9NV+L8m0SMNarluCpY
         EtEDibvPrIMVahP+n3Z1ZTvEt7T1jiM03BIMZcblazfZMl18zcQ7MuhzpDaTx1yGnOQn
         soWX4i56tzTSGFfY/9BtQo+4eEEZukK1ANUPTxp2/fhFsKYoLhMokADEcmo14cKabT4y
         KJ34QYqwVwdrfMjrVR62I4cEyqoKZfMrRdQCQKGeigziwDwq1YAgwboVfWHEw/wkINnH
         QympvTmr1TaHAtySndc8TVqJsPuQsujF5CdaLt+z4RK3LjutbCQaVvNQCJUE5yrwA3m7
         UILA==
X-Gm-Message-State: AOAM532uH1aJuXhF4jDvWat2r1vk0bg0CwFT0xWAPKS2rM4lSc1Uqcd5
        RKSlOl7QZ/nLCTN9U/QCn/NE9Q==
X-Google-Smtp-Source: ABdhPJwS0OBQfa+LmuHpns922Cw47fL3IBS0sOudVb65hfbHUJOG8aWxpjmoXzGrZ+ZZXR3oDfIYjQ==
X-Received: by 2002:a17:902:654f:b029:da:347d:7af3 with SMTP id d15-20020a170902654fb02900da347d7af3mr7808509pln.18.1609996933598;
        Wed, 06 Jan 2021 21:22:13 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id c5sm4824479pgt.73.2021.01.06.21.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 21:22:13 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: mt8183: Add krane-sku0 board.
Date:   Thu,  7 Jan 2021 13:22:06 +0800
Message-Id: <20210107052206.2599844-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20210107052206.2599844-1-hsinyi@chromium.org>
References: <20210107052206.2599844-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to krane-sku176 but using a different panel source.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
Change:
v2: move compatible to board dts
---
 .../devicetree/bindings/arm/mediatek.yaml     |  1 +
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt8183-kukui-krane-sku0.dts  | 23 +++++++++++++++++++
 3 files changed, 25 insertions(+)
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
index 0000000000000..fb5ee91b6fe0e
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts
@@ -0,0 +1,23 @@
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
+};
-- 
2.29.2.729.g45daf8777d-goog

