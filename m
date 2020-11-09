Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFAC52AB0E6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 06:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgKIFgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 00:36:02 -0500
Received: from relay1.mymailcheap.com ([144.217.248.100]:58809 "EHLO
        relay1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729507AbgKIFgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 00:36:01 -0500
X-Greylist: delayed 146719 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 00:36:00 EST
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 39C6D3F1C5;
        Mon,  9 Nov 2020 05:35:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 81A4C2A522;
        Mon,  9 Nov 2020 06:35:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1604900158;
        bh=tQSP6jEb+nlCIph8viKb/ttszWBAoq6XZvKRuUKb5CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=doPNJ93GoJjTZl5QedjD4phG2TDg6WsG4I+sQWSUzbmLAiCGr9nKjLYSugpB4sImz
         RmZtevE3K6Be7T84cT+os7JcOQJP33qLTgfcfRhkEzZRIeLYBROrKFazyYnB0qUs8k
         gEEuHBt0bXz2Yqoi1v514B7aOguGKHkMLFnoZfmg=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CvlzvEp4KGyU; Mon,  9 Nov 2020 06:35:57 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Mon,  9 Nov 2020 06:35:57 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id D7A9A41E32;
        Mon,  9 Nov 2020 05:35:56 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="GoZvr8ns";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0B91C41E32;
        Mon,  9 Nov 2020 05:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1604900151; bh=tQSP6jEb+nlCIph8viKb/ttszWBAoq6XZvKRuUKb5CA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GoZvr8nsejd+rcofAvapYEAmgKRr/rarnr76ZgkcGjmNMEPXTjZMFQmmiWo7i6zxQ
         ghLCsJS4s65tZ84txvnkmjsIq2ZzakjTYTPf1NDFrDBTv6bcrw8yVOc9bCY02d1z2R
         DUrLP1pIP25Ld+9StZ2CfUQkHTfKRR9gXJvzK5O8=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 2/2] clk: sunxi-ng: a64: disable mux and pll notifiers for CPUX reclocking
Date:   Mon,  9 Nov 2020 13:35:37 +0800
Message-Id: <20201109053537.54450-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201109053358.54220-1-icenowy@aosc.io>
References: <20201109053358.54220-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D7A9A41E32
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

After the dividers of PLL-CPUX disabled, there's no need for PLL-CPUX to
be gated when tweaking the clock of CPUX, thus reparenting CPUX to
osc24M is also now not needed.

Remove these notifiers.

Preventing reparenting CPUX is said to be able to help solving the issue
that the timer jumps backward according to Ondrej Jirman.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 6108d150a0e3..67d570efe5bd 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -943,7 +943,6 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *reg;
 	u32 val;
-	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	reg = devm_ioremap_resource(&pdev->dev, res);
@@ -1029,18 +1028,7 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 		writel(val, reg + SUN50I_A64_CPUX_AXI_REG);
 	}
 
-	ret = sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a64_ccu_desc);
-	if (ret)
-		return ret;
-
-	/* Gate then ungate PLL CPU after any rate changes */
-	ccu_pll_notifier_register(&sun50i_a64_pll_cpu_nb);
-
-	/* Reparent CPU during PLL CPU rate changes */
-	ccu_mux_notifier_register(pll_cpux_clk.common.hw.clk,
-				  &sun50i_a64_cpu_nb);
-
-	return 0;
+	return sunxi_ccu_probe(pdev->dev.of_node, reg, &sun50i_a64_ccu_desc);
 }
 
 static const struct of_device_id sun50i_a64_ccu_ids[] = {
-- 
2.28.0
