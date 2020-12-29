Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90992E7182
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgL2Ow0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgL2OwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:52:25 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02FBC061793;
        Tue, 29 Dec 2020 06:51:45 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id w17so12314343ilj.8;
        Tue, 29 Dec 2020 06:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Di5rQ0EgmYZ6otbdnLmDdmCVOtsDNDHwqdq0jBhtt5Y=;
        b=o5rn4yv9vTwvjfE1ZNzLwT1IXOfe1sduh5UaowGcH8mirKn2XqNgRkkP4DmT2uJwrS
         VCHPKJ0sZxT7MRuQWB99yEixHPrqjMBTErUg7pvem0pD3me6y1Fhatjz0S05kqTw0lMi
         diK0EQ372L0ZRNKGCdpjUnH6/1lztmFWCt8URxhDT83aYplGbLtyG5a0UQvc7m0f8sW2
         omNi6v0EG6Swq8cIEMeI2xp3+8MQ8rTeFNEmjhYWkbKiKH3/XhFaeuEOf57AOL1SmFPD
         ot1I5eXshdPlZhyA8WlUwMoz9r4cH/2sWnYZMcxA4ZiCwZNj/QxwhkPltkmlQ0U1TSVo
         vrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Di5rQ0EgmYZ6otbdnLmDdmCVOtsDNDHwqdq0jBhtt5Y=;
        b=arkY9nQBX2yIPEvKaSxMlhxj/RCwfh1wLpqYG2b/F0KTc/m8QQyShbCnhNqqtiVrJG
         bisW7W1/fHJgTGoAPruvHqGsyVJQv+GdWIYRuPAh1zafz+OyBoApcf+dl3FUpsY7/Kej
         Auii/XXqwplwEYbjhhNTIz8VtABLXM+euK28T6NNTf5tuU5IHuCgPYnfUnhgiyIcXy9F
         KSSd+/xIEGvjqh6YxmybTvVqUrnqz9JBSQh3vyL0qEzTA0yKMUecxExL/SURJ8AGBOOE
         X8aEm37VsWqwhG2WivQ+Bu0Z20vsI13PjCgx83QWtvEfQsqFGETmw4H3GYv1TVWxjQ/H
         jeLg==
X-Gm-Message-State: AOAM533ErztDmqIpIAI20J4gQIrUzGGutw6LGiwuxs5QjjT3hAJT72Sq
        2PJiPKv3QhH65aDqyb8JATHobNtJJjopSjoj
X-Google-Smtp-Source: ABdhPJxLukzB5nmQQwbCZJBdBWJDJkEJU29Dp3jIPDyX8J7VpN9C8KkIIJtqDm+SzeXKvH/mdkeHnQ==
X-Received: by 2002:a92:cc03:: with SMTP id s3mr49642332ilp.146.1609253504803;
        Tue, 29 Dec 2020 06:51:44 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id o195sm29397219ila.38.2020.12.29.06.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 06:51:44 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: imx: Cleanup references to imx_register_uart_clocks
