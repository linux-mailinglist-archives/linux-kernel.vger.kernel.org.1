Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5992B8BF1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKSHER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 02:04:17 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7935 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgKSHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 02:04:16 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cc9dR4JJxz70G2;
        Thu, 19 Nov 2020 15:03:55 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 15:04:01 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH] stm class: Fix a double vfree in stm_register_device()
Date:   Thu, 19 Nov 2020 15:08:44 +0800
Message-ID: <20201119070844.1123-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing stm, stm_register_device() caused a vfree issue:
-----
Trying to vfree() nonexistent vm area (00000000ad30ebb6)

Call Trace:
__vfree+0x41/0xe0
vfree+0x5f/0xa0
stm_register_device+0x4b1/0x660 [stm_core]
dummy_stm_init+0x248/0x360 [dummy_stm]
do_one_initcall+0x149/0x7e0
do_init_module+0x1ef/0x700
load_module+0x3467/0x4140
__do_sys_finit_module+0x10d/0x1a0
do_syscall_64+0x34/0x80
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x468ded
-----

This is because put_device(&stm->dev) calls stm_device_release,
which would call vfree(stm) inside, so there's no need to do
vfree again.

Fix this problem by simply return err after put_device().

Fixes: b5e2ced9bf81 ("stm class: Use vmalloc for the master map")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/hwtracing/stm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwtracing/stm/core.c b/drivers/hwtracing/stm/core.c
index 2712e699b..80b7c81d5 100644
--- a/drivers/hwtracing/stm/core.c
+++ b/drivers/hwtracing/stm/core.c
@@ -915,6 +915,8 @@ int stm_register_device(struct device *parent, struct stm_data *stm_data,
 
 	/* matches device_initialize() above */
 	put_device(&stm->dev);
+
+	return err;
 err_free:
 	vfree(stm);
 
-- 
2.23.0

