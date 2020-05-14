Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1376C1D3029
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 14:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgENMoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 08:44:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49584 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgENMoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:44:10 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04EChLJW068221;
        Thu, 14 May 2020 07:43:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589460201;
        bh=e5oLHvSAcu1wID8AuM4YdTSx1fGtweYfUrxREiY/l9M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZzYL2yj4lW+zhLcKMjsSTdTS2fE29lTKlJ8Ggipl0k8j3MPxk5B3VZXMxQJYjqbya
         7CXtPd1IQRbCKiqb7+1bbug0Fp2QmrztoxTl2a2AL9D7ku42OwaRNIO2P67p5TPKfa
         gXpaubt1qVABlteXdF/td+vUct15nOCJzrupxfZ8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04EChLME122019
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 07:43:21 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 07:43:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 07:43:21 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04EChLrv030975;
        Thu, 14 May 2020 07:43:21 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v3 3/3] ASoC: tlv320adcx140: Configure PDM sampling edge
Date:   Thu, 14 May 2020 07:33:38 -0500
Message-ID: <20200514123338.20392-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514123338.20392-1-dmurphy@ti.com>
References: <20200514123338.20392-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the PDM sampling edges based on the values from the firmware.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 22 ++++++++++++++++++++++
 sound/soc/codecs/tlv320adcx140.h |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 97634e0ca0ba..140a5802a9a9 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -760,6 +760,10 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	int sleep_cfg_val = ADCX140_WAKE_DEV;
 	u8 bias_source;
 	u8 vref_source;
+	int pdm_count;
+	u32 pdm_edges[ADCX140_NUM_PDM_EDGES];
+	u32 pdm_edge_val = 0;
+	int i;
 	int ret;
 
 	ret = device_property_read_u8(adcx140->dev, "ti,mic-bias-source",
@@ -786,6 +790,24 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 
 	bias_source |= vref_source;
 
+	pdm_count = device_property_count_u32(adcx140->dev,
+					      "ti,pdm-edge-select");
+	if (pdm_count <= ADCX140_NUM_PDM_EDGES && pdm_count > 0) {
+		ret = device_property_read_u32_array(adcx140->dev,
+						     "ti,pdm-edge-select",
+						     pdm_edges, pdm_count);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < pdm_count; i++)
+			pdm_edge_val |= pdm_edges[i] << (ADCX140_PDM_EDGE_SHIFT - i);
+
+		ret = regmap_write(adcx140->regmap, ADCX140_PDM_CFG,
+				   pdm_edge_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = adcx140_reset(adcx140);
 	if (ret)
 		goto out;
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 6d055e55909e..432eaf25d1a7 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -128,4 +128,7 @@
 
 #define ADCX140_TX_OFFSET_MASK		GENMASK(4, 0)
 
+#define ADCX140_NUM_PDM_EDGES		4
+#define ADCX140_PDM_EDGE_SHIFT		7
+
 #endif /* _TLV320ADCX140_ */
-- 
2.26.2

