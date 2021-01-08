Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34ED12EEEC2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbhAHIqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:46:06 -0500
Received: from smtp21.cstnet.cn ([159.226.251.21]:56256 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbhAHIqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:46:05 -0500
Received: from localhost.localdomain (unknown [124.16.141.241])
        by APP-01 (Coremail) with SMTP id qwCowAAXHxOKG_hfCUaaAQ--.6846S2;
        Fri, 08 Jan 2021 16:45:00 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     lars@metafoo.de, nuno.sa@analog.com, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: adau17x1: Remove redundant null check before clk_disable_unprepare
Date:   Fri,  8 Jan 2021 08:44:56 +0000
Message-Id: <20210108084456.6603-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowAAXHxOKG_hfCUaaAQ--.6846S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CFy8Aw45GF47uw15urg_yoW3GFb_Ja
        18Wr4vgF1DXwnIvryUGrWUZF4vqF1xZFWjkF10yF42qry8Gr43uFyqkw15Cas7A3WkCa45
        AF4UXrnxAr4xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb4AYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6xkF7I0En7xvr7AKxVWUJV
        W8JwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij
        64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
        AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
        rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
        v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8kWrJ
        UUUUU==
X-Originating-IP: [124.16.141.241]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCggPA1z4jSDJHAAAsS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because clk_disable_unprepare() already checked NULL clock parameter,
so the additional check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 sound/soc/codecs/adau17x1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/adau17x1.c b/sound/soc/codecs/adau17x1.c
index 30e072c80ac1..546ee8178038 100644
--- a/sound/soc/codecs/adau17x1.c
+++ b/sound/soc/codecs/adau17x1.c
@@ -1095,8 +1095,7 @@ void adau17x1_remove(struct device *dev)
 {
 	struct adau *adau = dev_get_drvdata(dev);
 
-	if (adau->mclk)
-		clk_disable_unprepare(adau->mclk);
+	clk_disable_unprepare(adau->mclk);
 }
 EXPORT_SYMBOL_GPL(adau17x1_remove);
 
-- 
2.17.1

