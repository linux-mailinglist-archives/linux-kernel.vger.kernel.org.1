Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20F927441F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIVOY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:24:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45496 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgIVOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:24:28 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08MEOEOP075109;
        Tue, 22 Sep 2020 09:24:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600784654;
        bh=10S2ODGxKZj5Pa33vv/awVmNVy3euFxke4kAERw9wUI=;
        h=From:To:CC:Subject:Date;
        b=WZYsY/t4z5VBqUiFfShd/9RDdZEUz6VdDkCb/cPaZUyCniqq6n7wYonwVt1UUN11T
         8xpbKAWNmOXlLf9cjYBGpPruAtNoanPT7rAzOFg1/B4nSwNqq0eAiAL4/o+k7GLtUm
         rR0TaTF0io2iqCIMLXZZMq6Sgn+KT0lllFQqFzlI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08MEOEjo068194;
        Tue, 22 Sep 2020 09:24:14 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 22
 Sep 2020 09:24:14 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 22 Sep 2020 09:24:14 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08MEODBE054756;
        Tue, 22 Sep 2020 09:24:13 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
        <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] ASoC: tas2562: Remove duplicate code for I/V sense
Date:   Tue, 22 Sep 2020 09:24:11 -0500
Message-ID: <20200922142411.10364-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate code for programming the I/V sense the call to update
the register was duplicated in commit 09ed395b05feb ("ASoC: tas2562:
Add voltage sense slot configuration").

Fixes: 09ed395b05feb ("ASoC: tas2562: Add voltage sense slot configuration")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index da820e8d59a1..f1ff204e3ad0 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -253,18 +253,6 @@ static int tas2562_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG5,
-					    TAS2562_TDM_CFG5_VSNS_SLOT_MASK,
-					    tas2562->v_sense_slot);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_component_update_bits(component, TAS2562_TDM_CFG6,
-					    TAS2562_TDM_CFG6_ISNS_SLOT_MASK,
-					    tas2562->i_sense_slot);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
-- 
2.28.0

