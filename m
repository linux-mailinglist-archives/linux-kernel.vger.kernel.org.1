Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8372EEAB0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 02:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbhAHBHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 20:07:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:9982 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbhAHBHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 20:07:52 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DBlKq3wN7zj3nT;
        Fri,  8 Jan 2021 09:06:23 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.200.137) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Fri, 8 Jan 2021 09:06:55 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <m.szyprowski@samsung.com>, <hch@lst.de>, <robin.murphy@arm.com>,
        <iommu@lists.linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH] dma-mapping: benchmark: fix kernel crash when dma_map_single fails
Date:   Fri, 8 Jan 2021 14:01:48 +1300
Message-ID: <20210108010148.21868-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.200.137]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if dma_map_single() fails, kernel will give the below oops since
task_struct has been destroyed and we are running into the memory
corruption due to use-after-free in kthread_stop():

[   48.095310] Unable to handle kernel paging request at virtual address 000000c473548040
[   48.095736] Mem abort info:
[   48.095864]   ESR = 0x96000004
[   48.096025]   EC = 0x25: DABT (current EL), IL = 32 bits
[   48.096268]   SET = 0, FnV = 0
[   48.096401]   EA = 0, S1PTW = 0
[   48.096538] Data abort info:
[   48.096659]   ISV = 0, ISS = 0x00000004
[   48.096820]   CM = 0, WnR = 0
[   48.097079] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000104639000
[   48.098099] [000000c473548040] pgd=0000000000000000, p4d=0000000000000000
[   48.098832] Internal error: Oops: 96000004 [#1] PREEMPT SMP
[   48.099232] Modules linked in:
[   48.099387] CPU: 0 PID: 2 Comm: kthreadd Tainted: G        W
[   48.099887] Hardware name: linux,dummy-virt (DT)
[   48.100078] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
[   48.100516] pc : __kmalloc_node+0x214/0x368
[   48.100944] lr : __kmalloc_node+0x1f4/0x368
[   48.101458] sp : ffff800011f0bb80
[   48.101843] x29: ffff800011f0bb80 x28: ffff0000c0098ec0
[   48.102330] x27: 0000000000000000 x26: 00000000001d4600
[   48.102648] x25: ffff0000c0098ec0 x24: ffff800011b6a000
[   48.102988] x23: 00000000ffffffff x22: ffff0000c0098ec0
[   48.103333] x21: ffff8000101d7a54 x20: 0000000000000dc0
[   48.103657] x19: ffff0000c0001e00 x18: 0000000000000000
[   48.104069] x17: 0000000000000000 x16: 0000000000000000
[   48.105449] x15: 000001aa0304e7b9 x14: 00000000000003b1
[   48.106401] x13: ffff8000122d5000 x12: ffff80001228d000
[   48.107296] x11: ffff0000c0154340 x10: 0000000000000000
[   48.107862] x9 : ffff80000fffffff x8 : ffff0000c473527f
[   48.108326] x7 : ffff800011e62f58 x6 : ffff0000c01c8ed8
[   48.108778] x5 : ffff0000c0098ec0 x4 : 0000000000000000
[   48.109223] x3 : 00000000001d4600 x2 : 0000000000000040
[   48.109656] x1 : 0000000000000001 x0 : ff0000c473548000
[   48.110104] Call trace:
[   48.110287]  __kmalloc_node+0x214/0x368
[   48.110493]  __vmalloc_node_range+0xc4/0x298
[   48.110805]  copy_process+0x2c8/0x15c8
[   48.111133]  kernel_clone+0x5c/0x3c0
[   48.111373]  kernel_thread+0x64/0x90
[   48.111604]  kthreadd+0x158/0x368
[   48.111810]  ret_from_fork+0x10/0x30
[   48.112336] Code: 17ffffe9 b9402a62 b94008a1 11000421 (f8626802)
[   48.112884] ---[ end trace d4890e21e75419d5 ]---

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 kernel/dma/map_benchmark.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index b1496e744c68..1b1b8ff875cb 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -147,8 +147,10 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	atomic64_set(&map->sum_sq_unmap, 0);
 	atomic64_set(&map->loops, 0);
 
-	for (i = 0; i < threads; i++)
+	for (i = 0; i < threads; i++) {
+		get_task_struct(tsk[i]);
 		wake_up_process(tsk[i]);
+	}
 
 	msleep_interruptible(map->bparam.seconds * 1000);
 
@@ -183,6 +185,8 @@ static int do_map_benchmark(struct map_benchmark_data *map)
 	}
 
 out:
+	for (i = 0; i < threads; i++)
+		put_task_struct(tsk[i]);
 	put_device(map->dev);
 	kfree(tsk);
 	return ret;
-- 
2.25.1

