Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 182222DDFF7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 09:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbgLRIgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 03:36:16 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48922 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgLRIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 03:36:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BI8YLNd088847;
        Fri, 18 Dec 2020 02:34:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608280461;
        bh=+AsqQXhaLlHomK8LtuyuLC+nrR1nfgdnGZarId8P5ag=;
        h=From:To:CC:Subject:Date;
        b=GOgmoRUA9guDxKSMZ5dGqSXvTIGgpveRT68U7Ub03FEwIBp0B46diceMYUFeq11SY
         +y/y5HwP8veq16s2KfUp0SVoFD5xMe+Gi45aVQpxIJ0XXtBXUwvC70ca7jTZatBXgH
         Aux8hkfkKZdJnzQF/fFxaIqLGH54iZPEgXQmlX+Q=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BI8YLsw072874
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 02:34:21 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Dec 2020 02:34:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Dec 2020 02:34:20 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BI8YHIY077604;
        Fri, 18 Dec 2020 02:34:18 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <sam@ravnborg.org>
CC:     <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <peter.ujfalusi@gmail.com>
Subject: [PATCH v2] dt-bindings: display: bridge: tc358768: Change maintainer information
Date:   Fri, 18 Dec 2020 10:35:22 +0200
Message-ID: <20201218083522.21743-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My employment with TI is coming to an end and I will not have access to
the board where this bridge is connected to and I will also loose access to
the manual of the chip.

Add the missing copyright information, author and change the maintainer to
Sam Ravnborg (thank you for volenteering!)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 .../devicetree/bindings/display/bridge/toshiba,tc358768.yaml  | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
index c036a75db8f7..c08fd42be2d0 100644
--- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358768.yaml
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2020 Texas Instruments Incorporated
+# Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/display/bridge/toshiba,tc358768.yaml#
@@ -7,7 +9,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Toschiba TC358768/TC358778 Parallel RGB to MIPI DSI bridge
 
 maintainers:
-  - Peter Ujfalusi <peter.ujfalusi@ti.com>
+  - Sam Ravnborg <sam@ravnborg.org>
 
 description: |
   The TC358768/TC358778 is bridge device which converts RGB to DSI.
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

