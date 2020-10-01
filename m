Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789BF280459
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 18:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgJAQ5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 12:57:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732096AbgJAQ5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 12:57:02 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B194C2075F;
        Thu,  1 Oct 2020 16:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601571422;
        bh=Bt0Gx0sCicncHn7/LXvk0u9+DwgWSv4J/UpkSmtFvDA=;
        h=From:To:Cc:Subject:Date:From;
        b=zZL1Z8w0QLURbWU1pODgu7T2djyFQ7VTPG77QVPRCSgOC+oyyMdtc7cAZQkdDh8jl
         xoCIpwKPUXHMBecvPSjJbAUSFFZPVh4LtIwrEzsKwtDCOfwuC8EpEY7LUGeuGIaHfn
         BGwfy8do4Y3JWqypk1k4aY/9M6qZxGCE8Wq2ONrg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 0/2] samsung: exynos: convert clkout to module driver
Date:   Thu,  1 Oct 2020 18:56:44 +0200
Message-Id: <20201001165646.32279-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch #2 depends on #1.  I could take it via samsung-soc or both
could go via samsung-clk tree.

The patchset is a proper solution to issue reported by Marek [1], for
which a revert was done [2].

[1] https://lore.kernel.org/linux-samsung-soc/20200906142146.21266-1-krzk@kernel.org/T/#m726edc89ff2927cf5aaf8b165128b3e3c45a677a
[2] https://lore.kernel.org/linux-samsung-soc/20200921174818.15525-1-krzk@kernel.org/T/#u

Best regards,
Krzysztof


Krzysztof Kozlowski (2):
  soc: samsung: exynos-pmu: instantiate clkout driver as MFD
  clk: samsung: exynos-clkout: convert to module driver

 drivers/clk/samsung/clk-exynos-clkout.c | 198 +++++++++++++++++-------
 drivers/soc/samsung/exynos-pmu.c        |  11 ++
 2 files changed, 152 insertions(+), 57 deletions(-)

-- 
2.17.1

