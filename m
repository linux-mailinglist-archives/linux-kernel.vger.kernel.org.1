Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F21B38B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 09:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDVHSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 03:18:49 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2869 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725786AbgDVHSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:18:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4190FA8636B45EF33076;
        Wed, 22 Apr 2020 15:18:47 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:18:36 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ASoC: soc-core: return true,false in snd_soc_volsw_is_stereo()
Date:   Wed, 22 Apr 2020 15:18:05 +0800
Message-ID: <20200422071805.48793-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

include/sound/soc.h:1271:9-10: WARNING: return of 0/1 in function
'snd_soc_volsw_is_stereo' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/sound/soc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 946f88a6c63d..d1e9a526363e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1268,13 +1268,13 @@ static inline void *snd_soc_card_get_drvdata(struct snd_soc_card *card)
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
 {
 	if (mc->reg == mc->rreg && mc->shift == mc->rshift)
-		return 0;
+		return false;
 	/*
 	 * mc->reg == mc->rreg && mc->shift != mc->rshift, or
 	 * mc->reg != mc->rreg means that the control is
 	 * stereo (bits in one register or in two registers)
 	 */
-	return 1;
+	return true;
 }
 
 static inline unsigned int snd_soc_enum_val_to_item(struct soc_enum *e,
-- 
2.21.1

