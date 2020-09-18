Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57182701FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgIRQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:19:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54038 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIRQS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:18:58 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IGIibu127362;
        Fri, 18 Sep 2020 11:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600445924;
        bh=6QokZMF6RjHPEWc7NrsYM8QzQWnzdKBphxV83v/HNCQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HbR3v7+r6RcOZeXd3znZjkqt0+J8qmEw5P6mnitDZ4o+fRAs5o4de/SnyHET9PlUD
         CQhcauE9seb557szWWO1VaxiV6YzkUqXedL0OaS3u7IIXn9Qio22Ql/8T6w9b9Oz7V
         V3OdDCBz7CWCkSMg//SN2ypH+jSCFd3Ixz2IXgVo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IGIiHs053210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 11:18:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 11:18:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 11:18:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IGIhVp037825;
        Fri, 18 Sep 2020 11:18:43 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 2/2] ASoC: tas2770: Add missing bias level power states
Date:   Fri, 18 Sep 2020 11:18:42 -0500
Message-ID: <20200918161842.4451-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918161842.4451-1-dmurphy@ti.com>
References: <20200918161842.4451-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the BIAS_STANDBY and BIAS_PREPARE to the set_bias_level or else the
driver will return -EINVAL which is not correct as they are valid
states.

Fixes: 1a476abc723e6 ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 03d7ad1885b8..7c6f61946ab3 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -57,7 +57,12 @@ static int tas2770_set_bias_level(struct snd_soc_component *component,
 			TAS2770_PWR_CTRL_MASK,
 			TAS2770_PWR_CTRL_ACTIVE);
 		break;
-
+	case SND_SOC_BIAS_STANDBY:
+	case SND_SOC_BIAS_PREPARE:
+		snd_soc_component_update_bits(component,
+			TAS2770_PWR_CTRL,
+			TAS2770_PWR_CTRL_MASK, TAS2770_PWR_CTRL_MUTE);
+		break;
 	case SND_SOC_BIAS_OFF:
 		snd_soc_component_update_bits(component,
 			TAS2770_PWR_CTRL,
-- 
2.28.0

