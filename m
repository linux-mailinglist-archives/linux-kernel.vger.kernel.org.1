Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218F120B507
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 17:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgFZPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 11:43:28 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59412 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgFZPn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:43:27 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05QFgj9D096147;
        Fri, 26 Jun 2020 10:42:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593186165;
        bh=EW2A9uRIGHHuM09Q2Wz7LAYeQOWX5tSnZ+cfBXr43XA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=KYO2Eu/yixigv8qpY3KFnVxeMkfl4LF75K5IQeT9gMx+OVjW3PjMRrujG7IH3hGk9
         SXJl/4E8wYs9ftgVGLmRetbcHX6L2S4TijmQgY6pi3ANQwwEaQxBIrw9TvYxIqAwfC
         WyMa3y01UksL9dN39v0OroGPuHxKkI7Q5YynEfVo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05QFgjRC080515
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Jun 2020 10:42:45 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 26
 Jun 2020 10:42:45 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 26 Jun 2020 10:42:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05QFgjVR085983;
        Fri, 26 Jun 2020 10:42:45 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 3/4] ASoC: tas2562: Add voltage sense slot configuration
Date:   Fri, 26 Jun 2020 10:41:42 -0500
Message-ID: <20200626154143.20351-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626154143.20351-1-dmurphy@ti.com>
References: <20200626154143.20351-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vsense slot configuration based on the device tree.  Adding this
property enables the slot programming to be moved to the tdm_set_slot
callback.  This in affect sets the slots for the Isense and Vsense and
enabling this these modes are now based on whether these features were
powered on or not.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 65 ++++++++++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 1d3c381aeefe..5c28af370bd4 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -250,12 +250,26 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		return ret;
 
+	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG5,
+					    TAS2562_TDM_CFG5_VSNS_SLOT_MASK,
+					    tas2562->v_sense_slot);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG6,
+					    TAS2562_TDM_CFG6_ISNS_SLOT_MASK,
+					    tas2562->i_sense_slot);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
 static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
 {
 	int ret;
+	int val;
+	int sense_en;
 
 	switch (bitwidth) {
 	case SNDRV_PCM_FORMAT_S16_LE:
@@ -263,21 +277,18 @@ static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
 					      TAS2562_TDM_CFG2,
 					      TAS2562_TDM_CFG2_RXWLEN_MASK,
 					      TAS2562_TDM_CFG2_RXWLEN_16B);
-		tas2562->v_sense_slot = tas2562->i_sense_slot + 2;
 		break;
 	case SNDRV_PCM_FORMAT_S24_LE:
 		snd_soc_component_update_bits(tas2562->component,
 					      TAS2562_TDM_CFG2,
 					      TAS2562_TDM_CFG2_RXWLEN_MASK,
 					      TAS2562_TDM_CFG2_RXWLEN_24B);
-		tas2562->v_sense_slot = tas2562->i_sense_slot + 4;
 		break;
 	case SNDRV_PCM_FORMAT_S32_LE:
 		snd_soc_component_update_bits(tas2562->component,
 					      TAS2562_TDM_CFG2,
 					      TAS2562_TDM_CFG2_RXWLEN_MASK,
 					      TAS2562_TDM_CFG2_RXWLEN_32B);
-		tas2562->v_sense_slot = tas2562->i_sense_slot + 4;
 		break;
 
 	default:
@@ -285,17 +296,27 @@ static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
 		return -EINVAL;
 	}
 
-	ret = snd_soc_component_update_bits(tas2562->component,
-		TAS2562_TDM_CFG5,
-		TAS2562_TDM_CFG5_VSNS_EN | TAS2562_TDM_CFG5_VSNS_SLOT_MASK,
-		TAS2562_TDM_CFG5_VSNS_EN | tas2562->v_sense_slot);
+	val = snd_soc_component_read(tas2562->component, TAS2562_PWR_CTRL);
+	if (val < 0)
+		return val;
+
+	if (val & (1 << TAS2562_VSENSE_POWER_EN))
+		sense_en = 0;
+	else
+		sense_en = TAS2562_TDM_CFG5_VSNS_EN;
+
+	ret = snd_soc_component_update_bits(tas2562->component, TAS2562_TDM_CFG5,
+		TAS2562_TDM_CFG5_VSNS_EN, sense_en);
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_component_update_bits(tas2562->component,
-		TAS2562_TDM_CFG6,
-		TAS2562_TDM_CFG6_ISNS_EN | TAS2562_TDM_CFG6_ISNS_SLOT_MASK,
-		TAS2562_TDM_CFG6_ISNS_EN | tas2562->i_sense_slot);
+	if (val & (1 << TAS2562_ISENSE_POWER_EN))
+		sense_en = 0;
+	else
+		sense_en = TAS2562_TDM_CFG6_ISNS_EN;
+
+	ret = snd_soc_component_update_bits(tas2562->component, TAS2562_TDM_CFG6,
+		TAS2562_TDM_CFG6_ISNS_EN, sense_en);
 	if (ret < 0)
 		return ret;
 
@@ -669,9 +690,25 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 
 	ret = fwnode_property_read_u32(dev->fwnode, "ti,imon-slot-no",
 			&tas2562->i_sense_slot);
-	if (ret)
-		dev_err(dev, "Looking up %s property failed %d\n",
-			"ti,imon-slot-no", ret);
+	if (ret) {
+		dev_err(dev, "Property %s is missing setting default slot\n",
+			"ti,imon-slot-no");
+		tas2562->i_sense_slot = 0;
+	}
+
+
+	ret = fwnode_property_read_u32(dev->fwnode, "ti,vmon-slot-no",
+			&tas2562->v_sense_slot);
+	if (ret) {
+		dev_info(dev, "Property %s is missing setting default slot\n",
+			"ti,vmon-slot-no");
+		tas2562->v_sense_slot = 2;
+	}
+
+	if (tas2562->v_sense_slot < tas2562->i_sense_slot) {
+		dev_err(dev, "Vsense slot must be greater than Isense slot\n");
+		return -EINVAL;
+	}
 
 	return ret;
 }
-- 
2.26.2

