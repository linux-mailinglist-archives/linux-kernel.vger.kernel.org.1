Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F112DB94A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 03:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgLPCnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 21:43:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:58309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgLPCnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 21:43:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608086510;
        bh=yMbD2YbjiR9ft+QKL4smXXGdFESTY+Y1ZPCXJXPkZ+g=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=Yhyk/P+jBDVOhzGgshU3L3UVnUMPWumB+X+ejvX894HZTggY9Mzgteln6w5XOLW22
         Kgb/hSvg2Jz8Qf9uo6VBZ9wBYBuj+geMXaKPBtJ7qauhsjPHQT8eBXTvyesB4DfdTO
         C+HJti+i+Q15gj5sZ2P+F1yLjEMBlex1zz0zilS8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.61]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MatVb-1kENyn3BYx-00cU3t; Wed, 16
 Dec 2020 03:41:50 +0100
Message-ID: <5979380e28f4ba8023e88f96d3a9291381a8457e.camel@gmx.de>
Subject: drm, qxl: post 5.11 merge warning+explosion
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Dave Airlie <airlied@redhat.com>
Date:   Wed, 16 Dec 2020 03:41:50 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qeUrWknwym0xq12SWshrLX3xA8HJU0SPkAToBMmgxsk3LgrVvCD
 vIbFcyKF96Ih0fkl8LbGmLpsCC1kzceXEXnHbKzza5NCq+6cHVt5uGLSIVqmumb9e0hNkVy
 YjocZ075Z26DvRJ/uwzILw8zGMvLfyZxYoHvCnXmIaOr+3FQ6BKYQaHBWW1Ylj6uORFZYDv
 dahWnXM87J9BScDqs5tZQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ip5yn0LIHgQ=:3ZQ21ysuw4iieP1IrpNRFf
 jpWTPHEMr/rqnYP9EgF/5ydzw07NJnrfTXTkMY38PihHAEvMZbEAAljUaKQfL5ZuwKB2Ddeue
 bZs4MLj6TqQFeIH7jbrwJER/tSpI1p6G0/ZchybgK+h26LrILxsNe+3wjmnWEIC4lU9Pl+1xV
 W3oEvfsDoXPKALrmCzKNThhtqDrDD0SHp3rA09OwsxsNmgkfoxNjomP5wr8bTzkABtefWzesL
 YQ3CxnQtCuff6JO0GRWYIL6Av/qSk2RlAf4pWdqLjc8NobovqPZR4HhmOaTq8Vlj9cp9pY7N8
 u6ZBKgfExIbvO1xqh2liaCUEMdDG4UNxilf7F8ntDQQxP8he3plkNPFYYk2TVmdl1xURUr2jr
 Y7nxU5Hj42RSkb1uHaDf5QwVCfDPV/MrbLV4gJ8djfNE5Ocn5fOzz7HUp9tsKCT4OgL3326jm
 /OwupHF1xfgtizjcMhxBCbbxE9WcmzUG5Oi+RwtlVzZvlt0N7EGAczAWS69+PqJlyJsnr4Ka8
 0ROK3iccWykVlc09PCYrW36UtjGhNj2reVzpdQnpPPP99ktqPhgzSrxoDD09BQ4rlVRwTyNbs
 uMPTtXlDPMjsj2i6rkyZ1mds7IILuK+fwprI3fKaWkqvbRMbb99nx/2aH36+aN+knd+jwlD35
 xBTtU4kDh+dDmnTNaxaPi16oWhpJ2WDfoLCXfua1h+OuOT1AvRoFU54cKGl4vpWVS71CiLJeY
 3s0zdsd8cyzmnIqSjx3NUfpGpRtUhZrmkjxZAeadOlI6RSR5JzIwWwjHuJzzJYEluI3lsfzmR
 LTeivRi4jjCjLx945cB4X1364XFgw3Lo4KQs2lNhYgZPWAPZ9qSW6Aqfw+GcR2jVuGtlVYrnI
 tL6tFnHNoa+PP7K9rt6w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Little kvm works fine with nomodeset, so will be busy for a while
bisecting two other problems that popped up here this cycle. (hohum)

[    1.815561] WARNING: CPU: 7 PID: 355 at drivers/gpu/drm/ttm/ttm_pool.c:=
365 ttm_pool_alloc+0x41b/0x540 [ttm]
[    1.815561] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_=
generic(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E=
) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E)=
 sysimgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pc=
