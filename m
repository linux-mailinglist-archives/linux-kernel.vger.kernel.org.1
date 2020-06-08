Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B81F1531
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgFHJRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 05:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729185AbgFHJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:17:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD719C08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 02:17:45 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so16526733wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lm/JhSU6WIUD9liaClHiq2/rbC+K/Ls1HtNWMD1Nn2A=;
        b=FcmK3W9ITgW61d17rdHrRaPjerQ/Zh5mw4c44iJ75UtbSzKwd9ySNyhyPDuGMRTLxq
         2H6QaFZW+s365p8SysfF3q8kg99qujIAIP4GhnqyzQnLjlHXspbg5JEahrzJ78nWEnGF
         aRcrfKcxTNzXNxRKNmmJpBF0AB/+tPCe22GtOBCWMYTUXilPvW8Lvxdki1cX49ScKgUK
         BRySgoCAhcZNHORHpL3uFQgs1EBb0AUcAEA6HciCJVGjMtZEHTCkbSjntdhWzJH7kes7
         Dd7a2aUhqxsr62MAVe8R4uHDvOXyCJ9+YQ+PtOW1FMOHbhRtoJzpV3wFSqG9ChnILtxd
         lRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lm/JhSU6WIUD9liaClHiq2/rbC+K/Ls1HtNWMD1Nn2A=;
        b=AB3OC0barkhlwHsWhqaq+/A7jpbv5xYIEEXWoFpNSp2WV0jUPw6mylqnc16+RJgxMY
         xi1Fj4EzjMV0PlupYFn19HM6jbNobCCdNWWt5iOFwNPmeZ8yNhUC+719Ba0ldrDEJASL
         OiGp3FoLs7pMlEpstWdEvPqXVD8aTwkd/4YG6igflnwdHj0C5d9dwBt2Wlcy20j/puP+
         8T1ht5yv8PgUeOcVkuBlRR+Yxd0IboCfsnY88NWpTyK3qonHTHOS6B/5Kdw7sERBjk5S
         pF0E4+rAiYfSfmQe9ETJ6z6/lfj1KpLtKZSh76oFx0UUbOlWLCG0QbA1KynG/c4kXiQB
         QF7Q==
X-Gm-Message-State: AOAM530DIHWWCUeoFGzWnzcy76uhTrqZm7n2IFsqdSzHOWfoZM+tN6Ct
        XJ/9vm0K8T/RNKmK0kXlr4BANA==
X-Google-Smtp-Source: ABdhPJy5nApKLg7sAnx1p1z/S0XJC5YRyMc2U//Q+srm6fnQM91nzIe3TXIUUym4iQ5GereEV0LpJg==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr21990314wrt.159.1591607864362;
        Mon, 08 Jun 2020 02:17:44 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:22:5867:d2c6:75f4])
        by smtp.gmail.com with ESMTPSA id t7sm22732326wrq.41.2020.06.08.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:17:43 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: mfd: add Khadas Microcontroller bindings
Date:   Mon,  8 Jun 2020 11:17:35 +0200
Message-Id: <20200608091739.2368-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200608091739.2368-1-narmstrong@baylibre.com>
References: <20200608091739.2368-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
boards.

It has multiple boot control features like password check, power-on
options, power-off control and system FAN control on recent boards.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/mfd/khadas,mcu.yaml   | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml

diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
new file mode 100644
index 000000000000..a3b976f101e8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/khadas,mcu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Khadas on-board Microcontroller Device Tree Bindings
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  Khadas embeds a microcontroller on their VIM and Edge boards adding some
+  system feature as PWM Fan control (for VIM2 rev14 or VIM3), User memory
+  storage, IR/Key resume control, system power LED control and more.
+
+properties:
+  compatible:
+    enum:
+      - khadas,mcu # MCU revision is discoverable
+
+  "#cooling-cells": # Only needed for boards having FAN control feature
+    const: 2
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+      khadas_mcu: system-controller@18 {
+        compatible = "khadas,mcu";
+        reg = <0x18>;
+        #cooling-cells = <2>;
+      };
+    };
-- 
2.22.0

