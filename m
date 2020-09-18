Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D4A2701F9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIRQS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:18:58 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47648 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIRQS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:18:57 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08IGIiZ3039579;
        Fri, 18 Sep 2020 11:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600445924;
        bh=CoXhZYsCP8vlZjkExtcfpn4Zh4jMPI7Jl8YtUqogz7E=;
        h=From:To:CC:Subject:Date;
        b=Q+SJAmhCY5JwhhSSU2942DsvrHGOXq7b24Ul2kC4wBy5npbePCEnOA61l6lneRkFR
         kD9n6nuRMfULrt8vTAFj/L7smcogmxFG2dprJtVqAYJ5STlZvZOumIAn/JFDN+l9cy
         oZGyb5P4D+uqS/vqx3MxxG9MhRPEYToFK82hVfWk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08IGIipr053207
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 11:18:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 18
 Sep 2020 11:18:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 18 Sep 2020 11:18:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08IGIhY1110655;
        Fri, 18 Sep 2020 11:18:43 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 1/2] ASoC: tas2770: Fix calling reset in probe
Date:   Fri, 18 Sep 2020 11:18:41 -0500
Message-ID: <20200918161842.4451-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tas2770_reset is called during i2c probe. The reset calls the
snd_soc_component_write which depends on the tas2770->component being
available. The component pointer is not set until codec_probe so move
the reset to the codec_probe after the pointer is set.

Fixes: 1a476abc723e6 ("tas2770: add tas2770 smart PA kernel driver")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c09851834395..03d7ad1885b8 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -575,6 +575,8 @@ static int tas2770_codec_probe(struct snd_soc_component *component)
 
 	tas2770->component = component;
 
+	tas2770_reset(tas2770);
+
 	return 0;
 }
 
@@ -771,8 +773,6 @@ static int tas2770_i2c_probe(struct i2c_client *client,
 	tas2770->channel_size = 0;
 	tas2770->slot_width = 0;
 
-	tas2770_reset(tas2770);
-
 	result = tas2770_register_codec(tas2770);
 	if (result)
 		dev_err(tas2770->dev, "Register codec failed.\n");
-- 
2.28.0

