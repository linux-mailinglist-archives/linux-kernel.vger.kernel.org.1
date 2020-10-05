Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E63283909
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgJEPIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJEPIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:08:23 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059FAC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:08:23 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a200so2277206pfa.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1S/FkXYTFn2oVLi29cIaAZFlPFb57vgrFD3svNFFhFE=;
        b=NwHhgJZg6oIyqBZiAJHMCgsRAKWrCLIrSD/1NL2vxuXuH2+LWyo00AH7v4AEnJdvGk
         fEoQodjkLw/LRrBW/+ptXC/s0GhTuHD84NsuoCDpCMul9ffo/WIc+h63rtncD6XQSD5J
         TZATynjHjKIQCY00zPcVLUkqZfV0GukjQFbs8SSG0IzhIS68CglsZoeqX+6K/p82t68U
         BCYzp4BX9O9cs5shPRqRHkwiMzAjXq8Z2dVcpRZ66B+Dx4Lu/ooo0dHSW5On9b5HIxdC
         +rKL8DyUzKUUkbbE9RSsG5u/jRKDw8c1swue5mZ0srtRR/kg8ZS1GSsWqL4s4zEJBNZD
         sMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1S/FkXYTFn2oVLi29cIaAZFlPFb57vgrFD3svNFFhFE=;
        b=gzNxU3GBBMqyPIA6GatiiIwc+YrmQfl3RTDbSPFPcCZt56ucwXLDDNPf9hWVFRqt8Z
         +AB4e13ZENYu2hlVorF2Gkko9tDbt4uLbz2pj0PbP7QJuJ2CkKgrPMVSsxCQX0C8RZDR
         88hpAriX+CnoAmlP4Ji3zFVYAQdGY8mCh6EiEFP6m92B472P4j68iEBWtjbawr9Q9fda
         ZT+TrpdsLXrD0WNLPRG/SitrFTJm+JqFg56AReQ39nPV6FBxI9mXRQxKUOrvpmGIFdxj
         Fn+ubWR2mLO6CgFMwVvBYLG4AU6Gi4pHuscNAUPqjeTrPSIhbZiw0zFVju2oa+hSpO0J
         BwrQ==
X-Gm-Message-State: AOAM532yqGDsHC2ZIfoCSf6w9SimwPk2734SK+Liy0NZ5dWy0mlff1ov
        RFK7nc3WzTLeyRM2BXh00wHtXyEd2mQZ1ETUhmpkGg==
X-Google-Smtp-Source: ABdhPJyHnO9QHIoG0zf/drGaDwjFyllVTYoa9Xo8ie4XOoCP9wjijxD4g1PK0MIzaT/mBobIZoLiNKs/EbUW9TvasVI=
X-Received: by 2002:a63:d56:: with SMTP id 22mr15491292pgn.286.1601910502282;
 Mon, 05 Oct 2020 08:08:22 -0700 (PDT)
MIME-Version: 1.0
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 5 Oct 2020 17:08:11 +0200
Message-ID: <CAAeHK+wb4k-LGTjK9F5YbJNviF_+yU+wE_=Vpo9Rn7KFN8vG6Q@mail.gmail.com>
Subject: Is usb_hcd_giveback_urb() allowed in task context?
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nazime Hande Harputluoglu <handeharputlu@google.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear USB and USB/IP maintainers,

While fuzzing the USB/IP stack with syzkaller we've stumbled upon an issue.

Currently kcov (the subsystem that is used for coverage collection)
USB-related callbacks assume that usb_hcd_giveback_urb() can only be
called from interrupt context, as indicated by the comment before the
function definition. In the USB/IP code, however, it's called from the
task context (see the stack trace below).

Is this something that is allowed and we need to fix kcov? Or is this
a bug in USB/IP?

Thank you!

------------[ cut here ]------------
WARNING: CPU: 2 PID: 57 at kernel/kcov.c:834
kcov_remote_start+0xa7/0x400 kernel/kcov.c:834
Kernel panic - not syncing: panic_on_warn set ...
CPU: 2 PID: 57 Comm: kworker/2:1 Not tainted 5.9.0-rc7+ #45
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
Workqueue: usb_hub_wq hub_event
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x14b/0x19d lib/dump_stack.c:118
 panic+0x319/0x765 kernel/panic.c:231
 __warn.cold+0x2f/0x2f kernel/panic.c:600
 report_bug+0x273/0x300 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:kcov_remote_start+0xa7/0x400 kernel/kcov.c:834
Code: 84 26 03 00 00 fa 66 0f 1f 44 00 00 65 8b 05 50 13 93 7e a9 00
01 ff 00 41 8b 94 24 50 0a 00 00 75 1a 81 e2 ff ff ff bf 74 12 <0f> 0b
48 83 3d 17 c4 26 08 00 0f 85 62 01 00 00 0f 0b 65 8b 05 20
RSP: 0018:ffffc9000030f600 EFLAGS: 00010002
RAX: 0000000080000000 RBX: 0100000000000003 RCX: ffffc90014cd1000
RDX: 0000000000000002 RSI: ffffffff85199fcc RDI: 0100000000000003
RBP: 0000000000000282 R08: ffff88806d594640 R09: fffff52000061eca
R10: 0000000000000003 R11: fffff52000061ec9 R12: ffff88806d594640
R13: 0000000000000000 R14: 0100000000000003 R15: 0000000000000000
 kcov_remote_start_usb include/linux/kcov.h:52 [inline]
 __usb_hcd_giveback_urb+0x284/0x4b0 drivers/usb/core/hcd.c:1649
 usb_hcd_giveback_urb+0x367/0x410 drivers/usb/core/hcd.c:1716
 vhci_urb_enqueue.cold+0x37f/0x4c5 drivers/usb/usbip/vhci_hcd.c:801
 usb_hcd_submit_urb+0x2b1/0x20d0 drivers/usb/core/hcd.c:1547
 usb_submit_urb+0x6e5/0x13b0 drivers/usb/core/urb.c:570
 usb_start_wait_urb+0x10f/0x2c0 drivers/usb/core/message.c:58
 usb_internal_control_msg drivers/usb/core/message.c:102 [inline]
 usb_control_msg+0x31c/0x4a0 drivers/usb/core/message.c:153
 hub_set_address drivers/usb/core/hub.c:4472 [inline]
 hub_port_init+0x23f6/0x2d20 drivers/usb/core/hub.c:4748
 hub_port_connect drivers/usb/core/hub.c:5140 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1cc9/0x38d0 drivers/usb/core/hub.c:5576
 process_one_work+0x7b6/0x1190 kernel/workqueue.c:2269
 worker_thread+0x94/0xdc0 kernel/workqueue.c:2415
 kthread+0x372/0x450 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
