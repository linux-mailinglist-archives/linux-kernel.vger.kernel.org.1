Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B21EE66E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbgFDOP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 10:15:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5853 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728496AbgFDOP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:15:58 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2E9EB9BADC0A4A544A24;
        Thu,  4 Jun 2020 22:15:50 +0800 (CST)
Received: from huawei.com (10.175.101.78) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Thu, 4 Jun 2020
 22:15:42 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <b.zolnierkie@samsung.com>, <linux-kernel@vger.kernel.org>
CC:     <yangyingliang@huawei.com>
Subject: [PATCH] vgacon: fix a UAF in do_update_region()
Date:   Thu, 4 Jun 2020 22:38:44 +0800
Message-ID: <1591281524-114053-1-git-send-email-yangyingliang@huawei.com>
X-Mailer: git-send-email 1.8.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.78]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got a UAF report in do_update_region() when I doing fuzz test.

[   51.161905] BUG: KASAN: use-after-free in do_update_region+0x579/0x600
[   51.161918] Read of size 2 at addr ffff888000100000 by task test/295

[   51.161957] CPU: 2 PID: 295 Comm: test Not tainted 5.7.0+ #975
[   51.161969] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   51.161976] Call Trace:
[   51.162001]  dump_stack+0xc6/0x11e
[   51.162019]  ? do_update_region+0x579/0x600
[   51.162047]  print_address_description.constprop.6+0x1a/0x220
[   51.162083]  ? vprintk_func+0x66/0xed
[   51.162100]  ? do_update_region+0x579/0x600
[   51.162112]  ? do_update_region+0x579/0x600
[   51.162128]  kasan_report.cold.9+0x37/0x7c
[   51.162151]  ? do_update_region+0x579/0x600
[   51.162173]  do_update_region+0x579/0x600
[   51.162207]  ? con_get_trans_old+0x230/0x230
[   51.162229]  ? retint_kernel+0x10/0x10
[   51.162278]  csi_J+0x557/0xa00
[   51.162307]  do_con_trol+0x49af/0x5cc0
[   51.162330]  ? lock_downgrade+0x720/0x720
[   51.162347]  ? reset_palette+0x1b0/0x1b0
[   51.162369]  ? lockdep_hardirqs_on_prepare+0x379/0x540
[   51.162393]  ? notifier_call_chain+0x11b/0x160
[   51.162438]  do_con_write.part.24+0xb0a/0x1a30
[   51.162501]  ? do_con_trol+0x5cc0/0x5cc0
[   51.162522]  ? console_unlock+0x7b8/0xb00
[   51.162555]  ? __mutex_unlock_slowpath+0xd4/0x670
[   51.162574]  ? this_tty+0xe0/0xe0
[   51.162589]  ? console_unlock+0x559/0xb00
[   51.162605]  ? wait_for_completion+0x260/0x260
[   51.162638]  con_write+0x31/0xb0
[   51.162658]  n_tty_write+0x4fa/0xd40
[   51.162710]  ? n_tty_read+0x1800/0x1800
[   51.162730]  ? prepare_to_wait_exclusive+0x270/0x270
[   51.162754]  ? __might_fault+0x175/0x1b0
[   51.162783]  tty_write+0x42b/0x8d0
[   51.162795]  ? n_tty_read+0x1800/0x1800
[   51.162825]  ? tty_lookup_driver+0x450/0x450
[   51.162848]  __vfs_write+0x7c/0x100
[   51.162875]  vfs_write+0x1c9/0x510
[   51.162901]  ksys_write+0xff/0x200
[   51.162918]  ? __ia32_sys_read+0xb0/0xb0
[   51.162940]  ? do_syscall_64+0x1a/0x520
[   51.162957]  ? lockdep_hardirqs_on_prepare+0x379/0x540
[   51.162984]  do_syscall_64+0xa1/0x520
[   51.163008]  entry_SYSCALL_64_after_hwframe+0x49/0xb3

After vgacon_set_origin() is called in set_origin(), the vc_origin is
set to vga_vram_base, the vc_pos should between vga_vram_base and
vga_vram_end. But we still use vc_screenbuf_size, if the vga_vram_size
is smaller than vc_screenbuf_size, vc_pos may be out of bound, using it
will cause a use-after-free(or out-of-bounds). Fix this by calling
vc_resize() if vga_vram_size is smaller than vc_screenbuf_size.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/video/console/vgacon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 998b0de..2ee3d62 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -1336,6 +1336,9 @@ static int vgacon_set_origin(struct vc_data *c)
 	if (vga_is_gfx ||	/* We don't play origin tricks in graphic modes */
 	    (console_blanked && !vga_palette_blanked))	/* Nor we write to blanked screens */
 		return 0;
+
+	if (c->vc_screenbuf_size > vga_vram_size)
+		vc_resize(c, screen_info.orig_video_cols, screen_info.orig_video_lines);
 	c->vc_origin = c->vc_visible_origin = vga_vram_base;
 	vga_set_mem_top(c);
 	vga_rolled_over = 0;
-- 
1.8.3

