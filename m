Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48D428388C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgJEOym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgJEOyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:54:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94711C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 07:54:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n136so1114580pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 07:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Su3W6CD3yVJd0qXurbu4noGeFN+fSrdrnmIPO8nh//w=;
        b=K76oFyLlBWabaQelHNQNbsaAXLcjnSgYNjC70MW5eyclMK3OfdrfrFi4c+xWRJC9dv
         U0VhJ2Bwqq3Oh6KT0itD89k+X8eV1rrZgsGQkaBqQCHsBzoVbx8qzvrhr0VDZrVP7UzH
         xESw1QFdirtFE3Q9SHK88B9Oz5QmM+85Y106FcBKFvGYcp/Bl82IYRAAJEnwmf2ruVIc
         xXO/gVcH9uMna0ygXL0rSxtoUNFicKp7Jmj+eHSKwt0ovz7+MspTGumANXa8oUcoWiDI
         UcENWb1B5qDP0IX9cNrv3g4SCH/E/rV0DsDPRi7Eo7Y4RoJgtKUKo2yQA23XL9qjkawp
         030Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Su3W6CD3yVJd0qXurbu4noGeFN+fSrdrnmIPO8nh//w=;
        b=CoaT2QKnPfqhSbfjYughnZoDA5Al+PlwXTeqyXrPE9+sa9kEjCCc0b1LSoJbWBW4fa
         jKbarKA0vbzYds6siFsJZ90fC1l3a8Xsr9sqf4yFm+2Id+qmS+NcRPo2+K+jLhvZ1sR0
         OmfrI3GdDGy/NdgnG9I7Sy6HqR9Xd0ttKi45PrxwyZQcEFd6HgcvjJpzTOb3sTcWOud9
         bKMjmqaWP4FwTA093ti6xHmR3zsLPSWawXlHwdpu1cFHA8E/PqEjuJIdEJetrwjvtJFh
         U3o1MrSdWKofVx2Hi8f7C2WlZnHRNnzsFyRuBM1rvGgV5K79XkDCwPUJRQjAla6SvPP/
         OHJg==
X-Gm-Message-State: AOAM5329K9KChUAbIqKSkGmIj65lYMpFKgmKDXJAq8UU0R83QAB7doMS
        MNJo2CtG1a0ZE9S2QUXRlfaConPogmAMcRTb2yBv1w==
X-Google-Smtp-Source: ABdhPJy0sNg7Su8r3ND+ci7uf8QZyPCU3br9J4R/UA01FWfaU294yEWb0VY41n6xu1LnxWMkl0wCENQ4JqKRcZLorrs=
X-Received: by 2002:a62:ee10:0:b029:142:2501:3972 with SMTP id
 e16-20020a62ee100000b029014225013972mr17442672pfi.55.1601909680854; Mon, 05
 Oct 2020 07:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000fefa4f05b0ea5fcd@google.com> <20201005143128.GD376584@rowland.harvard.edu>
In-Reply-To: <20201005143128.GD376584@rowland.harvard.edu>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 5 Oct 2020 16:54:30 +0200
Message-ID: <CAAeHK+x-BWcrWPpP_Ommyq8httdGB3rY1geGKzO1Ui0ZHnxJOQ@mail.gmail.com>
Subject: Re: WARNING in handle_bug/usb_submit_urb
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+9b802f11efb574105ec5@syzkaller.appspotmail.com>,
        eli.billauer@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        gustavoars@kernel.org, ingrassia@epigenesys.com,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 4:31 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Oct 05, 2020 at 03:59:22AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    168ae5a7 Merge 5.9-rc8 into usb-next
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=12bec877900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5429f3643ebc37a
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9b802f11efb574105ec5
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120aa50b900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134fa5c0500000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9b802f11efb574105ec5@syzkaller.appspotmail.com
> >
> > usb 1-1: Manufacturer: syz
> > usb 1-1: SerialNumber: syz
> > usb 1-1: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
> > usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
> > ------------[ cut here ]------------
> > usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> > WARNING: CPU: 1 PID: 21 at drivers/usb/core/urb.c:493 usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.9.0-rc8-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Workqueue: events request_firmware_work_func
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x107/0x16e lib/dump_stack.c:118
> >  panic+0x2cb/0x702 kernel/panic.c:231
> >  __warn.cold+0x20/0x44 kernel/panic.c:600
> >  report_bug+0x1bd/0x210 lib/bug.c:198
> >  handle_bug+0x41/0x80 arch/x86/kernel/traps.c:234
> >  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
> >  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> > RIP: 0010:usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
> > Code: 84 04 03 00 00 e8 3e 98 c6 fd 4c 89 ef e8 66 b6 12 ff 41 89 d8 44 89 e1 4c 89 f2 48 89 c6 48 c7 c7 20 b3 5d 86 e8 d0 ba 9a fd <0f> 0b e9 c6 f8 ff ff e8 12 98 c6 fd 48 81 c5 40 06 00 00 e9 f2 f7
> > RSP: 0018:ffff8881da33f808 EFLAGS: 00010286
>
> Andrey, what happened here?  Where's the rest of the stack trace?

