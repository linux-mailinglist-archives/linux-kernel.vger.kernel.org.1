Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236C01B53B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgDWEk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 00:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgDWEk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 00:40:58 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72955C03C1AF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 21:40:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so1898155pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 21:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uN77YYlhJ5hf5xvmhs+g80JKk6JqfP0Ww5cfVFBntyA=;
        b=OBKz8WU3m2vuOji78QzwgsVP51H136YvPgEt8OdzYI5V0ySedVeDWeLmfPw9h92OY/
         IUyMqjuDX1rZ/U885DafqHcLuVbO3hEipQ85nfmZ136gz6TaZJ5LD66MNvarzx/HhEGP
         HUCsZWn4OBRhCY6NPynsV9afwfjhe6mP7qrvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uN77YYlhJ5hf5xvmhs+g80JKk6JqfP0Ww5cfVFBntyA=;
        b=QIf4z83VilnZXfohAyFb3mM/LEWKosjl0RjOPijr9BWbfleD+ivK/5KbT6vPUij2YX
         B9Vuj1VqbqUIBsFqZsm6sy/2f2WeqeHY1yL7+8rc0I256mS8Qp55dA4kLofOLIzNFYLI
         R4uxrWnerlRpJ6XXvkm2t8hUDY8KK2Hz9kyo44DxOqNn1Np3Oy4xpX0EbBTZsl+MjQv8
         KBQUDcjAeKL85Z4ILD1oAPE2wAj5L1iQLO3awS5YYpNJfwpY8O5gv12XSAIHuqO2E14a
         zutJB3IMdICa1/lUkCFCUP1e0wIa1H42u58Fg32RNc6V/JrOkLP7y6AhANyF9kmAy5eV
         osGA==
X-Gm-Message-State: AGi0Puay7v/3gWmak1bENU3aQv8N0UX5CanMzlKAnj0tCvx/e0ZSwNq8
        gtV02BtN9PpzdDdkPmguu0lxxopsxj4=
X-Google-Smtp-Source: APiQypJzMoQkS2ozRE2GCKP0wjVVWrTqFAkBGUh8NTNQPCqzgFzatpMLual9HScnLyqtJPK8puazfg==
X-Received: by 2002:a17:902:8213:: with SMTP id x19mr2102986pln.86.1587616857814;
        Wed, 22 Apr 2020 21:40:57 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:1105:3e8a:838d:e326])
        by smtp.gmail.com with ESMTPSA id b15sm1211210pfd.139.2020.04.22.21.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 21:40:57 -0700 (PDT)
From:   Evan Benn <evanbenn@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     jwerner@chromium.org, xingyu.chen@amlogic.com,
        Evan Benn <evanbenn@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: watchdog: Add ARM smc wdt for mt8173 watchdog
Date:   Thu, 23 Apr 2020 14:40:35 +1000
Message-Id: <20200423143945.v5.1.Id96574f1f52479d7a2f3b866b8a0552ab8c03d7f@changeid>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200423044036.234578-1-evanbenn@chromium.org>
References: <20200423044036.234578-1-evanbenn@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This watchdog can be used on ARM systems with a Secure
Monitor firmware to forward watchdog operations to
firmware via a Secure Monitor Call.

Signed-off-by: Evan Benn <evanbenn@chromium.org>

---

Changes in v5:
- Change compatible to arm,smc-wdt

Changes in v4:
- Add arm,smc-id property

Changes in v3:
- Change name back to arm

Changes in v2:
- Change name arm > mt8173

 .../bindings/watchdog/arm-smc-wdt.yaml        | 36 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++++
 2 files changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
new file mode 100644
index 0000000000000..0ee39aa3be027
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/arm-smc-wdt.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/arm-smc-wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM Secure Monitor Call based watchdog
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Julius Werner <jwerner@chromium.org>
+
+properties:
+  compatible:
+    enum:
+      - arm,smc-wdt
+  arm,smc-id:
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - default: 0x82003D06
+    description:
+      The ATF smc function id used by the firmware.
+
+required:
+  - compatible
+
+examples:
+  - |
+    watchdog {
+      compatible = "arm,smc-wdt";
+      timeout-sec = <15>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10eb..0f2b39767bfa9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1457,6 +1457,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
 F:	drivers/irqchip/irq-vic.c
 
+ARM SMC WATCHDOG DRIVER
+M:	Julius Werner <jwerner@chromium.org>
+R:	Evan Benn <evanbenn@chromium.org>
+S:	Maintained
+F:	devicetree/bindings/watchdog/arm-smc-wdt.yaml
+
 ARM SMMU DRIVERS
 M:	Will Deacon <will@kernel.org>
 R:	Robin Murphy <robin.murphy@arm.com>
-- 
2.26.2.303.gf8c07b1a785-goog

