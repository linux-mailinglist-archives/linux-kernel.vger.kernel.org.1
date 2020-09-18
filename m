Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7E2704A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 21:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIRTGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 15:06:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40578 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIRTGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 15:06:24 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6B1Z067330;
        Fri, 18 Sep 2020 14:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600455971;
        bh=8MJa9OWUfuKyK2DPvT28uonc54QcPfadLbC0Yzo+5bQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=O215L2To8zCa8R5KyzGRA93eQCtffCw8cdTpbeTC/dy0mHQD6M0jlnyMRBXVXdiS/
         NsjdmzeLVIOC2EOK28qBVW04QO8mF+Jckq9ZNBStOZnQbwTMXv4cSw7OkiPs0N3MXZ
         6BNxWcHv8zV/DKT/ElStYSpu5VH3O5LFzttSiWWs=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6BsY101189;
        Fri, 18 Sep 2020 14:06:11 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 14:06:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 14:06:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IJ6AKS083581;
        Fri, 18 Sep 2020 14:06:11 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 5/9] ASoC: tas2770: Fix unbalanced calls to pm_runtime
Date:   Fri, 18 Sep 2020 14:05:44 -0500
Message-ID: <20200918190548.12598-5-dmurphy@ti.com>
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

Fix the unbalanced call to the pm_runtime_disable when removing the
module.  pm_runtime_enable is not called nor is the pm_runtime setup in
the code.  Remove the i2c_remove function and the pm_runtime_disable.

Fixes: 1a476abc723e6 ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index bdfdad5f4f64..16979583cd68 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -16,7 +16,6 @@
 #include <linux/i2c.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/firmware.h>
 #include <linux/regmap.h>
@@ -785,13 +784,6 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 	return result;
 }
 
-static int tas2770_i2c_remove(struct i2c_client *client)
-{
-	pm_runtime_disable(&client->dev);
-	return 0;
-}
-
-
 static const struct i2c_device_id tas2770_i2c_id[] = {
 	{ "tas2770", 0},
 	{ }
@@ -812,7 +804,6 @@ static struct i2c_driver tas2770_i2c_driver = {
 		.of_match_table = of_match_ptr(tas2770_of_match),
 	},
 	.probe      = tas2770_i2c_probe,
-	.remove     = tas2770_i2c_remove,
 	.id_table   = tas2770_i2c_id,
 };
 
-- 
2.28.0

