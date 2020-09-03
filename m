Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6AC25CAA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgICUeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 16:34:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729607AbgICUdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:33:10 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 845F120684;
        Thu,  3 Sep 2020 20:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599165189;
        bh=jQf1YvOOi6qqOrdkJa0hlJPeE/VEjcP4wOVbLqeX3js=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=unymFlAvsxJBHZVuoj7ah2m390fM5UKAcnYHWW0rts3GWScaOIKpbm2URLteZPJUJ
         WRns507l8M+gsoxxfUDPPoUvtH2rv/h8ExKajWoGGjthpBUZ8FzcXz68IZs86uDZs+
         z1Cbyp/c1zl3H9L9ySoci4NKJTxtpnBjlWigdCGE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kukjin Kim <kgene@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH 2/4] ASoC: samsung-i2s: Add missing properties
Date:   Thu,  3 Sep 2020 22:32:48 +0200
Message-Id: <20200903203250.19830-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903203250.19830-1-krzk@kernel.org>
References: <20200903203250.19830-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of "unevaluatedProperties: false" is not correct as it suppresses
warnings about all undocumented properties.  Instead, add all missing
properties.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Fixup for:
https://lore.kernel.org/linux-samsung-soc/20200829142501.31478-6-krzk@kernel.org/T/#m7476a34a33a443d05d2f05988e43d6a34c6fb227
---
 .../devicetree/bindings/sound/samsung-i2s.yaml  | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
index 16dc81288115..2e3628ef48df 100644
--- a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
@@ -41,6 +41,12 @@ properties:
       - samsung,exynos7-i2s
       - samsung,exynos7-i2s1
 
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
   reg:
     maxItems: 1
 
@@ -58,6 +64,9 @@ properties:
           - const: rx
           - const: tx-sec
 
+  assigned-clock-parents: true
+  assigned-clocks: true
+
   clocks:
     minItems: 1
     maxItems: 3
@@ -92,6 +101,9 @@ properties:
           - const: i2s_cdclk2
     description: Names of the CDCLK I2S output clocks.
 
+  interrupts:
+    maxItems: 1
+
   samsung,idma-addr:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
@@ -104,6 +116,9 @@ properties:
   pinctrl-names:
     const: default
 
+  power-domains:
+    maxItems: 1
+
   "#sound-dai-cells":
     const: 1
 
@@ -115,7 +130,7 @@ required:
   - clocks
   - clock-names
 
-unevaluatedProperties: false
+additionalProperties: false
 
 examples:
   - |
-- 
2.17.1

