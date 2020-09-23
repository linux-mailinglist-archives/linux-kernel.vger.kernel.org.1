Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8346027589D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgIWN0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:26:18 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42238 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWN0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:26:17 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQ64I079356;
        Wed, 23 Sep 2020 08:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600867566;
        bh=Jtx9TEjy/J58R+gZ76e1lApC4KJGiqGlJ+iQaXtH5Gw=;
        h=From:To:CC:Subject:Date;
        b=uvHtjwIYQv/sIz+smzPyt/5E1AgK0UvhBg/WOCgn0XvAgE8WrGK/QO3aoWTVmg/t1
         tOQpuv1ZKS07yFKWvDaBBY/H34GdX0fUsgzAfBPh65cGyLhr6CTxkRDafcreA6Lx1+
         BiuVbM4BGWu/2pEIZSW/3uCPuulocxq+xuKUEI40=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NDQ6Vs045148
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 08:26:06 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 08:26:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 08:26:06 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQ6dZ050553;
        Wed, 23 Sep 2020 08:26:06 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/6] dt-bindings: tas2770: Add shutdown gpio property
Date:   Wed, 23 Sep 2020 08:25:55 -0500
Message-ID: <20200923132600.10652-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the shutdown-gpios property to the yaml to define the GPIO that can
be used to place the device in shutdown mode or wake the device up.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 Documentation/devicetree/bindings/sound/tas2770.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
index bb26d081c9fa..9fdf614add55 100644
--- a/Documentation/devicetree/bindings/sound/tas2770.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
@@ -29,6 +29,9 @@ properties:
   reset-gpio:
     description: GPIO used to reset the device.
 
+  shutdown-gpios:
+    description: GPIO used to control the state of the device.
+
   interrupts:
     maxItems: 1
 
@@ -69,6 +72,7 @@ examples:
        interrupt-parent = <&gpio1>;
        interrupts = <14>;
        reset-gpio = <&gpio1 15 0>;
+       shutdown-gpios = <&gpio1 14 0>;
        ti,imon-slot-no = <0>;
        ti,vmon-slot-no = <2>;
      };
-- 
2.28.0

