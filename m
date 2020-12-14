Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D842D9E97
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440659AbgLNSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440627AbgLNSIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:08:48 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13B6C061793;
        Mon, 14 Dec 2020 10:08:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a12so32478391lfl.6;
        Mon, 14 Dec 2020 10:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zDoKcYpl/2aB4jgQj/68syTUZwXEKvTgElKugBhctZc=;
        b=hpYxcr394VP+xAw+146NJKdzFodipjSeU65GlM9r7+Oo7WwtNuzLrL0PZiJGluUdJv
         8QthC5+nxr+rXLWm7vJCeh4l7RjfM3fzIlRDW3c8Z6RkdKJpyNjw0pr+yUR4DJDfZN6m
         NRjBxErMcoICybX7HsZNxo626KU69JUk273Dsf4V2F1/9VyAXPmBrxVxFKBBFXqYOOpv
         +DzZTDqTuVph8DZEYe8VtMAc/OhNo3VDYHoZuLRTkyjWRDcP/QMF+s7ldzZWvmslgMKp
         OLPpgkt9Ph18NZ5QOMdcE5md5gnAslRHCtc4NiriJ/lDoYKOYc9441dI/IfGUkAHlVOF
         mFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDoKcYpl/2aB4jgQj/68syTUZwXEKvTgElKugBhctZc=;
        b=F4F5V31bQ+GSmiEdRSd6/sH+8oVRt4rjKYSFAl7YZ2aYaZerwLKgPfDC9hhCreEIBu
         odfXWyv7difMf2O9jpvyIuKN0zTXR5QQLO66Gnd9p/18QBlXQBxZfZpBzv7V87TvJYKq
         Sy4lNxCd6Cx+kx5m0K1b803VE0fa3t5q86llfgq2sjpQU5SokHUkDvHKy9/4odRTlv/v
         DhcCe3pX3/4aaHTTpWAYyEmSllaKPO6XDm+VotC0Npu940vV+aVJ+0OgNglUsGcrpmAj
         vsyh+nF0tFnPLMvFsvjJKRu7bBvZe8NMZjFFmss/vOUZ5Or8xDuT+qwA6F+aZ1ClddjD
         BWWg==
X-Gm-Message-State: AOAM533RYkbYVdwwjdL6BM7CTxERULKYzfLl4fX9y91EFX5/BS3+TaZ1
        TffSM2yQXiR6csPZDhQN2do=
X-Google-Smtp-Source: ABdhPJxECehjzMowQPQB4bYBXHzmbO64v+XwcANCVnfRYaVkPuyXyQct1KHDtqBGESceKREV8Kzzcg==
X-Received: by 2002:a2e:8910:: with SMTP id d16mr11062154lji.357.1607969284711;
        Mon, 14 Dec 2020 10:08:04 -0800 (PST)
Received: from localhost.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id t26sm2422349ljo.16.2020.12.14.10.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:08:04 -0800 (PST)
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
Subject: [PATCH V2 1/2] dt-bindings: power: document Broadcom's PMB binding
Date:   Mon, 14 Dec 2020 19:07:42 +0100
Message-Id: <20201214180743.14584-2-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201214180743.14584-1-zajec5@gmail.com>
References: <20201214180743.14584-1-zajec5@gmail.com>
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

