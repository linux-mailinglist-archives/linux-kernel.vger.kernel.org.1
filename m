Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C041F7C55
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgFLRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 13:15:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44848 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgFLRPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:15:03 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05CHEOIc035407;
        Fri, 12 Jun 2020 12:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591982064;
        bh=0CHEg/2YdJEaIawncJx10SE2riY6XRSDzxRhI2/Jvlg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=OK5Nh3Z2OTYUVBCeVNRk4E+OPFD5HYCeYi8rMkyH5xA4x6HX7+yjEFqUPLHDrsEE0
         UTnU+o3aM5yrZd4uwke2n/ngzPqioCd5QgF3kzNPjNjoptlzP1++VN/Aq4FqCxEp7E
         8DdRtJaw1072Urtb/ncJSDBfhdn2bzJnybK5BFD8=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05CHENbX014806
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 12:14:24 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 12
 Jun 2020 12:14:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 12 Jun 2020 12:14:23 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05CHENtL091610;
        Fri, 12 Jun 2020 12:14:23 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 2/2] ASoC: tas2562: Update shutdown GPIO property
Date:   Fri, 12 Jun 2020 12:14:12 -0500
Message-ID: <20200612171412.25423-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612171412.25423-1-dmurphy@ti.com>
References: <20200612171412.25423-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the shutdown GPIO property to be shutdown from shut-down.

Fixes: c173dba44c2d2 ("ASoC: tas2562: Introduce the TAS2562 amplifier")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 7fae88655a0f..6026d8b1e7d3 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -619,7 +619,7 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 	struct device *dev = tas2562->dev;
 	int ret = 0;
 
-	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down-gpio",
+	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
 						      GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2562->sdz_gpio)) {
 		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER) {
@@ -628,6 +628,21 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 		}
 	}
 
+	/*
+	 * The shut-down property is deprecated but needs to be checked for
+	 * backwards compatibility.
+	 */
+	if (tas2562->sdz_gpio == NULL) {
+		tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
+							      GPIOD_OUT_HIGH);
+		if (IS_ERR(tas2562->sdz_gpio)) {
+			if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER) {
+				tas2562->sdz_gpio = NULL;
+				return -EPROBE_DEFER;
+			}
+		}
+	}
+
 	ret = fwnode_property_read_u32(dev->fwnode, "ti,imon-slot-no",
 			&tas2562->i_sense_slot);
 	if (ret)
-- 
2.26.2

