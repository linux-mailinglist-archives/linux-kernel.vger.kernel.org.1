Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368792AF4B0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKKPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKKPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:25:35 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7988BC0613D1;
        Wed, 11 Nov 2020 07:25:35 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s24so2619487ioj.13;
        Wed, 11 Nov 2020 07:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V98jdF8UJSRGGjJzgv2zEND8PLBL6i+WJRmu7tvsP5c=;
        b=NNAMJxzpcjpmFESW+exwKjmjg6Z1AwFum4Il5mV22nH4uZB70yp5HCQCZaUG3h03zX
         1z7uTrFugW54OYjtC1//rVn7k8PcA3Wj9f+KgB1K6Udv9IkvvrnYCsVo617HedpgQMsj
         pUfn8MYA4GkygtCE+s7+hxW9P9rpmxrAFndepzzx3FDtlRomdscE3YBWIdyEVd88ry81
         jpoEzhGdg7UoVXxH81ZTL2yOKyCq0wtaqe7l4SRKFUnX9uSKawrV3xE/SavmbKRjCq08
         P0CI5Y2frOqY0pvOfpxrbmWfThzUWP3NMfarULkXZ1dmmaaQcS4kK17lF/YGM2WN26DA
         kE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V98jdF8UJSRGGjJzgv2zEND8PLBL6i+WJRmu7tvsP5c=;
        b=gGpdL4hEasTto8EBADTtI8jvEU8A7Hq7cc+o9QIX0Y0BcvUnTv28GJk49hCOf8ivxz
         b8cVvVS03gCC7J3MasHzxTM42vYUy9X5BW5e5R3FdBXxQK30YxjDAKx3+izzsxt2+MDB
         yqZYePrOYicNVlA6gaoD+n3ztf4L80OFbK2++fxsCr0DZslfCsoA2h67wEeWVpa9oITW
         WXBO9ZC48KNwWaViaND8bkgdcbvQm78jqwuGgk1MVG+tMqZtfGhwqbW5YiA9fc5Tml8H
         7qFOFF25xR1h69lSBaOzpt/0hMI/x9RqXGSWp1GLqlpEtXpZGGkfY85qyfuuD26vzCt2
         LSCw==
X-Gm-Message-State: AOAM5321W1DJ/7NeIs0f+69doVoJDa3u0ZBPD0oBM3BjfYq0OHN+xszJ
        jYn8b3wZ4VDy/ohpNzEWoMYcbI5CVAdT4w==
X-Google-Smtp-Source: ABdhPJx++TM5QV5gtKa9Ti3tuP80IYznVcus5VhHdm+/bsACr4rzTrbjfJB+1bN0pHw2PgeSsmCpiA==
X-Received: by 2002:a5d:9850:: with SMTP id p16mr18889062ios.22.1605108334174;
        Wed, 11 Nov 2020 07:25:34 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:59b1:ae74:30a3:447f])
        by smtp.gmail.com with ESMTPSA id f77sm1424395ilf.40.2020.11.11.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:25:33 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V4] dt-bindings: soc: imx: Add binding doc for spba bus
Date:   Wed, 11 Nov 2020 09:25:23 -0600
Message-Id: <20201111152523.76254-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for fsl,spba-bus.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
make dt_binding_check showed no errors if I did this right.

V4:  Remove an accidental makefile change
     Move type:object under additional properties

V3:  Rebase sample from aips-bus example
     Split off from series adding i.MX8M Nano functions to reduce noise

V2:  Attempted to update yaml from feedback

diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
new file mode 100644
index 000000000000..48d0c27d2e77
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
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
+select:
+  properties:
+    compatible:
+      contains:
+        const: fsl,spba-bus
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^bus(@[0-9a-f]+)?$"
+
+  compatible:
+    items:
+      - const: fsl,spba-bus
+      - const: simple-bus
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
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    bus@30000000 {
+        compatible = "fsl,spba-bus", "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x30000000 0x100000>;
+        ranges;
+    };
-- 
2.25.1

