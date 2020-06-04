Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A69E1EE010
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 10:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgFDItu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 04:49:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726802AbgFDItu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:49:50 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 100E8CF62E65406A1F6D;
        Thu,  4 Jun 2020 16:49:48 +0800 (CST)
Received: from use12-sp2.huawei.com (10.67.189.174) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Thu, 4 Jun 2020 16:49:37 +0800
From:   Xiaoming Ni <nixiaoming@huawei.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <steves.lee@maximintegrated.com>
CC:     <nixiaoming@huawei.com>, <alex.huangjianhui@huawei.com>,
        <dylix.dailei@huawei.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: max98390: fix build warning detected by -Wformat
Date:   Thu, 4 Jun 2020 16:49:34 +0800
Message-ID: <1591260574-12717-1-git-send-email-nixiaoming@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.174]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build warning:
	sound/soc/codecs/max98390.c:781:3: warning: format '%ld' expects
	argument of type 'long int', but argument 4 has type 'size_t {aka
	const unsigned int}' [-Wformat=]

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
---
 sound/soc/codecs/max98390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index b9ce44d..884ee55 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -778,7 +778,7 @@ static int max98390_dsm_init(struct snd_soc_component *component)
 	}
 
 	dev_dbg(component->dev,
-		"max98390: param fw size %ld\n",
+		"max98390: param fw size %zu\n",
 		fw->size);
 	dsm_param = (char *)fw->data;
 	dsm_param += MAX98390_DSM_PAYLOAD_OFFSET;
-- 
1.8.5.6

