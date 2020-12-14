Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3935B2D995D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408171AbgLNOCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:02:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49878 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732936AbgLNOCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:02:47 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BEE1q9I069588;
        Mon, 14 Dec 2020 08:01:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607954512;
        bh=33AuVZNORvzugvsNVbeRIQp/8O4uTVgriSBQcSSQ/tg=;
        h=From:To:CC:Subject:Date;
        b=YObRZc/IHwMXnOGZjqRSpTZ2NgmPmiLwQy53oDkmB5G265jLUD1goYhQeYUHyaxgp
         Jru7Ygmca3SNFY9BH6h83K01PgrxsNzsAgAqpkzsUpzGyhVrKHGSedkfyIvgO5HxOh
         TKWZffqVohEV0WR6VQH+mqOG3cMZASY1pTUNzsQM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BEE1qr5066001
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Dec 2020 08:01:52 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Dec 2020 08:01:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Dec 2020 08:01:52 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BEE1lpW036656;
        Mon, 14 Dec 2020 08:01:48 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] dt-bindings: usb: Add new compatible string for AM64 SoC
Date:   Mon, 14 Dec 2020 19:31:09 +0530
Message-ID: <20201214140109.21955-1-a-govindraju@ti.com>
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
index 388245b91a55..21e51ceca293 100644
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
+          - ti,j721e-usb
+          - ti,am64-usb
 
   reg:
     description: module registers
-- 
2.17.1

