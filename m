Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B8002CA422
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 14:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387884AbgLANoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 08:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727702AbgLANoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 08:44:20 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF04BC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 05:43:40 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d77so688925pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=plvQeaUD9wIIwbJapMgxHoz9Nu1G0OxoMzRow/yYT1o=;
        b=mrbeoE9Eh+XfdYw5G5mGNFmFb6DualPxipg3j34VULsY5vvlx0f86/9u7So6M5fPcK
         Ah0c4EN/OHfQqaHSrJ+93s7QOmADJNuZX4X5XDU18uSXKQBf7AmCsaQNx4C3d519+0MB
         Ybu/T+58N1UvvhXJ6BdtanFw3QUy4wJSvIlFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=plvQeaUD9wIIwbJapMgxHoz9Nu1G0OxoMzRow/yYT1o=;
        b=PZTEfkuH09rI0jJuNS7I/kQ/kY0lmeU91EsxIFiAM2AckcLKMrAcr0WVzjZEZf/DXb
         wS+JAbhtRH/GcpLWKKcKiOOAJw9XV3QZIgkprmivQ3B+kJXM6Phk1/WvqTvAXelJkywS
         p/EcBbWdLNQZN+b0exWN+eeCKeutFtkDg/x0Qqwfuyq7FOmLFtR0ph57lp9hZXhaGwCB
         DENqxFeGPhFvN7POiBIY6Y6NizjB7ZblTRQ1ejh0jB7PMfIS5d6ASgHtuWjun+bchmmt
         bxezB5PoKe0i84zgu4aNOdd9x0mS0uh5C28EzD2tiiLAZfo4EKGziYJa8q1mTQTV+lQX
         hQbw==
X-Gm-Message-State: AOAM533RDp+L9Y6jQfRtSfak02ug3qwsvv0lxL7zuPS8Caw0X2zyGaz2
        +4KXH67xilACc+ezVAqAmxQL4Q==
X-Google-Smtp-Source: ABdhPJzxeEuwbvL+1kRV6+uUT7mx09UASek8f5bclJNvTywXMbmSqEQERWDw7AskMIvw+oaxcr+v9g==
X-Received: by 2002:aa7:96ca:0:b029:19a:8ccd:895 with SMTP id h10-20020aa796ca0000b029019a8ccd0895mr2498359pfq.61.1606830220296;
        Tue, 01 Dec 2020 05:43:40 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id g14sm2839248pji.32.2020.12.01.05.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:43:39 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        robh@kernel.org, w@1wt.eu, daniel@0x0f.com
Subject: [PATCH v2 01/10] dt-bindings: mstar: Add binding details for mstar,smpctrl
Date:   Tue,  1 Dec 2020 22:43:21 +0900
Message-Id: <20201201134330.3037007-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201201134330.3037007-1-daniel@0x0f.com>
References: <20201201134330.3037007-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a YAML description of the smpctrl node needed by the
platform code for the MStar/SigmaStar Armv7 SoCs to boot secondary cpus.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../bindings/arm/mstar/mstar,smpctrl.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml
new file mode 100644
index 000000000000..599c65980f5d
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 thingy.jp.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/mstar/mstar,smpctrl.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: MStar/SigmaStar Armv7 SoC SMP control registers
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+description: |
+  MStar/SigmaStar's Armv7 SoCs that have more than one processor
+  have a region of registers that allow setting the boot address
+  and a magic number that allows secondary processors to leave
+  the loop they are parked in by the boot ROM.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - sstar,ssd201-smpctrl # SSD201/SSD202D
+      - const: mstar,smpctrl
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
+    smpctrl@204000 {
+        compatible = "sstar,ssd201-smpctrl", "mstar,smpctrl";
+        reg = <0x204000 0x200>;
+    };
-- 
2.29.2

