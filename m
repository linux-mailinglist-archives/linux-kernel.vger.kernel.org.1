Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FC72F4990
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbhAMLFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbhAMLFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:05:25 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533BAC061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:04:44 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 30so1270788pgr.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 03:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3cAH/07vPZODQW/iF5DB+fIj9Loro7b2PieBM5y4hjk=;
        b=n73bBTV+qgeVERiT+pRZtp8rI/K5i4cyHtw0afjKRcKK0ymFGO5kUequSSD5KLvFj2
         7po2l5HB81nM/iOqshAEVC9fj8kfTo4ucbPqBA25fatG17f0rRLv0MZimfcWRXCbU2+i
         YY1cnAbZ2dJ7FZWeVsMPrTI2AXSYcgLvRGz8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cAH/07vPZODQW/iF5DB+fIj9Loro7b2PieBM5y4hjk=;
        b=bh5Y8bp7X3SRKGkvux3tCknR6ZjHMavHKgEgfKXknmdhNOzrOlRxib4MJ9DtYPRtM5
         NWxOglWiZJ6tPsiCXkBKpvwKgi4/HH2SahtQiX8NJyhaaqh+XkJdQdu7gvPusi49/S0b
         Ye/79sxHNpok7ivaeUVDfofoPnUkZraDuaz2nw7T0OIrYC0oh9FS3hgXxgpBBXz2hMQf
         xX3j5ec/WhY65UXvNgVtXEYMttUCMWJevLXA5jTBfsIklkwlmiRIjztxCITWf1HCeC/a
         BNKfWdAO+Ofp3xiHDYKbC1znEZQF+0mDfZmFOMeNNuQNxCVguWh9iPyk8p0zH2TZorwZ
         Vb1A==
X-Gm-Message-State: AOAM531nG1MkEgpDm2/ZvA4SGCJFEX0TnM+alrxtpEVvvTtTKru2GoE3
        z4UEHgtsHpxYCAclCwKoK5Mo6A==
X-Google-Smtp-Source: ABdhPJzAwL/zxe8BmvIl7VPRxz3Tcvo0YpZLNZfElkxWbEJFN57r2m4HrDQlqzfVQ0DTfqBH5i1GCg==
X-Received: by 2002:a62:2bd4:0:b029:1ae:4d9f:60da with SMTP id r203-20020a622bd40000b02901ae4d9f60damr1731172pfr.20.1610535883826;
        Wed, 13 Jan 2021 03:04:43 -0800 (PST)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:1a60:24ff:fe89:3e93])
        by smtp.gmail.com with ESMTPSA id o129sm2114749pfg.66.2021.01.13.03.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 03:04:43 -0800 (PST)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] arm64: dts: mt8183: Add krane-sku0 board.
Date:   Wed, 13 Jan 2021 19:04:01 +0800
Message-Id: <20210113110400.616319-2-hsinyi@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210113110400.616319-1-hsinyi@chromium.org>
References: <20210113110400.616319-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to krane-sku176 but using a different panel source.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---
change:
v4: split dt-binding to another patch
---
 arch/arm64/boot/dts/mediatek/Makefile         |  1 +
 .../dts/mediatek/mt8183-kukui-krane-sku0.dts  | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dts

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
2.30.0.284.gd98b1dd5eaa7-goog

