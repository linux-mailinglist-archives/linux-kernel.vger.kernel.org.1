Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1D2C7AD2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 19:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbgK2Szz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 13:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2Szy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 13:55:54 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DC1C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Nov 2020 10:55:14 -0800 (PST)
Received: from dslb-178-004-174-066.178.004.pools.vodafone-ip.de ([178.4.174.66] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1kjRqq-0005jB-13; Sun, 29 Nov 2020 19:55:12 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Fabien Dessenne <fabien.dessenne@st.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH RESEND v2 3/3] mailbox: stm32-ipcc: cast void pointers to unsigned long
Date:   Sun, 29 Nov 2020 19:52:28 +0100
Message-Id: <20201129185228.16213-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201129185228.16213-1-martin@kaiser.cx>
References: <20201024133154.22767-1-martin@kaiser.cx>
 <20201129185228.16213-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the driver can be enabled by COMPILE_TEST, we see warnings on
64bit platforms when void pointers are cast to unsigned int (and
vice versa).

warning: cast to smaller integer type 'unsigned int' from 'void *'
           unsigned int chan = (unsigned int)link->con_priv;
...
warning: cast to 'void *' from smaller integer type 'unsigned int'
           ipcc->controller.chans[i].con_priv = (void *)i;

Update these casts to use unsigned long variables, which are the same
size as pointers on all platforms.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
---
changes in v2
- added this patch to fix COMPILE_TEST warnings

 drivers/mailbox/stm32-ipcc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mailbox/stm32-ipcc.c b/drivers/mailbox/stm32-ipcc.c
index ab8fe56af948..b84e0587937c 100644
--- a/drivers/mailbox/stm32-ipcc.c
+++ b/drivers/mailbox/stm32-ipcc.c
@@ -144,11 +144,11 @@ static irqreturn_t stm32_ipcc_tx_irq(int irq, void *data)
 
 static int stm32_ipcc_send_data(struct mbox_chan *link, void *data)
 {
-	unsigned int chan = (unsigned int)link->con_priv;
+	unsigned long chan = (unsigned long)link->con_priv;
 	struct stm32_ipcc *ipcc = container_of(link->mbox, struct stm32_ipcc,
 					       controller);
 
-	dev_dbg(ipcc->controller.dev, "%s: chan:%d\n", __func__, chan);
+	dev_dbg(ipcc->controller.dev, "%s: chan:%lu\n", __func__, chan);
 
 	/* set channel n occupied */
 	stm32_ipcc_set_bits(&ipcc->lock, ipcc->reg_proc + IPCC_XSCR,
@@ -163,7 +163,7 @@ static int stm32_ipcc_send_data(struct mbox_chan *link, void *data)
 
 static int stm32_ipcc_startup(struct mbox_chan *link)
 {
-	unsigned int chan = (unsigned int)link->con_priv;
+	unsigned long chan = (unsigned long)link->con_priv;
 	struct stm32_ipcc *ipcc = container_of(link->mbox, struct stm32_ipcc,
 					       controller);
 	int ret;
@@ -183,7 +183,7 @@ static int stm32_ipcc_startup(struct mbox_chan *link)
 
 static void stm32_ipcc_shutdown(struct mbox_chan *link)
 {
-	unsigned int chan = (unsigned int)link->con_priv;
+	unsigned long chan = (unsigned long)link->con_priv;
 	struct stm32_ipcc *ipcc = container_of(link->mbox, struct stm32_ipcc,
 					       controller);
 
@@ -206,7 +206,7 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct stm32_ipcc *ipcc;
 	struct resource *res;
-	unsigned int i;
+	unsigned long i;
 	int ret;
 	u32 ip_ver;
 	static const char * const irq_name[] = {"rx", "tx"};
@@ -265,7 +265,7 @@ static int stm32_ipcc_probe(struct platform_device *pdev)
 						irq_thread[i], IRQF_ONESHOT,
 						dev_name(dev), ipcc);
 		if (ret) {
-			dev_err(dev, "failed to request irq %d (%d)\n", i, ret);
+			dev_err(dev, "failed to request irq %lu (%d)\n", i, ret);
 			goto err_clk;
 		}
 	}
-- 
2.20.1

