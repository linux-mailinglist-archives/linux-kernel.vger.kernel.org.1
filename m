Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAADD26DA22
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgIQL1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:27:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53792 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgIQL1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:14 -0400
X-Greylist: delayed 24686 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 07:27:14 EDT
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GClNVB074174;
        Wed, 16 Sep 2020 07:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600260443;
        bh=99rMgmaxPLjfBgOLfW1ZXBuphUwsIscoTc8O8NdxdAs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=i5vpGzRGDDQRTCYBudGMU8sDABxlW81hXCqxFe0Vn9Wsm23n0yinzo52UxmmZKMTf
         pEyTOiXaFefGk4OeHLz4aBVBGj2ujCKIZbOgsX/Hsars69ubpH4UaDFaVf5aKfW2Ew
         XGsONyLNbrmFRfwmUWryWcgZJWCKeMKOa6mXKgdE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08GClNw2074563
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 07:47:23 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:47:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:47:23 -0500
Received: from deskari.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GClIov027623;
        Wed, 16 Sep 2020 07:47:21 -0500
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Yuti Amonkar <yamonkar@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/2] dt-bindings: phy: cdns,torrent-phy: add reset-names
Date:   Wed, 16 Sep 2020 15:47:11 +0300
Message-ID: <20200916124711.166643-2-tomi.valkeinen@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916124711.166643-1-tomi.valkeinen@ti.com>
References: <20200916124711.166643-1-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-names as a required property.

There are no dts files using torrent phy yet, so it is safe to add a new
required property.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index 4071438be2ba..12ce022e4764 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -54,6 +54,10 @@ properties:
       Torrent PHY reset.
       See Documentation/devicetree/bindings/reset/reset.txt
 
+  reset-names:
+    items:
+      - const: torrent_reset
+
 patternProperties:
   '^phy@[0-7]+$':
     type: object
@@ -111,6 +115,7 @@ required:
   - reg
   - reg-names
   - resets
+  - reset-names
 
 additionalProperties: false
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

