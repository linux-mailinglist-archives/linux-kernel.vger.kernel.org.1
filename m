Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2472D2704A2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIRTGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:06:32 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47674 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgIRTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:06:29 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6GLq041578;
        Fri, 18 Sep 2020 14:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600455976;
        bh=qFKZy2vTy5+EBqc16Od6YKxZ2fWq2j+AF/Xzpt+QPO4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BCwXPc4bWtFdQFkNvabKwguzdJRrKHOHKAyeSflx2sxEM5uGG14hAX1OD05zySK8p
         acOjvVf/2sl05c10juOiTxwUkEye9eXBQej1lEFPqJxVt6uAOvnm0BGp5JeSUnl/k0
         vz8ZVu64KO989h1Z9RQyvjaSD/BRzTROZd+MtYUs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6Gf5101391;
        Fri, 18 Sep 2020 14:06:16 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 14:06:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 14:06:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6GTD013631;
        Fri, 18 Sep 2020 14:06:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 7/9] ASoC: tas2770: Fix error handling with update_bits
Date:   Fri, 18 Sep 2020 14:05:46 -0500
Message-ID: <20200918190548.12598-7-dmurphy@ti.com>
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

snd_soc_update_bits returns a 1 when the bit was successfully updated,
returns a 0 is no update was needed and a negative if the call failed.
The code is currently failing the case of a successful update by just
checking for a non-zero number. Modify these checks and return the error
code only if there is a negative.

Fixes: 1a476abc723e6 ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 52 ++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 16979583cd68..3226c6d4493e 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -139,23 +139,18 @@ static int tas2770_dac_event(struct snd_soc_dapm_widget *w,
 			TAS2770_PWR_CTRL,
 			TAS2770_PWR_CTRL_MASK,
 			TAS2770_PWR_CTRL_MUTE);
-		if (ret)
-			goto end;
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_PWR_CTRL,
 			TAS2770_PWR_CTRL_MASK,
 			TAS2770_PWR_CTRL_SHUTDOWN);
-		if (ret)
-			goto end;
 		break;
 	default:
 		dev_err(tas2770->dev, "Not supported evevt\n");
 		return -EINVAL;
 	}
 
-end:
 	if (ret < 0)
 		return ret;
 
@@ -247,6 +242,9 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 		return -EINVAL;
 	}
 
+	if (ret < 0)
+		return ret;
+
 	tas2770->channel_size = bitwidth;
 
 	ret = snd_soc_component_update_bits(component,
@@ -255,16 +253,15 @@ static int tas2770_set_bitwidth(struct tas2770_priv *tas2770, int bitwidth)
 		TAS2770_TDM_CFG_REG5_50_MASK,
 		TAS2770_TDM_CFG_REG5_VSNS_ENABLE |
 		tas2770->v_sense_slot);
-	if (ret)
-		goto end;
+	if (ret < 0)
+		return ret;
+
 	ret = snd_soc_component_update_bits(component,
 		TAS2770_TDM_CFG_REG6,
 		TAS2770_TDM_CFG_REG6_ISNS_MASK |
 		TAS2770_TDM_CFG_REG6_50_MASK,
 		TAS2770_TDM_CFG_REG6_ISNS_ENABLE |
 		tas2770->i_sense_slot);
-
-end:
 	if (ret < 0)
 		return ret;
 
@@ -282,36 +279,35 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_SMP_MASK,
 			TAS2770_TDM_CFG_REG0_SMP_48KHZ);
-		if (ret)
-			goto end;
+		if (ret < 0)
+			return ret;
+
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_31_MASK,
 			TAS2770_TDM_CFG_REG0_31_44_1_48KHZ);
-		if (ret)
-			goto end;
 		break;
 	case 44100:
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_SMP_MASK,
 			TAS2770_TDM_CFG_REG0_SMP_44_1KHZ);
-		if (ret)
-			goto end;
+		if (ret < 0)
+			return ret;
+
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_31_MASK,
 			TAS2770_TDM_CFG_REG0_31_44_1_48KHZ);
-		if (ret)
-			goto end;
 		break;
 	case 96000:
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_SMP_MASK,
 			TAS2770_TDM_CFG_REG0_SMP_48KHZ);
-		if (ret)
-			goto end;
+		if (ret < 0)
+			return ret;
+
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_31_MASK,
@@ -322,8 +318,9 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_SMP_MASK,
 			TAS2770_TDM_CFG_REG0_SMP_44_1KHZ);
-		if (ret)
-			goto end;
+		if (ret < 0)
+			return ret;
+
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_31_MASK,
@@ -334,22 +331,22 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_SMP_MASK,
 			TAS2770_TDM_CFG_REG0_SMP_48KHZ);
-		if (ret)
-			goto end;
+		if (ret < 0)
+			return ret;
+
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_31_MASK,
 			TAS2770_TDM_CFG_REG0_31_176_4_192KHZ);
-		if (ret)
-			goto end;
 		break;
 	case 17640:
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_SMP_MASK,
 			TAS2770_TDM_CFG_REG0_SMP_44_1KHZ);
-		if (ret)
-			goto end;
+		if (ret < 0)
+			return ret;
+
 		ret = snd_soc_component_update_bits(component,
 			TAS2770_TDM_CFG_REG0,
 			TAS2770_TDM_CFG_REG0_31_MASK,
@@ -359,7 +356,6 @@ static int tas2770_set_samplerate(struct tas2770_priv *tas2770, int samplerate)
 		ret = -EINVAL;
 	}
 
-end:
 	if (ret < 0)
 		return ret;
 
-- 
2.28.0

