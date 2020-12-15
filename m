Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A42DA71A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 05:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgLOE1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 23:27:34 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44656 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgLOE1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 23:27:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BF4Ptxr121071;
        Mon, 14 Dec 2020 22:25:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608006356;
        bh=1NgGCRIjgY2IImg8iKnY9M0JdvpwcoHnFNpVJzDs6tk=;
        h=From:To:CC:Subject:Date;
        b=lXOcGtWzsS8JRgtIDnr+tBdU32dr12t8SteDRGi8Vubgv4tce7Lgz9DL//sDukVmi
         GllrL+E+w3BBD18BA8UFWBSFQBpuHPZ5t76Erp0FwGez6pNVXKm6RR4UfgZREslyyL
         c3Py1EPDOwozIVIZdnyPemOeA/NdsFZF1Xn8SVrs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BF4Pt6b064604
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 22:25:55 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 22:25:55 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Dec 2020 22:25:55 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BF4PpnH066580;
        Mon, 14 Dec 2020 22:25:52 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] dt-bindings: usb: Add new compatible string for AM64 SoC
Date:   Tue, 15 Dec 2020 09:55:49 +0530
Message-ID: <20201215042549.7956-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string in j721e-usb binding file as the same USB subsystem
is present in AM64.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Changes since v5:
 - Added const as the type for objects in items.

Changes since v4:
 - used oneOf instead of enum, as the schema has to convey that the strings
   ti,j721e-usb and ti,am64-usb can be used combined or seperately in the
   DT nodes.

Changes since v3:
 - used enum instead of anyOf.

Changes since v2:
 - added changes done over the versions.

Changes since v1:
 - replaced the '\t' at the beginning of the lines with spaces as it was
  causing the dt_binding_check to fail.

 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 388245b91a55..148b3fb4ceaf 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -11,8 +11,12 @@ maintainers:
 
 properties:
   compatible:
-    items:
+    oneOf:
       - const: ti,j721e-usb
+      - const: ti,am64-usb
+      - items:
+          - const: ti,j721e-usb
+          - const: ti,am64-usb
 
   reg:
     description: module registers
-- 
2.17.1

