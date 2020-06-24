Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F839207AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405792AbgFXRus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 13:50:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57382 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405556AbgFXRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:50:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OHo6D3029498;
        Wed, 24 Jun 2020 12:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593021006;
        bh=M1MPBLSDMN936E020JiJBRBjKYmEXCOU5/4sosJb4SA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=pZff7YfmW5idGnjmzn03bLGpLVISV35yDJhQlL0pmpCptF/UMM1G0gtkHJGb0nVFe
         QHnPism+n+RSAjYOMQcpkAf8WcihC72ISl9H9fSWLUaAp11+/VKVLXgKEwLGj09pKV
         sgnMZg0HIkHTwbCjySg55Kr1eaPrJRwKdDEneT4s=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OHo6Pr071498
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 24 Jun 2020 12:50:06 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 12:50:05 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 12:50:05 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OHo5QI120458;
        Wed, 24 Jun 2020 12:50:05 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v6 6/7] ASoC: tas2562: Add voltage sense slot configuration
Date:   Wed, 24 Jun 2020 12:49:31 -0500
Message-ID: <20200624174932.9604-7-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624174932.9604-1-dmurphy@ti.com>
References: <20200624174932.9604-1-dmurphy@ti.com>
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
index 2f1d4b697f01..b0b7cef79433 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -224,12 +224,26 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
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
@@ -237,21 +251,18 @@ static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
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
@@ -259,17 +270,27 @@ static int tas2562_set_bitwidth(struct tas2562_data *tas2562, int bitwidth)
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
 
@@ -645,9 +666,25 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 
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

