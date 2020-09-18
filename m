Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAA327006B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgIRPB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:01:58 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56722 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgIRPB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:01:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IF1gaa019692;
        Fri, 18 Sep 2020 10:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600441302;
        bh=MPE85KuowVExpmPMhgX6xawyPMtLr9jJP3e7mW/oIgs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nC2/19jxzsvFcN9wPqbQhCxlRycqX8+WEq07p/CoE0y2+/bH1VY50SAV5j9Xx+Btc
         McGdGBxpeZZY3SJ24DmzYzmBHP7GdpogoApSKxay91U0C4gGwdXyhS9saKCwJCo27c
         LIXcDshOgAAk2gjd0WGC+V4Ebu9xwI1onU2DopCY=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IF1g5p065553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 10:01:42 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 10:01:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 10:01:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IF1gG8086771;
        Fri, 18 Sep 2020 10:01:42 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] ASoC: tas2562: Add the TAS2564 compatible
Date:   Fri, 18 Sep 2020 10:01:30 -0500
Message-ID: <20200918150130.21015-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918150130.21015-1-dmurphy@ti.com>
References: <20200918150130.21015-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TAS2564 as a supported amplifier.  This amplifier is register,
bitmap and feature compatible to the TAS2562.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 99920c691d28..56d410141ee0 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -58,6 +58,7 @@ struct tas2562_data {
 enum tas256x_model {
 	TAS2562,
 	TAS2563,
+	TAS2564,
 };
 
 static int tas2562_set_bias_level(struct snd_soc_component *component,
@@ -761,6 +762,7 @@ static int tas2562_probe(struct i2c_client *client,
 static const struct i2c_device_id tas2562_id[] = {
 	{ "tas2562", TAS2562 },
 	{ "tas2563", TAS2563 },
+	{ "tas2564", TAS2564 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tas2562_id);
@@ -768,6 +770,7 @@ MODULE_DEVICE_TABLE(i2c, tas2562_id);
 static const struct of_device_id tas2562_of_match[] = {
 	{ .compatible = "ti,tas2562", },
 	{ .compatible = "ti,tas2563", },
+	{ .compatible = "ti,tas2564", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tas2562_of_match);
-- 
2.28.0

