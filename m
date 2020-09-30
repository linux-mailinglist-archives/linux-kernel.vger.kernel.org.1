Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61D427DE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgI3CxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:53:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55080 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729446AbgI3CxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:53:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 528F488803FECC4F942A;
        Wed, 30 Sep 2020 10:53:00 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 10:52:53 +0800
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
To:     <daniel@zonque.org>, <haojian.zhuang@gmail.com>,
        <robert.jarzmik@free.fr>, <perex@perex.cz>, <tiwai@suse.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <jingxiangfeng@huawei.com>
Subject: [PATCH] ASoC: pxa: remove unnecessary assignment to variable ret
Date:   Wed, 30 Sep 2020 10:52:40 +0800
Message-ID: <20200930025240.93345-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ret is always zero here in this code path. So remove this assignment.

Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 sound/arm/pxa2xx-ac97.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index ea8e233150c8..813e608dca82 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -210,7 +210,6 @@ static int pxa2xx_ac97_pcm_new(struct snd_card *card)
 		goto out;
 
 	pxa2xx_ac97_pcm = pcm;
-	ret = 0;
 
  out:
 	return ret;
-- 
2.17.1

