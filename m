Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCD4288A9A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388711AbgJIOTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:19:23 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45755 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731820AbgJIOTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:19:20 -0400
Received: by mail-io1-f72.google.com with SMTP id c5so6283801iok.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 07:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=D/E37UELAsiOgKflzFmz397iaCnWFeS5Gnrh8+M1hvk=;
        b=q8NbssCmsJq8MzuK89fkIsYZ9c9CGsOv9VW2NHqxfo0MnwGqbkIW4eqemWLPKOHi/7
         WnB2HR3map1zGCbgZYC/XxmSW4HYUUNjQ0JONoq9gcPJUs2D59q9qXGfWfSwOJ3Z3T81
         ZTH9w/X5XcLNywOhcWQMUHuTpSogxOX63M8ymVcQVsBdwzXUB7cTXoXqThx6i5wRRKVf
         E3TGNoXr5Rit3G51FhMS7rgr/ldAOGpCS1yEC2s2B/7gYiyJsDwx+omkqXlJYOaf930Q
         JRq2HPTJ+Ct4wStNRpmKgLlZycJeK19p41AxnHVJC5v5YewYngnzw1p578/6Afe2vBQ3
         odfg==
X-Gm-Message-State: AOAM532/tWiDYv3IZaQJE/a+zGx25fm169ufz8doQ2ia6haXiIVDEOQ3
        DFS3Ffk+YXCuL1+g2PBkk1f6MckoH4zvBwxbS5I/554taW47
X-Google-Smtp-Source: ABdhPJzLJP5WOA2wSYR708oOQw/zE8Pz/Um0gBQVWZI+0hZ82UN2ArEgI26iacjCpxrSVyIdm5YGdjgned1kd4ywbRrdfJIbfmHW
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c4:: with SMTP id i4mr11194098jaj.85.1602253159492;
 Fri, 09 Oct 2020 07:19:19 -0700 (PDT)
Date:   Fri, 09 Oct 2020 07:19:19 -0700
In-Reply-To: <000000000000021e6b05b0ea60bd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000069707b05b13da267@google.com>
Subject: Re: WARNING in hif_usb_send/usb_submit_urb
From:   syzbot <syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, eli.billauer@gmail.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        tiwai@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    6c8cf369 usb: typec: Add QCOM PMIC typec detection driver
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=14ea791b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df3bb4023c36d114
dashboard link: https://syzkaller.appspot.com/bug?extid=f5378bcf0f0cab45c1c6
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1087bfe7900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1327b010500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f5378bcf0f0cab45c1c6@syzkaller.appspotmail.com

usb 1-1: Manufacturer: syz
usb 1-1: SerialNumber: syz
usb 1-1: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 72 at drivers/usb/core/urb.c:493 usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 72 Comm: kworker/1:2 Not tainted 5.9.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x16e lib/dump_stack.c:118
 panic+0x2cb/0x702 kernel/panic.c:231
 __warn.cold+0x20/0x44 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x41/0x80 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
Code: 84 04 03 00 00 e8 3e 98 c6 fd 4c 89 ef e8 66 b6 12 ff 41 89 d8 44 89 e1 4c 89 f2 48 89 c6 48 c7 c7 20 b3 5d 86 e8 d0 ba 9a fd <0f> 0b e9 c6 f8 ff ff e8 12 98 c6 fd 48 81 c5 40 06 00 00 e9 f2 f7
RSP: 0018:ffff8881d4757808 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff8881d4ffe500 RSI: ffffffff8129efa3 RDI: ffffed103a8eaef3
RBP: ffff8881cde7d800 R08: 0000000000000001 R09: ffff8881db32f50f
R10: 0000000000000000 R11: 0000000000003754 R12: 0000000000000001
R13: ffff8881d1edd0a0 R14: ffff8881d9bc9320 R15: ffff8881d9ba8600
 hif_usb_send_regout drivers/net/wireless/ath/ath9k/hif_usb.c:127 [inline]
 hif_usb_send+0x4c1/0xcf0 drivers/net/wireless/ath/ath9k/hif_usb.c:470
 htc_issue_send drivers/net/wireless/ath/ath9k/htc_hst.c:34 [inline]
 htc_connect_service+0x705/0xa00 drivers/net/wireless/ath/ath9k/htc_hst.c:275
 ath9k_wmi_connect+0xc9/0x190 drivers/net/wireless/ath/ath9k/wmi.c:268
 ath9k_init_htc_services.constprop.0+0xb3/0x640 drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
 ath9k_htc_probe_device+0x25f/0x1e10 drivers/net/wireless/ath/ath9k/htc_drv_init.c:962
 ath9k_htc_hw_init+0x31/0x60 drivers/net/wireless/ath/ath9k/htc_hst.c:501
 ath9k_hif_usb_firmware_cb+0x274/0x530 drivers/net/wireless/ath/ath9k/hif_usb.c:1220
 request_firmware_work_func+0x126/0x250 drivers/base/firmware_loader/main.c:1006
 process_one_work+0x94c/0x15f0 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x392/0x470 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Kernel Offset: disabled
Rebooting in 86400 seconds..

