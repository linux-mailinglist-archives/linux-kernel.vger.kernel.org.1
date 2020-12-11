Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B286A2D70B2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 08:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436747AbgLKHNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 02:13:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:58442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390203AbgLKHMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 02:12:48 -0500
From:   Stephen Boyd <sboyd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.10-rc7
Date:   Thu, 10 Dec 2020 23:12:07 -0800
Message-Id: <20201211071207.3828638-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c277ca155d2f0028a5c79708426d3f79b54a5fc1:

  clk: imx8m: fix bus critical clk registration (2020-11-04 17:13:12 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to ceabbf94c317c6175dee6e91805fca4a6353745a:

  clk: renesas: r9a06g032: Drop __packed for portability (2020-12-07 13:58:49 -0800)

----------------------------------------------------------------
Two small clk driver build fixes

 - Remove __packed from a Renesas struct to improve portability
 - Fix a linking problem with i.MX when config options don't agree

----------------------------------------------------------------
Dong Aisheng (1):
      clk: imx: scu: fix MXC_CLK_SCU module build break

Geert Uytterhoeven (1):
      clk: renesas: r9a06g032: Drop __packed for portability

 drivers/clk/imx/Kconfig                | 4 ++--
 drivers/clk/renesas/r9a06g032-clocks.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
