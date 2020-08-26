Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECAB2533C3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 17:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgHZPdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 11:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727049AbgHZPdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:33:18 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 641CB2078A;
        Wed, 26 Aug 2020 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598455998;
        bh=vVqjzCOh+/tzkusGVweW2Ls2+a6FFfIhNB9EcG+IeYY=;
        h=From:To:Cc:Subject:Date:From;
        b=eQDUm+v7tGSDNMaHk1t7HThMfJN82m75NJdlouLlWb6uE/Wb4lpzPfxHB1ZWiGgUn
         az28ypH6e4CLHEDpcs9IQtWiFcgL3mM6g6AxsML9p3bOgSCN7tc/7ywDhWafFtSpz6
         fJvPhXBVbDZ95gRFWQkkejUtHLsRjwgqpsCCtcUE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hadar Gat <hadar.gat@arm.com>, Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] hwrng: cctrn - Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 17:32:33 +0200
Message-Id: <20200826153233.27586-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/char/hw_random/cctrng.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/char/hw_random/cctrng.c b/drivers/char/hw_random/cctrng.c
index 619148fb2dc9..7a293f2147a0 100644
--- a/drivers/char/hw_random/cctrng.c
+++ b/drivers/char/hw_random/cctrng.c
@@ -463,11 +463,10 @@ static int cc_trng_clk_init(struct cctrng_drvdata *drvdata)
 	int rc = 0;
 
 	clk = devm_clk_get_optional(dev, NULL);
-	if (IS_ERR(clk)) {
-		if (PTR_ERR(clk) != -EPROBE_DEFER)
-			dev_err(dev, "Error getting clock: %pe\n", clk);
-		return PTR_ERR(clk);
-	}
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk),
+				     "Error getting clock\n");
+
 	drvdata->clk = clk;
 
 	rc = clk_prepare_enable(drvdata->clk);
-- 
2.17.1