Date:   Tue, 29 Dec 2020 08:51:29 -0600
Message-Id: <20201229145130.2680442-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201229145130.2680442-1-aford173@gmail.com>
References: <20201229145130.2680442-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the clk driver scanning the device tree the for stdout, it
doesn't require a list of clocks to be passed to it.  Remove the
code that generates these clock lists.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
This was build tested for arm, and tested on i.MX8M Nano.
---
 drivers/clk/imx/clk-imx25.c   | 12 +-----------
 drivers/clk/imx/clk-imx27.c   | 13 +------------
 drivers/clk/imx/clk-imx31.c   | 10 ----------
 drivers/clk/imx/clk-imx35.c   | 10 +---------
 drivers/clk/imx/clk-imx5.c    | 30 +++---------------------------
 drivers/clk/imx/clk-imx6q.c   | 16 +---------------
 drivers/clk/imx/clk-imx6sl.c  | 16 +---------------
 drivers/clk/imx/clk-imx6sll.c | 24 +-----------------------
 drivers/clk/imx/clk-imx6sx.c  | 16 +---------------
 drivers/clk/imx/clk-imx7d.c   | 22 +---------------------
 drivers/clk/imx/clk-imx7ulp.c | 31 ++-----------------------------
 drivers/clk/imx/clk-imx8mm.c  | 18 ++----------------
 drivers/clk/imx/clk-imx8mn.c  | 18 ++----------------
 drivers/clk/imx/clk-imx8mp.c  | 17 +----------------
 drivers/clk/imx/clk-imx8mq.c  | 18 ++----------------
 drivers/clk/imx/clk.c         |  2 +-
 drivers/clk/imx/clk.h         |  4 ++--
 17 files changed, 23 insertions(+), 254 deletions(-)

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index a66cabfbf94f..cc013b343e62 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -73,16 +73,6 @@ enum mx25_clks {
 
 static struct clk *clk[clk_max];
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[uart_ipg_per],
-	&clk[uart1_ipg],
-	&clk[uart2_ipg],
-	&clk[uart3_ipg],
-	&clk[uart4_ipg],
-	&clk[uart5_ipg],
-	NULL
-};
-
 static int __init __mx25_clocks_init(void __iomem *ccm_base)
 {
 	BUG_ON(!ccm_base);
@@ -228,7 +218,7 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
 	 */
 	clk_set_parent(clk[cko_sel], clk[ipg]);
 
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 5585ded8b8c6..5d177125728d 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -49,17 +49,6 @@ static const char *ssi_sel_clks[] = { "spll_gate", "mpll", };
 static struct clk *clk[IMX27_CLK_MAX];
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[IMX27_CLK_PER1_GATE],
-	&clk[IMX27_CLK_UART1_IPG_GATE],
-	&clk[IMX27_CLK_UART2_IPG_GATE],
-	&clk[IMX27_CLK_UART3_IPG_GATE],
-	&clk[IMX27_CLK_UART4_IPG_GATE],
-	&clk[IMX27_CLK_UART5_IPG_GATE],
-	&clk[IMX27_CLK_UART6_IPG_GATE],
-	NULL
-};
-
 static void __init _mx27_clocks_init(unsigned long fref)
 {
 	BUG_ON(!ccm);
@@ -176,7 +165,7 @@ static void __init _mx27_clocks_init(unsigned long fref)
 
 	clk_prepare_enable(clk[IMX27_CLK_EMI_AHB_GATE]);
 
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 
 	imx_print_silicon_rev("i.MX27", mx27_revision());
 }
diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index 7b13fb57d842..c44e18c6f63f 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -51,16 +51,6 @@ enum mx31_clks {
 static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[ipg],
-	&clk[uart1_gate],
-	&clk[uart2_gate],
-	&clk[uart3_gate],
-	&clk[uart4_gate],
-	&clk[uart5_gate],
-	NULL
-};
-
 static void __init _mx31_clocks_init(void __iomem *base, unsigned long fref)
 {
 	clk[dummy] = imx_clk_fixed("dummy", 0);
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index c1df03665c09..7dcbaea3fea3 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -82,14 +82,6 @@ enum mx35_clks {
 
 static struct clk *clk[clk_max];
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[ipg],
-	&clk[uart1_gate],
-	&clk[uart2_gate],
-	&clk[uart3_gate],
-	NULL
-};
-
 static void __init _mx35_clocks_init(void)
 {
 	void __iomem *base;
@@ -243,7 +235,7 @@ static void __init _mx35_clocks_init(void)
 	 */
 	clk_prepare_enable(clk[scc_gate]);
 
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 }
diff --git a/drivers/clk/imx/clk-imx5.c b/drivers/clk/imx/clk-imx5.c
index 01e079b81026..b82044911603 100644
--- a/drivers/clk/imx/clk-imx5.c
+++ b/drivers/clk/imx/clk-imx5.c
@@ -128,30 +128,6 @@ static const char *ieee1588_sels[] = { "pll3_sw", "pll4_sw", "dummy" /* usbphy2_
 static struct clk *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks_mx51[] __initconst = {
-	&clk[IMX5_CLK_UART1_IPG_GATE],
-	&clk[IMX5_CLK_UART1_PER_GATE],
-	&clk[IMX5_CLK_UART2_IPG_GATE],
-	&clk[IMX5_CLK_UART2_PER_GATE],
-	&clk[IMX5_CLK_UART3_IPG_GATE],
-	&clk[IMX5_CLK_UART3_PER_GATE],
-	NULL
-};
-
-static struct clk ** const uart_clks_mx50_mx53[] __initconst = {
-	&clk[IMX5_CLK_UART1_IPG_GATE],
-	&clk[IMX5_CLK_UART1_PER_GATE],
-	&clk[IMX5_CLK_UART2_IPG_GATE],
-	&clk[IMX5_CLK_UART2_PER_GATE],
-	&clk[IMX5_CLK_UART3_IPG_GATE],
-	&clk[IMX5_CLK_UART3_PER_GATE],
-	&clk[IMX5_CLK_UART4_IPG_GATE],
-	&clk[IMX5_CLK_UART4_PER_GATE],
-	&clk[IMX5_CLK_UART5_IPG_GATE],
-	&clk[IMX5_CLK_UART5_PER_GATE],
-	NULL
-};
-
 static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 {
 	clk[IMX5_CLK_DUMMY]		= imx_clk_fixed("dummy", 0);
@@ -382,7 +358,7 @@ static void __init mx50_clocks_init(struct device_node *np)
 	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
 	clk_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
 
-	imx_register_uart_clocks(uart_clks_mx50_mx53);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx50_ccm, "fsl,imx50-ccm", mx50_clocks_init);
 
@@ -488,7 +464,7 @@ static void __init mx51_clocks_init(struct device_node *np)
 	val |= 1 << 23;
 	writel(val, MXC_CCM_CLPCR);
 
-	imx_register_uart_clocks(uart_clks_mx51);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx51_ccm, "fsl,imx51-ccm", mx51_clocks_init);
 
@@ -633,6 +609,6 @@ static void __init mx53_clocks_init(struct device_node *np)
 	r = clk_round_rate(clk[IMX5_CLK_USBOH3_PER_GATE], 54000000);
 	clk_set_rate(clk[IMX5_CLK_USBOH3_PER_GATE], r);
 
-	imx_register_uart_clocks(uart_clks_mx50_mx53);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx53_ccm, "fsl,imx53-ccm", mx53_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index b2ff187cedab..1fa9317af133 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -140,13 +140,6 @@ static inline int clk_on_imx6dl(void)
 	return of_machine_is_compatible("fsl,imx6dl");
 }
 
-static const int uart_clk_ids[] __initconst = {
-	IMX6QDL_CLK_UART_IPG,
-	IMX6QDL_CLK_UART_SERIAL,
-};
-
-static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
-
 static int ldb_di_sel_by_clock_id(int clock_id)
 {
 	switch (clock_id) {
@@ -440,7 +433,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	struct device_node *np;
 	void __iomem *anatop_base, *base;
 	int ret;
-	int i;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX6QDL_CLK_END), GFP_KERNEL);
@@ -982,12 +974,6 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 			       hws[IMX6QDL_CLK_PLL3_USB_OTG]->clk);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_clks[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 2f9361946a0e..6a48befc1ca5 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -178,19 +178,11 @@ void imx6sl_set_wait_clk(bool enter)
 		imx6sl_enable_pll_arm(false);
 }
 
-static const int uart_clk_ids[] __initconst = {
-	IMX6SL_CLK_UART,
-	IMX6SL_CLK_UART_SERIAL,
-};
-
-static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
-
 static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
 	int ret;
-	int i;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX6SL_CLK_END), GFP_KERNEL);
@@ -447,12 +439,6 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(hws[IMX6SL_CLK_LCDIF_AXI_SEL]->clk,
 		       hws[IMX6SL_CLK_PLL2_PFD2]->clk);
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_clks[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sll.c b/drivers/clk/imx/clk-imx6sll.c
index 8e8288bda4d0..51137121afc5 100644
--- a/drivers/clk/imx/clk-imx6sll.c
+++ b/drivers/clk/imx/clk-imx6sll.c
@@ -76,26 +76,10 @@ static u32 share_count_ssi1;
 static u32 share_count_ssi2;
 static u32 share_count_ssi3;
 
-static const int uart_clk_ids[] __initconst = {
-	IMX6SLL_CLK_UART1_IPG,
-	IMX6SLL_CLK_UART1_SERIAL,
-	IMX6SLL_CLK_UART2_IPG,
-	IMX6SLL_CLK_UART2_SERIAL,
-	IMX6SLL_CLK_UART3_IPG,
-	IMX6SLL_CLK_UART3_SERIAL,
-	IMX6SLL_CLK_UART4_IPG,
-	IMX6SLL_CLK_UART4_SERIAL,
-	IMX6SLL_CLK_UART5_IPG,
-	IMX6SLL_CLK_UART5_SERIAL,
-};
-
-static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
-
 static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX6SLL_CLK_END), GFP_KERNEL);
@@ -356,13 +340,7 @@ static void __init imx6sll_clocks_init(struct device_node *ccm_node)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_clks[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 
 	/* Lower the AHB clock rate before changing the clock source. */
 	clk_set_rate(hws[IMX6SLL_CLK_AHB]->clk, 99000000);
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index 20dcce526d07..b2b849d575f1 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -117,18 +117,10 @@ static u32 share_count_ssi3;
 static u32 share_count_sai1;
 static u32 share_count_sai2;
 
-static const int uart_clk_ids[] __initconst = {
-	IMX6SX_CLK_UART_IPG,
-	IMX6SX_CLK_UART_SERIAL,
-};
-
-static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
-
 static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX6SX_CLK_CLK_END), GFP_KERNEL);
