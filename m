Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA861E32C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 00:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392180AbgEZWlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 18:41:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34517 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389755AbgEZWlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:41:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jdiG4-0002VP-Iz; Tue, 26 May 2020 22:41:16 +0000
From:   Colin King <colin.king@canonical.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: versatile: remove redundant assignment to pointer clk
Date:   Tue, 26 May 2020 23:41:16 +0100
Message-Id: <20200526224116.63549-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer clk is being initialized with a value that is never read
and is being updated with a new value later on. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/versatile/clk-versatile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/versatile/clk-versatile.c b/drivers/clk/versatile/clk-versatile.c
index fd54d5c0251c..8ed7a179f651 100644
--- a/drivers/clk/versatile/clk-versatile.c
+++ b/drivers/clk/versatile/clk-versatile.c
@@ -56,7 +56,7 @@ static const struct clk_icst_desc versatile_auxosc_desc __initconst = {
 static void __init cm_osc_setup(struct device_node *np,
 				const struct clk_icst_desc *desc)
 {
-	struct clk *clk = ERR_PTR(-EINVAL);
+	struct clk *clk;
 	const char *clk_name = np->name;
 	const char *parent_name;
 
-- 
2.25.1

