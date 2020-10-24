Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EA2297CB8
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 16:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761861AbgJXOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761854AbgJXOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 10:04:22 -0400
X-Greylist: delayed 1920 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 24 Oct 2020 07:04:22 PDT
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519BCC0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 07:04:22 -0700 (PDT)
Received: from dslb-188-096-149-111.188.096.pools.vodafone-ip.de ([188.96.149.111] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1kWJej-0005I1-Bn; Sat, 24 Oct 2020 15:32:25 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] mailbox: stm32-ipcc: remove duplicate error message
Date:   Sat, 24 Oct 2020 15:31:54 +0200
Message-Id: <20201024133154.22767-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201024133154.22767-1-martin@kaiser.cx>
References: <20201024133154.22767-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq_byname already prints an error message if the requested irq
was not found. Don't print another message in the driver.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
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

