Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5F26AD03
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgIOTIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:08:14 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49732 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgIOTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:06:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6HwF013519;
        Tue, 15 Sep 2020 14:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600196777;
        bh=DkyZu5LoKU5RAM9n+bYIZ61osvE1080309ep6aCvTeQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dJDHqhDLlbu/voylnBEqiHCcamsxrLf7XEuptb+xoVF1Dy5AtnD6Zdb+GfFaiKH14
         0mQ8Swajq7q18FBSuLLnOa7qwHAJPg/3/+xrEPYEoHHisv5tqt5I0parp7Hs2OuFUF
         boZeL5akkfU/5gvYj5CbHftCbDOExC0ehAQB9neo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FJ6HI8060486
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 14:06:17 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 14:06:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 14:06:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6HpF008040;
        Tue, 15 Sep 2020 14:06:17 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <camel.guo@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/6] ASoC: tlv320adcx140: Fix BCLK inversion for DSP modes
Date:   Tue, 15 Sep 2020 14:06:02 -0500
Message-ID: <20200915190606.1744-2-dmurphy@ti.com>
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

Fix the BCLK inversion for DSP modes
This is how it is defined by ASoC:
 * BCLK:
 * - "normal" polarity means signal is available at rising edge of BCLK
 * - "inverted" polarity means signal is available at falling edge of BCLK

The adcx140 defines the BCLK edge based on coding type.
The PCM (DSP_A/B) should drive on rising and sample on falling edge, so
from ASoC pov, it is IB_NF. But from the codec pov if it is configured in
DSP mode, then the BCLK should not be inverted, defaults to the coding
standard.

For i2s, it is NB_NF from ASoC pov (drive on falling, sample on rising).
From the codec's pov BCLK should not invert either, as this is the default
for the coding.

So, inversion must take the format into account:
IB_NF + DSP_A/B == the codec bclk inversion should be disabled
NB_NF + DSP_A/B == the codec bclk inversion should be enabled
NB_NF + I2S == the codec bclk inversion should be disabled

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 44 +++++++++++++++++---------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 3909c1cf52be..73d18e8002e4 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -673,7 +673,7 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 	u8 iface_reg1 = 0;
 	u8 iface_reg2 = 0;
 	int offset = 0;
-	int width = adcx140->slot_width;
+	bool inverted_bclk = false;
 
 	/* set master/slave audio interface */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
@@ -689,24 +689,6 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		return -EINVAL;
 	}
 
-	/* signal polarity */
-	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
-	case SND_SOC_DAIFMT_NB_IF:
-		iface_reg1 |= ADCX140_FSYNCINV_BIT;
-		break;
-	case SND_SOC_DAIFMT_IB_IF:
-		iface_reg1 |= ADCX140_BCLKINV_BIT | ADCX140_FSYNCINV_BIT;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		iface_reg1 |= ADCX140_BCLKINV_BIT;
-		break;
-	case SND_SOC_DAIFMT_NB_NF:
-		break;
-	default:
-		dev_err(component->dev, "Invalid DAI clock signal polarity\n");
-		return -EINVAL;
-	}
-
 	/* interface format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
@@ -716,16 +698,36 @@ static int adcx140_set_dai_fmt(struct snd_soc_dai *codec_dai,
 		iface_reg1 |= ADCX140_LEFT_JUST_BIT;
 		break;
 	case SND_SOC_DAIFMT_DSP_A:
-		offset += (adcx140->tdm_delay * width + 1);
+		offset = 1;
+		inverted_bclk = true;
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
-		offset += adcx140->tdm_delay * width;
+		inverted_bclk = true;
 		break;
 	default:
 		dev_err(component->dev, "Invalid DAI interface format\n");
 		return -EINVAL;
 	}
 
+	/* signal polarity */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
+		inverted_bclk = !inverted_bclk;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		iface_reg1 |= ADCX140_FSYNCINV_BIT;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	default:
+		dev_err(component->dev, "Invalid DAI clock signal polarity\n");
+		return -EINVAL;
+	}
+
+	if (inverted_bclk)
+		iface_reg1 |= ADCX140_BCLKINV_BIT;
+
 	adcx140->dai_fmt = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
 
 	adcx140_pwr_ctrl(adcx140, false);
-- 
2.28.0

