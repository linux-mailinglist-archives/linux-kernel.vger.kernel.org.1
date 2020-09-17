Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F370926E61C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIQUFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:05:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgIQUFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:05:30 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6D30208C3;
        Thu, 17 Sep 2020 19:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600371479;
        bh=yd314DkCkTXkMXbH9+vztf9d5zQG0/FgZ92JW/yMqZk=;
        h=From:To:Cc:Subject:Date:From;
        b=VsvCO6OXMh93mPRVR4zIXffnOTxneISQ1DXuZpLMTNevwcFid7X+d94Xt7uArZ9yf
         my02CUlAhH5o06y3JfM6qWwThoS5X8yPZK4zbETRCTFd8kBmnjAYFRBZal5J/GXl2z
         RVm9mgJe1bJ33KdqXIrC6vBkqcNJZGFY/E1WLqNw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] dt-bindings: mfd: rohm,bd71837-pmic: Add common properties
Date:   Thu, 17 Sep 2020 21:37:54 +0200
Message-Id: <20200917193754.542-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common properties appearing in DTSes (clock-names,
clock-output-names) with the common values (actually used in DTSes) to
fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dt.yaml:
    pmic@4b: 'clock-names', 'clock-output-names', do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Define the names, as used in existing DTS files.
---
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml          | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
index 65018a019e1d..3bfdd33702ad 100644
--- a/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.yaml
@@ -32,9 +32,15 @@ properties:
   clocks:
     maxItems: 1
 
+  clock-names:
+    const: osc
+
   "#clock-cells":
     const: 0
 
+  clock-output-names:
+    const: pmic_clk
+
 # The BD718x7 supports two different HW states as reset target states. States
 # are called as SNVS and READY. At READY state all the PMIC power outputs go
 # down and OTP is reload. At the SNVS state all other logic and external
-- 
2.17.1

