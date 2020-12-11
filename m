Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546DD2D6FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 07:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395451AbgLKGGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 01:06:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:41832 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391588AbgLKGGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 01:06:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BB64cbx039923;
        Fri, 11 Dec 2020 00:04:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607666678;
        bh=wSqjmbU0YYGEkg93VVUH28s8uW6BoEtX08kYM08bGPo=;
        h=From:To:CC:Subject:Date;
        b=fPgU5gOnLC1M3lsMAIClh7KPtDTIZU9PFV36de1+wxiXDYfWRkhtdD2WB1gZO7Dof
         rp7ZEjWgKnJh9I3CPHoyxTPKqI4HF7iaku+R0985x47wvZkuxUggXFHpSCrO0gG1xb
         6X/W4c48RxSTR6aR3Eo/xPG+YxT2mtA6DTnJPQY4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BB64c1q078685
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Dec 2020 00:04:38 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 11
 Dec 2020 00:04:37 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 11 Dec 2020 00:04:38 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BB64Xoh116260;
        Fri, 11 Dec 2020 00:04:34 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4] dt-bindings: usb: Add new compatible string for AM64 SoC
Date:   Fri, 11 Dec 2020 11:34:29 +0530
Message-ID: <20201211060429.20027-1-a-govindraju@ti.com>
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

Changes since v3:
- used enum instead of anyOf.

Changes since v2:
- added changes done over the versions.

Changes since v1:
- replaced the '\t' at the beginning of the lines with spaces as it was
  causing the dt_binding_check to fail.

 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 388245b91a55..1a5c7bbb40d1 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -11,8 +11,9 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: ti,j721e-usb
+    enum:
+      - ti,j721e-usb
+      - ti,am64-usb
 
   reg:
     description: module registers
-- 
2.17.1

