Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8086A2AB78F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgKILxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:53:32 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7065 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgKILxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:53:32 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CV8X05vqnzhjVQ;
        Mon,  9 Nov 2020 19:53:20 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Mon, 9 Nov 2020 19:53:17 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH] regmap: Properly free allocated name for regmap_config of syscon
Date:   Mon, 9 Nov 2020 19:58:16 +0800
Message-ID: <20201109115816.160639-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscon_config.name in of_syscon_register is allocated using kasprintf,
which should be freed when it is not used after regmap_set_name, fix
the following memory leak.

unreferenced object 0xffffffe07fe8c150 (size 16):
  comm "swapper/0", pid 1, jiffies 4294892540 (age 68.168s)
  hex dump (first 16 bytes):
    74 65 73 74 40 31 30 30 30 30 30 00 e0 ff ff ff  test@100000.....
  backtrace:
    [<0000000023d86736>] create_object+0xe8/0x348
    [<00000000fe9d1b17>] kmemleak_alloc+0x20/0x2a
    [<000000006bba3c96>] __kmalloc_track_caller+0x174/0x272
    [<000000008bbb1565>] kvasprintf+0x42/0x86
    [<000000000e566920>] kasprintf+0x34/0x50
    [<00000000809602dd>] of_syscon_register+0x11c/0x2a8
    [<00000000711191ee>] device_node_get_regmap+0x6a/0x98
    [<0000000083dd951c>] syscon_node_to_regmap+0x2e/0x38
    [<00000000cbe0596d>] syscon_regmap_lookup_by_phandle+0x1e/0x26
    [<000000009d9c679f>] syscon_reboot_probe+0x58/0x1aa
    [<000000007b610fab>] platform_drv_probe+0x30/0x64
    [<0000000031597f78>] really_probe+0x9c/0x274
    [<000000004d1de808>] driver_probe_device+0x2c/0x68
    [<000000008a998a90>] device_driver_attach+0x4c/0x50
    [<000000002ea43ad9>] __driver_attach+0x66/0xa0
    [<0000000018505756>] bus_for_each_dev+0x5a/0x98

Fixes: 529a1101212a ("mfd: syscon: Don't free allocated name for regmap_config")
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 drivers/base/regmap/regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 5db536ccfcd6..c1c1e53d46ac 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -601,6 +601,7 @@ static int regmap_set_name(struct regmap *map, const struct regmap_config *confi
 		if (!name)
 			return -ENOMEM;
 
+		kfree_const(config->name);
 		kfree_const(map->name);
 		map->name = name;
 	}
-- 
2.26.2

