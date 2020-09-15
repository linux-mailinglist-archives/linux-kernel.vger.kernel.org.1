Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D92926AD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgIOTIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:08:44 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49754 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgIOTGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:06:33 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6Ocf013532;
        Tue, 15 Sep 2020 14:06:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600196784;
        bh=hgyrILCOHxn4aWfNT+mBa0oIr/oD9RVinyh1T/rioAw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BNqM+wyLN/jDKHkAaTzKShkDAfBaAQKd4tStU0EF/fZCwrx5pbO49bwxOPMkVCAAk
         CHmUw49P4q7vsobYJ9+di2J3pRtFcRVRGKAJwGW2QjxlYJyrS4Ap9+98giYgAU9Gz5
         CLePWE2JHyTWh8ZY0L+T1SVAo03aPQqNze2iYj9I=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FJ6O0R060657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 14:06:24 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 14:06:24 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 14:06:24 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6NcD102452;
        Tue, 15 Sep 2020 14:06:23 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <camel.guo@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 3/6] dt-bindings: tlv320adcx140: Add ASI Tx drive
Date:   Tue, 15 Sep 2020 14:06:03 -0500
Message-ID: <20200915190606.1744-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200915190606.1744-1-dmurphy@ti.com>
References: <20200915190606.1744-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a property to indicate if the device is to go into a High-z state on
the Tx ASI output pins when the device is idle.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tlv320adcx140.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
index f578f17f3e04..e79f8d1891e4 100644
--- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
+++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
@@ -108,6 +108,12 @@ properties:
       maximum: 7
     default: [0, 0, 0, 0]
 
+  ti,asi-tx-drive:
+    type: boolean
+    description: |
+      When set the device will set the Tx ASI output to a Hi-Z state for unused
+      data cycles. Default is to drive the output low on unused ASI cycles.
+
 patternProperties:
   '^ti,gpo-config-[1-4]$':
     $ref: /schemas/types.yaml#/definitions/uint32-array
-- 
2.28.0

