Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FA32CEB09
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387569AbgLDJh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbgLDJh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:37:57 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C812FC061A4F;
        Fri,  4 Dec 2020 01:37:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id s30so6794694lfc.4;
        Fri, 04 Dec 2020 01:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeHBNDBBt/4BBIZDmJJje1cPJ35YMQi7b/VOWZGP8D0=;
        b=D4CekTyNKSzBZnS7JG8eaejft2Zd29w9Ffnv/GBMzxTnSABVEjuCwTcINDM0E8GUIr
         YoTIMduBMNtxyXwQYIHlVArY9XXDGKNkU+t+BfGrAVzYdSCZ3wV6v/t41jj7O/aCPScP
         iWUCTPDfRhcxfkmkzF8HGCGQaF6jJFrNDMHQyUQ8LNGZrN2t1fs6UO0d8eAOYMEmZFxC
         b9hpqSOvgKEksV2pU1CtyyzGCC9FozzveuKMQyxFqFQpfy1stosbmgLS6iLfbLk/50sX
         64AHl+1RDpPJpxVW2tc+oearmeMguu01ufSHlIY2himhip4kjeMKGR2uu+rz6N9NvnzT
         jzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZeHBNDBBt/4BBIZDmJJje1cPJ35YMQi7b/VOWZGP8D0=;
        b=DnuM7MP2nHlVQAbHcKqk/OSY2r2MMS1TE8Q8PNijGFDGtBwxcHPS9iDpzrl7AUIf93
         Cv7iigWrMtX6xEI5YWLqd8vy3hMQ2a/SL7ZZdR2PTfwm3Hk9eEawxkTZlZqgMwDl/cpm
         ORViXGwp1pVtIUsvhf80GwRROD36Z7R5kajNR947T/i/rgj0t5v4XgEqrp2KAO5Hg2cf
         aeVS0y9+gxveVE9EnuuDwpjPISX6rxJjDKX42BXanIZH0jmihdm/df2StnPPPnWth+C8
         2EcpqtqZjK+8TpW3BghBUSu/0MBQVXI8UbrbTWP6TmW77JfDNu5h0lLUuBqXIe71pu0r
         T9Yg==
X-Gm-Message-State: AOAM531MyjsGk26VlVzmOaiTPt+kiLT86fulnUU2yrCqhgoTk4UolQsY
        T7fo7Ci8xoz13Eh5AQR8qQTq+zM9St4=
X-Google-Smtp-Source: ABdhPJzs7ThFvJs1avHRQPKi+dlDvgb/Nn7/TtRy/5rEMmEcO6b34gS6dPN1B64xqehoTYx4Y40NpQ==
X-Received: by 2002:a19:745:: with SMTP id 66mr3111293lfh.343.1607074635228;
        Fri, 04 Dec 2020 01:37:15 -0800 (PST)
Received: from elitebook.lan (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.gmail.com with ESMTPSA id p196sm1467657lfa.68.2020.12.04.01.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:37:14 -0800 (PST)
From:   =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: [PATCH 1/2] dt-bindings: reset: document Broadcom's BCM4908 USB reset binding
Date:   Fri,  4 Dec 2020 10:37:03 +0100
Message-Id: <20201204093704.11359-1-zajec5@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

Document binding of block responsible for initializing USB controllers
(OHCI, EHCI, XHCI).

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
---
 .../reset/brcm,bcm4908-usb-reset.yaml         | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml

diff --git a/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
new file mode 100644
index 000000000000..31beb1c8f3cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/reset/brcm,bcm4908-usb-reset.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reset/brcm,bcm4908-usb-reset.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM4908 USB host controller reset
+
+description: >
+  BCM4908 has a separated block controlling all USB controllers. It handles the
+  whole setup process and takes care of initializing PHYs at the right time
+  (state).
+
+maintainers:
+  - Rafał Miłecki <rafal@milecki.pl>
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm4908-usb-reset
+
+  reg:
+    maxItems: 1
+
+  resets:
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  phys:
+    minItems: 2
+    maxItems: 2
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  phy-names:
+    items:
+      - const: usb2
+      - const: usb3
+
+  "#reset-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - phys
+  - phy-names
+  - "#reset-cells"
+
+additionalProperties: true
+
+examples:
+  - |
+    reset-controller@8000c200 {
+        compatible = "brcm,bcm4908-usb-reset";
+        reg = <0x8000c200 0x100>;
+
+        phys = <&usb2_phy>, <&usb3_phy>;
+        phy-names = "usb2", "usb3";
+
+        #reset-cells = <0>;
+    };
-- 
2.26.2

