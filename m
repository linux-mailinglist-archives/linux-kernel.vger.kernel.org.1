Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3672CF41B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 19:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbgLDScw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 13:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 13:32:51 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3C0C061A51;
        Fri,  4 Dec 2020 10:32:10 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id z10so6081585ilu.3;
        Fri, 04 Dec 2020 10:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NzKZ943JGTNloiN146GZP9I+EpZC20D+gFEel4Gitb8=;
        b=SeSqVhHl47UvFR6qCSbOqOwUPvIQm298r8//4V8E3E1wtei2+ml27FPsm6fF9oqWJi
         JKLkIZSgtRmjYJEBXq8encd8/ps9kieq3N/Fk/jOxEOLXe1BmyUjnxz4wdv9j3ZOesml
         ULm4YCbA7x9cs8vMJ0VhcsjLq+l6MqgQLP3ERg4jzYkrEgdgCOXcMzMynFWlm/yIInaT
         oNxZX4R7UId/p162m8BDccGn99S/W3FsQUDKBtGmByPLIoS6qz+YOE9fUR0QrHTYocjr
         yBQd1bZdoxNPWwjEmvejjcKyh9hNoGdkXOZwKufxeJGmLG90AhrfOUue8/w+dU4KDvhd
         OqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NzKZ943JGTNloiN146GZP9I+EpZC20D+gFEel4Gitb8=;
        b=UFN/kw6W13QEwhSFJ68v8XX8j1h/YGVHQ0Xkno7ULixHlaHTmusAyX29jwhTFMFiWZ
         BnLCi0ccNSqH/BlGHih4qpFp+5tAisBPyBCIEaG4FGaFJP9ICpHf0CUQfJ8VfDu8ve1Z
         EUw6Noj3n5m0IhHDYLuLDLLlxxn5RGGL2ztQC5RAJbCIqZaZY6or5lJDoCQMCNshcZTi
         dYwuQV/sg4tecGc0FFwgXlXRPnCKR7I+4NODi/agZ7pzqlayJMykunqYBLeRAEui/MpX
         cECQseAycRYqhZL9tpVhvhQOzlh8h+39HerYuvRSRKFLEUMai6RJ4wauz8mpDGGF2OcA
         1lKA==
X-Gm-Message-State: AOAM531sTmP2mckh7OX8tlJPghf+mTE1jaISMWEL7cqhEiStvcyxKIgQ
        /Ojvk51jRxbC59j1gRxO84FkmZuJVDo2iw==
X-Google-Smtp-Source: ABdhPJxGsBLdSmKY8+m4xFcwZUgkJ1jukKmUe+1owxKbk3IXvQtv0d+e0qtlamj75Nr3azRE9cCSCQ==
X-Received: by 2002:a05:6e02:929:: with SMTP id o9mr8055335ilt.42.1607106729669;
        Fri, 04 Dec 2020 10:32:09 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:4c53:aff:c64:cd45])
        by smtp.gmail.com with ESMTPSA id s17sm1955714ilj.25.2020.12.04.10.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 10:32:08 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.steves@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: imx: Fix reparenting of UARTs not associated with sdout
Date:   Fri,  4 Dec 2020 12:31:54 -0600
Message-Id: <20201204183154.94002-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default clock source on i.MX8M Mini and Nano boards use a 24MHz clock,
but users who need to re-parent the clock source run into issues because
all the UART clocks are enabled whether or not they're needed by sdout.

Any attempt to change the parent results in an busy error because the
clocks have been enabled already.

  clk: failed to reparent uart1 to sys_pll1_80m: -16

Instead of pre-initializing all UARTS, scan the device tree to see if UART
clock is used as stdout before initializing it.  Only enable the UART clock
if it's needed in order to delay the clock initialization until after the
re-parenting of the clocks.

Fixes: 9461f7b33d11c ("clk: fix CLK_SET_RATE_GATE with clock rate protection")
Suggested-by: Aisheng Dong <aisheng.dong@nxp.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 47882c51cb85..6dcc5fbd8f3f 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -163,12 +163,18 @@ __setup_param("earlyprintk", imx_keep_uart_earlyprintk,
 
 void imx_register_uart_clocks(struct clk ** const clks[])
 {
+	struct clk *uart_clk;
 	if (imx_keep_uart_clocks) {
 		int i;
 
 		imx_uart_clocks = clks;
-		for (i = 0; imx_uart_clocks[i]; i++)
-			clk_prepare_enable(*imx_uart_clocks[i]);
+		for (i = 0; imx_uart_clocks[i]; i++) {
+			uart_clk = of_clk_get(of_stdout, i);
+			if (IS_ERR(uart_clk))
+				continue;
+			clk_prepare_enable(uart_clk);
+			clk_put(uart_clk);
+		}
 	}
 }
 
-- 
2.25.1

