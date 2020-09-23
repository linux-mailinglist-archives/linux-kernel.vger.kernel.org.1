Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783112758A1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 15:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgIWN02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 09:26:28 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42300 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgIWN0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 09:26:25 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQHHe079425;
        Wed, 23 Sep 2020 08:26:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600867577;
        bh=6SSvm9G2P56pxI7wpDWCpaQ8Vvxx3pHTwKWjp8JbjVc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=y55UDMmkESUghVpJ4vZoD8XHFu4ZJN9FLY2rvwgzniKoHUelgrAtV4EVwuhbbUjpi
         OSQasSXFxEkq1nHH5lDMFoyTCTc+ts+uUZl/vkf6HEZk72anGt/IzuJzqg0qglW8GM
         PA/JDIKVwY3ZAj02AV/Om+v+NUCHL866g3Hr4hpE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NDQHqE045501
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 08:26:17 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 08:26:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 08:26:16 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQGsR049836;
        Wed, 23 Sep 2020 08:26:16 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 3/6] ASoC: tas2770: Set regcache when shutting down and waking device
Date:   Wed, 23 Sep 2020 08:25:57 -0500
Message-ID: <20200923132600.10652-3-dmurphy@ti.com>
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

Set the regcache to cache data and mark cache as dirty when the device
is shutdown when suspend is called. When the device is woken up then
sync the cache and set to not caching the data.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 9f7363927c50..c42e653cd653 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -82,14 +82,20 @@ static int tas2770_codec_suspend(struct snd_soc_component *component)
 	struct tas2770_priv *tas2770 = snd_soc_component_get_drvdata(component);
 	int ret = 0;
 
+	regcache_cache_only(tas2770->regmap, true);
+	regcache_mark_dirty(tas2770->regmap);
+
 	if (tas2770->sdz_gpio) {
 		gpiod_set_value_cansleep(tas2770->sdz_gpio, 0);
 	} else {
 		ret = snd_soc_component_update_bits(component, TAS2770_PWR_CTRL,
 						    TAS2770_PWR_CTRL_MASK,
 						    TAS2770_PWR_CTRL_SHUTDOWN);
-		if (ret < 0)
+		if (ret < 0) {
+			regcache_cache_only(tas2770->regmap, false);
+			regcache_sync(tas2770->regmap);
 			return ret;
+		}
 
 		ret = 0;
 	}
@@ -110,11 +116,11 @@ static int tas2770_codec_resume(struct snd_soc_component *component)
 						    TAS2770_PWR_CTRL_ACTIVE);
 		if (ret < 0)
 			return ret;
-
-		ret = 0;
 	}
 
-	return ret;
+	regcache_cache_only(tas2770->regmap, false);
+
+	return regcache_sync(tas2770->regmap);
 }
 #else
 #define tas2770_codec_suspend NULL
-- 
2.28.0

