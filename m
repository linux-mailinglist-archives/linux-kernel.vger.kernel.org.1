Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3896F26AD18
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgIOTJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:09:37 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35728 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbgIOTHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:07:20 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6T8e060905;
        Tue, 15 Sep 2020 14:06:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600196789;
        bh=D4KwWA3PAUDgR7udHAL3tu/8wxSo8YWIeqTiceCZ3J0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IO5DMOoX3KpUlEAILLPSCVQ9CkqRfGBaw0gaW/H9C9AT1GyXdyO9709jDW8uGLYZR
         hv+7Ix/O8WpANRpaXr0yMYRw0/xrP+RtZ+nqeKPCptZmATY2KyM1Ezpww4KlsThPJt
         nwNTqYEkLhWW0qC2T/eIFdmiBd4UfVUdroy7d5ys=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08FJ6TYe060751
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 14:06:29 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 14:06:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 14:06:29 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FJ6Tiq102549;
        Tue, 15 Sep 2020 14:06:29 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <camel.guo@axis.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 4/6] ASoC: tlv320adcx140: Add the config to configure Tx ASI output
Date:   Tue, 15 Sep 2020 14:06:04 -0500
Message-ID: <20200915190606.1744-4-dmurphy@ti.com>
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

Add code to allow the ASI Tx output to be placed into High-z mode
during unused ASI cycles.  This allows for other devices that may be on
the bus to drive the ASI out. By default the 320adcx140 sends 0's for
unused cycles.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 11 +++++++++++
 sound/soc/codecs/tlv320adcx140.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 73d18e8002e4..7fa5c8682c51 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -839,6 +839,7 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	u32 gpi_input_val = 0;
 	int i;
 	int ret;
+	bool tx_high_z;
 
 	ret = device_property_read_u32(adcx140->dev, "ti,mic-bias-source",
 				      &bias_source);
@@ -930,6 +931,16 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		dev_err(adcx140->dev, "setting MIC bias failed %d\n", ret);
 
+	tx_high_z = device_property_read_bool(adcx140->dev, "ti,asi-tx-drive");
+	if (tx_high_z) {
+		ret = regmap_update_bits(adcx140->regmap, ADCX140_ASI_CFG0,
+				 ADCX140_TX_FILL, ADCX140_TX_FILL);
+		if (ret) {
+			dev_err(adcx140->dev, "Setting Tx drive failed %d\n", ret);
+			goto out;
+		}
+	}
+
 	adcx140_pwr_ctrl(adcx140, true);
 out:
 	return ret;
diff --git a/sound/soc/codecs/tlv320adcx140.h b/sound/soc/codecs/tlv320adcx140.h
index 94c6d1fd2977..107bd7927d9c 100644
--- a/sound/soc/codecs/tlv320adcx140.h
+++ b/sound/soc/codecs/tlv320adcx140.h
@@ -146,5 +146,6 @@
 #define ADCX140_GPO_CFG_MAX		4
 #define ADCX140_GPO_DRV_MAX		5
 
+#define ADCX140_TX_FILL    BIT(0)
 
 #endif /* _TLV320ADCX140_ */
-- 
2.28.0

