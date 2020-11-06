Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848752A9515
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgKFLPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgKFLPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:15:53 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9958DC0613CF;
        Fri,  6 Nov 2020 03:15:53 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id r12so1067407iot.4;
        Fri, 06 Nov 2020 03:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiWE+QWWlazimLi0TrkBpKXq5Z0IleCm9UdBmqp2vvs=;
        b=bf8eze0RbGRLUlVN4d2YRJ1wRNnN72T61UbXrzhdwAK5TklUYKbjX8mIoNQYPbZa3O
         vpHt3V3w050vcAomNruqwg7787crYSS3n9r5OzovD+ow2jm7a/y3Vn2wOYQg2cAZq5hX
         IYjZLZmg0IqYVavZi9je8F0qqUZ8WZovIT+Keg3ltlVjhEW9STVD+enPz8pMuNx4pF5D
         b4pT89MLptxr2ZU/32V/TcS4Qv6NkUKzvuCJSuZIkfqXpxFUeHgbyD540iBHIABlfPS1
         fIBWbtFgPRxeEY6xXWPjVX4j3raIuFZj5jLcvR7Q9zUrs318eWZsc4B6c5tfKIt5U4dJ
         5m8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AiWE+QWWlazimLi0TrkBpKXq5Z0IleCm9UdBmqp2vvs=;
        b=lTzPqdB103NqE14vARQ7DGZmQ4/qEbDg+SfzRN0+HiVh497lFScyAHPk9v15ol/jdi
         14mhImfItLcJJbwXVedy5vNFpJf3HpVaAQ2E8t3q0s5seGulgMRrA5J6xsmXd0UDzXFA
         Zy7CyvJ1C7y4k2c6hRHtFnYqqqWvob0/mPOfsLnycpRPiMps6B0bRB0dxuulPyF6UKHX
         AwT19z/79I4XDd+wOLrbiHBKr705MKLc8zUxYlQ7glZ5oWuWhEmHv/aZcOd/ZdibXOgz
         LoASfwAhH6O7cQZBegCJd/5fpcaEhwdN3OLV9mzquaIMHz3e/y5gCxWddLf+bx5L5eI0
         enYw==
X-Gm-Message-State: AOAM533UPOpWMLqem8JeUZ/wisAzv8DZ37axwFTx30kUNpZsPPIpxJ3G
        dvZGHcUphQv3xohqTnb0e4M=
X-Google-Smtp-Source: ABdhPJwJszyNIhmZ2EzMaYQpVFdey2wlDA1k9QOUIRXS+UhWEB+I/7123KokQykevQ1iP9DygoTdGg==
X-Received: by 2002:a6b:5f1d:: with SMTP id t29mr1027946iob.86.1604661352879;
        Fri, 06 Nov 2020 03:15:52 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8492:7d60:7e29:2784])
        by smtp.gmail.com with ESMTPSA id x5sm854597ilc.15.2020.11.06.03.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 03:15:51 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] dt-bindings: soc: imx: Add binding doc for spba bus
Date:   Fri,  6 Nov 2020 05:15:39 -0600
Message-Id: <20201106111543.1806809-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for fsl,spba-bus.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
V3:  New to series

diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
new file mode 100644
index 000000000000..0a2add841145
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/simple-pm-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Shared Peripherals Bus Interface
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: |
+  A simple bus enabling access to shared peripherals.
+
+  The "spba-bus" follows the "simple-bus" set of properties, as
+  specified in the Devicetree Specification.  It is an extension of
+  "simple-bus" because the SDMA controller uses this compatible flag to
+  determine which peripherals are available to it and the range over which
+  the SDMA can access.  There are no special clocks for the bus, because
+  the SDMA controller itself has its interrupt, and clock assignments.
+
+properties:
+  $nodename:
+    pattern: "^bus(@[0-9a-f]+)?$"
+
+  compatible:
+    contains:
+      const: fsl,spba-bus
+    description:
+      Shall contain "fsl,spba-bus" in addition to "simple-bus"
+      compatible strings.
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+  ranges: true
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - ranges
+
+additionalProperties: true
+
+examples:
+  - |
+    bus {
+        compatible = "fsl,spba-bus", "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+    };
-- 
2.25.1