@@ -556,12 +548,6 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 	clk_set_parent(hws[IMX6SX_CLK_QSPI1_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
 	clk_set_parent(hws[IMX6SX_CLK_QSPI2_SEL]->clk, hws[IMX6SX_CLK_PLL2_BUS]->clk);
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_clks[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 22d24a6a05e7..9627518dd2dd 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -377,23 +377,10 @@ static const char *pll_video_bypass_sel[] = { "pll_video_main", "pll_video_main_
 static struct clk_hw **hws;
 static struct clk_hw_onecell_data *clk_hw_data;
 
-static const int uart_clk_ids[] __initconst = {
-	IMX7D_UART1_ROOT_CLK,
-	IMX7D_UART2_ROOT_CLK,
-	IMX7D_UART3_ROOT_CLK,
-	IMX7D_UART4_ROOT_CLK,
-	IMX7D_UART5_ROOT_CLK,
-	IMX7D_UART6_ROOT_CLK,
-	IMX7D_UART7_ROOT_CLK,
-};
-
-static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1] __initdata;
-
 static void __init imx7d_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
 	void __iomem *base;
-	int i;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX7D_CLK_END), GFP_KERNEL);
@@ -897,14 +884,7 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_USB1_MAIN_480M_CLK] = imx_clk_hw_fixed_factor("pll_usb1_main_clk", "osc", 20, 1);
 	hws[IMX7D_USB_MAIN_480M_CLK] = imx_clk_hw_fixed_factor("pll_usb_main_clk", "osc", 20, 1);
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_clks[i] = &hws[index]->clk;
-	}
-
-
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 
 }
 CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);
diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index 634c0b6636b0..34c5a7f9ffc6 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -43,19 +43,6 @@ static const struct clk_div_table ulp_div_table[] = {
 	{ /* sentinel */ },
 };
 
-static const int pcc2_uart_clk_ids[] __initconst = {
-	IMX7ULP_CLK_LPUART4,
-	IMX7ULP_CLK_LPUART5,
-};
-
-static const int pcc3_uart_clk_ids[] __initconst = {
-	IMX7ULP_CLK_LPUART6,
-	IMX7ULP_CLK_LPUART7,
-};
-
-static struct clk **pcc2_uart_clks[ARRAY_SIZE(pcc2_uart_clk_ids) + 1] __initdata;
-static struct clk **pcc3_uart_clks[ARRAY_SIZE(pcc3_uart_clk_ids) + 1] __initdata;
-
 static void __init imx7ulp_clk_scg1_init(struct device_node *np)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -150,7 +137,6 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw **hws;
 	void __iomem *base;
-	int i;
 
 	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC2_END),
 			   GFP_KERNEL);
@@ -190,13 +176,7 @@ static void __init imx7ulp_clk_pcc2_init(struct device_node *np)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 
-	for (i = 0; i < ARRAY_SIZE(pcc2_uart_clk_ids); i++) {
-		int index = pcc2_uart_clk_ids[i];
-
-		pcc2_uart_clks[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(pcc2_uart_clks);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc2, "fsl,imx7ulp-pcc2", imx7ulp_clk_pcc2_init);
 
@@ -205,7 +185,6 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 	struct clk_hw_onecell_data *clk_data;
 	struct clk_hw **hws;
 	void __iomem *base;
-	int i;
 
 	clk_data = kzalloc(struct_size(clk_data, hws, IMX7ULP_CLK_PCC3_END),
 			   GFP_KERNEL);
@@ -244,13 +223,7 @@ static void __init imx7ulp_clk_pcc3_init(struct device_node *np)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_data);
 
