Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB5C27A7B9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgI1Gjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:39:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43972 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgI1Gjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:39:48 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08S6dMg2126278;
        Mon, 28 Sep 2020 01:39:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601275162;
        bh=85unnZJhyI+scHoIxruVD24vC/qQPy3VUMvy4L1fLlQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ik+yoNMzwDTQNENweQtvlHkvPwnIOJkCxMFA/5wSE5Wefd29wNumgGTch569B2M8j
         gWTp8exdcXkPIpI3v8LOQPm1Zc3NQ/adAN79eM/QfkwAKdDan85Ks2MZCP/+nF64+L
         hflyhpCNJsZbMTWgVIYBohF7NA6MUy31iX5vdo/I=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08S6dMCH021948
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Sep 2020 01:39:22 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 28
 Sep 2020 01:39:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 28 Sep 2020 01:39:21 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08S6dG3e111672;
        Mon, 28 Sep 2020 01:39:19 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 1/2] dt-bindings: irqchip: ti,sci-inta: Update for unmapped event handling
Date:   Mon, 28 Sep 2020 09:39:29 +0300
Message-ID: <20200928063930.12012-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928063930.12012-1-peter.ujfalusi@ti.com>
References: <20200928063930.12012-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new DMA architecture introduced with AM64 introduced new event types:
unampped events.

These events are mapped within INTA in contrast to other K3 devices where
the events with similar function was originating from the UDMAP or ringacc.

The ti,unmapped-event-sources should contain phandle array to the devices
in the system (typically DMA controllers) from where the unmapped events
originate.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../bindings/interrupt-controller/ti,sci-inta.yaml           | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index c7cd05656a3e..2837b90bbb56 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -70,6 +70,11 @@ properties:
         - description: |
             "limit" specifies the limit for translation
 
+  ti,unmapped-event-sources:
+    $ref: /schemas/types.yaml#definitions/phandle-array
+    description:
+      Array of phandles to DMA controllers where the unmapped events originate.
+
 required:
   - compatible
   - reg
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

