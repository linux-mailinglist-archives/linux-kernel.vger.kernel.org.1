Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7132E18F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 07:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgLWG3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 01:29:02 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10066 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgLWG3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 01:29:01 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D13CZ4vDvzM0jm;
        Wed, 23 Dec 2020 14:27:22 +0800 (CST)
Received: from DESKTOP-2DH7KI2.china.huawei.com (10.67.101.108) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 23 Dec 2020 14:28:08 +0800
From:   Chengsong Ke <kechengsong@huawei.com>
To:     <richard@nod.at>, <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangfangpeng1@huawei.com>, <chengzhihao1@huawei.com>
Subject: [PATCH] ubifs: Fix read out-of-bounds in ubifs_jnl_write_inode()
Date:   Wed, 23 Dec 2020 14:28:08 +0800
Message-ID: <20201223062808.27512-1-kechengsong@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kechengsong <kechengsong@huawei.com>

ubifs_jnl_write_inode() probably cause read out-of-bounds in some situation.
There is kasan stack:
[  336.432159] BUG: KASAN: slab-out-of-bounds in ecc_sw_hamming_calculate+0x1dc/0x7d0
[  336.433634] Read of size 4 at addr ffff888019612ff8 by task kworker/u8:4/135
[  336.434605]
[  336.434830] CPU: 1 PID: 135 Comm: kworker/u8:4 Not tainted 5.10.0-11826-gaf2a097952f3-dirty #338
[  336.436050] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[  336.437876] Workqueue: writeback wb_workfn (flush-ubifs_0_0)
[  336.438670] Call Trace:
[  336.439021]  ? dump_stack+0xdd/0x126
[  336.439513]  ? print_address_description.constprop.0+0x2c/0x3c0
[  336.440308]  ? _raw_write_lock_irqsave+0x140/0x140
[  336.440921]  ? ecc_sw_hamming_calculate+0x1dc/0x7d0
[  336.441546]  ? ecc_sw_hamming_calculate+0x1dc/0x7d0
[  336.442186]  ? kasan_report.cold+0x5d/0xd8
[  336.442711]  ? nand_reset_op+0x280/0x310
[  336.443218]  ? ecc_sw_hamming_calculate+0x1dc/0x7d0
[  336.443842]  ? __asan_load4+0x77/0x120
[  336.444334]  ? ecc_sw_hamming_calculate+0x1dc/0x7d0
[  336.444963]  ? nand_ecc_sw_hamming_calculate+0x6c/0x80
[  336.445619]  ? rawnand_sw_hamming_calculate+0x12/0x20
[  336.446263]  ? nand_write_page_swecc+0xa9/0x160
[  336.446849]  ? nand_do_write_ops+0x390/0x830
[  336.447406]  ? __writeback_single_inode+0x6cc/0x880
[  336.448041]  ? nand_write_oob+0x78/0x100
[  336.448568]  ? mtd_write_oob_std+0xe2/0x160
[  336.449127]  ? mtd_write_oob+0xec/0x1b0
[  336.449679]  ? mtd_write+0x92/0xf0
[  336.450128]  ? mtd_write_oob+0x1b0/0x1b0
[  336.450633]  ? ubi_self_check_all_ff+0x82/0x2e0 [ubi]
[  336.451328]  ? __list_add_valid+0x2b/0x130
[  336.451865]  ? ubi_io_write+0x2c2/0xa90 [ubi]
[  336.452472]  ? _raw_read_lock_irq+0x90/0x90
[  336.453078]  ? kmem_cache_alloc_trace+0x465/0x8b0
[  336.453749]  ? do_sync_erase+0x350/0x350 [ubi]
[  336.454430]  ? __kasan_check_write+0x20/0x30
[  336.455050]  ? down_write+0xf2/0x190
[  336.455569]  ? down_write_killable+0x1b0/0x1b0
[  336.456221]  ? check_mapping+0x2c/0x590 [ubi]
[  336.456890]  ? ubi_eba_write_leb+0x58a/0xfa0 [ubi]
[  336.457618]  ? __kmalloc+0x490/0x910
[  336.458142]  ? ubifs_jnl_write_inode.cold+0x6f/0x878 [ubifs]
[  336.459033]  ? writeback_sb_inodes+0x3a9/0x9a0
[  336.459672]  ? __writeback_inodes_wb+0xc8/0x170
[  336.460330]  ? wb_writeback+0x637/0x700
[  336.460882]  ? wb_workfn+0x8af/0xb80
[  336.461398]  ? process_one_work+0x467/0x9f0
[  336.462004]  ? worker_thread+0x34d/0x8e0
[  336.462582]  ? kthread+0x204/0x280
[  336.463047]  ? ret_from_fork+0x1f/0x30
[  336.463570]  ? create_prof_cpu_mask+0x30/0x30
[  336.464185]  ? ubi_eba_read_leb_sg+0x1f0/0x1f0 [ubi]
[  336.464917]  ? hrtimer_active+0x9b/0x100
[  336.465468]  ? ubi_leb_write+0x22c/0x2f0 [ubi]
[  336.466130]  ? ubifs_leb_write+0xf2/0x1b0 [ubifs]
[  336.466851]  ? ubifs_wbuf_write_nolock+0x412/0x1280 [ubifs]
[  336.467686]  ? write_head+0xdf/0x1c0 [ubifs]
[  336.468355]  ? ubifs_jnl_write_inode.cold+0x3ec/0x878 [ubifs]
[  336.469183]  ? ret_from_fork+0x1e/0x30
[  336.469707]  ? ubifs_jnl_write_data+0x660/0x660 [ubifs]
[  336.470497]  ? unwind_next_frame+0x247/0xca0
[  336.471095]  ? ret_from_fork+0x1f/0x30
[  336.471574]  ? fprop_reflect_period_percpu.isra.0+0x1f/0x1b0
[  336.472335]  ? generic_writepages+0x93/0x140
[  336.472933]  ? __kasan_check_write+0x20/0x30
[  336.473526]  ? mutex_lock+0xa6/0x110
[  336.474031]  ? __mutex_lock_slowpath+0x30/0x30
[  336.474662]  ? ubifs_write_inode+0x1c3/0x290 [ubifs]
[  336.475446]  ? __writeback_single_inode+0x6cc/0x880
[  336.476155]  ? wbc_attach_and_unlock_inode+0x2b6/0x400
[  336.476891]  ? writeback_sb_inodes+0x3a9/0x9a0
[  336.477528]  ? write_inode_now+0x1e0/0x1e0
[  336.478119]  ? __writeback_inodes_wb+0xc8/0x170
[  336.478770]  ? wb_writeback+0x637/0x700
[  336.479326]  ? __writeback_inodes_wb+0x170/0x170
[  336.479992]  ? current_work+0xa0/0xa0
[  336.480524]  ? _find_next_bit.constprop.0+0x3e/0x140
[  336.481241]  ? find_next_bit+0x18/0x30
[  336.481780]  ? cpumask_next+0x2f/0x40
[  336.482312]  ? wb_workfn+0x8af/0xb80
[  336.482832]  ? update_cfs_group+0x1e/0x1b0
[  336.483421]  ? inode_wait_for_writeback+0x60/0x60
[  336.484106]  ? schedule+0xb7/0x240
[  336.484595]  ? finish_task_switch+0x14e/0x9a0
[  336.485225]  ? __kasan_check_write+0x20/0x30
[  336.485841]  ? __schedule+0x6f4/0x1600
[  336.486382]  ? __kasan_check_read+0x1d/0x30
[  336.486981]  ? read_word_at_a_time+0x16/0x30
[  336.487594]  ? process_one_work+0x467/0x9f0
[  336.488198]  ? worker_thread+0x34d/0x8e0
[  336.488762]  ? rescuer_thread+0x820/0x820
[  336.489344]  ? kthread+0x204/0x280
[  336.489839]  ? kthread_bind+0x50/0x50
[  336.490367]  ? ret_from_fork+0x1f/0x30
[  336.490913]
[  336.491138] Allocated by task 135:
[  336.491629]  kasan_save_stack+0x23/0x60
[  336.492189]  __kasan_kmalloc.constprop.0+0x10b/0x120
[  336.492898]  kasan_kmalloc+0xd/0x20
[  336.493401]  __kmalloc+0x490/0x910
[  336.493890]  ubifs_jnl_write_inode.cold+0x6f/0x878 [ubifs]
[  336.494744]  ubifs_write_inode+0x1c3/0x290 [ubifs]
[  336.495500]  __writeback_single_inode+0x6cc/0x880
[  336.496179]  writeback_sb_inodes+0x3a9/0x9a0
[  336.496791]  __writeback_inodes_wb+0xc8/0x170
[  336.497417]  wb_writeback+0x637/0x700
[  336.497949]  wb_workfn+0x8af/0xb80
[  336.498440]  process_one_work+0x467/0x9f0
[  336.499023]  worker_thread+0x34d/0x8e0
[  336.499567]  kthread+0x204/0x280
[  336.500050]  ret_from_fork+0x1f/0x30
[  336.500570]
[  336.500793] The buggy address belongs to the object at ffff888019612000
[  336.500793]  which belongs to the cache kmalloc-4k of size 4096
[  336.502550] The buggy address is located 4088 bytes inside of
[  336.502550]  4096-byte region [ffff888019612000, ffff888019613000)
[  336.504231] The buggy address belongs to the page:
[  336.504917] page:000000003204ded8 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x19610
[  336.506234] head:000000003204ded8 order:3 compound_mapcount:0 compound_pincount:0
[  336.507293] flags: 0x1fffff80010200(slab|head)
[  336.507934] raw: 001fffff80010200 ffffea0000667000 0000000200000002 ffff888010842140
[  336.509038] raw: 0000000000000000 0000000080040004 00000001ffffffff ffff88801956e3c1
[  336.510132] page dumped because: kasan: bad access detected
[  336.510923] pages's memcg:ffff88801956e3c1
[  336.511509]
[  336.511730] Memory state around the buggy address:
[  336.512421]  ffff888019612e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  336.513446]  ffff888019612f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[  336.514468] >ffff888019612f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01
[  336.515494]                                                                 ^
[  336.516506]  ffff888019613000: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  336.517535]  ffff888019613080: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  336.518560] ==================================================================

