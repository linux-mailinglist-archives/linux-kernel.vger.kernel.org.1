Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB432748EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIVTQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgIVTQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:16:42 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34713206FC;
        Tue, 22 Sep 2020 19:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600802202;
        bh=xFAegshdal4oOFaZe0xOh2NNgkqPJPvZzLl0b11jFcw=;
        h=From:To:Cc:Subject:Date:From;
        b=sPqHsK5xTBVlrFS5V8D8Wi7xnOOszj7cfZKZAUpMFKFHJYJO+CoJxpfvQJ2l44+W4
         HktAjslwLIrurrpF1cgwjH6Ut/AVl+/sN3o0E/WjGTL3d8OCtxPV7OGXZfrrm6zTWc
         BWYJPnWpg2oYkKk9Lb/DRhYboZ0my/m5MGUmhEpw=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Joseph Lo <josephl@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH] clk: tegra: Drop !provider check in tegra210_clk_emc_set_rate()
Date:   Tue, 22 Sep 2020 12:16:41 -0700
Message-Id: <20200922191641.2305144-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The provider variable is already dereferenced earlier in this function.
Drop the check for NULL as it is impossible.

Found with smatch

drivers/clk/tegra/clk-tegra210-emc.c:131 tegra210_clk_emc_set_rate() warn: variable dereferenced before check 'provider' (see line 124)

Cc: Joseph Lo <josephl@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>
Fixes: 0ac65fc946d3 ("clk: tegra: Implement Tegra210 EMC clock")
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/tegra/clk-tegra210-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra210-emc.c b/drivers/clk/tegra/clk-tegra210-emc.c
index 352a2c3fc374..971c919b2994 100644
--- a/drivers/clk/tegra/clk-tegra210-emc.c
+++ b/drivers/clk/tegra/clk-tegra210-emc.c
@@ -126,7 +126,7 @@ static int tegra210_clk_emc_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned int i;
 	int err;
 
-	if (!provider || !provider->configs || provider->num_configs == 0)
+	if (!provider->configs || provider->num_configs == 0)
 		return -EINVAL;
 
 	for (i = 0; i < provider->num_configs; i++) {

base-commit: 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/

