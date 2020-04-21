Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A461B208D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 10:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgDUIBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 04:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDUIBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:01:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0AC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d17so15294553wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XS8MLiD43HRCDGUhNCWbHcgAStwvWxC9A943TxLQEZ4=;
        b=dqccmwCPUeowj8HiqvQkLRNkuOeABsVeVjPM+aYtVdGHzR30TfxrgLOVQ1lBF8Zq5N
         Zm+BFJSq6bB/WLfyqH+0q2K+A77wqVXCuymPMdDSom8ufRIU4pMd2Q1Z2gbJ1UABDiw0
         AkjZVTl6POa+4J9BLZfMUJv8vTD7PSXZWHOUajpqlCgen4CVqPn8DLypKKU9BxfndNQU
         rESK9iZ84iwp8PY66iTHa+ykgf/1vnPYltV7QVv9WMOFB0+4D1h3+0peupb8kt0aTfCC
         H161G2/+KQz9ZPWWSEpcGWJPSR+c9UGTuzHDxePJ9eeDmHmlnMg9w0fxtv5jl88gdona
         XXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XS8MLiD43HRCDGUhNCWbHcgAStwvWxC9A943TxLQEZ4=;
        b=YFcP4Ti6rE43po6z5xQUFH6bVekcXjttcdg+8NOXftRqUBgEvIZHSkhxr96fmuEwMo
         /y4SNYrrOO+m+B/N8GsK0tagUpSv2P1PWHctWtafrBlPNSIKw/fuoW0zEFthfMpEuUEL
         lxE16I62GSlksiLx+FL8akEwvWnfoWWzD11/KziabpThm8i9VsAlX+tESmV+ueJb9YWg
         dP70vko/vM2qi898rwzk7heHs/mqWltOH/hAMRp5qhpGFrCCDX7uupg0b5InqhCfd1HJ
         CCLFLU5O7JfOWozMWP4xiOXY8OfwKsskS0ZJKb37A50nRYVMMCuA8oOdgYFxxzWdDMi8
         rZ6w==
X-Gm-Message-State: AGi0PuZNzC7M6oR6rO8AaBLD1P1VG2pIseCVkMAwGWdWU9zPpvUwml1v
        bi73d1s/bhWOVu9+vvJniXoxFA==
X-Google-Smtp-Source: APiQypL3ext83ZV7Ejx37wb5fdthOPJTVdWdGp7RREmAluHAuw2POo2GOmh2ApeG2micdKbP7iIQgQ==
X-Received: by 2002:adf:dc06:: with SMTP id t6mr21931763wri.385.1587456067996;
        Tue, 21 Apr 2020 01:01:07 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id x132sm2561552wmg.33.2020.04.21.01.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:01:07 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
        srinivas.kandagatla@linaro.org, devicetree@vger.kernel.org
Cc:     nick@khadas.com, art@khadas.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 1/8] dt-bindings: mfd: add Khadas Microcontroller bindings
Date:   Tue, 21 Apr 2020 10:00:55 +0200
Message-Id: <20200421080102.22796-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200421080102.22796-1-narmstrong@baylibre.com>
References: <20200421080102.22796-1-narmstrong@baylibre.com>
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

