Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37392F858E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 20:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388627AbhAOTcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 14:32:17 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:37620 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbhAOTcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 14:32:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10FJVYmk009482;
        Fri, 15 Jan 2021 13:31:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610739094;
        bh=s4yqArMb0hjWfckvA2wYPty2j60vPxoJhIt411BfUPU=;
        h=From:To:CC:Subject:Date;
        b=IRxLjnbRNw45kCnuIJp/fxvQwtzUQqdGTsdYXLACpvRvayJH4I8rXe402k7u+mxYm
         Qq7G6oQ4Fi8mqchiqNJRVXsXui2OHEkFx7jC/P6hFJ31KYijBQnqHhQ4MhKAGJ3hUm
         HJk+/7U+NUBlgCw+jUvaadmzPKmClvgkvzrmb6BA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10FJVYgP028544
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Jan 2021 13:31:34 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 15
 Jan 2021 13:31:33 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 15 Jan 2021 13:31:33 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10FJVWRe063203;
        Fri, 15 Jan 2021 13:31:33 -0600
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aswath Govindraju <a-govindraju@ti.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] dt-bindings: usb: j721e: add ranges and dma-coherent props
Date:   Fri, 15 Jan 2021 21:31:24 +0200
Message-ID: <20210115193124.5706-1-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missed 'ranges' and 'dma-coherent' properties as cdns-usb DT nodes has
child node and DMA IO is coherent on TI K3 J721E/J7200 SoCs.

This also fixes dtbs_check warning:
 cdns-usb@4104000: 'dma-coherent', 'ranges' do not match any of the regexes: '^usb@', 'pinctrl-[0-9]+'

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
index 4423f0a29f54..7ec87a783c5c 100644
--- a/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml
@@ -21,6 +21,8 @@ properties:
   reg:
     maxItems: 1
 
+  ranges: true
+
   power-domains:
     description:
       PM domain provider node and an args specifier containing
@@ -63,6 +65,8 @@ properties:
   '#size-cells':
     const: 2
 
+  dma-coherent: true
+
 patternProperties:
   "^usb@":
     type: object
-- 
2.17.1

