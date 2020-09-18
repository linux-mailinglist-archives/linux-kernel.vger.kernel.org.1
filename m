Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3062704A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgIRTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:06:43 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41920 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgIRTGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:06:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6SQW084878;
        Fri, 18 Sep 2020 14:06:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600455988;
        bh=g4j02rh2c3KYgw9HISkgKOgsc2HItFd1z0XOZrS0lCM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=K22qfhh0dV6KthpVYtwk7eNbOZRZjtW7OZ0umS71Y4s50AFbsnDxyaU8Btk9mxbKe
         Pv6JgKo+lMWU6MYuc0UdgRyIlsPFZYetzqroWr/59xs9uCkzpVhOdN1TxYdKDAEYqx
         Tp5hrKLYJv+H4RzAA8Myj9s7y56ieJQTnQotezHw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6Sik101568;
        Fri, 18 Sep 2020 14:06:28 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 14:06:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 14:06:28 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6SI7025072;
        Fri, 18 Sep 2020 14:06:28 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 9/9] ASoC: tas2770: Refactor sample rate function
Date:   Fri, 18 Sep 2020 14:05:48 -0500
Message-ID: <20200918190548.12598-9-dmurphy@ti.com>
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

Refactor the tas2770_set_samplerate to simplify the code and access the
I2C bus only once per rate request. The ramp rate and sample rate bits
are contained in the same register so a single call to the
snd_soc_update_bits function is all that is needed

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 75 ++++++++++----------------------------
 1 file changed, 19 insertions(+), 56 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index b17cf0a7f785..386aaa11fa08 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -252,80 +252,43 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 
 static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 {
-	int ret;
 	struct snd_soc_component *component = tas2770->component;
+	int ramp_rate_val;
+	int ret;
 
 	switch (samplerate) {
 	case 48000:
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_SMP_MASK,
-						    TAS2770_TDM_CFG_REG0_SMP_48KHZ);
-		if (ret < 0)
-			return ret;
-
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_31_MASK,
-						    TAS2770_TDM_CFG_REG0_31_44_1_48KHZ);
+		ramp_rate_val = TAS2770_TDM_CFG_REG0_SMP_48KHZ |
+				TAS2770_TDM_CFG_REG0_31_44_1_48KHZ;
 		break;
 	case 44100:
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_SMP_MASK,
-						    TAS2770_TDM_CFG_REG0_SMP_44_1KHZ);
-		if (ret < 0)
-			return ret;
-
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_31_MASK,
-						    TAS2770_TDM_CFG_REG0_31_44_1_48KHZ);
+		ramp_rate_val = TAS2770_TDM_CFG_REG0_SMP_44_1KHZ |
+				TAS2770_TDM_CFG_REG0_31_44_1_48KHZ;
 		break;
 	case 96000:
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_SMP_MASK,
-						    TAS2770_TDM_CFG_REG0_SMP_48KHZ);
-		if (ret < 0)
-			return ret;
-
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_31_MASK,
-						    TAS2770_TDM_CFG_REG0_31_88_2_96KHZ);
+		ramp_rate_val = TAS2770_TDM_CFG_REG0_SMP_48KHZ |
+				TAS2770_TDM_CFG_REG0_31_88_2_96KHZ;
 		break;
 	case 88200:
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_SMP_MASK,
-						    TAS2770_TDM_CFG_REG0_SMP_44_1KHZ);
-		if (ret < 0)
-			return ret;
-
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_31_MASK,
-						    TAS2770_TDM_CFG_REG0_31_88_2_96KHZ);
+		ramp_rate_val = TAS2770_TDM_CFG_REG0_SMP_44_1KHZ |
+				TAS2770_TDM_CFG_REG0_31_88_2_96KHZ;
 		break;
 	case 19200:
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_SMP_MASK,
-						    TAS2770_TDM_CFG_REG0_SMP_48KHZ);
-		if (ret < 0)
-			return ret;
-
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_31_MASK,
-						    TAS2770_TDM_CFG_REG0_31_176_4_192KHZ);
+		ramp_rate_val = TAS2770_TDM_CFG_REG0_SMP_48KHZ |
+				TAS2770_TDM_CFG_REG0_31_176_4_192KHZ;
 		break;
 	case 17640:
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_SMP_MASK,
-						    TAS2770_TDM_CFG_REG0_SMP_44_1KHZ);
-		if (ret < 0)
-			return ret;
-
-		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
-						    TAS2770_TDM_CFG_REG0_31_MASK,
-						    TAS2770_TDM_CFG_REG0_31_176_4_192KHZ);
+		ramp_rate_val = TAS2770_TDM_CFG_REG0_SMP_44_1KHZ |
+				TAS2770_TDM_CFG_REG0_31_176_4_192KHZ;
 		break;
 	default:
-		ret = -EINVAL;
+		return -EINVAL;
 	}
 
+	ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG0,
+					    TAS2770_TDM_CFG_REG0_SMP_MASK |
+					    TAS2770_TDM_CFG_REG0_31_MASK,
+					    ramp_rate_val);
 	if (ret < 0)
 		return ret;
 
-- 
2.28.0

