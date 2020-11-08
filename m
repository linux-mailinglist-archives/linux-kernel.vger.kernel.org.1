Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA02AACFB
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 19:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgKHSvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 13:51:33 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:55223 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHSv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 13:51:28 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id ACCF223E64;
        Sun,  8 Nov 2020 19:51:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1604861486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=06+nbmiG4lnDyueLVMl1bo6/nZZ0MAeHgQZQwzo4IUU=;
        b=kVo/WQVlxbm+ucAHJEoDEkNOWLbk1kl1aFBAsKSK2vQ1mW5+BbvKunFtu5Lru82o4/+UsC
        snR2Q8k/Zo7fEzKtdNXlo023WaHlHMuwFQvARqCqMTey9/1TTFAxtyMdVkbTHiQa/Q67mu
        x5vOD+W0dEZZKFBOjehwnJhmFc5To9Y=
From:   Michael Walle <michael@walle.cc>
To:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        "Y . b . Lu" <yangbo.lu@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Ashish Kumar <Ashish.Kumar@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 3/9] clk: qoriq: provide constants for the type
Date:   Sun,  8 Nov 2020 19:51:07 +0100
Message-Id: <20201108185113.31377-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201108185113.31377-1-michael@walle.cc>
References: <20201108185113.31377-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid future mistakes in the device tree for the clockgen module, add
constants for the clockgen subtype as well as a macro for the PLL
divider.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v2:
 - new patch

 drivers/clk/clk-qoriq.c                        | 13 +++++++------
 include/dt-bindings/clock/fsl,qoriq-clockgen.h | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/clock/fsl,qoriq-clockgen.h

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index 46101c6a20f2..70aa521e7e7f 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -7,6 +7,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <dt-bindings/clock/fsl,qoriq-clockgen.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clkdev.h>
@@ -1368,33 +1369,33 @@ static struct clk *clockgen_clk_get(struct of_phandle_args *clkspec, void *data)
 	idx = clkspec->args[1];
 
 	switch (type) {
-	case 0:
+	case QORIQ_CLK_SYSCLK:
 		if (idx != 0)
 			goto bad_args;
 		clk = cg->sysclk;
 		break;
-	case 1:
+	case QORIQ_CLK_CMUX:
 		if (idx >= ARRAY_SIZE(cg->cmux))
 			goto bad_args;
 		clk = cg->cmux[idx];
 		break;
-	case 2:
+	case QORIQ_CLK_HWACCEL:
 		if (idx >= ARRAY_SIZE(cg->hwaccel))
 			goto bad_args;
 		clk = cg->hwaccel[idx];
 		break;
-	case 3:
+	case QORIQ_CLK_FMAN:
 		if (idx >= ARRAY_SIZE(cg->fman))
 			goto bad_args;
 		clk = cg->fman[idx];
 		break;
-	case 4:
+	case QORIQ_CLK_PLATFORM_PLL:
 		pll = &cg->pll[PLATFORM_PLL];
 		if (idx >= ARRAY_SIZE(pll->div))
 			goto bad_args;
 		clk = pll->div[idx].clk;
 		break;
-	case 5:
+	case QORIQ_CLK_CORECLK:
 		if (idx != 0)
 			goto bad_args;
 		clk = cg->coreclk;
diff --git a/include/dt-bindings/clock/fsl,qoriq-clockgen.h b/include/dt-bindings/clock/fsl,qoriq-clockgen.h
new file mode 100644
index 000000000000..ddec7d0bdc7f
--- /dev/null
+++ b/include/dt-bindings/clock/fsl,qoriq-clockgen.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef DT_CLOCK_FSL_QORIQ_CLOCKGEN_H
+#define DT_CLOCK_FSL_QORIQ_CLOCKGEN_H
+
+#define QORIQ_CLK_SYSCLK	0
+#define QORIQ_CLK_CMUX		1
+#define QORIQ_CLK_HWACCEL	2
+#define QORIQ_CLK_FMAN		3
+#define QORIQ_CLK_PLATFORM_PLL	4
+#define QORIQ_CLK_CORECLK	5
+
+#define QORIQ_CLK_PLL_DIV(x)	((x) - 1)
+
+#endif /* DT_CLOCK_FSL_QORIQ_CLOCKGEN_H */
-- 
2.20.1

