Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164BA26A4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIOMF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:05:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49628 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgIOLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:46:46 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FBjrtZ127864;
        Tue, 15 Sep 2020 06:45:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600170353;
        bh=0lW9ds17Xt2k5aIxGmpwPVJAVmIxkRT10vlHsczvB6o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ciSXD2OnGKkj4p9kJnK1czKM+6aK0MEHJ9cMRWUZPmVK3MX8TsGYob2dWAsu/eDSA
         Vgau0kiY78JrEMIZ48okUKXC9uhFXzwFu+EAoQ9Lx2wjlx0w6lcU1pE2F6Je/G9fWG
         yvBLBavwt6F8yz7hjmds4cED9J2maaWBhJCYhiFY=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FBjrpV058178
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 06:45:53 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 06:45:53 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 06:45:52 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FBjin8091853;
        Tue, 15 Sep 2020 06:45:50 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 2/3] dt-bindings: usb: cdns,usb3: Add cdns,phyrst-a-enable property
Date:   Tue, 15 Sep 2020 14:45:42 +0300
Message-ID: <20200915114543.2599-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915114543.2599-1-rogerq@ti.com>
References: <20200915114543.2599-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controller version 0x0002450D has USB2 PHY RX sensitivity issues
that needs to be worked around by enabling phyrst-a-enable bit
in PHYRST_CFG register.

There is no way to know controller version before device controller
is started and the workaround needs to be applied for both host and
device modes, so we add this DT property.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
index 9b14c8443d39..ac20b98e9910 100644
--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -61,6 +61,10 @@ properties:
       buffers expressed in KB
     $ref: /schemas/types.yaml#/definitions/uint32
 
+  cdns,phyrst-a-enable:
+    description: Enable resetting of PHY if Rx fail is detected
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

