Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC523246E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 19:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390060AbgHQRZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 13:25:49 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52660 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389850AbgHQRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 13:22:52 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07HHLv8o048896;
        Mon, 17 Aug 2020 12:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597684917;
        bh=LklfsQNtzEgv4Muun+dSl7Ny7j+95Ivu7/MecpZEky0=;
        h=From:To:CC:Subject:Date;
        b=cskJHjmSEpYEbTI8yN/aG5sv6LTSTZD8UxSG54Pmh+5Xa7F0Wuzd7WxCdp0UBzomR
         /QsCKvJW1Tza7CmR+BrNClMInj/J7zEHDMqUKU3h3vtymBtw4417dXEWs/2B8ji4yV
         hL/8UFY2aQSKfnxEPeP6O+rC4QeC0lT/quSAUEzE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07HHLvbx063744
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Aug 2020 12:21:57 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 17
 Aug 2020 12:21:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 17 Aug 2020 12:21:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07HHLv4L073434;
        Mon, 17 Aug 2020 12:21:57 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: tas2562: Remove tas2562 text file
Date:   Mon, 17 Aug 2020 12:21:50 -0500
Message-ID: <20200817172151.26564-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the tas2562 text file as the tas2562.yaml is now available.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 .../devicetree/bindings/sound/tas2562.txt     | 37 -------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/tas2562.txt

diff --git a/Documentation/devicetree/bindings/sound/tas2562.txt b/Documentation/devicetree/bindings/sound/tas2562.txt
deleted file mode 100644
index dc6d7362ded7..000000000000
--- a/Documentation/devicetree/bindings/sound/tas2562.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Texas Instruments TAS2562 Smart PA
-
-The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
-efficiently driving high peak power into small loudspeakers.
-Integrated speaker voltage and current sense provides for
-real time monitoring of loudspeaker behavior.
-
-Required properties:
- - #address-cells  - Should be <1>.
- - #size-cells     - Should be <0>.
- - compatible:	   - Should contain "ti,tas2562", "ti,tas2563".
- - reg:		   - The i2c address. Should be 0x4c, 0x4d, 0x4e or 0x4f.
- - ti,imon-slot-no:- TDM TX current sense time slot.
- - ti,vmon-slot-no:- TDM TX voltage sense time slot. This slot must always be
-		     greater then ti,imon-slot-no.
-
-Optional properties:
-- interrupt-parent: phandle to the interrupt controller which provides
-                    the interrupt.
-- interrupts: (GPIO) interrupt to which the chip is connected.
-- shut-down-gpio: GPIO used to control the state of the device.
-
-Examples:
-tas2562@4c {
-        #address-cells = <1>;
-        #size-cells = <0>;
-        compatible = "ti,tas2562";
-        reg = <0x4c>;
-
-        interrupt-parent = <&gpio1>;
-        interrupts = <14>;
-
-	shut-down-gpio = <&gpio1 15 0>;
-        ti,imon-slot-no = <0>;
-        ti,vmon-slot-no = <1>;
-};
-
-- 
2.28.0

