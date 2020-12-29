Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C15B2E7181
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 15:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgL2OwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 09:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgL2OwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 09:52:23 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7CC0613D6;
        Tue, 29 Dec 2020 06:51:43 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id k8so12342137ilr.4;
        Tue, 29 Dec 2020 06:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jb+nE3BcvsGpUV61L75GL3+vz8aPHA/Rr7IXVY4Y9Sg=;
        b=sf1Umk4yFlzhrtePM4EaHqU2uI9dgFC1csHURywFJxLWNM6w3wjWI4FQONisuHByrm
         fFcI3xkTRtxiuIdrqZKXRql7YcUbWRXt3O5EHQLA3oPjLLszVx+UW2chEfMnIlgmyMTd
         MyWWs9D6hN0R1uTZohnHgYJ1SSy9nCGNKOLqhktgwz9h/317K1p1vi81jzbp/EQFlJ3T
         SfnSXILRQ3LO6FZJGKtw9DUnK+8tc+rsmxGynSVwE2fwvzLnMjP7qDG9XmcE3V3iFlDu
         0ruhTQ/qiTQ2UXQkEk5DiI8IYjiUCyCkObx6wD67x8HK1y6KqgTx42i/CAkBUbIQTAwE
         AJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jb+nE3BcvsGpUV61L75GL3+vz8aPHA/Rr7IXVY4Y9Sg=;
        b=IDXB6pojOnqnMhkRzeXYehYXuVzRb91CW2mS7mtj8KsClud88MiDjP683DkU4Jc8Ct
         x26YGe9X5CyzJsRaMpsd61zsTmuKgimxhbNfOEowhUDAhIlhACHgTUycdgpdjq2/eFZI
         1CL5xg2n3VSO5TO/+ujKGqXi4oI9fQKlVXG1sxxe+z0NDOY4Bhu3PMI+AXLdiWkXLuEd
         zkSHE5Hi4rW98NKHtDY/26EIdcmmw1PMhYsX3fmD+id9yqCNn9FZF3T3aIJHW/XggZIH
         8kBbd1vosLEA+hZJwt68f5r6p47kMTrYYhyiKwWybI9HBAmxeC/9zAkJRVTz+nFUfl3X
         rKkg==
X-Gm-Message-State: AOAM5316t9bQ/Nq693aKrIOwLBSf0qJEpMAah4vwJ1oW7lZIXT/EHHUw
        2Oj5QSxPMxM4t6lccx4XIT0=
X-Google-Smtp-Source: ABdhPJzFgJthD4igIhE/FqcMN7qamBnRIXe2+YhMXFNeLtl2AunejbpHDdpHNuhqZ308IxuSIX4x1Q==
X-Received: by 2002:a92:91d7:: with SMTP id e84mr47894935ill.159.1609253502363;
        Tue, 29 Dec 2020 06:51:42 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:f45d:df49:9a4c:4914])
        by smtp.gmail.com with ESMTPSA id o195sm29397219ila.38.2020.12.29.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 06:51:41 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Fugang Duan <fugang.duan@nxp.com>,
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
Subject: [PATCH 1/2] clk: imx: enable the earlycon uart clocks by parsing from dt
Date:   Tue, 29 Dec 2020 08:51:28 -0600
Message-Id: <20201229145130.2680442-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the earlycon uart clocks that are hard cord in platforms
clock driver, instead of parsing the earlycon uart port from dt
and enable these clocks from clock property in dt node.

Fixes: 9461f7b33d11c ("clk: fix CLK_SET_RATE_GATE with clock rate protection")
Signed-off-by: Fugang Duan <fugang.duan@nxp.com>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
Based on NXP's code base and adapted for 5.11-rc1.
https://source.codeaurora.org/external/imx/linux-imx/commit/drivers/clk/imx/clk.c?h=imx_5.4.47_2.2.0&id=754ae82cc55b7445545fc2f092a70e0f490e9c1b

The original signed-off was retained.
Added the fixes tag.
---
 drivers/clk/imx/clk.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 47882c51cb85..c32b46890945 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -148,7 +148,7 @@ void imx_cscmr1_fixup(u32 *val)
 
 #ifndef MODULE
 static int imx_keep_uart_clocks;
-static struct clk ** const *imx_uart_clocks;
+static bool imx_uart_clks_on;
 
 static int __init imx_keep_uart_clocks_param(char *str)
 {
@@ -161,25 +161,40 @@ __setup_param("earlycon", imx_keep_uart_earlycon,
 __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
 	      imx_keep_uart_clocks_param, 0);
 
-void imx_register_uart_clocks(struct clk ** const clks[])
+static void imx_earlycon_uart_clks_onoff(bool is_on)
 {
-	if (imx_keep_uart_clocks) {
-		int i;
+	struct clk *uart_clk;
+	int i = 0;
 
-		imx_uart_clocks = clks;
-		for (i = 0; imx_uart_clocks[i]; i++)
-			clk_prepare_enable(*imx_uart_clocks[i]);
-	}
+	if (!imx_keep_uart_clocks || (!is_on && !imx_uart_clks_on))
+		return;
+
+	/* only support dt */
+	if (!of_stdout)
+		return;
+
+	do {
+		uart_clk = of_clk_get(of_stdout, i++);
+		if (IS_ERR(uart_clk))
+			break;
+
+		if (is_on)
+			clk_prepare_enable(uart_clk);
+		else
+			clk_disable_unprepare(uart_clk);
+	} while (true);
+
+	if (is_on)
+		imx_uart_clks_on = true;
+}
+void imx_register_uart_clocks(struct clk ** const clks[])
+{
+	imx_earlycon_uart_clks_onoff(true);
 }
 
 static int __init imx_clk_disable_uart(void)
 {
-	if (imx_keep_uart_clocks && imx_uart_clocks) {
-		int i;
-
-		for (i = 0; imx_uart_clocks[i]; i++)
-			clk_disable_unprepare(*imx_uart_clocks[i]);
-	}
+	imx_earlycon_uart_clks_onoff(false);
 
 	return 0;
 }
-- 
2.25.1

