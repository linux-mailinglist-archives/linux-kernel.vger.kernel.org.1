Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8151927026E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIRQnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:43:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49164 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:43:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IGhRTm028426;
        Fri, 18 Sep 2020 11:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600447407;
        bh=dTAM7ZNYGRkaUHqtwQ2Jc2yzxy7+xjgyUcfu900PcvM=;
        h=From:To:CC:Subject:Date;
        b=j7Rq2ltpESmHeDC2HoGQzJl7Pm5p/xXEuBcABDJIe3AdPama3YcNFZG124RqV7GB0
         pUpaTeiLKbyd7+LSl6GA9DUqb3FmPa9RNsKhxrZ8HnxlPmNJfYh5UmD8Es13nPW4Ly
         kr09BfqWvrixzjmT0TGQJZPFnhVxIB4DJHrBNTU8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IGhRNV090571
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 11:43:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 11:43:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 11:43:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IGhQkw024902;
        Fri, 18 Sep 2020 11:43:27 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] dt-bindings: tas2770: Fix I2C addresses for the TAS2770
Date:   Fri, 18 Sep 2020 11:43:20 -0500
Message-ID: <20200918164320.11577-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The I2C addresses listed in the yaml are not correct. The addresses can
range from 0x41 through 0x48 based on register configurations. Fix the
example and the description.

Fixes: 4b7151dadfd4 ("dt-bindings: ASoC: Add tas2770 smart PA dt bindings")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2770.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index 33a90f829c80..bb26d081c9fa 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -24,7 +24,7 @@ properties:
   reg:
     maxItems: 1
     description: |
-       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
+       I2C address of the device can be between 0x41 to 0x48.
 
   reset-gpio:
     description: GPIO used to reset the device.
@@ -62,9 +62,9 @@ examples:
    i2c0 {
      #address-cells = <1>;
      #size-cells = <0>;
-     codec: codec@4c {
+     codec: codec@41 {
        compatible = "ti,tas2770";
-       reg = <0x4c>;
+       reg = <0x41>;
        #sound-dai-cells = <1>;
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
-- 
2.28.0

