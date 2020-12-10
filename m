Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811C22D5369
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 06:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732623AbgLJFjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 00:39:01 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60538 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgLJFim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 00:38:42 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BA5bmrB037995;
        Wed, 9 Dec 2020 23:37:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607578668;
        bh=669p0aGvc+wv5r2P4jSKbM0nhtpSnzsMzUMKngI6XnQ=;
        h=From:To:CC:Subject:Date;
        b=HzP7D/Y3EC1d7VZNfWaNXAEi2JjbaR/6oVoq6ngmHPwmspdStUckTAB4EBExVVawa
         X5rt37Liqa93oqv6jw/Am9JBJxyfe+6fvpKHhf5Ti8FwA95hDJHTXDhEexnlIJixIW
         Z5by7J5L9VCbPfNWGnXxZucsjDOmqd2p7hPlGhTg=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BA5bmg9013766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Dec 2020 23:37:48 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Dec
 2020 23:37:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Dec 2020 23:37:47 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BA5bgJ1113899;
        Wed, 9 Dec 2020 23:37:43 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dt-bindings: usb: Add new compatible string for AM64 SoC
Date:   Thu, 10 Dec 2020 11:07:40 +0530
Message-ID: <20201210053740.5564-1-a-govindraju@ti.com>
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
Acked-by: Roger Quadros <rogerq@ti.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 388245b91a55..453587f6d304 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -11,8 +11,11 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - const: ti,j721e-usb
+    anyOf:
+      - items:
+          - const: ti,j721e-usb
+      - items:
+          - const: ti,am64-usb
 
   reg:
     description: module registers
-- 
2.17.1

