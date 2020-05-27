Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E474D1E3443
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 03:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgE0BBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 21:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727906AbgE0BA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:00:58 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97D9D20888;
        Wed, 27 May 2020 01:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590541257;
        bh=wGQJIPZAKWK2xPvtTcKd1UuwUntCA2nsRt2k35SxbjI=;
        h=From:To:Cc:Subject:Date:From;
        b=qy/fdoBlUxMwAIlmlNWCFWc5HxjEjJaLY4Qfify10DipEjc11cuWqrlTLJ+z+2wcw
         UlEvw5UXS1rPPQVPcipGR+v3Ha7OWvgyGjDDk2osc2QpTMNaBPWWvcKcYbPQy2GQJZ
         qSr/NSQ6Ka18VqtPAXQm23xcZq9s3D8MDPlfGWBw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Jolly Shah <jolly.shah@xilinx.com>
Subject: [PATCH] clk: zynqmp: Mark zynqmp_clk_get_max_divisor() static
Date:   Tue, 26 May 2020 18:00:57 -0700
Message-Id: <20200527010057.57877-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function isn't used outside this file. Mark it static to silence
sparse.

Cc: Jolly Shah <jolly.shah@xilinx.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/zynqmp/divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
index 79a294488e84..b22ca33e40c0 100644
--- a/drivers/clk/zynqmp/divider.c
+++ b/drivers/clk/zynqmp/divider.c
@@ -266,7 +266,7 @@ static const struct clk_ops zynqmp_clk_divider_ops = {
  * Return: Maximum divisor of a clock if query data is successful
  *	   U16_MAX in case of query data is not success
  */
-u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
+static u32 zynqmp_clk_get_max_divisor(u32 clk_id, u32 type)
 {
 	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
 	struct zynqmp_pm_query_data qdata = {0};

base-commit: 2ce7e495dab4647055f6cf300bc66870dc8a7cab
-- 
Sent by a computer, using git, on the internet

