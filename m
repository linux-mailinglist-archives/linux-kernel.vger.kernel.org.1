Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26E22A8720
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbgKET2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732157AbgKET17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:27:59 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B73C0613D2;
        Thu,  5 Nov 2020 11:27:58 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B37A723E3F;
        Thu,  5 Nov 2020 20:27:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604604475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=plNNHT7VIZNzARI2mJ5mJsRA1g2t6wd+Fq/gWFZ7ctY=;
        b=Z7ceb00QD5eb0+75AufiFopYJNDAOIPTLJW/RQA0KKm5Rv6h7Knb0livuDnX15HPyWh/Mr
        KQIRzqQt9vBpvX2zU0LOAtrox/nuKAj5/xdgga6XHo3qbWzx6bwiPaMhxIRAH46rJKS9Ff
        DVRUKjtfvUfn6pD1X0U0OPSlBTFC5u0=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 3/3] clk: fsl-sai: use devm_clk_hw_register_composite_pdata()
Date:   Thu,  5 Nov 2020 20:27:46 +0100
Message-Id: <20201105192746.19564-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105192746.19564-1-michael@walle.cc>
References: <20201105192746.19564-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplify the driver by using that helper and drop the remove() function.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v1:
 - new patch

 drivers/clk/clk-fsl-sai.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/clk/clk-fsl-sai.c b/drivers/clk/clk-fsl-sai.c
index 1e81c8d8a6fd..6238fcea0467 100644
--- a/drivers/clk/clk-fsl-sai.c
+++ b/drivers/clk/clk-fsl-sai.c
@@ -58,30 +58,19 @@ static int fsl_sai_clk_probe(struct platform_device *pdev)
 	/* set clock direction, we are the BCLK master */
 	writel(CR2_BCD, base + I2S_CR2);
 
-	hw = clk_hw_register_composite_pdata(dev, dev->of_node->name,
-					     &pdata, 1, NULL, NULL,
-					     &sai_clk->div.hw,
-					     &clk_divider_ops,
-					     &sai_clk->gate.hw,
-					     &clk_gate_ops,
-					     CLK_SET_RATE_GATE);
+	hw = devm_clk_hw_register_composite_pdata(dev, dev->of_node->name,
+						  &pdata, 1, NULL, NULL,
+						  &sai_clk->div.hw,
+						  &clk_divider_ops,
+						  &sai_clk->gate.hw,
+						  &clk_gate_ops,
+						  CLK_SET_RATE_GATE);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
 
-	platform_set_drvdata(pdev, hw);
-
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, hw);
 }
 
-static int fsl_sai_clk_remove(struct platform_device *pdev)
-{
-	struct clk_hw *hw = platform_get_drvdata(pdev);
-
-	clk_hw_unregister_composite(hw);
-
-	return 0;
-}
-
 static const struct of_device_id of_fsl_sai_clk_ids[] = {
 	{ .compatible = "fsl,vf610-sai-clock" },
 	{ }
@@ -90,7 +79,6 @@ MODULE_DEVICE_TABLE(of, of_fsl_sai_clk_ids);
 
 static struct platform_driver fsl_sai_clk_driver = {
 	.probe = fsl_sai_clk_probe,
-	.remove = fsl_sai_clk_remove,
 	.driver		= {
 		.name	= "fsl-sai-clk",
 		.of_match_table = of_fsl_sai_clk_ids,
-- 
2.20.1

