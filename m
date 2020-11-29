Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6B502C7AD1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 19:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgK2Szt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 13:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2Szs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:55:48 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627BBC0613D2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 10:55:08 -0800 (PST)
Received: from dslb-178-004-174-066.178.004.pools.vodafone-ip.de ([178.4.174.66] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1kjRqk-0005jB-6i; Sun, 29 Nov 2020 19:55:06 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH RESEND v2 2/3] mailbox: stm32-ipcc: remove duplicate error message
Date:   Sun, 29 Nov 2020 19:52:27 +0100
Message-Id: <20201129185228.16213-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201129185228.16213-1-martin@kaiser.cx>
References: <20201024133154.22767-1-martin@kaiser.cx>
 <20201129185228.16213-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq_byname already prints an error message if the requested
irq was not found. Don't print another message in the driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
---
changes in v2
- added Fabien's review tag
- reformatted the commit message such that lines are < 75 chars

 drivers/mailbox/stm32-ipcc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index ef966887aa15..ab8fe56af948 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -257,9 +257,6 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	for (i = 0; i < IPCC_IRQ_NUM; i++) {
 		ipcc->irqs[i] = platform_get_irq_byname(pdev, irq_name[i]);
 		if (ipcc->irqs[i] < 0) {
-			if (ipcc->irqs[i] != -EPROBE_DEFER)
-				dev_err(dev, "no IRQ specified %s\n",
-					irq_name[i]);
 			ret = ipcc->irqs[i];
 			goto err_clk;
 		}
-- 
2.20.1

