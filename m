Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689F0272A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgIUPih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:38:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39952 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgIUPig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:38:36 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08LFcQqW005002;
        Mon, 21 Sep 2020 10:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600702706;
        bh=T+nRlCqX5IHRf3MYSSGGXbHZiGYKvj0laXcut/LHJ1w=;
        h=From:To:CC:Subject:Date;
        b=fh+WCxWOl72RuOuxnAc3z5Psv7QOfaHDtpgbEzef4TRwxFmsqVccP7/gupzKBidXF
         FALwR0DlIuWQDTVuc39cpwVF4fM5DFwV6FEmK8IJUx3V0S/mR2TyrLVUVVZ894oOWJ
         ff7J8hrB0hlUtRKGKrcg2mjKJuXZXhj/GhLgDTa8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08LFcQSC106713
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 10:38:26 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 21
 Sep 2020 10:38:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 21 Sep 2020 10:38:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08LFcQWL075280;
        Mon, 21 Sep 2020 10:38:26 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] dt-bindings: tas2562: Add the TAS2110 amplifier
Date:   Mon, 21 Sep 2020 10:38:19 -0500
Message-ID: <20200921153820.18357-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TAS2110 amplifier compatible.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

This patchset is based on top of patchset https://lore.kernel.org/patchwork/project/lkml/list/?series=463709

 Documentation/devicetree/bindings/sound/tas2562.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
index d3ceda356aaa..27f7132ba2ef 100644
--- a/Documentation/devicetree/bindings/sound/tas2562.yaml
+++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
@@ -20,6 +20,7 @@ description: |
     https://www.ti.com/lit/gpn/tas2562
     https://www.ti.com/lit/gpn/tas2563
     https://www.ti.com/lit/gpn/tas2564
+    https://www.ti.com/lit/gpn/tas2110
 
 properties:
   compatible:
@@ -27,6 +28,7 @@ properties:
       - ti,tas2562
       - ti,tas2563
       - ti,tas2564
+      - ti,tas2110
 
   reg:
     maxItems: 1
-- 
2.28.0

