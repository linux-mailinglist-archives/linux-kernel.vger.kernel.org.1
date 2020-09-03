Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E08325B874
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 03:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgICBvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 21:51:23 -0400
Received: from crapouillou.net ([89.234.176.41]:47938 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgICBvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 21:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1599097859; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aJiJklocasIc6J5kOikYu2s2q4dlO3I37o2u+17tEl4=;
        b=yiPWvnkNMeeaC0df5QWltkTSLeR7f08S3ehUikCIPMW1W5KAvjhSnEo9hzezHmugdA8dsz
        p1o7McQHHqgxfTWzjt8jgCj19QBGKXdtcBpmhVSF8A47qy3Wrm6W4Sd9wAZoRSBGSABD3s
        LWIRKVhkS49w1esP72W27JIfdpEhWvk=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     od@zcrc.me, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] clk: ingenic: Don't tag custom clocks with CLK_SET_RATE_PARENT
Date:   Thu,  3 Sep 2020 03:50:47 +0200
Message-Id: <20200903015048.3091523-4-paul@crapouillou.net>
In-Reply-To: <20200903015048.3091523-1-paul@crapouillou.net>
References: <20200903015048.3091523-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The custom clocks have custom functions to round, get or set their rate.
Therefore, we can't assume that they need the CLK_SET_RATE_PARENT flag.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/clk/ingenic/cgu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/ingenic/cgu.c b/drivers/clk/ingenic/cgu.c
index 521a40dfcb72..a1a4f1adaa3a 100644
--- a/drivers/clk/ingenic/cgu.c
+++ b/drivers/clk/ingenic/cgu.c
@@ -629,6 +629,13 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 
 	caps = clk_info->type;
 
+	if (caps & CGU_CLK_DIV) {
+		caps &= ~CGU_CLK_DIV;
+	} else if (!(caps & CGU_CLK_CUSTOM)) {
+		/* pass rate changes to the parent clock */
+		clk_init.flags |= CLK_SET_RATE_PARENT;
+	}
+
 	if (caps & (CGU_CLK_MUX | CGU_CLK_CUSTOM)) {
 		clk_init.num_parents = 0;
 
@@ -690,13 +697,6 @@ static int ingenic_register_clock(struct ingenic_cgu *cgu, unsigned idx)
 		caps &= ~(CGU_CLK_MUX | CGU_CLK_MUX_GLITCHFREE);
 	}
 
-	if (caps & CGU_CLK_DIV) {
-		caps &= ~CGU_CLK_DIV;
-	} else {
-		/* pass rate changes to the parent clock */
-		clk_init.flags |= CLK_SET_RATE_PARENT;
-	}
-
 	if (caps) {
 		pr_err("%s: unknown clock type 0x%x\n", __func__, caps);
 		goto out;
-- 
2.28.0

