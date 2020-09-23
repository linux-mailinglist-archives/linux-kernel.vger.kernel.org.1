Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C462758A5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgIWN0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:26:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42382 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWN0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:26:35 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQRSq079517;
        Wed, 23 Sep 2020 08:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600867587;
        bh=A4bgooINotZr+K0CU0OP7KantsSeOeiJxDKk2TXeaTM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CgMMJMnzSRXDnwA3NrOftnO0mVOcH1U6+onAuVS2skPwNxLuD+UxouWpqFCQ43NFv
         YRHeK7TjfNMPsobDLpublzpxVubonsReldeZXNcwMt3c74rja6rff/OGnayPok++O9
         qaHDsGcMp1moh/dQfG2FAvAR8ZKUhkCeUpzCZaxA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NDQRt2101881
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 08:26:27 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 08:26:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 08:26:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQRfL007732;
        Wed, 23 Sep 2020 08:26:27 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 5/6] ASoC: tas2770: Remove ti,asi-format code
Date:   Wed, 23 Sep 2020 08:25:59 -0500
Message-ID: <20200923132600.10652-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923132600.10652-1-dmurphy@ti.com>
References: <20200923132600.10652-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the code to support the asi-format binding property. The code
does nothing except read the property and set a variable. No additional
action is taken except to reset the variable. The property is supposed
to set the rising or falling RX edge detection of the SBCLK but this
edge detection is done by checking the DAI_FMT_INV_MASK.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 11 -----------
 sound/soc/codecs/tas2770.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c42e653cd653..c7a6f7e8200c 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -391,8 +391,6 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
-	tas2770->asi_format = fmt;
-
 	return 0;
 }
 
@@ -646,15 +644,6 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 {
 	int rc = 0;
 
-	rc = fwnode_property_read_u32(dev->fwnode, "ti,asi-format",
-				      &tas2770->asi_format);
-	if (rc) {
-		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
-			 "ti,asi-format");
-
-		tas2770->asi_format = 0;
-	}
-
 	rc = fwnode_property_read_u32(dev->fwnode, "ti,imon-slot-no",
 				      &tas2770->i_sense_slot);
 	if (rc) {
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index b3fc4a487033..856a7c5cff5a 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -132,7 +132,6 @@ struct tas2770_priv {
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	int power_state;
-	int asi_format;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *sdz_gpio;
 	int sampling_rate;
-- 
2.28.0

