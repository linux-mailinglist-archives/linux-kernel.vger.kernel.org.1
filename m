Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D00E26AD1D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgIOTKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:10:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35726 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbgIOTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:07:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6Yx1060938;
        Tue, 15 Sep 2020 14:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600196794;
        bh=lfBspNnpVGK9fOkXASWVZnL//G/ZoFt7Tt8VaXOOno0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=f+eXQdfTJJPzfZ18SP6Yppv/ZTZ/M8SnbGBwRIuXdaalF2w1f7DFZMjXBl3f5iH/0
         Ovj6VPYU85xQA1Loly7Z5ZePVTi6T7i7Xfi9FydFLeh5+qKXGHpmwosdzqu5NAbRLA
         Rxf8L3EuUYRYdS+0jaRDoN0+1XmFP0J3AqUZ1sRM=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6Yp9039687;
        Tue, 15 Sep 2020 14:06:34 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 14:06:34 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 14:06:34 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6YED008324;
        Tue, 15 Sep 2020 14:06:34 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <camel.guo@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 5/6] dt-bindings: tlv320adcx140: Add slot programming property
Date:   Tue, 15 Sep 2020 14:06:05 -0500
Message-ID: <20200915190606.1744-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200915190606.1744-1-dmurphy@ti.com>
References: <20200915190606.1744-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a property to configure the each channel to a specific TDM slot.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../bindings/sound/tlv320adcx140.yaml          | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index e79f8d1891e4..dfc00308da94 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -114,6 +114,24 @@ properties:
       When set the device will set the Tx ASI output to a Hi-Z state for unused
       data cycles. Default is to drive the output low on unused ASI cycles.
 
+  ti,slot-mapping:
+    type: boolean
+    description: |
+      Each channel can be assigned a specific TDM slot for either a left or
+      right channel. The left channel values are from 0-31d and the right
+      channel values are from 32-63d. If the right channel value is 32 then the
+      right channel slot will be slot 31.
+      The array index is sequential audio channel to be set.
+      [ch1, ch2, ch3, ch4, ch5, ch6, ch7, ch8]
+      If the channel is not to be used then the channel should be set to it's
+      default value.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 1
+    maxItems: 8
+    items:
+      maximum: 63
+    default: [0, 1, 2, 3, 4, 5, 6, 7]
+
 patternProperties:
   '^ti,gpo-config-[1-4]$':
     $ref: /schemas/types.yaml#/definitions/uint32-array
-- 
2.28.0

