Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8A42D4174
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgLILxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:53:02 -0500
Received: from foss.arm.com ([217.140.110.172]:33472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731037AbgLILwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:52:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8090B1424;
        Wed,  9 Dec 2020 03:52:04 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.24.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C06683F718;
        Wed,  9 Dec 2020 03:52:02 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     lukasz.luba@arm.com, robh@kernel.org, airlied@linux.ie,
        daniel@ffwll.ch
Subject: [PATCH 2/2] dt-bindings: mali-bifrost: Add dynamic-power-coefficient
Date:   Wed,  9 Dec 2020 11:51:43 +0000
Message-Id: <20201209115143.15321-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201209115143.15321-1-lukasz.luba@arm.com>
References: <20201209115143.15321-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a property dynamic-power-coefficient which allows to register Energy
Model for the Mali Bifrost devices.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../bindings/gpu/arm,mali-bifrost.yaml          | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index b1844b9c295d..184492162e7e 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -52,6 +52,23 @@ properties:
   "#cooling-cells":
     const: 2
 
+  dynamic-power-coefficient:
+    $ref: '/schemas/types.yaml#/definitions/uint32'
+    description:
+      A u32 value that represents the running time dynamic
+      power coefficient in units of uW/MHz/V^2. The
+      coefficient can either be calculated from power
+      measurements or derived by analysis.
+
+      The dynamic power consumption of the GPU is
+      proportional to the square of the Voltage (V) and
+      the clock frequency (f). The coefficient is used to
+      calculate the dynamic power as below -
+
+      Pdyn = dynamic-power-coefficient * V^2 * f
+
+      where voltage is in V, frequency is in MHz.
+
 required:
   - compatible
   - reg
-- 
2.17.1

