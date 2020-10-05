Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676BB2837DB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgJEOb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 10:31:29 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43707 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725936AbgJEOb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:31:29 -0400
Received: (qmail 378125 invoked by uid 1000); 5 Oct 2020 10:31:28 -0400
Date:   Mon, 5 Oct 2020 10:31:28 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+9b802f11efb574105ec5@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, eli.billauer@gmail.com,
        gregkh@linuxfoundation.org, gustavoars@kernel.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, oneukum@suse.com,
        syzkaller-bugs@googlegroups.com, tiwai@suse.de
Subject: Re: WARNING in handle_bug/usb_submit_urb
Message-ID: <20201005143128.GD376584@rowland.harvard.edu>
References: <000000000000fefa4f05b0ea5fcd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000fefa4f05b0ea5fcd@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 03:59:22AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    168ae5a7 Merge 5.9-rc8 into usb-next
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bec877900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5429f3643ebc37a
> dashboard link: https://syzkaller.appspot.com/bug?extid=9b802f11efb574105ec5
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120aa50b900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=134fa5c0500000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9b802f11efb574105ec5@syzkaller.appspotmail.com
> 
> usb 1-1: Manufacturer: syz
> usb 1-1: SerialNumber: syz
> usb 1-1: ath9k_htc: Firmware ath9k_htc/htc_9271-1.4.0.fw requested
> usb 1-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
> ------------[ cut here ]------------
> usb 1-1: BOGUS urb xfer, pipe 1 != type 3
> WARNING: CPU: 1 PID: 21 at drivers/usb/core/urb.c:493 usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
> Kernel panic - not syncing: panic_on_warn set ...
> CPU: 1 PID: 21 Comm: kworker/1:1 Not tainted 5.9.0-rc8-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events request_firmware_work_func
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x107/0x16e lib/dump_stack.c:118
>  panic+0x2cb/0x702 kernel/panic.c:231
>  __warn.cold+0x20/0x44 kernel/panic.c:600
>  report_bug+0x1bd/0x210 lib/bug.c:198
>  handle_bug+0x41/0x80 arch/x86/kernel/traps.c:234
>  exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
>  asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
> RIP: 0010:usb_submit_urb+0xce2/0x14e0 drivers/usb/core/urb.c:493
> Code: 84 04 03 00 00 e8 3e 98 c6 fd 4c 89 ef e8 66 b6 12 ff 41 89 d8 44 89 e1 4c 89 f2 48 89 c6 48 c7 c7 20 b3 5d 86 e8 d0 ba 9a fd <0f> 0b e9 c6 f8 ff ff e8 12 98 c6 fd 48 81 c5 40 06 00 00 e9 f2 f7
> RSP: 0018:ffff8881da33f808 EFLAGS: 00010286

Andrey, what happened here?  Where's the rest of the stack trace?

Alan Stern
