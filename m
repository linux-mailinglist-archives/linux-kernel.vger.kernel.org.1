Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47442221E25
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 10:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgGPIXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 04:23:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37522 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgGPIXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:23:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06G8N0H4037724;
        Thu, 16 Jul 2020 03:23:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594887780;
        bh=eV0FmK0L/UGY3PgbV8rEUhbMy0YKYdxtkan+LL/VvZk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WbQ8dxEqkvin1Cr1KJLU20lyHGQOgg81dSlD4xFTGHTUtta5DzEjR03fadUgdRoUA
         SdCx6ryYULlykvX/I6SEWtr6wwtVWZFdVsSDOIRQmwRYe89lwi9ZhxA8wNot8PfvIP
         h5aX/wNUY/WsCVpb7xWfonmzGqRHU0Xt9Az+JG9s=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06G8N0V4043204;
        Thu, 16 Jul 2020 03:23:00 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 16
 Jul 2020 03:22:59 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 16 Jul 2020 03:22:59 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06G8MrSH049495;
        Thu, 16 Jul 2020 03:22:58 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <kishon@ti.com>
CC:     <robh+dt@kernel.org>, <nsekhar@ti.com>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>
Subject: [PATCH v4 2/3] dt-binding: phy: ti,omap-usb2: Add quirk to disable charger detection
Date:   Thu, 16 Jul 2020 11:22:51 +0300
Message-ID: <20200716082252.21266-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716082252.21266-1-rogerq@ti.com>
References: <20200716082252.21266-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "ti,disable-charger-det" property to disable the USB2_PHY Charger Detect
logic.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
index a05110351814..7d52c5bf9f21 100644
--- a/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
@@ -53,6 +53,11 @@ properties:
       (deprecated) phandle of the control module used by PHY driver
       to power on the PHY. Use syscon-phy-power instead.
 
+  ti,disable-charger-det:
+    description:
+      if present, driver will disable charger detection logic.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

