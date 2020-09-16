Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B146B26B98F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 03:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIPB6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 21:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgIPB6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 21:58:09 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295D12087D;
        Wed, 16 Sep 2020 01:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600221489;
        bh=Rg81xqpyLSJsqQIYCQLlfYC0tHPrrN2Eh9YQQF6u6+A=;
        h=From:To:Cc:Subject:Date:From;
        b=Dk709+8guA/2Iht317EAtpnLe3Tm1x8fFtoTrh8Ffkru3PDSfeAwbgsu0aP8SQxqG
         CFm4+qEcTk+0D6YJiDH7ga0isTrRAy8kRBrSbamiw8IdJBD+uH/qUHB5++VQFEDBh1
         EmGUv58uhY4mgCRoHX5RaCyABVEnNiXn9V2ytbQk=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.9-rc5
Date:   Tue, 15 Sep 2020 18:58:08 -0700
Message-Id: <20200916015808.3287134-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to d2249bf25c565b6e310453962fef63f8d38677a6:

  clk: qcom: lpass: Correct goto target in lpass_core_sc7180_probe() (2020-09-10 13:42:35 -0700)

----------------------------------------------------------------
A handful of clk driver fixes. Mostly they're for error paths or
improper memory allocations sizes. Nothing as exciting as a wildfire.

----------------------------------------------------------------
Christophe JAILLET (1):
      clk: davinci: Use the correct size when allocating memory

Jing Xiangfeng (1):
      clk: qcom: lpass: Correct goto target in lpass_core_sc7180_probe()

Maxime Ripard (1):
      clk: bcm: dvp: Select the reset framework

Nathan Chancellor (1):
      clk: rockchip: Fix initialization of mux_pll_src_4plls_p

Sumera Priyadarsini (1):
      clk: versatile: Add of_node_put() before return statement

 drivers/clk/bcm/Kconfig               | 1 +
 drivers/clk/davinci/pll.c             | 2 +-
 drivers/clk/qcom/lpasscorecc-sc7180.c | 7 ++++---
 drivers/clk/rockchip/clk-rk3228.c     | 2 +-
 drivers/clk/versatile/clk-impd1.c     | 4 +++-
 5 files changed, 10 insertions(+), 6 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