The memory area allocated in ubifs_jnl_write_inode() is not aligned with 8 bytes:
ino_start = ino = kmalloc(write_len, GFP_NOFS);

When ino_start passed into write_head -> ubifs_wbuf_write_nolock:
    n = aligned_len >> c->max_write_shift;
    if (n) {
      n <<= c->max_write_shift;
      err = ubifs_leb_write(c, wbuf->lnum, buf + written, wbuf->offs, n);
      // Read oob occurs here, read n bytes from buf, and buf is passed from @ino_start which is
      // not 8 bytes aligned(write_len < n). Program read (n - write_len) more bytes.
    }

Reproducer:
0. config KASAN && apply print.patch
1. mount ubifs on /root/temp
2. run test.sh
3. cd /root/temp && ls // change atime for link_file
4. wait 1~2 minutes

Cc: <stable@vger.kernel.org>
Fixes: 1e51764a3c2ac0 ("UBIFS: add new flash file system")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=210865

Signed-off-by: Chengsong Ke <kechengsong@huawei.com>
---
 fs/ubifs/io.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 00b61dba62b7..6b9d550341e5 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -836,13 +836,20 @@ int ubifs_wbuf_write_nolock(struct ubifs_wbuf *wbuf, void *buf, int len)
 		n <<= c->max_write_shift;
 		dbg_io("write %d bytes to LEB %d:%d", n, wbuf->lnum,
 		       wbuf->offs);
-		err = ubifs_leb_write(c, wbuf->lnum, buf + written,
+
+		memcpy(wbuf->buf, buf + written, min(len, n));
+		if (n > len) {
+			ubifs_assert(c, n - len < 8);
+			ubifs_pad(c, wbuf->buf + len, n - len);
+		}
+
+		err = ubifs_leb_write(c, wbuf->lnum, wbuf->buf,
 				      wbuf->offs, n);
 		if (err)
 			goto out;
 		wbuf->offs += n;
 		aligned_len -= n;
-		len -= n;
+		len -= min(len, n);
 		written += n;
 	}
 
-- 
2.12.3