Hi Alan,

Looks like some lockup while printing the stack trace, typical kernel issues :)

Here' the full trace:

------------[ cut here ]------------
usb 1-1: BOGUS urb xfer, pipe 1 != type 3
WARNING: CPU: 1 PID: 215 at drivers/usb/core/urb.c:493
usb_submit_urb+0x1189/0x1460
Modules linked in:
CPU: 1 PID: 215 Comm: kworker/1:3 Not tainted 5.9.0-rc8+ #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
Workqueue: events request_firmware_work_func
RIP: 0010:usb_submit_urb+0x1189/0x1460 drivers/usb/core/urb.c:493
Code: 4d 85 ed 74 46 e8 57 12 cd fd 4c 89 f7 e8 1f 6e 16 ff 41 89 d8
44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 20 a7 5d 86 e8 99 b5 a0 fd <0f> 0b
e9 1f f4 ff ff e8 2b 12 cd fd 0f 1f 44 00 d
RSP: 0018:ffff88806b69f820 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff812a0933 RDI: ffffed100d6d3ef6
RBP: ffff888068f40400 R08: ffff8880662f3000 R09: ffffed100d963fd2
R10: ffff88806cb1fe8b R11: ffffed100d963fd1 R12: 0000000000000001
R13: ffff888067844a50 R14: ffff88806b2160a0 R15: ffff88806ba5dc00
FS:  0000000000000000(0000) GS:ffff88806cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000055c071 CR3: 0000000064e41000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 hif_usb_send_regout drivers/net/wireless/ath/ath9k/hif_usb.c:127 (inline)
 hif_usb_send+0x4dc/0xd60 drivers/net/wireless/ath/ath9k/hif_usb.c:470
 htc_connect_service+0x5bd/0x840 drivers/net/wireless/ath/ath9k/htc_hst.c:275
 ath9k_wmi_connect+0xc9/0x190 drivers/net/wireless/ath/ath9k/wmi.c:268
 ath9k_init_htc_services.constprop.0+0xb3/0x640
drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
 ath9k_htc_probe_device+0x25f/0x1e40
drivers/net/wireless/ath/ath9k/htc_drv_init.c:962
 ath9k_htc_hw_init+0x31/0x60 drivers/net/wireless/ath/ath9k/htc_hst.c:501
 ath9k_hif_usb_firmware_cb+0x274/0x510
drivers/net/wireless/ath/ath9k/hif_usb.c:1220
 request_firmware_work_func+0x126/0x242 drivers/base/firmware_loader/main.c:1006
 process_one_work+0x969/0x1620 kernel/workqueue.c:2269
 worker_thread+0x96/0xe20 kernel/workqueue.c:2415
 kthread+0x352/0x460 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
irq event stamp: 152313
hardirqs last  enabled at (152321): [<ffffffff8129b57a>]
console_unlock+0xa5a/0xca0
hardirqs last disabled at (152340): [<ffffffff8129b438>]
console_unlock+0x918/0xca0
softirqs last  enabled at (152338): [<ffffffff85e005c9>]
__do_softirq+0x5c9/0x8cf
softirqs last disabled at (152329): [<ffffffff85c00f0f>]
asm_call_irq_on_stack+0xf/0x20
---[ end trace 4311cee8f0938f1c ]---

Looks like a dup of:

#syz dup: WARNING in hif_usb_send/usb_submit_urb

Sorry for the noise.
