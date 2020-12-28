Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C09E2E6A79
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgL1T3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:29:21 -0500
Received: from lists.gateworks.com ([108.161.130.12]:46931 "EHLO
        lists.gateworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgL1T3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:29:21 -0500
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by lists.gateworks.com with esmtp (Exim 4.82)
        (envelope-from <tharvey@gateworks.com>)
        id 1ktyJK-0005R5-En; Mon, 28 Dec 2020 19:36:06 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] dt-bindings: mfd: gateworks-gsc: Add fan-tach mode
Date:   Mon, 28 Dec 2020 11:28:36 -0800
Message-Id: <1609183716-26529-1-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 7497d4a66c59 ("hwmon: (gsc-hwmon) add fan sensor") a mode
was added to report RPM's from a fan tach input.

Add this mode to the dt-bindings for the Gateworks System Controller.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
index d08e8fe..5a1e8d2 100644
--- a/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
+++ b/Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
@@ -83,8 +83,9 @@ properties:
                 2 - scaled voltage based on an optional resistor divider
                     and optional offset
                 3 - pre-scaled 16-bit voltage value
+                4 - fan tach input to report RPM's
             $ref: /schemas/types.yaml#/definitions/uint32
-            enum: [0, 1, 2, 3]
+            enum: [0, 1, 2, 3, 4]
 
           gw,voltage-divider-ohms:
             description: Values of resistors for divider on raw ADC input
-- 
2.7.4

