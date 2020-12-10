Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFAEA2D50F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 03:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgLJCjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 21:39:39 -0500
Received: from smtp.h3c.com ([60.191.123.56]:16895 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgLJCji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 21:39:38 -0500
Received: from DAG2EX08-IDC.srv.huawei-3com.com ([10.8.0.71])
        by h3cspam01-ex.h3c.com with ESMTP id 0BA2bvvR039003;
        Thu, 10 Dec 2020 10:37:57 +0800 (GMT-8)
        (envelope-from gao.yanB@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 10 Dec 2020 10:37:58 +0800
From:   "Yan.Gao" <gao.yanB@h3c.com>
To:     <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tian.xianting@h3c.com>,
        "Yan.Gao" <gao.yanB@h3c.com>
Subject: [PATCH] [v2] tty: Protect disc_data in n_tty_close and n_tty_flush_buffer
Date:   Thu, 10 Dec 2020 10:25:07 +0800
Message-ID: <20201210022507.30729-1-gao.yanB@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX08-IDC.srv.huawei-3com.com (10.8.0.71)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 0BA2bvvR039003
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n_tty_flush_buffer can happen in parallel with n_tty_close that the
tty->disc_data will be set to NULL. n_tty_flush_buffer accesses
tty->disc_data, so we must prevent n_tty_close clear tty->disc_data
while n_tty_flush_buffer  has a non-NULL view of tty->disc_data.

So we need to make sure that accesses to disc_data are atomic using
tty->termios_rwsem.

There is an example I meet:
When n_tty_flush_buffer accesses tty struct, the disc_data is right.
However, then reset_buffer_flags accesses tty->disc_data, disc_data
become NULL, So kernel crash when accesses tty->disc_data->real_tail.
I guess there could be another thread change tty->disc_data to NULL,
and during N_TTY line discipline, n_tty_close will set tty->disc_data
to be NULL. So use tty->termios_rwsem to protect disc_data between close
and flush_buffer.

IP: reset_buffer_flags+0x9/0xf0
PGD 0 P4D 0
Oops: 0002 [#1] SMP
CPU: 23 PID: 2087626 Comm: (agetty) Kdump: loaded Tainted: G
Hardware name: UNISINSIGHT X3036P-G3/ST01M2C7S, BIOS 2.00.13 01/11/2019
task: ffff9c4e9da71e80 task.stack: ffffb30cfe898000
RIP: 0010:reset_buffer_flags+0x9/0xf0
RSP: 0018:ffffb30cfe89bca8 EFLAGS: 00010246
RAX: ffff9c4e9da71e80 RBX: ffff9c368d1bac00 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffff9c4ea17b50f0 RDI: 0000000000000000
RBP: ffffb30cfe89bcc8 R08: 0000000000000100 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000000 R12: ffff9c368d1bacc0
R13: ffff9c20cfd18428 R14: ffff9c4ea17b50f0 R15: ffff9c368d1bac00
FS:  00007f9fbbe97940(0000) GS:ffff9c375c740000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000002260 CR3: 0000002f72233003 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
? n_tty_flush_buffer+0x2a/0x60
tty_buffer_flush+0x76/0x90
tty_ldisc_flush+0x22/0x40
vt_ioctl+0x5a7/0x10b0
? n_tty_ioctl_helper+0x27/0x110
tty_ioctl+0xef/0x8c0
do_vfs_ioctl+0xa7/0x5e0
? __audit_syscall_entry+0xaf/0x100
? syscall_trace_enter+0x1d0/0x2b0
SyS_ioctl+0x79/0x90
do_syscall_64+0x6c/0x1b0
entry_SYSCALL64_slow_path+0x25/0x25

n_tty_flush_buffer			--->tty->disc_data is OK
	->reset_buffer_flags		 -->tty->disc_data is NULL

Signed-off-by: Yan.Gao <gao.yanB@h3c.com>
Reviewed-by: Xianting Tian <tian.xianting@h3c.com>
---
 drivers/tty/n_tty.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 7e5e36315..e78124ce1 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1892,8 +1892,10 @@ static void n_tty_close(struct tty_struct *tty)
 	if (tty->link)
 		n_tty_packet_mode_flush(tty);
 
+	down_write(&tty->termios_rwsem);
 	vfree(ldata);
 	tty->disc_data = NULL;
+	up_write(&tty->termios_rwsem);
 }
 
 /**
-- 
2.17.1

