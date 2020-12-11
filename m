Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78FF02D817F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394262AbgLKWBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404913AbgLKWAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:00:38 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58B3C0613D3;
        Fri, 11 Dec 2020 13:59:57 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id m13so12602896ljo.11;
        Fri, 11 Dec 2020 13:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDoKcYpl/2aB4jgQj/68syTUZwXEKvTgElKugBhctZc=;
        b=l9cJWdS5w4lFyQHgz6nXcunvA0RfufrXycm5oYvhaMU+W8JXYsas3V4PfjmmBO6clD
         4EmAfxBl8pNlb/Kh/nk8t5rhDCDcIx+EQySfPGgWdojT1sxm9La/9OSAPlKpl4+gWknI
         Wihyd+LwsHAkmJbnz5IjtFNnlRXZW5WG2aKrvK695pR1wKFoVot+oNowscCYZaH7lFLY
         k3tk65RWkV9F3i1yoO2xF1PopJRuDgZTaIdjXzljNkOc67cuMY+tyMj/yj/qb2XBRHR0
         tAWgT7YXuMdJZ5Hz6I6V8OzM2dQm7EC5jcKgV8i4AnKQEZIN9lZ4/5kZpORMGZgpuopP
         VFig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDoKcYpl/2aB4jgQj/68syTUZwXEKvTgElKugBhctZc=;
        b=IaCaKiGyjZud+Xs95njOf9E/FEaM3Pb0ZqEtvBaSEq4WN1D06+EsfRxSKF6lEMh5/1
         koZDVjLJ2WkTD7Cx1AdAQv2em/NgtX8MNWktYzLgotaQR8treAolDcRATPqUu6Jo/eRq
         rVqWLOY0Ti0KmuQM2NzwkdTAdb9Y2JAvAMME2rXXy9erEgrZfiM2konwnuGv5uwjjJ5/
         jRVbEE+55uGpRIJrncsTSw2wUwsoQMHI+snkzR33SspQLq0JHRgNZMNvt+j7NGrNWjR5
         iJnpPRrLBKbuQC+kcNGTu6PpKSCDbxGFLfBIhDiN7zqsawE80EbDecImWd37du+V6w/u
         AZDQ==
X-Gm-Message-State: AOAM5333nqWzWmDpB5KebE4S6BFNkf4UqbRpk4g9khkrcRUTxqzNRWMX
        hRyLP9+9xgCTWGRoOSJshUo=
X-Google-Smtp-Source: ABdhPJwJXzNsy0U4hLXg88FGI8xpm6leQV+H8EEBJbZVtmdAfLvzTm1DfolDejq5w8m/01TKuYzTmw==
X-Received: by 2002:a2e:a54f:: with SMTP id e15mr6118241ljn.461.1607723996209;
        Fri, 11 Dec 2020 13:59:56 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id d21sm1026140lfi.137.2020.12.11.13.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 13:59:55 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: power: document Broadcom's PMB binding
Date:   Fri, 11 Dec 2020 22:59:41 +0100
Message-Id: <20201211215942.5726-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201211215942.5726-1-zajec5@gmail.com>
References: <20201211215942.5726-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Broadcom's PMB is power controller used for disabling and enabling SoC
devices.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../bindings/power/brcm,bcm-pmb.yaml          | 50 +++++++++++++++++++
 include/dt-bindings/soc/bcm-pmb.h             | 11 ++++
 2 files changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
 create mode 100644 include/dt-bindings/soc/bcm-pmb.h

diff --git a/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml b/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
new file mode 100644
index 000000000000..40b08d83c80b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/brcm,bcm-pmb.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/brcm,bcm-pmb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom PMB (Power Management Bus) controller
+
+description: This document describes Broadcom's PMB controller. It supports
+  powering various types of connected devices (e.g. PCIe, USB, SATA).
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm4908-pmb
+
+  reg:
+    description: register space of one or more buses
+    maxItems: 1
+
+  big-endian:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Flag to use for block working in big endian mode.
+
+  "#power-domain-cells":
+    description: cell specifies device ID (see bcm-pmb.h)
+    const: 1
+
+required:
+  - reg
+  - "#power-domain-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/soc/bcm-pmb.h>
+
+    pmb: power-controller@802800e0 {
+        compatible = "brcm,bcm4908-pmb";
+        reg = <0x802800e0 0x40>;
+        #power-domain-cells = <1>;
+    };
+
+    foo {
+        power-domains = <&pmb BCM_PMB_PCIE0>;
+    };
diff --git a/include/dt-bindings/soc/bcm-pmb.h b/include/dt-bindings/soc/bcm-pmb.h
new file mode 100644
index 000000000000..744dc3af4d41
--- /dev/null
+++ b/include/dt-bindings/soc/bcm-pmb.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR MIT */
+
+#ifndef __DT_BINDINGS_SOC_BCM_PMB_H
+#define __DT_BINDINGS_SOC_BCM_PMB_H
+
+#define BCM_PMB_PCIE0				0x01
+#define BCM_PMB_PCIE1				0x02
+#define BCM_PMB_PCIE2				0x03
+#define BCM_PMB_HOST_USB			0x04
+
+#endif
-- 
2.26.2

