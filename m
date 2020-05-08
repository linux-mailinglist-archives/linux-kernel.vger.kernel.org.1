Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81B1CA609
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 10:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEHI3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 04:29:47 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49582 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEHI3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:29:46 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0488Tido023273;
        Fri, 8 May 2020 03:29:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588926584;
        bh=nAlvTGsJH+rs2JUDiU2G2Y01gpAIibR+kM4znZi5wVA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yFRDlehr15XZcdpOmPVA/p5UXlpUpyMFS/KcF/8xGTygTBkpoTwobCxrtZEMvFFnf
         9cdctCi5r3lcQkau5N8SpMCfLWNlUGTdEkh/3lD38o/gF48b/KvqkhIsWN2V2t3A1E
         KPMOo9eT4KNF4H4lzklbK4FFgWPaCM30Bsl9H6tM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488TiM8099863;
        Fri, 8 May 2020 03:29:44 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 03:29:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 03:29:44 -0500
Received: from lta0400828a.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488TdnA073953;
        Fri, 8 May 2020 03:29:42 -0500
From:   Roger Quadros <rogerq@ti.com>
To:     <t-kristo@ti.com>
CC:     <robh@kernel.org>, <kishon@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/7] dt-bindings: syscon: Add TI's J721E specific compatible string
Date:   Fri, 8 May 2020 11:29:31 +0300
Message-ID: <20200508082937.14171-2-rogerq@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508082937.14171-1-rogerq@ti.com>
References: <20200508082937.14171-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

Add TI's J721E SoC specific compatible string.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
index 39375e4313d2..f9aac75d423a 100644
--- a/Documentation/devicetree/bindings/mfd/syscon.yaml
+++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
@@ -38,6 +38,7 @@ properties:
           - allwinner,sun8i-h3-system-controller
           - allwinner,sun8i-v3s-system-controller
           - allwinner,sun50i-a64-system-controller
+          - ti,j721e-system-controller
 
         - const: syscon
 
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

