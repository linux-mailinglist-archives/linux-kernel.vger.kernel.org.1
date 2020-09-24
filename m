Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB01276556
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 02:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgIXAom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 20:44:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgIXAom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 20:44:42 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6F142145D;
        Thu, 24 Sep 2020 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600908282;
        bh=P/1iP0KEMhsJEBrZInw8qZDV8sgAY0xrFzWjGIvxAr0=;
        h=From:To:Cc:Subject:Date:From;
        b=ICy4UCTNRxzJpP3wZhQf83xcbhC8pF3VfYU86xRmkE2He/pRnWhp3qlICALcHnAZ2
         wEFnQ4QnaG1x4xL3Aqo0mLivGyn16mZi9RWL8GDmmur5Xn5RStK21Hf+H2q2JNSHX+
         XpOBHCDb/TgFNYJNyn7orZe4VhQ381sY3wxYk3ys=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] clk: rockchip: Initialize hw to error to avoid undefined behavior
Date:   Wed, 23 Sep 2020 17:44:41 -0700
Message-Id: <20200924004441.1476015-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can get down to this return value from ERR_CAST() without
initializing hw. Set it to -ENOMEM so that we always return something
sane.

Fixes the following smatch warning:

drivers/clk/rockchip/clk-half-divider.c:228 rockchip_clk_register_halfdiv() error: uninitialized symbol 'hw'.
drivers/clk/rockchip/clk-half-divider.c:228 rockchip_clk_register_halfdiv() warn: passing zero to 'ERR_CAST'

Cc: Elaine Zhang <zhangqing@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Fixes: 956060a52795 ("clk: rockchip: add support for half divider")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/rockchip/clk-half-divider.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-half-divider.c b/drivers/clk/rockchip/clk-half-divider.c
index e97fd3dfbae7..ccd5c270c213 100644
--- a/drivers/clk/rockchip/clk-half-divider.c
+++ b/drivers/clk/rockchip/clk-half-divider.c
@@ -166,7 +166,7 @@ struct clk *rockchip_clk_register_halfdiv(const char *name,
 					  unsigned long flags,
 					  spinlock_t *lock)
 {
-	struct clk_hw *hw;
+	struct clk_hw *hw = ERR_PTR(-ENOMEM);
 	struct clk_mux *mux = NULL;
 	struct clk_gate *gate = NULL;
 	struct clk_divider *div = NULL;

base-commit: ca52a47af60f791b08a540a8e14d8f5751ee63e9
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/

