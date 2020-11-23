Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987252C0E37
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgKWOwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgKWOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:52:04 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F491C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:52:04 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id t4so5926372wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEZ1OITwjc7OKfdtDJWO+IuuMpz7cR7Bh/LeoiGOQ8k=;
        b=bFSnRKfLlSTZsjpOyZlRdLr+9GsxVTIDaXh+Ozrr/6iIla6U4mb9wzUtVuMVNV2p/p
         FS/gLQbhUfAm1NBEaGqd+9GayjqPA48f+inUJO4yY7oEzG1KKuuXkHB8d7lZUywQI/h5
         zLhaoc8l/XeIK4P4AGPc52EZLRVkvGvtaUSal/pwA1bMubyw+vko7WdhmyEtAsHTxMRi
         xNW/Rc8Dn4WOhKTaqMe5E+kxw1gEKVA58UEi600DsdzbS8CedNBTkb4QrYklxQlFNEzb
         GCo5qWfXS4RNsXKmA6Q4Jbu0va5RZuDhLnwpYYDbi+djTz/oc1A1rtud4SHN46v54kSp
         bvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEZ1OITwjc7OKfdtDJWO+IuuMpz7cR7Bh/LeoiGOQ8k=;
        b=azAnndgDSNcqO/D55FeYlv7v5CxD0sHSuw0lz9v1iZqT3MIttHA5Pcxbma1BafqqXh
         /vGr48a8Xj8S3hZJYJ5kjRFXQ6xvg+SIyqCpkWZ1epiRBaTJgMVirjgmjra1ksKQmBpI
         1xVV/lEYjwRAPaQ9xGZZQcmL0n274lgxV42Q2Q6zzQgKcOHI1olcle5WO1HFJh7vDs4a
         9yQXaRe74D6DADjItkVjLBlNa5gTLUOUEMED/PV1APoSOc2H01FgQlZTlq/Ev86v1n5b
         2EZ4z0FuPCCWu04aOqiZxQu0hJt1e0QjDAVAKyDnYKjqniibwonmf60XuKmHmT2R6SeX
         9SgA==
X-Gm-Message-State: AOAM530SIe+bYcNX4w/B7u2kkj9ckM8oXPKLJDtJkSRK3DtVw41kFScl
        RcE6F504Nbg1Jbq8MYodGO2oNw==
X-Google-Smtp-Source: ABdhPJyCKHzsFFIcaH2EeQrhpd3TFYZexAVFJ1Jhy5BUT/T1CRHH+5hqfiSTieF5VcrojJRsELxkPA==
X-Received: by 2002:adf:916e:: with SMTP id j101mr25757231wrj.55.1606143122651;
        Mon, 23 Nov 2020 06:52:02 -0800 (PST)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9541:d2fd:3a68:67ae])
        by smtp.gmail.com with ESMTPSA id 9sm14225175wmo.34.2020.11.23.06.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:52:01 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     vkoul@kernel.org, kishon@ti.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
Date:   Mon, 23 Nov 2020 15:51:56 +0100
Message-Id: <20201123145157.300456-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201123145157.300456-1-narmstrong@baylibre.com>
References: <20201123145157.300456-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This Analog D-PHY works with a separate Digital MIPI D-PHY.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
new file mode 100644
index 000000000000..28663552f05b
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic G12A MIPI analog PHY
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |+
+  The Everything-Else Power Domains node should be the child of a syscon
+  node with the required property:
+
+  - compatible: Should be the following:
+                "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon"
+
+  Refer to the the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.yaml
+
+properties:
+  compatible:
+    const: amlogic,g12a-mipi-dphy-analog
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    mpphy: phy {
+          compatible = "amlogic,g12a-mipi-dphy-analog";
+          #phy-cells = <0>;
+    };
-- 
2.25.1

