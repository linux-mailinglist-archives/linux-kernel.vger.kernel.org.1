Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D2D27049E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgIRTGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:06:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40542 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbgIRTGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:06:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ67l5067319;
        Fri, 18 Sep 2020 14:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600455967;
        bh=SuC07PDfmDmZkHNGotu4rKFFSf7BkH+mxsA1p5rSHEg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Huqcok7FCnC3sfGezQGWF6DFpYbkswS3JO203HqCc+MTtmOhC1VoEADqlBnmHQlPn
         MmToFYW0N/fBzVzNQCcWPDuLZEtmJFh8to9FdXfekwgC6dlD34d20bKbLx3BNK4yHN
         z62Gr1bdEz6Bul47QRMxb521J2zZr8tTYqb21B/g=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IJ66Ir078852
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 14:06:06 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 14:06:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 14:06:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ65Yv013112;
        Fri, 18 Sep 2020 14:06:05 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 4/9] ASoC: tas2770: Fix required DT properties in the code
Date:   Fri, 18 Sep 2020 14:05:43 -0500
Message-ID: <20200918190548.12598-4-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918190548.12598-1-dmurphy@ti.com>
References: <20200918190548.12598-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree binding indicates that the ti,asi-format, ti,imon-slot-no
and ti,vmon-slot-no are not required but the driver requires them or it
fails to probe. Honor the binding and allow these entries to be optional
and set the corresponding values to the default values for each as defined
in the data sheet.

Fixes: 1a476abc723e6 ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 7c6f61946ab3..bdfdad5f4f64 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -708,29 +708,28 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 	rc = fwnode_property_read_u32(dev->fwnode, "ti,asi-format",
 					&tas2770->asi_format);
 	if (rc) {
-		dev_err(tas2770->dev, "Looking up %s property failed %d\n",
-			"ti,asi-format", rc);
-		goto end;
+		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
+			"ti,asi-format");
+		tas2770->asi_format = 0;
 	}
 
 	rc = fwnode_property_read_u32(dev->fwnode, "ti,imon-slot-no",
 			&tas2770->i_sense_slot);
 	if (rc) {
-		dev_err(tas2770->dev, "Looking up %s property failed %d\n",
-			"ti,imon-slot-no", rc);
-		goto end;
+		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
+			"ti,imon-slot-no");
+		tas2770->i_sense_slot = 0;
 	}
 
 	rc = fwnode_property_read_u32(dev->fwnode, "ti,vmon-slot-no",
 				&tas2770->v_sense_slot);
 	if (rc) {
-		dev_err(tas2770->dev, "Looking up %s property failed %d\n",
-			"ti,vmon-slot-no", rc);
-		goto end;
+		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
+			"ti,vmon-slot-no");
+		tas2770->v_sense_slot = 2;
 	}
 
-end:
-	return rc;
+	return 0;
 }
 
 static int tas2770_i2c_probe(struct i2c_client *client,
-- 
2.28.0

