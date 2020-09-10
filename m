Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B994264F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 21:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgIJTbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 15:31:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727792AbgIJT3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:29:33 -0400
Received: from localhost.localdomain (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E329221E3;
        Thu, 10 Sep 2020 19:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599766173;
        bh=EfUI1dyzt3SWILGjbm4xkkgdUT1vq2/kiW2omjKTGf0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OSCBpD756N1pMGFV1zwLMRNM19gRS8a2dhOg90mvNF7mb+Ar1IgS2igUxh3Bo2Weq
         ESCmBWUVBP2inW2aO8MjkGBUVRmj/A+FiXF6LGNzv9ryvdxBQJZw5U0AbFk1DOJwNp
         S4UkmbMXjHDszVqNzkujQJ/hVuLqH1mvXIH0NG4Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 3/4] crypto: stm32-hash - Simplify with dev_err_probe()
Date:   Thu, 10 Sep 2020 21:29:18 +0200
Message-Id: <20200910192919.12503-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200910192919.12503-1-krzk@kernel.org>
References: <20200910192919.12503-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. None
---
 drivers/crypto/stm32/stm32-hash.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index e84330f247d9..e3e25278a970 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -1464,14 +1464,9 @@ static int stm32_hash_probe(struct platform_device *pdev)
 	}
 
 	hdev->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(hdev->clk)) {
-		if (PTR_ERR(hdev->clk) != -EPROBE_DEFER) {
-			dev_err(dev, "failed to get clock for hash (%lu)\n",
-				PTR_ERR(hdev->clk));
-		}
-
-		return PTR_ERR(hdev->clk);
-	}
+	if (IS_ERR(hdev->clk))
+		return dev_err_probe(dev, PTR_ERR(hdev->clk),
+				     "failed to get clock for hash\n");
 
 	ret = clk_prepare_enable(hdev->clk);
 	if (ret) {
-- 
2.17.1

