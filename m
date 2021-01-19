Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC892FB6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbhASJqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 04:46:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732603AbhASJW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:22:56 -0500
Received: from yawp.biot.com (yawp.biot.com [IPv6:2a01:4f8:10a:8e::fce2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3827C061796
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 01:21:50 -0800 (PST)
Received: from debian-spamd by yawp.biot.com with sa-checked (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l1nCv-00EDx1-9n
        for linux-kernel@vger.kernel.org; Tue, 19 Jan 2021 10:21:49 +0100
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on yawp
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.4
Received: from [2a02:578:460c:1:ae1f:6bff:fed1:9ca8] (helo=sumner.biot.com)
        by yawp.biot.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l1nCQ-00EDru-69; Tue, 19 Jan 2021 10:21:18 +0100
Received: from bert by sumner.biot.com with local (Exim 4.93)
        (envelope-from <bert@biot.com>)
        id 1l1nCP-000mDJ-Nv; Tue, 19 Jan 2021 10:21:17 +0100
From:   Bert Vermeulen <bert@biot.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>,
        John Crispin <john@phrozen.org>,
        Birger Koblitz <mail@birger-koblitz.de>
Cc:     Bert Vermeulen <bert@biot.com>
Subject: [PATCH v4 1/5] dt-bindings: mips: Add support for RTL83xx SoC series
Date:   Tue, 19 Jan 2021 10:21:05 +0100
Message-Id: <20210119092109.185282-2-bert@biot.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119092109.185282-1-bert@biot.com>
References: <20210119092109.185282-1-bert@biot.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bert Vermeulen <bert@biot.com>
---
 .../devicetree/bindings/mips/realtek-rtl.yaml | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mips/realtek-rtl.yaml

diff --git a/Documentation/devicetree/bindings/mips/realtek-rtl.yaml b/Documentation/devicetree/bindings/mips/realtek-rtl.yaml
new file mode 100644
index 000000000000..aadff8ce0f49
--- /dev/null
+++ b/Documentation/devicetree/bindings/mips/realtek-rtl.yaml
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mips/realtek-rtl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Realtek RTL83xx/93xx SoC series device tree bindings
+
+maintainers:
+  - Bert Vermeulen <bert@biot.com>
+  - Sander Vanheule <sander@svanheule.net>
+
+properties:
+  $nodename:
+    const: "/"
+  compatible:
+    oneOf:
+      # RTL8382-based boards
+      - items:
+          - enum:
+              - cisco,sg220-26
+          - const: realtek,rtl8382-soc
+
+additionalProperties: true
-- 
2.25.1

