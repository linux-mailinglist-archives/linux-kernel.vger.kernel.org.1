Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0983C2B3325
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 10:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKOJK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 04:10:57 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7541 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726600AbgKOJKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 04:10:50 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CYmB70TpqzhZ5N;
        Sun, 15 Nov 2020 16:50:23 +0800 (CST)
Received: from huawei.com (10.175.124.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Sun, 15 Nov 2020
 16:50:25 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
To:     <thierry.reding@gmail.com>
CC:     <jonathanh@nvidia.com>, <olof@lixom.net>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <huawei.libin@huawei.com>, <cj.chengjian@huawei.com>
Subject: [PATCH] soc/tegra: fuse: Fix build with Tegra234 configuration
Date:   Sun, 15 Nov 2020 16:50:21 +0800
Message-ID: <20201115085021.42100-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
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

Fixes: 1f44febf71ba ("soc/tegra: fuse: Add Tegra234 support")
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
2.17.1

