Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FFF20DFC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 23:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbgF2UjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 16:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389392AbgF2UjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:39:20 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F8B20672;
        Mon, 29 Jun 2020 20:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593463159;
        bh=L1Zczp4G94BGZF6AbOCQuN5y8MVMnaPGHuo808oDcHo=;
        h=From:To:Subject:Date:From;
        b=LDzIOgDv674g5tQqCvxsTTAKURVuacJ5Rf9RT9R+uWMp6sTNSpMwjEBywxXZs9/xU
         Rx3i4ms6wo21O+78JqdY2Fp6UHaUsptFMfN10IYKj/6ecDXqKoyrQQDSH1SAhLx9sq
         Z1sEONvenJ8ztfTbIFnrWfSDgJY0AcjApohqqJt8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: arm: samsung: Do not require clkout on Exynos5260 and Exynos7
Date:   Mon, 29 Jun 2020 22:38:59 +0200
Message-Id: <20200629203859.17298-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMU (Power Management Unit) driver is a clkout clock provider (for
clock signal monitoring) only for certain Exynos SoCs.  It was never
implemented for Exynos5260 and Exynos7.  This fixes dtschema validator
warnings like:

    system-controller@105c0000: '#clock-cells' is a required property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/arm/samsung/pmu.yaml  | 22 ++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
index c9651892710e..686c13c14e32 100644
--- a/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/pmu.yaml
@@ -85,12 +85,28 @@ properties:
 required:
   - compatible
   - reg
-  - '#clock-cells'
-  - clock-names
-  - clocks
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - samsung,exynos3250-pmu
+              - samsung,exynos4210-pmu
+              - samsung,exynos4412-pmu
+              - samsung,exynos5250-pmu
+              - samsung,exynos5410-pmu
+              - samsung,exynos5420-pmu
+              - samsung,exynos5433-pmu
+    then:
+      required:
+        - '#clock-cells'
+        - clock-names
+        - clocks
+
 examples:
   - |
     #include <dt-bindings/clock/exynos5250.h>
-- 
2.17.1

