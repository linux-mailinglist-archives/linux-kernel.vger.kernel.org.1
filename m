Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87E32BB054
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgKTQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbgKTQWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:22:02 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846C9223BE;
        Fri, 20 Nov 2020 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605889322;
        bh=BHllnI+0v2HI0B7TLmesbiXjOywu6r/Z9IUQpQJMATU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FpnPh8GcZZUlkdKeBDgvFO30GwAUkj1ECxkpT7xkjt1Wrx3RJ6Muj2127fwDqdgAI
         wgdYga1hIiJkvFDrD76cHmGzbnAq1gmzaU3FwxQxIqyfDGP8leXlsV7gIR3mxusByN
         ajewyrt+eQe28Y3MwTBN/9Ho50VtywfShZOpVsIE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/16] mfd: fsl-imx25: drop of_match_ptr from of_device_id table
Date:   Fri, 20 Nov 2020 17:21:24 +0100
Message-Id: <20201120162133.472938-7-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120162133.472938-1-krzk@kernel.org>
References: <20201120162133.472938-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  drivers/mfd/fsl-imx25-tsadc.c:190:34: warning: ‘mx25_tsadc_ids’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/fsl-imx25-tsadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/fsl-imx25-tsadc.c b/drivers/mfd/fsl-imx25-tsadc.c
index a016b39fe9b0..5f6f0a83e1c5 100644
--- a/drivers/mfd/fsl-imx25-tsadc.c
+++ b/drivers/mfd/fsl-imx25-tsadc.c
@@ -196,7 +196,7 @@ MODULE_DEVICE_TABLE(of, mx25_tsadc_ids);
 static struct platform_driver mx25_tsadc_driver = {
 	.driver = {
 		.name = "mx25-tsadc",
-		.of_match_table = of_match_ptr(mx25_tsadc_ids),
+		.of_match_table = mx25_tsadc_ids,
 	},
 	.probe = mx25_tsadc_probe,
 	.remove = mx25_tsadc_remove,
-- 
2.25.1

