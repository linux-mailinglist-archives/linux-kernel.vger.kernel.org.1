Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E627F1FF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbgI3S5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:57:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbgI3S5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:57:44 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8869420708;
        Wed, 30 Sep 2020 18:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601492263;
        bh=7DBLzj0AFFlixJiM06qjIevaCnAyUlyySzwLvB3SMq8=;
        h=From:To:Cc:Subject:Date:From;
        b=BAfMb8awL1XSSox57K+L81UtE9Cfh84GFPeDCXMiY+kTCOmF/2W3TxeOQtj3gSgnM
         gGTkrGlZjwHp3/l2sjRdtUijcat5FlLnmMaS8yExI8x16/uKepDsNbL0RQQoRdH+nm
         kVFlvOWP/MakWcvdL3c2spY2xJFDTmFsUamwRqeg=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.9-rc7
Date:   Wed, 30 Sep 2020 11:57:42 -0700
Message-Id: <20200930185742.4044166-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d2249bf25c565b6e310453962fef63f8d38677a6:

  clk: qcom: lpass: Correct goto target in lpass_core_sc7180_probe() (2020-09-10 13:42:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to b02cf0c4736c65c6667f396efaae6b5521e82abf:

  clk: socfpga: stratix10: fix the divider for the emac_ptp_free_clk (2020-09-22 12:54:41 -0700)

----------------------------------------------------------------
Another batch of clk driver fixes

 - Make sure DRAM and ChipID region doesn't get disabled on Exynos
 - Fix a SATA failure on Tegra
 - Fix the emac_ptp clk divider on stratix10

----------------------------------------------------------------
Dinh Nguyen (1):
      clk: socfpga: stratix10: fix the divider for the emac_ptp_free_clk

Marek Szyprowski (2):
      clk: samsung: Keep top BPLL mux on Exynos542x enabled
      clk: samsung: exynos4: mark 'chipid' clock as CLK_IGNORE_UNUSED

Stephen Boyd (2):
      Merge tag 'v5.9-clk-samsung-fixes' of https://git.kernel.org/.../snawrocki/clk into clk-fixes
      Merge tag 'for-5.10-clk' of git://git.kernel.org/.../tegra/linux into clk-fixes

Thierry Reding (3):
      clk: tegra: Capitalization fixes
      clk: tegra: Always program PLL_E when enabled
      clk: tegra: Fix missing prototype for tegra210_clk_register_emc()

 drivers/clk/samsung/clk-exynos4.c    | 4 ++--
 drivers/clk/samsung/clk-exynos5420.c | 5 +++++
 drivers/clk/socfpga/clk-s10.c        | 2 +-
 drivers/clk/tegra/clk-pll.c          | 7 ++-----
 drivers/clk/tegra/clk-tegra210-emc.c | 2 ++
 5 files changed, 12 insertions(+), 8 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
