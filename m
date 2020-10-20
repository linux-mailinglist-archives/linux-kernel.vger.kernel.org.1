Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26E42935C7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405131AbgJTHca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:32:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38056 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405114AbgJTHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:32:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09K7WJAA036886;
        Tue, 20 Oct 2020 02:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1603179139;
        bh=4NPm+f2JwROmY0jcGX6zDh7AfDuMzQF7QjzVLDyH9hY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hHay811TZqoELS9VAfloKy4n1C0uhOkzZMqJaFoy7uAFohbV1mC4fP4G/yk0YXr86
         GrAFkGfcIhc9RcEl74ZRPRXH8MGF4FXxB1dxwfi8VUAbO7SbSEOwJVzisIimg0sKg3
         NK/cuHFcxmSiNmaCCwEroC9TlWBmhKYoLLeuPESY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09K7WJ6L028640
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Oct 2020 02:32:19 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 20
 Oct 2020 02:32:18 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 20 Oct 2020 02:32:18 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09K7WCic069455;
        Tue, 20 Oct 2020 02:32:16 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: irqchip: ti,sci-inta: Update for unmapped event handling
Date:   Tue, 20 Oct 2020 10:32:42 +0300
Message-ID: <20201020073243.19255-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020073243.19255-1-peter.ujfalusi@ti.com>
References: <20201020073243.19255-1-peter.ujfalusi@ti.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/interrupt-controller/ti,sci-inta.yaml     | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
index c7cd05656a3e..cc795498488f 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/ti,sci-inta.yaml
@@ -32,6 +32,11 @@ description: |
                        | | vint  | bit  |  | 0 |.....|63| vintx  |
                        | +--------------+  +------------+        |
                        |                                         |
+                       |      Unmap                              |
+                       | +--------------+                        |
+ Unmapped events ----->| |   umapidx    |-------------------------> Globalevents
+                       | +--------------+                        |
+                       |                                         |
                        +-----------------------------------------+
 
   Configuration of these Intmap registers that maps global events to vint is
@@ -70,6 +75,11 @@ properties:
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