i(E) rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) vir=
tio_ring(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) d=
m_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) sc=
si_mod(E) autofs4(E)
[    1.815589] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G            E  =
   5.10.0.g489e9fe-master #26
[    1.815590] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[    1.815614] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
[    1.815621] RIP: 0010:ttm_pool_alloc+0x41b/0x540 [ttm]
[    1.815623] Code: fc ff ff 89 ea 48 8d 04 d5 00 00 00 00 48 29 d0 48 8d=
 3c c5 00 1c 40 a0 e9 d7 fc ff ff 85 c0 0f 89 2f fc ff ff e9 28 fc ff ff <=
0f> 0b e9 35 fc ff ff 89 e9 49 8b 7d 00 b8 00 10 00 00 48 d3 e0 45
[    1.815623] RSP: 0018:ffff888105d3b818 EFLAGS: 00010246
[    1.815625] RAX: 0000000000000000 RBX: ffff888106978800 RCX: 0000000000=
000000
[    1.815626] RDX: ffff888105d3bc68 RSI: 0000000000000001 RDI: ffff888106=
238820
[    1.815626] RBP: ffff888106238758 R08: ffffc90000296000 R09: 8000000000=
00016b
[    1.815627] R10: 0000000000000001 R11: ffffc90000296000 R12: 0000000000=
000000
[    1.815628] R13: ffff888106238820 R14: 0000000000000000 R15: ffff888106=
978800
[    1.815628] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS=
:0000000000000000
[    1.815632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.815633] CR2: 00007eff52a0d5b8 CR3: 0000000002010003 CR4: 0000000000=
1706e0
[    1.815633] Call Trace:
[    1.815644]  ttm_tt_populate+0xb1/0xc0 [ttm]
[    1.815647]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
[    1.815652]  qxl_bo_move+0x230/0x2f0 [qxl]
[    1.815655]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
[    1.815657]  ttm_bo_evict+0x124/0x250 [ttm]
[    1.815693]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
[    1.815696]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
[    1.815698]  ttm_bo_mem_space+0x261/0x270 [ttm]
[    1.815702]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
[    1.815705]  ttm_bo_validate+0x117/0x150 [ttm]
[    1.815756]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
[    1.815772]  qxl_bo_create+0x134/0x1d0 [qxl]
[    1.815775]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
[    1.815791]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
[    1.815794]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
[    1.815797]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
[    1.815815]  ? _cond_resched+0x15/0x40
[    1.815819]  ? ww_mutex_lock_interruptible+0x12/0x60
[    1.815822]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
[    1.815841]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
[    1.815853]  process_one_work+0x1f5/0x3c0
[    1.815866]  ? process_one_work+0x3c0/0x3c0
[    1.815867]  worker_thread+0x2d/0x3d0
[    1.815868]  ? process_one_work+0x3c0/0x3c0
[    1.815872]  kthread+0x117/0x130
[    1.815876]  ? kthread_park+0x90/0x90
[    1.815880]  ret_from_fork+0x1f/0x30
[    1.815886] ---[ end trace 51e464c1e89a1728 ]---
[    1.815894] BUG: kernel NULL pointer dereference, address: 000000000000=
0230
[    1.815895] #PF: supervisor read access in kernel mode
[    1.815895] #PF: error_code(0x0000) - not-present page
[    1.815896] PGD 0 P4D 0
[    1.815898] Oops: 0000 [#1] SMP NOPTI
[    1.815900] CPU: 7 PID: 355 Comm: kworker/7:2 Tainted: G        W   E  =
   5.10.0.g489e9fe-master #26
[    1.815901] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS=
 rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
[    1.815916] Workqueue: events drm_fb_helper_dirty_work [drm_kms_helper]
[    1.815921] RIP: 0010:dma_map_page_attrs+0xf/0x1c0
[    1.815922] Code: 1f 17 5b 01 48 85 c0 75 e3 31 c0 c3 66 66 2e 0f 1f 84=
 00 00 00 00 00 0f 1f 40 00 0f 1f 44 00 00 41 55 41 54 55 53 48 83 ec 08 <=
48> 8b 87 30 02 00 00 48 85 c0 48 0f 44 05 e7 16 5b 01 41 83 f8 02
[    1.815923] RSP: 0018:ffff888105d3b7e8 EFLAGS: 00010296
[    1.815924] RAX: 0000000000001000 RBX: 0000000000000001 RCX: 0000000000=
001000
[    1.815924] RDX: 0000000000000000 RSI: ffffea0004171e40 RDI: 0000000000=
000000
[    1.815925] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000=
000000
[    1.815925] R10: ffffea0004171e40 R11: ffffc90000296000 R12: 0000000000=
000001
[    1.815926] R13: ffff888106238820 R14: ffff888105d07100 R15: ffff888106=
978800
[    1.815926] FS:  0000000000000000(0000) GS:ffff888237dc0000(0000) knlGS=
:0000000000000000
[    1.815928] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.815929] CR2: 0000000000000230 CR3: 0000000002010003 CR4: 0000000000=
1706e0
[    1.815929] Call Trace:
[    1.815937]  ttm_pool_alloc+0x448/0x540 [ttm]
[    1.815940]  ttm_tt_populate+0xb1/0xc0 [ttm]
[    1.815942]  ttm_bo_move_memcpy+0x4a5/0x500 [ttm]
[    1.815945]  qxl_bo_move+0x230/0x2f0 [qxl]
[    1.815947]  ttm_bo_handle_move_mem+0x79/0x140 [ttm]
[    1.815949]  ttm_bo_evict+0x124/0x250 [ttm]
[    1.815982]  ? drm_mm_insert_node_in_range+0x55c/0x580 [drm]
[    1.815984]  ttm_mem_evict_first+0x110/0x3d0 [ttm]
[    1.815988]  ttm_bo_mem_space+0x261/0x270 [ttm]
[    1.890133]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
[    1.890138]  ttm_bo_validate+0x117/0x150 [ttm]
[    1.891740]  ttm_bo_init_reserved+0x2c8/0x3c0 [ttm]
[    1.891744]  qxl_bo_create+0x134/0x1d0 [qxl]
[    1.893398]  ? qxl_ttm_debugfs_init+0xb0/0xb0 [qxl]
[    1.893400]  qxl_alloc_bo_reserved+0x2c/0x90 [qxl]
[    1.893402]  qxl_image_alloc_objects+0xa3/0x120 [qxl]
[    1.893405]  qxl_draw_dirty_fb+0x155/0x450 [qxl]
[    1.896515]  ? _cond_resched+0x15/0x40
[    1.896517]  ? ww_mutex_lock_interruptible+0x12/0x60
[    1.896520]  qxl_framebuffer_surface_dirty+0x14f/0x1a0 [qxl]
[    1.896533]  drm_fb_helper_dirty_work+0x11d/0x180 [drm_kms_helper]
[    1.896537]  process_one_work+0x1f5/0x3c0
[    1.900535]  ? process_one_work+0x3c0/0x3c0
[    1.900536]  worker_thread+0x2d/0x3d0
[    1.900538]  ? process_one_work+0x3c0/0x3c0
[    1.902704]  kthread+0x117/0x130
[    1.902706]  ? kthread_park+0x90/0x90
[    1.902709]  ret_from_fork+0x1f/0x30
[    1.902711] Modules linked in: ext4(E) crc16(E) mbcache(E) jbd2(E) ata_=
generic(E) ata_piix(E) virtio_console(E) virtio_rng(E) virtio_blk(E) qxl(E=
) drm_ttm_helper(E) ttm(E) drm_kms_helper(E) syscopyarea(E) sysfillrect(E)=
 sysimgblt(E) ahci(E) fb_sys_fops(E) cec(E) libahci(E) uhci_hcd(E) ehci_pc=
i(E) rc_core(E) ehci_hcd(E) crc32c_intel(E) serio_raw(E) virtio_pci(E) vir=
tio_ring(E) 8139cp(E) virtio(E) libata(E) drm(E) usbcore(E) mii(E) sg(E) d=
m_multipath(E) dm_mod(E) scsi_dh_rdac(E) scsi_dh_emc(E) scsi_dh_alua(E) sc=
si_mod(E) autofs4(E)
[    1.904797] Dumping ftrace buffer:
[    1.911038]    (ftrace buffer empty)
[    1.911041] CR2: 0000000000000230

