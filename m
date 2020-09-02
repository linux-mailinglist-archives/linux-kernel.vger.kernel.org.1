Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1A725AE03
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 16:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgIBO5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 10:57:54 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51498 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgIBN4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:56:55 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082DZqkm126151;
        Wed, 2 Sep 2020 08:35:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599053752;
        bh=+OataKjcHaS2/yUx/zgmwoW6NcsuC7JMXVcJUiQn8J0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=xOrbSudmxkxw2W04FYoQyGdhwbMsMv63n2u26Dg3K5sNA516c7A/OQVuSBdZwQ1iQ
         YWLRvFmkb9kt5/JTPpdM4zGtJwInR5rR0uKewhYSKGo0QMopK5lzQBoDAqXMmLE/Zl
         DorswhPx6hzif6KlX8d2K7srl/MglzqaBmj7Cwko=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082DZqqE056989
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 08:35:52 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 08:35:52 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 08:35:52 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082DZiGB065816;
        Wed, 2 Sep 2020 08:35:50 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <balbi@kernel.org>
CC:     <pawell@cadence.com>, <kurahul@cadence.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/3] dt-bindings: usb: cdns,usb3: Add cdns,phyrst-a-enable property
Date:   Wed, 2 Sep 2020 16:35:42 +0300
Message-ID: <20200902133543.17222-3-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902133543.17222-1-rogerq@ti.com>
References: <20200902133543.17222-1-rogerq@ti.com>
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
---
 Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
index 7bc0263accee..e670adc955e1 100644
--- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
+++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
@@ -58,6 +58,10 @@ properties:
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

