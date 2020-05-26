Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C23F1AAEAB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416262AbgDOQrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 12:47:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416235AbgDOQqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 12:46:55 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00ADD214AF;
        Wed, 15 Apr 2020 16:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586969214;
        bh=OUvJ1KZplfv0DwyMT1EooihGccT5EsQHkf0A8xFqIVc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6Ag+9rDud44WvVooHBmLLzzIXqvQ8EK0JWt4WoQYixg0SM00+PPj2l0vMZaJ4NN/
         DVu2CDyoTa1EEs5/fqRH7aVWaJTaSoA6liKZuTEqXQO8M63xTZAiGGMOA9I1qhGMQf
         BEcd1zVvyb9/pcr6cn+IX97/jor5D+QgKKsqWZlE=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv7 3/5] clk: socfpga: add const to _ops data structures
Date:   Wed, 15 Apr 2020 11:46:40 -0500
Message-Id: <20200415164642.29382-4-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200415164642.29382-1-dinguyen@kernel.org>
References: <20200415164642.29382-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the static clk_ops data structure need a const.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
v7: no changes
v6: no changes
v5: no changes
v4: no changes
v3: no changes
v2: created
---
 drivers/clk/socfpga/clk-pll-a10.c | 2 +-
 drivers/clk/socfpga/clk-pll-s10.c | 4 ++--
 drivers/clk/socfpga/clk-pll.c     | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/socfpga/clk-pll-a10.c b/drivers/clk/socfpga/clk-pll-a10.c
index 6d9395106c0c..db54f7d806a0 100644
--- a/drivers/clk/socfpga/clk-pll-a10.c
+++ b/drivers/clk/socfpga/clk-pll-a10.c
@@ -58,7 +58,7 @@ static u8 clk_pll_get_parent(struct clk_hw *hwclk)
 		CLK_MGR_PLL_CLK_SRC_MASK;
 }
 
-static struct clk_ops clk_pll_ops = {
+static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.get_parent = clk_pll_get_parent,
 };
diff --git a/drivers/clk/socfpga/clk-pll-s10.c b/drivers/clk/socfpga/clk-pll-s10.c
index 9faa80ff3b53..5c3e1ee44f6b 100644
--- a/drivers/clk/socfpga/clk-pll-s10.c
+++ b/drivers/clk/socfpga/clk-pll-s10.c
@@ -98,13 +98,13 @@ static int clk_pll_prepare(struct clk_hw *hwclk)
 	return 0;
 }
 
-static struct clk_ops clk_pll_ops = {
+static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.get_parent = clk_pll_get_parent,
 	.prepare = clk_pll_prepare,
 };
 
-static struct clk_ops clk_boot_ops = {
+static const struct clk_ops clk_boot_ops = {
 	.recalc_rate = clk_boot_clk_recalc_rate,
 	.get_parent = clk_boot_get_parent,
 	.prepare = clk_pll_prepare,
diff --git a/drivers/clk/socfpga/clk-pll.c b/drivers/clk/socfpga/clk-pll.c
index a001641b2f42..e5fb786843f3 100644
--- a/drivers/clk/socfpga/clk-pll.c
+++ b/drivers/clk/socfpga/clk-pll.c
@@ -65,7 +65,7 @@ static u8 clk_pll_get_parent(struct clk_hw *hwclk)
 			CLK_MGR_PLL_CLK_SRC_MASK;
 }
 
-static struct clk_ops clk_pll_ops = {
+static const struct clk_ops clk_pll_ops = {
 	.recalc_rate = clk_pll_recalc_rate,
 	.get_parent = clk_pll_get_parent,
 };
-- 
2.25.1

