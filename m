Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432C02AB0DB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 06:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgKIFek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 00:34:40 -0500
Received: from relay4.mymailcheap.com ([137.74.80.154]:46387 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgKIFek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 00:34:40 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 4460D3F162;
        Mon,  9 Nov 2020 06:34:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 755962A34E;
        Mon,  9 Nov 2020 00:34:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1604900075;
        bh=SwvQnJtqUgOiKdb4MC207JwiS1YKn0JykmKbXGcSsCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qXiHMHWe8z8lBfXIgkpyoKw4/thsd2g3Iuqz7QeGUz4Rik1+k/teJQP5ea1wrNHg6
         lTK2ax7gB63cBHZy6GEg+O32uzvCsbYxD0GRAqd/b6OfnwXZJgeULxun3Z6JbEtUPH
         BPFYsnIZ50u9tFU9kPCrkEDYMaBTiGcjR7rKMdmY=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qmJiP_2da-GT; Mon,  9 Nov 2020 00:34:34 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon,  9 Nov 2020 00:34:34 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 80CD641E32;
        Mon,  9 Nov 2020 05:34:33 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="xNsQjkv6";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id CDDDE41E32;
        Mon,  9 Nov 2020 05:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1604900065; bh=SwvQnJtqUgOiKdb4MC207JwiS1YKn0JykmKbXGcSsCE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xNsQjkv6u2WGKbu7wGyhNi77itJ4KVRL59E/R693qWX29uQMzGoPFsui69w4GgoJn
         CtuUpMMSBvPaIWY4JANUYaJ3+lGo/NRUTklnwHxPyACX5Obj2Ui/YC8oNlxTzPDIo/
         SZxvItj+UKR2i43UCffRsY+l/DXguyFaEvYFY08I=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 1/2] clk: sunxi-ng: a64: disable dividers in PLL-CPUX
Date:   Mon,  9 Nov 2020 13:33:57 +0800
Message-Id: <20201109053358.54220-2-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109053358.54220-1-icenowy@aosc.io>
References: <20201109053358.54220-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 80CD641E32
X-Spamd-Result: default: False [4.90 / 20.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.164:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the user manual, PLL-CPUX have two dividers, in which P is
only allowed when the desired rate is less than 240MHz. As the CCU
framework have no such feature yet and the clock rate that allows P is
much lower than where we normally operate, disallow the usage of P
factor now.

M is not restricted in the user manual, however according to the BSP PLL
setup table (see [1]), it's not used at all. To follow what the BSP
does, disable this factor too.

Disabling the dividers will make it possible to remove the need to
switch to osc24M when doing frequency scaling on PLL-CPUX.

In order to prevent boot-time usage of dividers (current known mainline
U-Boot implementation use m = 2), tweaking of the factors are done when
probing CCU driver.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 79 ++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 5f66bf879772..6108d150a0e3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -23,13 +24,14 @@
 
 #include "ccu-sun50i-a64.h"
 
+#define SUN50I_A64_PLL_CPUX_REG		0x000
 static struct ccu_nkmp pll_cpux_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(28),
 	.n		= _SUNXI_CCU_MULT(8, 5),
 	.k		= _SUNXI_CCU_MULT(4, 2),
-	.m		= _SUNXI_CCU_DIV(0, 2),
-	.p		= _SUNXI_CCU_DIV_MAX(16, 2, 4),
+	.m		= _SUNXI_CCU_DIV_MAX(16, 2, 1),
+	.p		= _SUNXI_CCU_DIV_MAX(0, 2, 1),
 	.common		= {
 		.reg		= 0x000,
 		.hw.init	= CLK_HW_INIT("pll-cpux",
@@ -215,6 +217,7 @@ static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
 				   BIT(28),	/* lock */
 				   CLK_SET_RATE_UNGATE);
 
+#define SUN50I_A64_CPUX_AXI_REG		0x050
 static const char * const cpux_parents[] = { "osc32k", "osc24M",
 					     "pll-cpux", "pll-cpux" };
 static SUNXI_CCU_MUX(cpux_clk, "cpux", cpux_parents,
@@ -954,6 +957,78 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 
 	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
 
+	/* Disable any possible dividers on PLL-CPUX */
+	val = readl(reg + SUN50I_A64_PLL_CPUX_REG);
+	if (val & (GENMASK(17, 16) | GENMASK(1, 0))) {
+		unsigned int n, k, m, p;
+
+		n = ((val & GENMASK(12, 8)) >> 8) + 1;
+		k = ((val & GENMASK(5, 4)) >> 4) + 1;
+		m = (val & GENMASK(1, 0)) + 1;
+		p = 1 << ((val & GENMASK(17, 16)) >> 16);
+
+		/*
+		 * Known mainline U-Boot revisions never uses
+		 * divider p, and it will only use m when k = 3 or 4.
+		 * Specially judge for these cases, to satisfy
+		 * what will most possibly happen.
+		 * For m = 2 and k = 3, fractional change will be
+		 * applied to n, to mostly keep the clock rate.
+		 * For m = 2 and k = 4, just change to m = 1 and k = 2.
+		 * For other cases, just try to divide it from N.
+		 */
+		if (p >= 2) {
+			n /= p;
+			p = 1;
+		}
+
+		if (m == 2) {
+			if (k == 3) {
+				k = 2;
+				n = n * 3 / 4;
+				m = 1;
+			}
+			if (k == 4) {
+				k = 2;
+				m = 1;
+			}
+		}
+
+		if (m >= 2) {
+			n /= m;
+			m = 1;
+		}
+
+		/* The user manual constrains n*k >= 10 */
+		if (n * k < 10) {
+			n = 10;
+			k = 1;
+		}
+
+		/* Switch CPUX clock to osc24M temporarily */
+		val = readl(reg + SUN50I_A64_CPUX_AXI_REG);
+		val &= ~GENMASK(17, 16);
+		val |= (1 << 16);
+		writel(val, reg + SUN50I_A64_CPUX_AXI_REG);
+		udelay(1);
+
+		/* Setup PLL-CPUX with new factors */
+		val = ((n - 1) << 8) | ((k - 1) << 4);
+		writel(val, reg + SUN50I_A64_PLL_CPUX_REG);
+		val |= BIT(31);
+		writel(val, reg + SUN50I_A64_PLL_CPUX_REG);
+		do {
+			/* Wait the PLL to lock */
+			val = readl(reg + SUN50I_A64_PLL_CPUX_REG);
+		} while (!(val & BIT(28)));
+
+		/* Switch CPUX clock back to PLL-CPUX */
+		val = readl(reg + SUN50I_A64_CPUX_AXI_REG);
+		val &= ~GENMASK(17, 16);
+		val |= (2 << 16);
+		writel(val, reg + SUN50I_A64_CPUX_AXI_REG);
+	}
+
 	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a64_ccu_desc);
 	if (ret)
 		return ret;
-- 
2.28.0
