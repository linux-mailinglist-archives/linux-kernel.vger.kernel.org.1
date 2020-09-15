Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26FF269BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 04:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIOCKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 22:10:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:32964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726034AbgIOCKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 22:10:12 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 23924D37C27CE1C836AE;
        Tue, 15 Sep 2020 10:10:06 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 15 Sep 2020
 10:09:55 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <dinguyen@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] clk: socfpga: agilex: Remove unused variable 'cntr_mux'
Date:   Tue, 15 Sep 2020 10:09:50 +0800
Message-ID: <20200915020950.4688-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clk/socfpga/clk-agilex.c:24:37: warning: ‘cntr_mux’ defined but not used [-Wunused-const-variable=]
 static const struct clk_parent_data cntr_mux[] = {
                                     ^~~~~~~~

There is no caller in tree, so can remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/socfpga/clk-agilex.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 8fb12cbe0208..bb3e80928ebe 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -21,19 +21,6 @@ static const struct clk_parent_data pll_mux[] = {
 	  .name = "f2s-free-clk", },
 };
 
-static const struct clk_parent_data cntr_mux[] = {
-	{ .fw_name = "main_pll",
-	  .name = "main_pll", },
-	{ .fw_name = "periph_pll",
-	  .name = "periph_pll", },
-	{ .fw_name = "osc1",
-	  .name = "osc1", },
-	{ .fw_name = "cb-intosc-hs-div2-clk",
-	  .name = "cb-intosc-hs-div2-clk", },
-	{ .fw_name = "f2s-free-clk",
-	  .name = "f2s-free-clk", },
-};
-
 static const struct clk_parent_data boot_mux[] = {
 	{ .fw_name = "osc1",
 	  .name = "osc1", },
-- 
2.17.1


