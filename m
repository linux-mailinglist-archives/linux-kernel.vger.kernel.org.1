Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918C3213200
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jul 2020 05:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgGCDEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 23:04:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbgGCDEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:04:40 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 22DB6E5DE6A194980ED4;
        Fri,  3 Jul 2020 11:04:37 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Fri, 3 Jul 2020 11:04:27 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next] ASoC: ti: j721e-evm: Fix missing unlock on error in j721e_audio_hw_params()
Date:   Fri, 3 Jul 2020 03:09:10 +0000
Message-ID: <20200703030910.75047-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function j721e_audio_hw_params()
in the error handling case.

Fixes: 6748d0559059 ("ASoC: ti: Add custom machine driver for j721e EVM (CPB and IVI)")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 sound/soc/ti/j721e-evm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/ti/j721e-evm.c b/sound/soc/ti/j721e-evm.c
index 3a2a8b1f3aa3..174306cf53ad 100644
--- a/sound/soc/ti/j721e-evm.c
+++ b/sound/soc/ti/j721e-evm.c
@@ -330,7 +330,7 @@ static int j721e_audio_hw_params(struct snd_pcm_substream *substream,
 		ret = snd_soc_dai_set_tdm_slot(codec_dai, 0x3, 0x3, 2,
 					       slot_width);
 		if (ret && ret != -ENOTSUPP)
-			return ret;
+			goto out;
 	}
 
 	ret = j721e_configure_refclk(priv, domain_id, params_rate(params));



