Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520C72DE07D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 10:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732684AbgLRJmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 04:42:43 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:51378 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725870AbgLRJmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:42:42 -0500
Received: from localhost.localdomain (unknown [124.16.141.242])
        by APP-05 (Coremail) with SMTP id zQCowADXx3Bcedxfzt8SAA--.43979S2;
        Fri, 18 Dec 2020 17:41:48 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        mcoquelin.stm32@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: stm32-dfsdm: Remove redundant null check before clk_disable_unprepare
Date:   Fri, 18 Dec 2020 09:41:45 +0000
Message-Id: <20201218094145.1123-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowADXx3Bcedxfzt8SAA--.43979S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8CFy8Aw1xGryrKr48Zwb_yoW3tFXEy3
        WUu39rKF4aqrnay3y8WFn8Zr90vry8Zws3ur10yrWrGFy7Z3y7ZrWavr43Jw1UAanFya47
        A3WDX34fAr1xCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2kYjsxI4VWDJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r4fMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
        IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
        z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8LjjDUUUUU==
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCgkOA1z4jO9-VwAAsh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ecause clk_disable_unprepare() already checked NULL clock parameter,
so the additional check is unnecessary, just remove it.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 42a7377704a4..bb925a11c8ae 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -117,8 +117,7 @@ static void stm32_dfsdm_clk_disable_unprepare(struct stm32_dfsdm *dfsdm)
 {
 	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
 
-	if (priv->aclk)
-		clk_disable_unprepare(priv->aclk);
+	clk_disable_unprepare(priv->aclk);
 	clk_disable_unprepare(priv->clk);
 }
 
-- 
2.17.1

