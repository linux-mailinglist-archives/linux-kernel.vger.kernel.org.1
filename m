Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2E6F2865C6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728251AbgJGRUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:20:46 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:64585 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbgJGRUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:20:46 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id 01E5C20035BD
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 17:20:44 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=connolly.tech header.i=@connolly.tech header.b="UEAruBE3"
Date:   Wed, 07 Oct 2020 17:20:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1602091241;
        bh=55HoEt0OV8YYq8cG2qxe2D4pju6+UzBhBfwJ7r5tuRA=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=UEAruBE3kMhehwlrZQF9NVBbNiI+AW5AzDp4MrBIDCOVtZc5d+HfyZ2io3+AKzJ8B
         Xx+uSXSRtC0zoIyfeAxQ7la8L4qnz6wBSxiFjfdwMJekpP3tzO/GUISsJ9qHhmTSYh
         kVSkqpXsMQ0QBWfbhsnsJQLMWLuIpzaCWzRzKyMY=
To:     Rob Herring <robh+dt@kernel.org>,
        Caleb Connolly <caleb@connolly.tech>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 4/5] dt-bindings: add vendor bindings for OnePlus
Message-ID: <20201007171807.285298-5-caleb@connolly.tech>
In-Reply-To: <20201007171807.285298-1-caleb@connolly.tech>
References: <20201007171807.285298-1-caleb@connolly.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Used by the OnePlus 6/T device trees

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 .../bindings/arm/oneplus/oneplus-boards.yaml  | 25 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 2 files changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/oneplus/oneplus-b=
oards.yaml

diff --git a/Documentation/devicetree/bindings/arm/oneplus/oneplus-boards.y=
aml b/Documentation/devicetree/bindings/arm/oneplus/oneplus-boards.yaml
new file mode 100644
index 000000000000..a4d9bbd5681f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/oneplus/oneplus-boards.yaml
@@ -0,0 +1,25 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/oneplus/oneplus-boards.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: OnePlus based boards
+
+maintainers:
+  - Caleb Connolly <caleb@connolly.tech>
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - description: SDM845 based boards
+        items:
+          - enum:
+              - oneplus,enchilada               # OnePlus 6
+              - oneplus,fajita                  # OnePlus 6T
+          - const: oneplus,oneplus6             # OnePlus 6 and derivative=
s
+
+required:
+  - compatible
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Docum=
entation/devicetree/bindings/vendor-prefixes.yaml
index 63996ab03521..6672d7242d54 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -754,6 +754,8 @@ patternProperties:
     description: OLIMEX Ltd.
   "^olpc,.*":
     description: One Laptop Per Child
+  "^oneplus,.*":
+    description: One Plus Technology (Shenzhen) Co., Ltd..
   "^onion,.*":
     description: Onion Corporation
   "^onnn,.*":
--=20
2.28.0


