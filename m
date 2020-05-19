Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED4F1DA4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 00:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgESWmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 18:42:35 -0400
Received: from v6.sk ([167.172.42.174]:58646 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgESWma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:42:30 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 8D6EE610D5;
        Tue, 19 May 2020 22:41:58 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 02/13] clk: mmp: frac: Allow setting bits other than the numerator/denominator
Date:   Wed, 20 May 2020 00:41:40 +0200
Message-Id: <20200519224151.2074597-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519224151.2074597-1-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the I2S fractional clocks, there are more bits that need to be set
for the clock to run. Their actual meaning is unknown.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/clk/mmp/clk-frac.c | 3 +++
 drivers/clk/mmp/clk.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index ed9928f5bdc7..48f592bd633d 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -148,7 +148,10 @@ static int clk_factor_init(struct clk_hw *hw)
 		val &= ~(masks->den_mask << masks->den_shift);
 		val |= (factor->ftbl[0].den & masks->den_mask) <<
 			masks->den_shift;
+	}
 
+	if (!(val & masks->enable_mask) || i >= factor->ftbl_cnt) {
+		val |= masks->enable_mask;
 		writel(val, factor->base);
 	}
 
diff --git a/drivers/clk/mmp/clk.h b/drivers/clk/mmp/clk.h
index 20dc1e5dd756..369a09256e2f 100644
--- a/drivers/clk/mmp/clk.h
+++ b/drivers/clk/mmp/clk.h
@@ -16,6 +16,7 @@ struct mmp_clk_factor_masks {
 	unsigned int den_mask;
 	unsigned int num_shift;
 	unsigned int den_shift;
+	unsigned int enable_mask;
 };
 
 struct mmp_clk_factor_tbl {
-- 
2.26.2

