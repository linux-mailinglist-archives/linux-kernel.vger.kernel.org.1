Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5831E73ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 05:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbgE2D5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 23:57:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388051AbgE2D5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:57:30 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5C5720707;
        Fri, 29 May 2020 03:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590724649;
        bh=UQk/T016wJiZwyu2CR71gcGTRWBIZcKMHDB+t7J3PEY=;
        h=From:To:Cc:Subject:Date:From;
        b=sKLVJppNWW0spd8QTDJ14uzY/gLGtkXPtsRcTZOYfauWpkD1/ARhQCJe1CXGuA0ZF
         hV68bJRHg3pNf0tTaM0tgRcAi2tj78vu59Icf6Yt1qen31DT6CojYSufvcdP7KMBxl
         NCzCeFt4DVfZxjSVoE7JPk81BNDyFZfDp1+xRl7k=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.7-rc7
Date:   Thu, 28 May 2020 20:57:29 -0700
Message-Id: <20200529035729.202144-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 852049594b9af58fa2972103699fd58a7ac165c6:

  clk: ti: clkctrl: convert subclocks to use proper names also (2020-05-12 20:18:19 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to a76f274182f054481182c81cd62bb8794a5450a6:

  clk: qcom: gcc: Fix parent for gpll0_out_even (2020-05-26 17:15:06 -0700)

----------------------------------------------------------------
Two fixes for the new SM8150 and SM8250 Qualcomm clk drivers
to fix a randconfig build error and an incorrect parent mapping.

----------------------------------------------------------------
Jonathan Marek (1):
      clk: qcom: sm8250 gcc depends on QCOM_GDSC

Vinod Koul (1):
      clk: qcom: gcc: Fix parent for gpll0_out_even

 drivers/clk/qcom/Kconfig      | 1 +
 drivers/clk/qcom/gcc-sm8150.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
Sent by a computer, using git, on the internet
