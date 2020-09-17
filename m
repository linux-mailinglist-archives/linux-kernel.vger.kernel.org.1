Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB426D3E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 08:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgIQGrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 02:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgIQGrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 02:47:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE271C061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:47:10 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w5so748597wrp.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YHTRbSYxiwB3ZQDUmxVKEyXQSDMyANy7ZOYYgytHKAA=;
        b=QlhqD01DrDGFTX1xNMS4ZO5VEJ9/raT3dY10P/Zw2hTR94Skm6WAiAAU81PST0DAqH
         q+rMkfmQwGpA+ZNn9UOb2tr3/OVYlYJu3t/ilm4+NYTy+pGEW8dbuWpyELG4VVIqdfB8
         4M8RiJZNx47fdlpnwzS5bmfh+VRbYQVQx8txafbC2UqaOG8oFqzV7DY/BI4Poj48RXH5
         +UhvtC8dbScM5tJtksdKLqwSuwHtJVti+ag+4VwC5gebJxrSkNJ3J9nQNLD/KcP3ZBj8
         MW9jGeaLnBkK0RUItsv7nbt3Uvl9h2O/MZGdVWQfTXbL81RTn4pWkhhZklCg0GSSmunY
         11cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YHTRbSYxiwB3ZQDUmxVKEyXQSDMyANy7ZOYYgytHKAA=;
        b=A0PKjg9pmhoKUoJMf9sdi111y98rUpwAwdri9+/z0FBp65WG9DKbiPraAX4okwS/YS
         GcN5Z+hygZ9moTlc7xo3EEZ3DOvu0pCgNX7NP9Flkw98ueA79u9ubdpuCkmA88icNoKB
         JEWNyVhb06B0/OQvxRez8NIy9WKCpgGbWeqinGynmVxVTWZyJar/1mLtZLGa+3aqsx7j
         B/oawB19uDsSKm1whVsG+US0Tr4Wy4QImPeZXfWS/lSofsMIvyw6R2qhBVZzOnt6CCbF
         ww++QIMI6afWuX2alPe5/21yq5FNSDqxuoDFbFwFZfGDXBdRVjY5ytxkbgYPrg3EY20f
         PPJg==
X-Gm-Message-State: AOAM532lRViAIBDCsOH49qk0XLPNJQv8Ai4pMZSxviMuHHSGj6/ZcEUz
        x4BTf1Z4v5cbbb868MnweBbtQQ==
X-Google-Smtp-Source: ABdhPJxxOngjpGTOMOIimvND/eMb+ZnzvjapG2m/s/ngeNrtLBfT0YebWIFLbPnbSpWgQt7+efFd9g==
X-Received: by 2002:adf:f106:: with SMTP id r6mr30908636wro.106.1600325228729;
        Wed, 16 Sep 2020 23:47:08 -0700 (PDT)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q4sm38516552wru.65.2020.09.16.23.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 23:47:08 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] dt-bindings: power: amlogic,meson-ee-pwrc: add Amlogic AXG power controller bindings
Date:   Thu, 17 Sep 2020 08:47:01 +0200
Message-Id: <20200917064702.1459-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200917064702.1459-1-narmstrong@baylibre.com>
References: <20200917064702.1459-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This add the bindings of the Power Controller found in the Amlogic AXG SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 23 +++++++++++++++++--
 include/dt-bindings/power/meson-axg-power.h   | 14 +++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/power/meson-axg-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index 4f524f822e84..d30f85cc395e 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -27,6 +27,7 @@ properties:
       - amlogic,meson8b-pwrc
       - amlogic,meson8m2-pwrc
       - amlogic,meson-gxbb-pwrc
+      - amlogic,meson-axg-pwrc
       - amlogic,meson-g12a-pwrc
       - amlogic,meson-sm1-pwrc
 
@@ -42,11 +43,11 @@ properties:
       - const: vapb
 
   resets:
-    minItems: 11
+    minItems: 5
     maxItems: 12
 
   reset-names:
-    minItems: 11
+    minItems: 5
     maxItems: 12
 
   "#power-domain-cells":
@@ -107,6 +108,24 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-axg-pwrc
+    then:
+      properties:
+        reset-names:
+          items:
+            - const: viu
+            - const: venc
+            - const: vcbus
+            - const: vencl
+            - const: vid_lock
+      required:
+        - resets
+        - reset-names
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/power/meson-axg-power.h b/include/dt-bindings/power/meson-axg-power.h
new file mode 100644
index 000000000000..e5243884b249
--- /dev/null
+++ b/include/dt-bindings/power/meson-axg-power.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2020 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_AXG_POWER_H
+#define _DT_BINDINGS_MESON_AXG_POWER_H
+
+#define PWRC_AXG_VPU_ID			0
+#define PWRC_AXG_ETHERNET_MEM_ID	1
+#define PWRC_AXG_AUDIO_ID		2
+
+#endif
-- 
2.22.0

