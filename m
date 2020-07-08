Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9765D21858E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 13:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbgGHLHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 07:07:36 -0400
Received: from foss.arm.com ([217.140.110.172]:60944 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728466AbgGHLHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:07:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C9791045;
        Wed,  8 Jul 2020 04:07:33 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C1383F68F;
        Wed,  8 Jul 2020 04:07:32 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Dien Pham <dien.pham.ry@renesas.com>
Subject: [PATCH 2/2] clk: scmi: Fix min and max rate when registering clocks with discrete rates
Date:   Wed,  8 Jul 2020 12:07:25 +0100
Message-Id: <20200708110725.18017-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708110725.18017-1-sudeep.holla@arm.com>
References: <20200708110725.18017-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we are not initializing the scmi clock with discrete rates
correctly. We fetch the min_rate and max_rate value only for clocks with
ranges and ignore the ones with discrete rates. This will lead to wrong
initialization of rate range when clock supports discrete rate.

Fix this by using the first and the last rate in the sorted list of the
discrete clock rates while registering the clock.

Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
Reported-by: Dien Pham <dien.pham.ry@renesas.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

Hi Stephen,

If you fine, I can take this via ARM SoC along with the change in firmware
driver. But it is fine if you want to merge this independently as it should
be fine. Let me know either way.

Regards,
Sudeep

diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index c491f5de0f3f..ea65b7bf1408 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -103,6 +103,8 @@ static const struct clk_ops scmi_clk_ops = {
 static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)
 {
 	int ret;
+	unsigned long min_rate, max_rate;
+
 	struct clk_init_data init = {
 		.flags = CLK_GET_RATE_NOCACHE,
 		.num_parents = 0,
@@ -112,9 +114,23 @@ static int scmi_clk_ops_init(struct device *dev, struct scmi_clk *sclk)

 	sclk->hw.init = &init;
 	ret = devm_clk_hw_register(dev, &sclk->hw);
-	if (!ret)
-		clk_hw_set_rate_range(&sclk->hw, sclk->info->range.min_rate,
-				      sclk->info->range.max_rate);
+	if (ret)
+		return ret;
+
+	if (sclk->info->rate_discrete) {
+		int num_rates = sclk->info->list.num_rates;
+
+		if (num_rates <= 0)
+			return -EINVAL;
+
+		min_rate = sclk->info->list.rates[0]
+		max_rate = sclk->info->list.rates[num_rates - 1];
+	} else {
+		min_rate = sclk->info->range.min_rate;
+		max_rate = sclk->info->range.max_rate;
+	}
+
+	clk_hw_set_rate_range(&sclk->hw, min_rate, max_rate);
 	return ret;
 }

--
2.17.1

