Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7D91E6E68
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 00:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436897AbgE1WMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 18:12:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45708 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436887AbgE1WMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:12:24 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jeQl9-0007zv-Hz; Thu, 28 May 2020 22:12:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] clk: intel: remove redundant initialization of variable rate64
Date:   Thu, 28 May 2020 23:12:19 +0100
Message-Id: <20200528221219.535804-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rate64 is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/x86/clk-cgu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/x86/clk-cgu.c b/drivers/clk/x86/clk-cgu.c
index 802a7fa88535..56af0e04ec1e 100644
--- a/drivers/clk/x86/clk-cgu.c
+++ b/drivers/clk/x86/clk-cgu.c
@@ -538,7 +538,7 @@ lgm_clk_ddiv_round_rate(struct clk_hw *hw, unsigned long rate,
 	struct lgm_clk_ddiv *ddiv = to_lgm_clk_ddiv(hw);
 	u32 div, ddiv1, ddiv2;
 	unsigned long flags;
-	u64 rate64 = rate;
+	u64 rate64;
 
 	div = DIV_ROUND_CLOSEST_ULL((u64)*prate, rate);
 
-- 
2.25.1

