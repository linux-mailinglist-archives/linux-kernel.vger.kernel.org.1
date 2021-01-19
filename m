Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB942FB1DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 07:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbhASGon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 01:44:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46352 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbhASGoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 01:44:10 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10J6gWVH005772;
        Tue, 19 Jan 2021 00:42:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611038552;
        bh=kicaJWe4lJcpgcnt3hDVKDopAjMnUwOLVZVReyXGh54=;
        h=From:To:CC:Subject:Date;
        b=S7uOWjQLnuNq0BxAtgjLQ8OqfzknwlknkT7S+2aTWu+EpTt9tk5yFbAy1N+ijl+S8
         rXSuY9l2XZzF75XA36inpVQvlOegueCZ/CHqXzQrnv1qBnRt4Dy5ad/H6/fEn0sgT9
         Ma6sLrtglUMtmh2PkFIlOJ9Zvq5rsGdg+9+gz+9c=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10J6gW0N099790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Jan 2021 00:42:32 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 Jan 2021 00:42:31 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 Jan 2021 00:42:31 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10J6gQ2V017026;
        Tue, 19 Jan 2021 00:42:27 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>
Subject: [PATCH] dt-bindings: usb: Add ranges and dma-coherent property
Date:   Tue, 19 Jan 2021 12:12:24 +0530
Message-ID: <20210119064224.6946-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ranges and dma-coherent property in ti,j721e-usb dt-binding.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 4423f0a29f54..0c553e72d2ff 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -38,6 +38,8 @@ properties:
       - const: ref
       - const: lpm
 
+  ranges: true
+
   ti,usb2-only:
     description:
       If present, it restricts the controller to USB2.0 mode of
@@ -63,6 +65,8 @@ properties:
   '#size-cells':
     const: 2
 
+  dma-coherent: true
+
 patternProperties:
   "^usb@":
     type: object
@@ -73,6 +77,7 @@ required:
   - power-domains
   - clocks
   - clock-names
+  - ranges
 
 additionalProperties: false
 
@@ -95,6 +100,7 @@ examples:
             assigned-clock-parents = <&k3_clks 288 16>; /* HFOSC0 */
             #address-cells = <2>;
             #size-cells = <2>;
+            ranges;
 
             usb@6000000 {
                   compatible = "cdns,usb3";
-- 
2.17.1

