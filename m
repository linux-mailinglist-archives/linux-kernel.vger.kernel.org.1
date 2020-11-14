Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D70B82B303B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 20:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKNTjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Nov 2020 14:39:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNTjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Nov 2020 14:39:35 -0500
Received: from mail.kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26E9522275;
        Sat, 14 Nov 2020 19:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605382775;
        bh=OhUkYtHxpcowYlogkbZuwo4qzcsgKrOVLFlT2QSSKF4=;
        h=From:To:Cc:Subject:Date:From;
        b=CkTpQTcDtgyEw9tJHUAGAZ1XV9W2Vg8qYl1dTjglY+b7m8+blomMkD6a8TOSN5Pm0
         SUoHFHRmIW7CTHj2cm2Rq5ipegdfbR9KLjAByYNGvgcJSfGDdoqJbz8LeNpiOhTle/
         tDaiqKm4hIpanPcBCQBIVVrBrL1MG8p0zzW/w+VE=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.10-rc3
Date:   Sat, 14 Nov 2020 11:39:34 -0800
Message-Id: <20201114193934.785014-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to c277ca155d2f0028a5c79708426d3f79b54a5fc1:

  clk: imx8m: fix bus critical clk registration (2020-11-04 17:13:12 -0800)

----------------------------------------------------------------
Two small clk driver fixes

 - Make to_clk_regmap() inline to avoid compiler annoyance
 - Fix critical clks on i.MX imx8m SoCs

----------------------------------------------------------------
Arnd Bergmann (1):
      clk: define to_clk_regmap() as inline function

Peng Fan (1):
      clk: imx8m: fix bus critical clk registration

 drivers/clk/imx/clk-imx8mm.c   | 10 +++++-----
 drivers/clk/imx/clk-imx8mn.c   |  6 +++---
 drivers/clk/imx/clk-imx8mp.c   | 10 +++++-----
 drivers/clk/imx/clk-imx8mq.c   |  8 ++++----
 drivers/clk/imx/clk.h          |  5 +++++
 drivers/clk/meson/clk-regmap.h |  5 ++++-
 drivers/clk/qcom/clk-regmap.h  |  6 +++++-
 7 files changed, 31 insertions(+), 19 deletions(-)

-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
