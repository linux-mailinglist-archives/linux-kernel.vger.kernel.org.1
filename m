Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969552C2294
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbgKXKOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbgKXKOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:14:33 -0500
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch [84.226.167.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82396206FA;
        Tue, 24 Nov 2020 10:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606212872;
        bh=b8HhW9uD6Rj5MLBmsqYc9N3xHsa1TIn+WX9DZwiS+MM=;
        h=From:To:Cc:Subject:Date:From;
        b=NlR9Xce3ZfRoyhKndZaataNqsLYkXUxW1Nyu64thgrWP7ub7s3mPfC2N0UNVRzaGy
         sF2QN/emYbctPOykg3+4QCyI9f2dFJXT5oi572QWiJEvfw/+0GMJMCcUDR7JRaQNRz
         RWllSTEVpKSfAY+bIGBg3B/Yty9yKmQJVZ2FTPfc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [GIT PULL] memory: tegra soc/clock for v5.11 - sharing a tag
Date:   Tue, 24 Nov 2020 11:13:52 +0100
Message-Id: <20201124101352.26381-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stable tag with Tegra SoC changes in Memory controllers tree, being a part of
my regular v5.11 pull request later to arm-soc. Please pull if your patches
depend on this.

Best regards,
Krzysztof


The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/tegra-soc-clk-drivers-5.11

for you to fetch changes up to 245157a31e91aec7f5b621ed26c0a8370b1c8a64:

  soc/tegra: fuse: Add stub for tegra_sku_info (2020-11-06 19:25:21 +0100)

----------------------------------------------------------------
Tegra SoC and clock controller changes for v5.11

Export symbols and add stubs necessary for upcoming modified Tegra
memory controller drivers (touching also devfreq and interconnect).

----------------------------------------------------------------
Dmitry Osipenko (3):
      clk: tegra: Export Tegra20 EMC kernel symbols
      soc/tegra: fuse: Export tegra_read_ram_code()
      soc/tegra: fuse: Add stub for tegra_sku_info

 drivers/clk/tegra/clk-tegra20-emc.c    | 3 +++
 drivers/soc/tegra/fuse/tegra-apbmisc.c | 2 ++
 include/soc/tegra/fuse.h               | 4 ++++
 3 files changed, 9 insertions(+)
