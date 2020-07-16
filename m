Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB8221961
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 03:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGPBWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 21:22:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:44408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPBWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:22:22 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6F5320775;
        Thu, 16 Jul 2020 01:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594862541;
        bh=dsj9+fJd/vy9XsF5SWuo2b2iwd2BiMXB1J2TwY0lct4=;
        h=From:To:Cc:Subject:Date:From;
        b=p9/2/dPYofHAEvUpOar17hDBnDQqUUBPWauQdmZTpZCT9dRUFvkdRTc9vk9XY7gL1
         0yDzgRTk48HojzS2xCWtNl54S9870aBJZItZSjA5pXS7gF2hBigudvQjauc8Arzei6
         ed5D+NNXMWixDcIk8SVVi5Wfqj80+IuCPuMPtvfY=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.8-rc5
Date:   Wed, 15 Jul 2020 18:22:21 -0700
Message-Id: <20200716012221.2640243-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 1e7468bd9d30a21e059af477106dc5588ae52dff:

  clk: Specify IOMEM dependency for HSDK pll driver (2020-07-11 09:28:10 -0700)

----------------------------------------------------------------
A couple build fixes for issues exposed this merge window and a fix for
the eMMC clk on AST2600 SoCs that fixes the rate that is calculated by
the clk framework.

----------------------------------------------------------------
David Gow (1):
      clk: Specify IOMEM dependency for HSDK pll driver

Eddie James (1):
      clk: AST2600: Add mux for EMMC clock

Nathan Chancellor (1):
      clk: mvebu: ARMADA_AP_CPU_CLK needs to select ARMADA_AP_CP_HELPER

 drivers/clk/Kconfig       |  1 +
 drivers/clk/clk-ast2600.c | 49 +++++++++++++++++++++++++++++++++++++++--------
 drivers/clk/mvebu/Kconfig |  1 +
 3 files changed, 43 insertions(+), 8 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
