Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E902C4D95
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731915AbgKZDAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:00:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgKZDAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:00:50 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE0EC061A04
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:00:48 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t37so475298pga.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGy6irohT0f1tWD/mm+Ymd5mnTZ2qIfD7SCUyRih0uQ=;
        b=EFPNSrhZhrvcg/8kPsEw0/6/KGCVTW/U4tL3dia9WRhqh8fktxXhEh0onyuuA4xEss
         JKt//yl3RnphApbznkwNRTAEi7+cmvsRtc7L7n4sy5hga6/qEfxRtF+8MH5B+8MObP2c
         Pxdvyz61EwO4TdO6DsnhPYd/1G4cLBBdS+qDL1PfkCH2yzam8qs24jVY69mLrXYFtUYy
         +kJ1IhYj8S3N8Qu/Z3mxjEWx+BdCWzERk+NwFL+Iwo9zYdYwtUfmZYGYr91ROsP9GLX9
         Y/lD95PTfUtMCVFbsYKsYyN9daXOuKSprQwoUbt/JlpSECcZKE7nl14scKVwfbcZB0uk
         A+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HGy6irohT0f1tWD/mm+Ymd5mnTZ2qIfD7SCUyRih0uQ=;
        b=ao1KZB4uwrDyaxl7FRpI9AWslUMYC8gDP5MIaGl6uGqnPZxHJQK96QU0NPkP8f7U8c
         ULChH0FRwIDNTt40n45SX8wCGULvkuVEf24MDthvP/mw8Mlou+WbXwPCXtN9L+f7KpLR
         zowPdDdSx2q5V5gqpThHpQ2JhqM9gtEXF3yYtXi3AMtMLnY3lRLv3kJTLin9ReANu0lK
         gmMqytP7t9Hv91PSTMF5xboCTzz5FrfwRSzHU5BAJRH/VQrEAP13fiKaHJ8BeVUdOXWa
         sk+FPg+zXhuU6c2uPQ/m8a6m0zBzIuVWQ8qpAiX/OI9kcftPpPENV+cby7LZP9y3fGFx
         9h+g==
X-Gm-Message-State: AOAM530cADp6scGxwWq85WljDb3nM6G1dhXu1GtlIjTxdfYa972o8apu
        AUxD8NnvYbR1oLfM48ayU79dtw==
X-Google-Smtp-Source: ABdhPJwg7TmxhRtsDO0z7BK3t08FW6TEtxmleXh8/VWrBOjgOOJgyhWVu/0QilTxqH1ENYkKsDoWzQ==
X-Received: by 2002:a17:90a:4889:: with SMTP id b9mr1038424pjh.79.1606359648430;
        Wed, 25 Nov 2020 19:00:48 -0800 (PST)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id d2sm4322057pji.7.2020.11.25.19.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 19:00:47 -0800 (PST)
From:   Zong Li <zong.li@sifive.com>
To:     robh+dt@kernel.org, sboyd@kernel.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [PATCH] dt-bindings: fu740: prci: add YAML documentation for the FU740 PRCI
Date:   Thu, 26 Nov 2020 11:00:43 +0800
Message-Id: <20201126030043.67390-1-zong.li@sifive.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add YAML DT binding documentation for the SiFive FU740 PRCI. The
link of unmatched board as follow, the U740-C000 manual would be present
in the same page later.

    https://www.sifive.com/boards/hifive-unmatched

Passes dt_binding_check.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 .../bindings/clock/sifive/fu740-prci.yaml     | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/sifive/fu740-prci.yaml

diff --git a/Documentation/devicetree/bindings/clock/sifive/fu740-prci.yaml b/Documentation/devicetree/bindings/clock/sifive/fu740-prci.yaml
new file mode 100644
index 000000000000..e17143cac316
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/sifive/fu740-prci.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 SiFive, Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/sifive/fu740-prci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SiFive FU740 Power Reset Clock Interrupt Controller (PRCI)
+
+maintainers:
+  - Zong Li <zong.li@sifive.com>
+  - Paul Walmsley  <paul.walmsley@sifive.com>
+
+description:
+  On the FU740 family of SoCs, most system-wide clock and reset integration
+  is via the PRCI IP block.
+  The clock consumer should specify the desired clock via the clock ID
+  macros defined in include/dt-bindings/clock/sifive-fu740-prci.h.
+  These macros begin with PRCI_CLK_.
+
+  The hfclk and rtcclk nodes are required, and represent physical
+  crystals or resonators located on the PCB.  These nodes should be present
+  underneath /, rather than /soc.
+
+properties:
+  compatible:
+    const: sifive,fu740-c000-prci
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: high frequency clock.
+      - description: RTL clock.
+
+  clock-names:
+    items:
+      - const: hfclk
+      - const: rtcclk
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    prci: clock-controller@10000000 {
+      compatible = "sifive,fu740-c000-prci";
+      reg = <0x10000000 0x1000>;
+      clocks = <&hfclk>, <&rtcclk>;
+      #clock-cells = <1>;
+    };
-- 
2.29.2