-	for (i = 0; i < ARRAY_SIZE(pcc3_uart_clk_ids); i++) {
-		int index = pcc3_uart_clk_ids[i];
-
-		pcc3_uart_clks[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(pcc3_uart_clks);
+	imx_register_uart_clocks();
 }
 CLK_OF_DECLARE(imx7ulp_clk_pcc3, "fsl,imx7ulp-pcc3", imx7ulp_clk_pcc3_init);
 
diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 7c905861af5d..9933a95b749c 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -291,20 +291,12 @@ static const char *imx8mm_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sys_pll1_
 static struct clk_hw_onecell_data *clk_hw_data;
 static struct clk_hw **hws;
 
-static const int uart_clk_ids[] = {
-	IMX8MM_CLK_UART1_ROOT,
-	IMX8MM_CLK_UART2_ROOT,
-	IMX8MM_CLK_UART3_ROOT,
-	IMX8MM_CLK_UART4_ROOT,
-};
-static struct clk **uart_hws[ARRAY_SIZE(uart_clk_ids) + 1];
-
 static int imx8mm_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *base;
-	int ret, i;
+	int ret;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX8MM_CLK_END), GFP_KERNEL);
@@ -622,13 +614,7 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_hws[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(uart_hws);
+	imx_register_uart_clocks();
 
 	return 0;
 
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index 3c21db942d5b..ac698ce18568 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -284,20 +284,12 @@ static const char * const imx8mn_clko2_sels[] = {"osc_24m", "sys_pll2_200m", "sy
 static struct clk_hw_onecell_data *clk_hw_data;
 static struct clk_hw **hws;
 
-static const int uart_clk_ids[] = {
-	IMX8MN_CLK_UART1_ROOT,
-	IMX8MN_CLK_UART2_ROOT,
-	IMX8MN_CLK_UART3_ROOT,
-	IMX8MN_CLK_UART4_ROOT,
-};
-static struct clk **uart_hws[ARRAY_SIZE(uart_clk_ids) + 1];
-
 static int imx8mn_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *base;
-	int ret, i;
+	int ret;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX8MN_CLK_END), GFP_KERNEL);
@@ -573,13 +565,7 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_hws[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(uart_hws);
+	imx_register_uart_clocks();
 
 	return 0;
 
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 2f4e1d674e1c..d2d3a9ee8bb0 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -414,20 +414,11 @@ static const char * const imx8mp_dram_core_sels[] = {"dram_pll_out", "dram_alt_r
 static struct clk_hw **hws;
 static struct clk_hw_onecell_data *clk_hw_data;
 
-static const int uart_clk_ids[] = {
-	IMX8MP_CLK_UART1_ROOT,
-	IMX8MP_CLK_UART2_ROOT,
-	IMX8MP_CLK_UART3_ROOT,
-	IMX8MP_CLK_UART4_ROOT,
-};
-static struct clk **uart_clks[ARRAY_SIZE(uart_clk_ids) + 1];
-
 static int imx8mp_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np;
 	void __iomem *anatop_base, *ccm_base;
-	int i;
 
 	np = of_find_compatible_node(NULL, NULL, "fsl,imx8mp-anatop");
 	anatop_base = of_iomap(np, 0);
@@ -737,13 +728,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_clks[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(uart_clks);
+	imx_register_uart_clocks();
 
 	return 0;
 }
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 779ea69e639c..971b8fe661b7 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -273,20 +273,12 @@ static const char * const imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sy
 static struct clk_hw_onecell_data *clk_hw_data;
 static struct clk_hw **hws;
 
-static const int uart_clk_ids[] = {
-	IMX8MQ_CLK_UART1_ROOT,
-	IMX8MQ_CLK_UART2_ROOT,
-	IMX8MQ_CLK_UART3_ROOT,
-	IMX8MQ_CLK_UART4_ROOT,
-};
-static struct clk **uart_hws[ARRAY_SIZE(uart_clk_ids) + 1];
-
 static int imx8mq_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	void __iomem *base;
-	int err, i;
+	int err;
 
 	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
 					  IMX8MQ_CLK_END), GFP_KERNEL);
@@ -607,13 +599,7 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 		goto unregister_hws;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(uart_clk_ids); i++) {
-		int index = uart_clk_ids[i];
-
-		uart_hws[i] = &hws[index]->clk;
-	}
-
-	imx_register_uart_clocks(uart_hws);
+	imx_register_uart_clocks();
 
 	return 0;
 
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index c32b46890945..61b788aec983 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -187,7 +187,7 @@ static void imx_earlycon_uart_clks_onoff(bool is_on)
 	if (is_on)
 		imx_uart_clks_on = true;
 }
-void imx_register_uart_clocks(struct clk ** const clks[])
+void imx_register_uart_clocks(void)
 {
 	imx_earlycon_uart_clks_onoff(true);
 }
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 4f04c8287286..ad80d87f050e 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -11,9 +11,9 @@ extern spinlock_t imx_ccm_lock;
 void imx_check_clocks(struct clk *clks[], unsigned int count);
 void imx_check_clk_hws(struct clk_hw *clks[], unsigned int count);
 #ifndef MODULE
-void imx_register_uart_clocks(struct clk ** const clks[]);
+void imx_register_uart_clocks(void);
 #else
-static inline void imx_register_uart_clocks(struct clk ** const clks[])
+static inline void imx_register_uart_clocks(void)
 {
 }
 #endif
-- 
2.25.1

