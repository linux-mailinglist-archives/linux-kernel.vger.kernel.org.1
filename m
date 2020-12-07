Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AB32D190F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgLGTGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgLGTGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:06:12 -0500
From:   Krzysztof Kozlowski <krzk@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [PATCH v2 0/4] soc: samsung: exynos-chipid and asv improvements
Date:   Mon,  7 Dec 2020 20:05:13 +0100
Message-Id: <20201207190517.262051-1-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Changes since v1:
1. Drop patch "soc: samsung: exynos-chipid: initialize later - with
   arch_initcall" which is now superseded by convertin to a driver.
2. Include Marek's patch, just for the reference and rebase.
3. Add patch "soc: samsung: exynos-asv: handle reading revision register
   error".
4. Add patch "soc: samsung: exynos-chipid: convert to driver and merge
   exynos-asv".

Best regards,
Krzysztof

Krzysztof Kozlowski (3):
  soc: samsung: exynos-asv: handle reading revision register error
  soc: samsung: exynos-chipid: order list of SoCs by name
  soc: samsung: exynos-chipid: convert to driver and merge exynos-asv

Marek Szyprowski (1):
  soc: samsung: exynos-asv: don't defer early on not-supported SoCs

 arch/arm/mach-exynos/Kconfig        |  1 -
 drivers/soc/samsung/Kconfig         | 12 ++---
 drivers/soc/samsung/Makefile        |  3 +-
 drivers/soc/samsung/exynos-asv.c    | 57 ++++++++-------------
 drivers/soc/samsung/exynos-asv.h    |  2 +
 drivers/soc/samsung/exynos-chipid.c | 78 ++++++++++++++++++++---------
 6 files changed, 81 insertions(+), 72 deletions(-)

-- 
2.25.1

