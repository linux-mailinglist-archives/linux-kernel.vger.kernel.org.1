Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7122C84C1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgK3NLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgK3NLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:11:44 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC9C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:10:58 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x15so6458045pll.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=66bIbZIMyYy2aQ1+PNHmZ6rTWFoZDMO1KzGC89/vZyE=;
        b=GdTnAdX9F8W8qDdgb8euxuSQVdabwSLXIb5t7PUvLLZrWinfSjCqKxreDd+2Klo9kY
         buosYpZqM1Ol0MZmzneIS39JMkyfbFz7SzMTzCQjXsi/xQB7YOXTckAVmoGd5WUHFTa4
         eJUf2CdeEa5rVAlg3JbjevfrD02CcUskuQg0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66bIbZIMyYy2aQ1+PNHmZ6rTWFoZDMO1KzGC89/vZyE=;
        b=CK0tOcSfaX77JHVBnRCKJ2Wj2YCP1kfKrNx92JPIoLtwZzy0TlU7t/GDFD9vIp3xhy
         8FoBxl8ajU81IGdoNh/eb1qbtGpAtenU716715Z2Ln75Frmd47BDCJgr46rnUCqU90aj
         /HOnOyE8qAbrgq6CgdfdN6oXjtlW+HbRXEuhFkxEqV/LoGxxQqH4PctC5qaR1J4zZ67T
         0GO69yu4YAuIaY8sBdkDuJAgSyXFCZEMih4QdbVHjMpjleBNpOmxxQ4HDVnsIUeiIU6i
         UfwPOWtEBUA23OoUF/Elbmg/10nEJcUhABCpfegWOw8FUtTDq+htAUJOk5C8KWgKUh0X
         nO4Q==
X-Gm-Message-State: AOAM530ScJHDJQEp/DiSZbAjUb9BgSEzqbhm+snr2IOKA+mLdiNGlnoA
        NPtjq+oWZtjwtLRUaXghwJjX1QhUQ0hVaQ==
X-Google-Smtp-Source: ABdhPJy/vEeiJjPZKJDVRM9cViVIu8FP89iPKQ41rcgsVoY6HMn0FcCPUSI9RrJ+vkesBYf4n4MTUw==
X-Received: by 2002:a17:90a:7e8e:: with SMTP id j14mr2229217pjl.60.1606741857634;
        Mon, 30 Nov 2020 05:10:57 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id a4sm41757578pjq.0.2020.11.30.05.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:10:57 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        w@1wt.eu, daniel@0x0f.com
Subject: [PATCH 1/9] dt-bindings: mstar: Add binding details for mstar,smpctrl
Date:   Mon, 30 Nov 2020 22:10:39 +0900
Message-Id: <20201130131047.2648960-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130131047.2648960-1-daniel@0x0f.com>
References: <20201130131047.2648960-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a YAML description of the smpctrl node needed by the
platform code for the MStar/SigmaStar Armv7 SoCs to boot secondary cpus.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../bindings/arm/mstar/mstar,smpctrl.yaml     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml

diff --git a/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml b/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml
new file mode 100644
index 000000000000..a102287b5c88
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mstar/mstar,smpctrl.yaml
@@ -0,0 +1,38 @@
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
+        compatible = "mstar,smpctrl";
+        reg = <0x204000 0x200>;
+    };
-- 
2.29.2

