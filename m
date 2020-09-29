Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CAC27C679
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 13:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgI2Lpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 07:45:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14776 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730681AbgI2LpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 07:45:18 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DB96EF3FBE7670F74CDA;
        Tue, 29 Sep 2020 19:45:14 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Tue, 29 Sep 2020
 19:45:05 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <weiyongjun1@huawei.com>, <huawei.libin@huawei.com>,
        <cj.chengjian@huawei.com>, <thierry.reding@gmail.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] soc/tegra: fuse: Fix build with Tegra234 configuration
Date:   Tue, 29 Sep 2020 19:43:25 +0800
Message-ID: <20200929114325.3909556-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If only Tegra234 support is enabled, the tegra30_fuse_read() and
tegra30_fuse_init() function are not declared and cause a build failure.

drivers/soc/tegra/fuse/fuse-tegra30.c:376:10: error: ‘tegra30_fuse_read’
 undeclared here (not in a function); did you mean ‘tegra_fuse_readl’?
  .read = tegra30_fuse_read,
          ^~~~~~~~~~~~~~~~~
          tegra_fuse_readl
drivers/soc/tegra/fuse/fuse-tegra30.c:382:10: error: ‘tegra30_fuse_init’
 undeclared here (not in a function); did you mean ‘tegra30_fuse_read’?
  .init = tegra30_fuse_init,
          ^~~~~~~~~~~~~~~~~
          tegra30_fuse_read

Signed-off-by: Wang ShaoBo <bobo.shaobowang@huawei.com>
---
 drivers/soc/tegra/fuse/fuse-tegra30.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c b/drivers/soc/tegra/fuse/fuse-tegra30.c
index 9ea7f0168457..c1aa7815bd6e 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra30.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
@@ -37,7 +37,8 @@
     defined(CONFIG_ARCH_TEGRA_132_SOC) || \
     defined(CONFIG_ARCH_TEGRA_210_SOC) || \
     defined(CONFIG_ARCH_TEGRA_186_SOC) || \
-    defined(CONFIG_ARCH_TEGRA_194_SOC)
+    defined(CONFIG_ARCH_TEGRA_194_SOC) || \
+    defined(CONFIG_ARCH_TEGRA_234_SOC)
 static u32 tegra30_fuse_read_early(struct tegra_fuse *fuse, unsigned int offset)
 {
 	if (WARN_ON(!fuse->base))
-- 
2.25.1

