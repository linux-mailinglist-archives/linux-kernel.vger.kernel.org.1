Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC482A46DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 14:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgKCNuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 08:50:18 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51852 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgKCNto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:49:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0A3DnRg9107792;
        Tue, 3 Nov 2020 07:49:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1604411367;
        bh=SzidYoneQWvOnD0s5bdWsq+0FdRLRXVKaW3T7pfHr5w=;
        h=From:To:CC:Subject:Date;
        b=pn+CzX9ghk9WGxtrDT64mG4frsZ9AXHHvskF/MPk6Bm0ebWgOXLHUoQ8uP6QXeNzS
         scdOe5phyARnHoe3Efoxzdgy9Ry13ipwKrBpQWipYg6Q4AeombAQvf/A+HOKOXPhyJ
         nmsQZqzXy9qU+BfTnNPlG0ZP1NZWoSmXqLhBWCHw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0A3DnRNx022246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Nov 2020 07:49:27 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 3 Nov
 2020 07:49:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 3 Nov 2020 07:49:27 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0A3DnNaS055735;
        Tue, 3 Nov 2020 07:49:24 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH] dt-bindings: irqchip: ti, sci-inta: Fix diagram indentation for unmapped events
Date:   Tue, 3 Nov 2020 15:50:04 +0200
Message-ID: <20201103135004.2363-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One space has been missing by the diagram update.

Fixes: bb2bd7c7f3d0 ("dt-bindings: irqchip: ti, sci-inta: Update for unmapped event handling")
Reported-by: Rob Herring <robh@kernel.org>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

I'm very sorry, I did not realized the missing whitespace in the original patch
and obviously I failed to run the check.

Regards,
Peter

 .../devicetree/bindings/interrupt-controller/ti,sci-inta.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index be5f06f0044b..b5af12011499 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -34,7 +34,7 @@ description: |
                        |                                         |
                        |      Unmap                              |
                        | +--------------+                        |
- Unmapped events ----->| |   umapidx    |-------------------------> Globalevents
+  Unmapped events ---->| |   umapidx    |-------------------------> Globalevents
                        | +--------------+                        |
                        |                                         |
                        +-----------------------------------------+
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

