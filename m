Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646BF2D9932
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440018AbgLNNqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:46:53 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:47338 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438538AbgLNNqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:46:51 -0500
Received: by mail-io1-f71.google.com with SMTP id q21so3221431ios.14
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 05:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=u5uOJTkvi9oLcz7eMTJJP02g8EDZk0rHridQXPr2iyA=;
        b=DU/Thx1f271tyg6iUJaTxej/oG+HNApvTqp2E9gjxuwW/+EGjb92LtBYfbBjjyU3JK
         6WnKzElcnflp48UHTJX7VC61+DGi5EFjoicjJb3CeAtu5R/J8/imoQ3dr1bpVneNLQzK
         5tx9uxFYbduiDU5NJCYt59EfBvFz03sBS3bPI2oQ4+NDYkgRxMF3kKtupdCJ1mCgtkri
         MKwVHobiIdmr/CtpV7SS/959Gp9976PkaR599y4EXtmTKnnUd8svLXHrSFttgyzz6P5N
         PezJfDAXcwb1CGrtjHzGcu45q1XSB9N260sdwmBeXo/9mxJXcj1fIpfmwn2cUxXI6nCW
         UWgA==
X-Gm-Message-State: AOAM531U1hToWp1gF0mk0UqqHLMQFJwY/wExaUTdtP63jCaZ3MFBL/5h
        +cvQ0oN0krKd+Qu/iXDVCjRbzro4KlxC/JQqA02X92aOXg2c
X-Google-Smtp-Source: ABdhPJw30Zf+SQWT4CZg+eXyhFKthUhneApcpWHnyF2LbdX5WYe+Qia53e6TuouwwLQaVEigd+Q2wIqtoMj2DZQzRnP6aZNujfO7
MIME-Version: 1.0
X-Received: by 2002:a05:6602:150b:: with SMTP id g11mr32252338iow.88.1607953570678;
 Mon, 14 Dec 2020 05:46:10 -0800 (PST)
Date:   Mon, 14 Dec 2020 05:46:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000654c9c05b66cdd73@google.com>
Subject: KASAN: vmalloc-out-of-bounds Read in drm_fb_helper_dirty_work (2)
From:   syzbot <syzbot+cc9acdabdf6ea0c8dc0b@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, syzkaller-bugs@googlegroups.com,
        tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a2f5ea9e Merge tag 'arm-soc-fixes-v5.10-4b' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=167b497b500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=868cd1c95c02180
dashboard link: https://syzkaller.appspot.com/bug?extid=cc9acdabdf6ea0c8dc0b
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cc9acdabdf6ea0c8dc0b@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: vmalloc-out-of-bounds in memcpy include/linux/string.h:399 [inline]
BUG: KASAN: vmalloc-out-of-bounds in drm_fb_helper_dirty_blit_real drivers/gpu/drm/drm_fb_helper.c:403 [inline]
BUG: KASAN: vmalloc-out-of-bounds in drm_fb_helper_dirty_work+0x42e/0x810 drivers/gpu/drm/drm_fb_helper.c:435
Read of size 3168 at addr ffffc9000b8613a0 by task kworker/0:5/11875

CPU: 0 PID: 11875 Comm: kworker/0:5 Not tainted 5.10.0-rc7-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:385
 __kasan_report mm/kasan/report.c:545 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:562
 check_memory_region_inline mm/kasan/generic.c:186 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:192
 memcpy+0x20/0x60 mm/kasan/common.c:105
 memcpy include/linux/string.h:399 [inline]
 drm_fb_helper_dirty_blit_real drivers/gpu/drm/drm_fb_helper.c:403 [inline]
 drm_fb_helper_dirty_work+0x42e/0x810 drivers/gpu/drm/drm_fb_helper.c:435
 process_one_work+0x933/0x15a0 kernel/workqueue.c:2272
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2418
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296


Memory state around the buggy address:
 ffffc9000b861280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000b861300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>ffffc9000b861380: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
                               ^
 ffffc9000b861400: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
 ffffc9000b861480: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
